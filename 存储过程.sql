-- ============================
-- 第一步：删除所有旧版对象（清理冗余）
-- ============================
DROP PROCEDURE IF EXISTS `sp_清理过期告警`;
DROP PROCEDURE IF EXISTS `sp_统计未处理告警`;
DROP PROCEDURE IF EXISTS `sp_修复告警设备关联`;
DROP PROCEDURE IF EXISTS `sp_高等级告警自动派单_V2`;
DROP PROCEDURE IF EXISTS `sp_高等级告警自动派单`;
DROP PROCEDURE IF EXISTS `sp_高等级告警自动派单_优化`;
DROP PROCEDURE IF EXISTS `sp_误报审核`;
DROP PROCEDURE IF EXISTS `sp_告警误报审核`;
DROP PROCEDURE IF EXISTS `sp_完善误报审核流程`;
DROP PROCEDURE IF EXISTS `sp_基于规则生成告警`;
DROP PROCEDURE IF EXISTS `sp_优化运维工单分配`;
DROP PROCEDURE IF EXISTS `sp_设备通讯状态检测`;

DROP VIEW IF EXISTS `v_待审核误报告警`;

DROP EVENT IF EXISTS `event_高等级告警超时检查`;

-- ============================
-- 第二步：创建最终优化版对象（无冗余）
-- ============================

-- 1. 批量清理过期告警记录
DELIMITER ;;
CREATE DEFINER=`jw`@`%` PROCEDURE `sp_清理过期告警`(IN p_保留天数 INT)
BEGIN
    DELETE wo, alm
    FROM `告警信息表` alm
    LEFT JOIN `运维工单数据表` wo ON alm.`告警编号` = wo.`告警编号`
    WHERE alm.`处理状态` = '已结案'
      AND alm.`发生时间` < DATE_SUB(NOW(), INTERVAL p_保留天数 DAY);
    
    SELECT CONCAT('清理完成，共删除过期告警', ROW_COUNT(), '条') AS 清理结果;
END ;;
DELIMITER ;

-- 2. 按设备类型统计未处理告警
DELIMITER ;;
CREATE DEFINER=`jw`@`%` PROCEDURE `sp_统计未处理告警`(
    OUT p_变压器告警 INT, 
    OUT p_光伏设备告警 INT, 
    OUT p_能耗设备告警 INT
)
BEGIN
    -- 变压器告警统计
    SELECT COUNT(*) INTO p_变压器告警
    FROM `告警信息表`
    WHERE `处理状态` IN ('未处理', '处理中')
      AND `关联设备编号` IN (SELECT `设备编号` FROM `设备台账数据表` WHERE `设备类型` = '变压器');
    
    -- 光伏设备告警统计
    SELECT COUNT(*) INTO p_光伏设备告警
    FROM `告警信息表`
    WHERE `处理状态` IN ('未处理', '处理中')
      AND `关联设备编号` IN (SELECT `设备编号` FROM `光伏设备信息表`);
    
    -- 能耗设备告警统计
    SELECT COUNT(*) INTO p_能耗设备告警
    FROM `告警信息表`
    WHERE `处理状态` IN ('未处理', '处理中')
      AND `关联设备编号` IN (SELECT `设备编号` FROM `能耗计量设备信息表`);
END ;;
DELIMITER ;

-- 3. 修复告警设备关联关系
DELIMITER //
CREATE PROCEDURE `sp_修复告警设备关联`()
BEGIN
    DECLARE done INT DEFAULT FALSE;
    DECLARE v_alarm_id VARCHAR(20);
    DECLARE v_alarm_content VARCHAR(500);
    DECLARE v_current_device VARCHAR(20);
    DECLARE v_new_device VARCHAR(20);
    DECLARE v_device_exists INT;
    
    -- 游标：查询关联设备异常的告警
    DECLARE alarm_cursor CURSOR FOR 
        SELECT 告警编号, 告警内容, 关联设备编号
        FROM 告警信息表
        WHERE 关联设备编号 = 'UNKNOWN-DEVICE' 
           OR 关联设备编号 LIKE 'INVALID%'
           OR 关联设备编号 NOT IN (
               SELECT 设备编号 FROM 光伏设备信息表
               UNION 
               SELECT 设备编号 FROM 能耗计量设备信息表
               UNION
               SELECT 台账编号 FROM 设备台账数据表
           );
           
    DECLARE CONTINUE HANDLER FOR NOT FOUND SET done = TRUE;
    
    OPEN alarm_cursor;
    
    read_loop: LOOP
        FETCH alarm_cursor INTO v_alarm_id, v_alarm_content, v_current_device;
        IF done THEN
            LEAVE read_loop;
        END IF;
        
        -- 从告警内容提取变压器编号（示例规则）
        IF v_alarm_content LIKE '%变压器%' AND v_alarm_content REGEXP '[B|T][Y|Z]Q[0-9]{3}' THEN
            SET v_new_device = REGEXP_SUBSTR(v_alarm_content, '[B|T][Y|Z]Q[0-9]{3}');
            
            -- 验证设备是否存在
            SELECT COUNT(*) INTO v_device_exists 
            FROM 设备台账数据表 
            WHERE 台账编号 = v_new_device;
            
            IF v_device_exists > 0 THEN
                UPDATE 告警信息表
                SET 关联设备编号 = v_new_device
                WHERE 告警编号 = v_alarm_id;
            END IF;
        END IF;
    END LOOP;
    
    CLOSE alarm_cursor;
    SELECT CONCAT('已尝试修复 ', ROW_COUNT(), ' 条告警的设备关联') AS result;
END //
DELIMITER ;

-- 4. 高等级告警自动派单（基础版：单条派单）
DELIMITER //
CREATE PROCEDURE `sp_高等级告警自动派单`(
    IN p_告警编号 VARCHAR(20),
    IN p_运维人员ID VARCHAR(20)
)
BEGIN
    DECLARE v_工单编号 VARCHAR(20);
    DECLARE v_告警等级 VARCHAR(20);
    
    SELECT `告警等级` INTO v_告警等级 FROM `告警信息表` WHERE `告警编号` = p_告警编号;
    
    -- 仅高等级告警执行派单
    IF v_告警等级 = '高' THEN
        SET v_工单编号 = LEFT(CONCAT('WO-H-', DATE_FORMAT(NOW(), '%d%H%i%s')), 20);
        
        INSERT INTO `运维工单数据表` (
            `工单编号`, `告警编号`, `运维人员ID`, `派单时间`, `复查状态`
        ) VALUES (
            v_工单编号, p_告警编号, p_运维人员ID, NOW(), '待复查'
        );
        
        UPDATE `告警信息表` SET `处理状态` = '处理中' WHERE `告警编号` = p_告警编号;
        SELECT CONCAT('工单已创建：', v_工单编号) AS result;
    ELSE
        SELECT '非高等级告警，不支持自动派单' AS result;
    END IF;
END //
DELIMITER ;

-- 5. 高等级告警自动派单V2（批量检查+15分钟内派单）
DELIMITER //
CREATE PROCEDURE `sp_高等级告警自动派单_V2`()
BEGIN
    DECLARE done INT DEFAULT FALSE;
    DECLARE v_告警编号 VARCHAR(20);
    DECLARE v_发生时间 DATETIME;
    DECLARE v_告警等级 VARCHAR(20);
    DECLARE v_关联设备编号 VARCHAR(20);
    DECLARE v_运维人员ID VARCHAR(20);
    DECLARE v_超时分钟 INT;
    
    DECLARE alarm_cursor CURSOR FOR 
        SELECT a.`告警编号`, a.`发生时间`, a.`告警等级`, a.`关联设备编号`
        FROM `告警信息表` a
        WHERE a.`告警等级` = '高'
          AND a.`处理状态` = '未处理'
          AND a.`是否误报` = 0
          AND a.`自动派单状态` = 0
        ORDER BY a.`发生时间` ASC;
    
    DECLARE CONTINUE HANDLER FOR NOT FOUND SET done = TRUE;
    SET GLOBAL event_scheduler = ON; -- 启用事件调度器
    OPEN alarm_cursor;
    
    read_loop: LOOP
        FETCH alarm_cursor INTO v_告警编号, v_发生时间, v_告警等级, v_关联设备编号;
        IF done THEN LEAVE read_loop; END IF;
        
        SET v_超时分钟 = TIMESTAMPDIFF(MINUTE, v_发生时间, NOW());
        -- 15分钟内未派单的高等级告警执行分配
        IF v_超时分钟 <= 15 THEN
            SELECT `用户ID` INTO v_运维人员ID FROM `用户表` 
            WHERE `角色` LIKE '%运维%' ORDER BY RAND() LIMIT 1;
            
            IF v_运维人员ID IS NOT NULL THEN
                CALL `sp_高等级告警自动派单`(v_告警编号, v_运维人员ID);
                UPDATE `告警信息表` SET 
                    `自动派单状态` = 1, `最后派单时间` = NOW(), `派单尝试次数` = `派单尝试次数` + 1
                WHERE `告警编号` = v_告警编号;
            ELSE
                UPDATE `告警信息表` SET 
                    `自动派单状态` = 2, `最后派单时间` = NOW(), `派单尝试次数` = `派单尝试次数` + 1
                WHERE `告警编号` = v_告警编号;
            END IF;
        END IF;
    END LOOP;
    
    CLOSE alarm_cursor;
    SELECT CONCAT('已处理 ', FOUND_ROWS(), ' 条高等级告警派单检查') AS result;
END //
DELIMITER ;

-- 6. 高等级告警自动派单（优化版：超15分钟未派单强制分配）
DELIMITER //
CREATE PROCEDURE `sp_高等级告警自动派单_优化`()
BEGIN
    DECLARE done INT DEFAULT FALSE;
    DECLARE v_告警编号 VARCHAR(20);
    DECLARE v_发生时间 DATETIME;
    DECLARE v_关联设备编号 VARCHAR(20);
    DECLARE v_运维人员ID VARCHAR(20);
    DECLARE v_最近运维人员 VARCHAR(20);
    DECLARE v_工单编号 VARCHAR(20);
    
    DECLARE alarm_cursor CURSOR FOR 
        SELECT a.告警编号, a.发生时间, a.关联设备编号
        FROM 告警信息表 a
        WHERE a.告警等级 = '高'
          AND a.处理状态 = '未处理'
          AND a.是否误报 = 0
          AND a.自动派单状态 = 0
          AND TIMESTAMPDIFF(MINUTE, a.发生时间, NOW()) >= 15
        ORDER BY a.发生时间;
    
    DECLARE CONTINUE HANDLER FOR NOT FOUND SET done = TRUE;
    OPEN alarm_cursor;
    
    alarm_loop: LOOP
        FETCH alarm_cursor INTO v_告警编号, v_发生时间, v_关联设备编号;
        IF done THEN LEAVE alarm_loop; END IF;
        
        SET v_运维人员ID = NULL;
        -- 规则1：按设备类型匹配有经验的运维人员
        IF v_关联设备编号 LIKE 'INV%' OR v_关联设备编号 LIKE 'COMB%' THEN
            SELECT 运维人员ID INTO v_最近运维人员
            FROM (
                SELECT wo.运维人员ID, MAX(wo.处理完成时间) as last_time
                FROM 运维工单数据表 wo
                JOIN 告警信息表 a ON wo.告警编号 = a.告警编号
                WHERE (a.关联设备编号 LIKE 'INV%' OR a.关联设备编号 LIKE 'COMB%')
                  AND wo.复查状态 = '通过'
                GROUP BY wo.运维人员ID
                ORDER BY last_time DESC LIMIT 1
            ) AS recent_workers;
            SET v_运维人员ID = v_最近运维人员;
        ELSEIF v_关联设备编号 LIKE 'BYQ%' THEN
            SELECT 运维人员ID INTO v_最近运维人员
            FROM (
                SELECT wo.运维人员ID, MAX(wo.处理完成时间) as last_time
                FROM 运维工单数据表 wo
                JOIN 告警信息表 a ON wo.告警编号 = a.告警编号
                WHERE a.关联设备编号 LIKE 'BYQ%' AND wo.复查状态 = '通过'
                GROUP BY wo.运维人员ID
                ORDER BY last_time DESC LIMIT 1
            ) AS recent_workers;
            SET v_运维人员ID = v_最近运维人员;
        END IF;
        
        -- 规则2：无匹配人员则随机分配
        IF v_运维人员ID IS NULL THEN
            SELECT `用户ID` INTO v_运维人员ID FROM `用户表` 
            WHERE `角色` LIKE '%运维%' ORDER BY RAND() LIMIT 1;
        END IF;
        
        -- 执行派单
        IF v_运维人员ID IS NOT NULL THEN
            SET v_工单编号 = LEFT(CONCAT('WO-A-', DATE_FORMAT(NOW(), '%d%H%i%s')), 20);
            INSERT INTO 运维工单数据表 (
                工单编号, 告警编号, 运维人员ID, 派单时间, 复查状态
            ) VALUES (v_工单编号, v_告警编号, v_运维人员ID, NOW(), '待复查');
            
            UPDATE 告警信息表 SET 
                处理状态 = '处理中', 自动派单状态 = 1, 
                最后派单时间 = NOW(), 派单尝试次数 = 派单尝试次数 + 1
            WHERE 告警编号 = v_告警编号;
        ELSE
            UPDATE 告警信息表 SET 
                自动派单状态 = 2, 最后派单时间 = NOW(), 
                派单尝试次数 = 派单尝试次数 + 1
            WHERE 告警编号 = v_告警编号;
        END IF;
    END LOOP;
    
    CLOSE alarm_cursor;
END //
DELIMITER ;

-- 7. 优化运维工单分配（按设备类型+工作量均衡）
DELIMITER //
CREATE PROCEDURE `sp_优化运维工单分配`(IN p_告警编号 VARCHAR(20))
BEGIN
    DECLARE v_设备类型 VARCHAR(20);
    DECLARE v_设备位置 VARCHAR(50);
    DECLARE v_运维人员ID VARCHAR(20);
    DECLARE v_匹配规则 VARCHAR(50);
    DECLARE v_工单编号 VARCHAR(20);
    
    -- 获取告警关联设备信息
    SELECT 
        CASE 
            WHEN a.`关联设备编号` LIKE 'INV%' OR a.`关联设备编号` LIKE 'COMB%' THEN '光伏'
            WHEN a.`关联设备编号` LIKE 'BYQ%' THEN '变压器'
            WHEN a.`关联设备编号` LIKE 'NH%' THEN '能耗'
            ELSE '通用'
        END AS device_type,
        COALESCE(pv.`安装位置`, em.`安装位置`, s.`位置描述`, '未知位置') AS location
    INTO v_设备类型, v_设备位置
    FROM `告警信息表` a
    LEFT JOIN `光伏设备信息表` pv ON a.`关联设备编号` = pv.`设备编号`
    LEFT JOIN `能耗计量设备信息表` em ON a.`关联设备编号` = em.`设备编号`
    LEFT JOIN `配电房信息表` s ON a.`关联设备编号` = s.`配电房编号`
    WHERE a.`告警编号` = p_告警编号;
    
    -- 规则1：按设备类型匹配专业运维人员
    IF v_设备类型 = '光伏' THEN
        SELECT u.`用户ID` INTO v_运维人员ID
        FROM `用户表` u
        WHERE u.`角色` LIKE '%运维%'
          AND EXISTS (
              SELECT 1 FROM `运维工单数据表` wo
              JOIN `告警信息表` a2 ON wo.`告警编号` = a2.`告警编号`
              WHERE wo.`运维人员ID` = u.`用户ID`
                AND (a2.`关联设备编号` LIKE 'INV%' OR a2.`关联设备编号` LIKE 'COMB%')
                AND wo.`复查状态` = '通过'
          )
        ORDER BY (
            SELECT COUNT(*) FROM `运维工单数据表` wo2
            WHERE wo2.`运维人员ID` = u.`用户ID` AND wo2.`复查状态` = '待复查'
        ) ASC LIMIT 1;
        SET v_匹配规则 = '光伏设备专家';
    ELSEIF v_设备类型 = '变压器' THEN
        SELECT u.`用户ID` INTO v_运维人员ID
        FROM `用户表` u
        WHERE u.`角色` LIKE '%运维%'
          AND EXISTS (
              SELECT 1 FROM `运维工单数据表` wo
              JOIN `告警信息表` a2 ON wo.`告警编号` = a2.`告警编号`
              WHERE wo.`运维人员ID` = u.`用户ID`
                AND a2.`关联设备编号` LIKE 'BYQ%'
                AND wo.`复查状态` = '通过'
          )
        ORDER BY (
            SELECT COUNT(*) FROM `运维工单数据表` wo2
            WHERE wo2.`运维人员ID` = u.`用户ID` AND wo2.`复查状态` = '待复查'
        ) ASC LIMIT 1;
        SET v_匹配规则 = '变压器专家';
    END IF;
    
    -- 规则2：无专业人员则随机分配
    IF v_运维人员ID IS NULL THEN
        SELECT u.`用户ID` INTO v_运维人员ID FROM `用户表` 
        WHERE `角色` LIKE '%运维%' ORDER BY RAND() LIMIT 1;
        SET v_匹配规则 = '随机分配';
    END IF;
    
    -- 创建工单并更新告警状态
    IF v_运维人员ID IS NOT NULL THEN
        SET v_工单编号 = CONCAT('WO-OPT-', DATE_FORMAT(NOW(), '%m%d%H%i'));
        INSERT INTO `运维工单数据表` (
            `工单编号`, `告警编号`, `运维人员ID`, `派单时间`, `处理结果`, `复查状态`
        ) VALUES (
            v_工单编号, p_告警编号, v_运维人员ID, NOW(), 
            CONCAT('自动派单 - ', v_匹配规则), '待复查'
        );
        
        UPDATE `告警信息表` SET 
            `处理状态` = '处理中', `自动派单状态` = 1
        WHERE `告警编号` = p_告警编号;
        
        SELECT CONCAT('工单已创建:', v_工单编号, ', 分配给:', v_运维人员ID) AS result;
    ELSE
        SELECT '未找到合适的运维人员' AS result;
    END IF;
END //
DELIMITER ;

-- 8. 完善误报审核流程（事务+日志+工单联动）
DELIMITER //
CREATE PROCEDURE `sp_完善误报审核流程`(
    IN p_告警编号 VARCHAR(20),
    IN p_审核人ID VARCHAR(20),
    IN p_是否误报 TINYINT,
    IN p_误报原因 VARCHAR(200),
    IN p_审核备注 VARCHAR(500)
)
BEGIN
    DECLARE v_工单编号 VARCHAR(20);
    DECLARE v_告警内容 VARCHAR(500);
    DECLARE v_设备编号 VARCHAR(20);
    DECLARE v_误报标记 INT DEFAULT 0;
    
    START TRANSACTION; -- 开启事务保证数据一致性
    
    -- 获取告警基础信息
    SELECT `告警内容`, `关联设备编号` INTO v_告警内容, v_设备编号
    FROM `告警信息表` WHERE `告警编号` = p_告警编号;
    
    IF v_告警内容 IS NOT NULL THEN
        IF p_是否误报 = 1 THEN
            -- 标记为误报并结案
            UPDATE `告警信息表` SET 
                `是否误报` = 1, `误报审核人` = p_审核人ID, `误报审核时间` = NOW(),
                `误报原因` = p_误报原因, `处理状态` = '已结案', `自动派单状态` = 0,
                `告警内容` = CONCAT(`告警内容`, ' 【误报审核:', p_审核备注, '】')
            WHERE `告警编号` = p_告警编号;
            
            SET v_误报标记 = 1;
            
            -- 联动更新关联工单
            SELECT `工单编号` INTO v_工单编号
            FROM `运维工单数据表`
            WHERE `告警编号` = p_告警编号 AND `复查状态` != '通过';
            
            IF v_工单编号 IS NOT NULL THEN
                UPDATE `运维工单数据表` SET 
                    `处理结果` = CONCAT('告警经审核为误报：', p_误报原因, '。备注：', p_审核备注),
                    `复查状态` = '通过', `处理完成时间` = NOW()
                WHERE `工单编号` = v_工单编号;
                
                -- 记录系统日志
                INSERT INTO `系统日志表` (`日志内容`, `日志类型`, `关联ID`, `创建时间`)
                VALUES (
                    CONCAT('误报审核完成，告警:', p_告警编号, '，工单:', v_工单编号, '已取消'),
                    '误报处理', p_告警编号, NOW()
                );
            END IF;
            
            -- 通讯误报自动恢复设备状态
            IF p_误报原因 LIKE '%通讯%' OR p_误报原因 LIKE '%网络%' THEN
                UPDATE `光伏设备信息表` SET `运行状态` = '正常', `更新时间` = NOW()
                WHERE `设备编号` = v_设备编号 AND `运行状态` != '正常';
                
                UPDATE `能耗计量设备信息表` SET `运行状态` = '正常', `更新时间` = NOW()
                WHERE `设备编号` = v_设备编号 AND `运行状态` != '正常';
            END IF;
            
            SELECT '告警已标记为误报并结案' AS result;
        ELSE
            -- 确认为真实告警
            UPDATE `告警信息表` SET 
                `是否误报` = 0, `误报审核人` = p_审核人ID, `误报审核时间` = NOW(),
                `误报原因` = NULL, `告警内容` = CONCAT(`告警内容`, ' 【确认为真实告警:', p_审核备注, '】')
            WHERE `告警编号` = p_告警编号;
            
            -- 高/中等级未派单告警自动触发派单
            IF EXISTS (
                SELECT 1 FROM `告警信息表`
                WHERE `告警编号` = p_告警编号
                  AND `告警等级` IN ('高', '中')
                  AND `自动派单状态` = 0
            ) THEN
                CALL `sp_优化运维工单分配`(p_告警编号);
            END IF;
            
            SELECT '告警已确认为真实告警' AS result;
        END IF;
        
        -- 记录审核日志
        INSERT INTO `告警审核日志表` (
            `日志编号`, `告警编号`, `审核人ID`, `审核结果`, `审核原因`, `审核备注`, `审核时间`
        ) VALUES (
            CONCAT('AUDIT-', DATE_FORMAT(NOW(), '%Y%m%d%H%i%s')),
            p_告警编号, p_审核人ID,
            IF(p_是否误报 = 1, '误报', '真实告警'),
            p_误报原因, p_审核备注, NOW()
        );
    ELSE
        SELECT '告警不存在' AS result;
    END IF;
    
    COMMIT; -- 提交事务
END //
DELIMITER ;

-- 9. 基于规则生成告警（动态SQL+多表适配）
DELIMITER //
CREATE PROCEDURE `sp_基于规则生成告警`(
    IN p_设备类型 VARCHAR(20),
    IN p_设备编号 VARCHAR(20),
    IN p_数据表名 VARCHAR(50),
    IN p_数据记录 JSON
)
BEGIN
    DECLARE done INT DEFAULT FALSE;
    DECLARE v_规则编号 VARCHAR(20);
    DECLARE v_规则名称 VARCHAR(50);
    DECLARE v_触发条件 VARCHAR(200);
    DECLARE v_告警内容模板 VARCHAR(300);
    DECLARE v_告警等级 VARCHAR(10);
    DECLARE v_告警类型 VARCHAR(20);
    DECLARE v_最后触发时间 DATETIME;
    DECLARE v_抑制时长 INT;
    DECLARE v_实际条件 VARCHAR(500);
    DECLARE v_告警内容 VARCHAR(500);
    DECLARE v_check_sql VARCHAR(1000);
    DECLARE v_condition_met INT DEFAULT 0;
    
    DECLARE rule_cursor CURSOR FOR
        SELECT 
            r.`规则编号`, r.`规则名称`, r.`触发条件表达式`,
            r.`告警内容模板`, r.`告警等级`, r.`告警类型`,
            r.`最后触发时间`, r.`告警抑制时长`
        FROM `告警规则配置表` r
        WHERE r.`设备类型` = p_设备类型
          AND r.`是否启用` = 1
          AND (r.`设备子类型` IS NULL OR r.`设备子类型` = '所有类型' 
               OR EXISTS (
                   SELECT 1 FROM `设备台账数据表` d 
                   WHERE d.`台账编号` = p_设备编号 
                     AND d.`设备类型` LIKE CONCAT('%', r.`设备子类型`, '%')
               ))
        ORDER BY r.`优先级`;
    
    DECLARE CONTINUE HANDLER FOR NOT FOUND SET done = TRUE;
    OPEN rule_cursor;
    
    rule_loop: LOOP
        FETCH rule_cursor INTO 
            v_规则编号, v_规则名称, v_触发条件, v_告警内容模板,
            v_告警等级, v_告警类型, v_最后触发时间, v_抑制时长;
        
        IF done THEN LEAVE rule_loop; END IF;
        
        -- 抑制期内跳过
        IF v_最后触发时间 IS NOT NULL AND v_抑制时长 > 0 THEN
            IF TIMESTAMPDIFF(MINUTE, v_最后触发时间, NOW()) < v_抑制时长 THEN
                ITERATE rule_loop;
            END IF;
        END IF;
        
        -- 动态构建条件SQL
        SET v_实际条件 = REPLACE(v_触发条件, '{设备编号}', p_设备编号);
        SET v_check_sql = NULL;
        
        CASE p_数据表名
            WHEN '变压器监测数据表' THEN
                SET v_check_sql = CONCAT(
                    'SELECT COUNT(*) INTO @condition_met FROM `变压器监测数据表` ',
                    'WHERE `变压器编号` = ''', p_设备编号, ''' ',
                    'AND ', v_实际条件, ' AND `采集时间` >= DATE_SUB(NOW(), INTERVAL 5 MINUTE)'
                );
            WHEN '回路监测数据表' THEN
                SET v_check_sql = CONCAT(
                    'SELECT COUNT(*) INTO @condition_met FROM `回路监测数据表` ',
                    'WHERE `回路编号` = ''', p_设备编号, ''' ',
                    'AND ', v_实际条件, ' AND `采集时间` >= DATE_SUB(NOW(), INTERVAL 5 MINUTE)'
                );
            WHEN '光伏发电数据表' THEN
                SET v_check_sql = CONCAT(
                    'SELECT COUNT(*) INTO @condition_met FROM `光伏发电数据表` ',
                    'WHERE `设备编号` = ''', p_设备编号, ''' ',
                    'AND ', v_实际条件, ' AND `采集时间` >= DATE_SUB(NOW(), INTERVAL 5 MINUTE)'
                );
            WHEN '能耗监测数据表' THEN
                SET v_check_sql = CONCAT(
                    'SELECT COUNT(*) INTO @condition_met FROM `能耗监测数据表` ',
                    'WHERE `设备编号` = ''', p_设备编号, ''' ',
                    'AND ', v_实际条件, ' AND `采集时间` >= DATE_SUB(NOW(), INTERVAL 5 MINUTE)'
                );
        END CASE;
        
        -- 执行条件检查
        IF v_check_sql IS NOT NULL THEN
            SET @sql = v_check_sql;
            PREPARE stmt FROM @sql;
            EXECUTE stmt;
            DEALLOCATE PREPARE stmt;
            SET v_condition_met = @condition_met;
        END IF;
        
        -- 条件满足则生成告警
        IF v_condition_met > 0 THEN
            SET v_告警内容 = REPLACE(REPLACE(v_告警内容模板, '{设备编号}', p_设备编号), '{规则名称}', v_规则名称);
            
            INSERT INTO `告警信息表` (
                `告警编号`, `告警类型`, `关联设备编号`, `发生时间`,
                `告警等级`, `告警内容`, `处理状态`, `告警触发阈值`, `创建时间`
            ) VALUES (
                CONCAT('ALM-RULE-', v_规则编号, '-', DATE_FORMAT(NOW(), '%Y%m%d%H%i%s')),
                v_告警类型, p_设备编号, NOW(), v_告警等级, v_告警内容,
                '未处理', CONCAT('规则:', v_规则名称), NOW()
            );
            
            -- 更新规则触发记录
            UPDATE `告警规则配置表` SET 
                `最后触发时间` = NOW(), `触发次数` = `触发次数` + 1
            WHERE `规则编号` = v_规则编号;
        END IF;
        
        SET v_condition_met = 0;
    END LOOP;
    
    CLOSE rule_cursor;
    SELECT CONCAT('规则检查完成，设备:', p_设备编号) AS result;
END //
DELIMITER ;

-- 10. 设备通讯状态检测（自动生成离线告警）
DELIMITER //
CREATE PROCEDURE `sp_设备通讯状态检测`()
BEGIN
    -- 光伏设备离线告警
    INSERT INTO `告警信息表` (
        `告警编号`, `告警类型`, `关联设备编号`, `发生时间`,
        `告警等级`, `告警内容`, `处理状态`, `告警触发阈值`
    )
    SELECT 
        CONCAT('ALM-OFFLINE-', pv.`设备编号`, '-', DATE_FORMAT(NOW(), '%Y%m%d%H%i%s')),
        '通讯故障', pv.`设备编号`, NOW(),
        CASE 
            WHEN TIMESTAMPDIFF(HOUR, pv.`更新时间`, NOW()) > 24 THEN '高'
            WHEN TIMESTAMPDIFF(HOUR, pv.`更新时间`, NOW()) > 4 THEN '中'
            ELSE '低'
        END,
        CONCAT('光伏设备', pv.`设备编号`, '(', pv.`设备类型`, ')已离线',
               TIMESTAMPDIFF(HOUR, pv.`更新时间`, NOW()), '小时'),
        '未处理', '离线时间阈值:>1小时'
    FROM `光伏设备信息表` pv
    WHERE pv.`运行状态` = '离线'
      AND TIMESTAMPDIFF(HOUR, pv.`更新时间`, NOW()) > 1
      AND NOT EXISTS (
          SELECT 1 FROM `告警信息表` a 
          WHERE a.`关联设备编号` = pv.`设备编号`
            AND a.`告警类型` = '通讯故障'
            AND a.`处理状态` IN ('未处理', '处理中')
            AND DATE(a.`发生时间`) = CURDATE()
      );
    
    -- 能耗设备离线告警
    INSERT INTO `告警信息表` (
        `告警编号`, `告警类型`, `关联设备编号`, `发生时间`,
        `告警等级`, `告警内容`, `处理状态`, `告警触发阈值`
    )
    SELECT 
        CONCAT('ALM-OFFLINE-', em.`设备编号`, '-', DATE_FORMAT(NOW(), '%Y%m%d%H%i%s')),
        '通讯故障', em.`设备编号`, NOW(), '低',
        CONCAT('能耗设备', em.`设备编号`, '(', em.`能源类型`, ')超过12小时无数据'),
        '未处理', '无数据时间阈值:>12小时'
    FROM `能耗计量设备信息表` em
    WHERE em.`运行状态` = '正常'
      AND NOT EXISTS (
          SELECT 1 FROM `能耗监测数据表` emd
          WHERE emd.`设备编号` = em.`设备编号`
            AND emd.`采集时间` >= DATE_SUB(NOW(), INTERVAL 12 HOUR)
      )
      AND NOT EXISTS (
          SELECT 1 FROM `告警信息表` a 
          WHERE a.`关联设备编号` = em.`设备编号`
            AND a.`告警类型` = '通讯故障'
            AND a.`处理状态` IN ('未处理', '处理中')
            AND DATE(a.`发生时间`) = CURDATE()
      );
END //
DELIMITER ;

-- 11. 待审核误报告警视图
CREATE OR REPLACE VIEW `v_待审核误报告警` AS
SELECT 
    a.`告警编号`, a.`告警类型`, a.`告警等级`, a.`关联设备编号`,
    a.`发生时间`, a.`告警内容`, a.`处理状态`,
    TIMESTAMPDIFF(MINUTE, a.`发生时间`, NOW()) AS `告警持续时间(分钟)`,
    CASE 
        WHEN a.`告警等级` = '高' AND TIMESTAMPDIFF(MINUTE, a.`发生时间`, NOW()) > 15 THEN '需优先审核'
        WHEN a.`告警内容` LIKE '%波动%' OR a.`告警内容` LIKE '%通讯%' THEN '可能为误报'
        ELSE '待审核'
    END AS `审核优先级`
FROM `告警信息表` a
WHERE a.`是否误报` = 0
  AND a.`处理状态` = '未处理'
  AND a.`发生时间` >= DATE_SUB(NOW(), INTERVAL 7 DAY)
ORDER BY 
    CASE `审核优先级`
        WHEN '需优先审核' THEN 1
        WHEN '可能为误报' THEN 2
        ELSE 3
    END,
    a.`发生时间` DESC;

-- 12. 高等级告警超时检查事件（每分钟执行）
DELIMITER //
CREATE EVENT `event_高等级告警超时检查`
ON SCHEDULE EVERY 1 MINUTE
STARTS CURRENT_TIMESTAMP
DO
BEGIN
    -- 标记超时告警内容
    UPDATE `告警信息表`
    SET `告警内容` = CONCAT(`告警内容`, ' 【告警已超15分钟未自动派单，请手动处理！】')
    WHERE `告警等级` = '高'
      AND `处理状态` = '未处理'
      AND `是否误报` = 0
      AND `自动派单状态` = 0
      AND TIMESTAMPDIFF(MINUTE, `发生时间`, NOW()) > 15
      AND `告警内容` NOT LIKE '%【告警已超15分钟未自动派单%';
    
    -- 生成超时通知
    INSERT INTO `告警通知记录表` (
        `通知编号`, `告警编号`, `通知方式`, `通知内容`, `接收人ID`, `发送状态`, `发送时间`
    )
    SELECT 
        CONCAT('NOTIFY-', DATE_FORMAT(NOW(), '%Y%m%d%H%i%s'), '-', SUBSTRING(MD5(RAND()), 1, 6)),
        a.`告警编号`, '系统消息',
        CONCAT('高等级告警"', LEFT(a.`告警内容`, 50), '..."已超15分钟未自动派单，请及时处理！'),
        'admin', '待发送', NOW()
    FROM `告警信息表` a
    WHERE a.`告警等级` = '高'
      AND a.`处理状态` = '未处理'
      AND a.`是否误报` = 0
      AND TIMESTAMPDIFF(MINUTE, a.`发生时间`, NOW()) > 15
      AND NOT EXISTS (
          SELECT 1 FROM `告警通知记录表` n 
          WHERE n.`告警编号` = a.`告警编号`
            AND n.`通知内容` LIKE '%已超15分钟未自动派单%'
            AND DATE(n.`发送时间`) = CURDATE()
      );
END//
DELIMITER ;