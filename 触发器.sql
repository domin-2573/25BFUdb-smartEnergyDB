-- ============================================
-- 第一部分：设备台账相关触发器
-- ============================================

-- 1. 光伏设备台账同步
DROP TRIGGER IF EXISTS `trg_光伏设备台账同步`;

DELIMITER //

CREATE TRIGGER `trg_光伏设备台账同步` AFTER INSERT ON `光伏设备信息表` FOR EACH ROW
BEGIN
    -- 检查设备是否已存在于台账
    IF NOT EXISTS (
        SELECT 1 FROM `设备台账数据表`
        WHERE `台账编号` = NEW.`设备编号`
    ) THEN
        -- 插入新设备到台账
        INSERT INTO `设备台账数据表` (
            `台账编号`,
            `设备名称`,
            `设备类型`,
            `型号规格`,
            `安装时间`,
            `质保期_年`,
            `校准记录`,
            `报废状态`,
            `创建时间`,
            `更新时间`
        ) VALUES (
            NEW.`设备编号`,
            CONCAT('光伏', NEW.`设备类型`, '-', NEW.`设备编号`),
            NEW.`设备类型`,
            CONCAT('容量:', NEW.`装机容量kWp`, 'kWp, 协议:', NEW.`通信协议`),
            NEW.`投运时间`,
            5, -- 默认5年质保期
            CONCAT(DATE_FORMAT(NEW.`投运时间`, '%Y-%m-%d'), '-安装'),
            '正常使用',
            NOW(),
            NOW()
        );
    END IF;
END //

DELIMITER ;

-- 2. 能耗设备台账同步
DROP TRIGGER IF EXISTS `trg_能耗设备台账同步`;

DELIMITER //

CREATE TRIGGER `trg_能耗设备台账同步` AFTER INSERT ON `能耗计量设备信息表` FOR EACH ROW
BEGIN
    -- 检查设备是否已存在于台账
    IF NOT EXISTS (
        SELECT 1 FROM `设备台账数据表`
        WHERE `台账编号` = NEW.`设备编号`
    ) THEN
        -- 插入新设备到台账
        INSERT INTO `设备台账数据表` (
            `台账编号`,
            `设备名称`,
            `设备类型`,
            `型号规格`,
            `安装时间`,
            `质保期_年`,
            `校准记录`,
            `报废状态`,
            `创建时间`,
            `更新时间`
        ) VALUES (
            NEW.`设备编号`,
            CONCAT(NEW.`能源类型`, '计量设备-', NEW.`设备编号`),
            NEW.`能源类型`,
            CONCAT('管径:', NEW.`管径规格`, ', 协议:', NEW.`通讯协议`),
            CURDATE(), -- 使用当前日期作为安装时间
            CEILING(NEW.`校准周期` / 12.0), -- 将月转换为年（向上取整）
            CONCAT(DATE_FORMAT(CURDATE(), '%Y-%m-%d'), '-安装'),
            '正常使用',
            NOW(),
            NOW()
        );
    END IF;
END //

DELIMITER ;

-- ============================================
-- 第二部分：数据异常检测触发器
-- ============================================

-- 3. 能耗数据异常告警（合并两个版本）
DROP TRIGGER IF EXISTS `trg_能耗数据异常告警`;
DROP TRIGGER IF EXISTS `trg_能耗数据异常告警_基于规则`;

DELIMITER //

CREATE TRIGGER `trg_能耗数据异常告警` AFTER INSERT ON `能耗监测数据表` FOR EACH ROW
BEGIN
    DECLARE v_avg_能耗 DECIMAL(12,2);
    DECLARE v_规则匹配 INT DEFAULT 0;
    
    -- 优先使用规则系统
    SELECT COUNT(*) INTO v_规则匹配 
    FROM `告警规则配置表` 
    WHERE `设备类型` IN ('能耗设备', '所有类型') 
      AND `是否启用` = 1
      AND TIMESTAMPDIFF(MINUTE, `最后触发时间`, NOW()) >= `告警抑制时长`;
    
    IF v_规则匹配 > 0 THEN
        -- 使用规则系统
        CALL `sp_基于规则生成告警`(
            '能耗设备',
            NEW.`设备编号`,
            '能耗监测数据表',
            JSON_OBJECT(
                '能耗值', NEW.`能耗值`,
                '数据质量', NEW.`数据质量`,
                '单位', NEW.`单位`,
                '所属厂区编号', NEW.`所属厂区编号`
            )
        );
    ELSE
        -- 默认逻辑：数据质量中/差 或 能耗值波动超20%
        SELECT AVG(`能耗值`) INTO v_avg_能耗 
        FROM (
            SELECT `能耗值` 
            FROM `能耗监测数据表` 
            WHERE `设备编号` = NEW.`设备编号` 
            ORDER BY `采集时间` DESC 
            LIMIT 3
        ) AS t;
        
        IF NEW.`数据质量` IN ('中', '差') 
           OR (v_avg_能耗 > 0 AND (NEW.`能耗值` > v_avg_能耗 * 1.2 OR NEW.`能耗值` < v_avg_能耗 * 0.8)) 
        THEN
            -- 生成告警编号（确保不超过告警编号字段长度）
            INSERT INTO `告警信息表` (
                `告警编号`,
                `告警类型`,
                `关联设备编号`,
                `发生时间`,
                `告警等级`,
                `告警内容`,
                `处理状态`,
                `告警触发阈值`
            ) VALUES (
                CONCAT('ALM-NH-', DATE_FORMAT(NOW(), '%y%m%d%H%i')), -- 简化格式
                '越限告警',
                NEW.`设备编号`,
                NOW(),
                '低',
                CONCAT('能耗设备', NEW.`设备编号`, '（', NEW.`所属厂区编号`, '）数据异常：', 
                       NEW.`能耗值`, NEW.`单位`, '，质量:', NEW.`数据质量`),
                '未处理',
                CONCAT('质量阈值:良以上, 波动阈值:±20%')
            );
        END IF;
    END IF;
END //

DELIMITER ;

-- 4. 回路监测数据异常检测
DROP TRIGGER IF EXISTS `trg_回路监测数据异常检测`;

DELIMITER //

CREATE TRIGGER `trg_回路监测数据异常检测` AFTER INSERT ON `回路监测数据表` FOR EACH ROW
BEGIN
    DECLARE v_电压等级 VARCHAR(10);
    DECLARE v_告警内容 VARCHAR(500);
    DECLARE v_异常类型 VARCHAR(100);
    DECLARE v_告警等级 VARCHAR(10);
    DECLARE v_规则匹配 INT DEFAULT 0;
    
    -- 优先使用规则系统
    SELECT COUNT(*) INTO v_规则匹配 
    FROM `告警规则配置表` 
    WHERE `设备类型` = '回路' 
      AND `是否启用` = 1
      AND TIMESTAMPDIFF(MINUTE, `最后触发时间`, NOW()) >= `告警抑制时长`;
    
    IF v_规则匹配 > 0 THEN
        -- 使用规则系统
        CALL `sp_基于规则生成告警`(
            '回路',
            NEW.`回路编号`,
            '回路监测数据表',
            JSON_OBJECT(
                '电压kV', NEW.`电压kV`,
                '电缆头温度', NEW.`电缆头温度`,
                '电容器温度', NEW.`电容器温度`,
                '功率因数', NEW.`功率因数`,
                '配电房编号', NEW.`配电房编号`
            )
        );
    ELSE
        -- 传统检测逻辑（作为后备）
        SELECT `电压等级` INTO v_电压等级
        FROM `配电房信息表`
        WHERE `配电房编号` = NEW.`配电房编号`;
        
        SET v_异常类型 = '';
        SET v_告警等级 = '低';
        SET v_告警内容 = CONCAT('回路', NEW.`回路编号`, '异常：');
        
        -- 电压越限检测
        IF v_电压等级 LIKE '35kV%' AND (NEW.`电压kV` > 37.0 OR NEW.`电压kV` < 33.0) THEN
            SET v_异常类型 = CONCAT(v_异常类型, '电压越限,');
            SET v_告警等级 = '中';
        ELSEIF (v_电压等级 LIKE '10kV%' OR v_电压等级 LIKE '0.4kV%') 
               AND (NEW.`电压kV` > 0.42 OR NEW.`电压kV` < 0.38) THEN
            SET v_异常类型 = CONCAT(v_异常类型, '电压越限,');
            SET v_告警等级 = '中';
        END IF;
        
        -- 温度检测
        IF NEW.`电缆头温度` > 100 THEN
            SET v_异常类型 = CONCAT(v_异常类型, '电缆头温度过高,');
            SET v_告警等级 = '高';
        END IF;
        
        IF NEW.`电容器温度` > 75 THEN
            SET v_异常类型 = CONCAT(v_异常类型, '电容器温度过高,');
            SET v_告警等级 = '高';
        END IF;
        
        -- 功率因数检测
        IF NEW.`功率因数` < 0.85 THEN
            SET v_异常类型 = CONCAT(v_异常类型, '功率因数偏低,');
        END IF;
        
        -- 如果有异常
        IF LENGTH(v_异常类型) > 0 THEN
            -- 移除最后一个逗号
            SET v_异常类型 = TRIM(TRAILING ',' FROM v_异常类型);
            
            -- 更新数据状态
            UPDATE `回路监测数据表`
            SET `数据状态` = '异常'
            WHERE `数据编号` = NEW.`数据编号`;
            
            -- 生成告警
            INSERT INTO `告警信息表` (
                `告警编号`,
                `告警类型`,
                `关联设备编号`,
                `发生时间`,
                `告警等级`,
                `告警内容`,
                `处理状态`,
                `告警触发阈值`
            ) VALUES (
                CONCAT('ALM-C-', DATE_FORMAT(NOW(), '%y%m%d%H%i')),
                '越限告警',
                NEW.`回路编号`,
                NEW.`采集时间`,
                v_告警等级,
                CONCAT(v_告警内容, v_异常类型, '。电压:', NEW.`电压kV`, 'kV, 电缆头:', NEW.`电缆头温度`, '℃'),
                '未处理',
                CONCAT('电压阈值:正常范围, 温度:<100℃/75℃, 功率因数:>0.85')
            );
        END IF;
    END IF;
END //

DELIMITER ;

-- ============================================
-- 第三部分：告警处理相关触发器
-- ============================================

-- 5. 告警设备关联验证（优化版）
DROP TRIGGER IF EXISTS `trg_告警设备关联验证`;
DROP TRIGGER IF EXISTS `trg_告警设备关联更新`;

DELIMITER //

CREATE TRIGGER `trg_告警设备关联验证` BEFORE INSERT ON `告警信息表` FOR EACH ROW
BEGIN
    DECLARE v_device_exists INT DEFAULT 0;
    DECLARE v_matched_device VARCHAR(20);
    
    -- 如果关联设备编号为空，尝试从告警内容中提取
    IF NEW.`关联设备编号` IS NULL OR NEW.`关联设备编号` = '' THEN
        -- 从告警内容中提取可能的设备编号
        CASE
            -- 变压器相关
            WHEN NEW.`告警内容` LIKE '%变压器%' THEN
                SET v_matched_device = REGEXP_SUBSTR(NEW.`告警内容`, 'BYQ-?[0-9]+');
                IF v_matched_device IS NULL THEN
                    SET v_matched_device = REGEXP_SUBSTR(NEW.`告警内容`, '变压器[0-9]+');
                    IF v_matched_device IS NOT NULL THEN
                        SET v_matched_device = CONCAT('BYQ-', REGEXP_SUBSTR(v_matched_device, '[0-9]+'));
                    END IF;
                END IF;
                
            -- 光伏设备相关
            WHEN NEW.`告警内容` LIKE '%光伏%' OR NEW.`告警内容` LIKE '%逆变器%' THEN
                SET v_matched_device = REGEXP_SUBSTR(NEW.`告警内容`, 'INV-?[0-9]+');
                IF v_matched_device IS NULL THEN
                    SET v_matched_device = REGEXP_SUBSTR(NEW.`告警内容`, '逆变器[0-9]+');
                    IF v_matched_device IS NOT NULL THEN
                        SET v_matched_device = CONCAT('INV-', REGEXP_SUBSTR(v_matched_device, '[0-9]+'));
                    END IF;
                END IF;
                
            -- 能耗设备相关
            WHEN NEW.`告警内容` LIKE '%水%' OR NEW.`告警内容` LIKE '%蒸汽%' OR NEW.`告警内容` LIKE '%天然气%' THEN
                SET v_matched_device = REGEXP_SUBSTR(NEW.`告警内容`, 'NH-?[0-9]+');
                
            -- 回路相关
            WHEN NEW.`告警内容` LIKE '%回路%' THEN
                SET v_matched_device = REGEXP_SUBSTR(NEW.`告警内容`, 'L[0-9]+');
                IF v_matched_device IS NOT NULL THEN
                    SET v_matched_device = CONCAT('CIRCUIT-', v_matched_device);
                END IF;
        END CASE;
        
        -- 验证提取的设备编号是否存在
        IF v_matched_device IS NOT NULL THEN
            -- 检查光伏设备表
            SELECT COUNT(*) INTO v_device_exists 
            FROM `光伏设备信息表` 
            WHERE `设备编号` = v_matched_device;
            
            IF v_device_exists = 0 THEN
                -- 检查能耗设备表
                SELECT COUNT(*) INTO v_device_exists 
                FROM `能耗计量设备信息表` 
                WHERE `设备编号` = v_matched_device;
            END IF;
            
            IF v_device_exists = 0 THEN
                -- 检查设备台账表
                SELECT COUNT(*) INTO v_device_exists 
                FROM `设备台账数据表` 
                WHERE `台账编号` = v_matched_device;
            END IF;
            
            IF v_device_exists > 0 THEN
                SET NEW.`关联设备编号` = v_matched_device;
            END IF;
        END IF;
        
        -- 如果仍然没有关联设备，设置为默认值
        IF NEW.`关联设备编号` IS NULL OR NEW.`关联设备编号` = '' THEN
            SET NEW.`关联设备编号` = 'SYS-UNKNOWN';
        END IF;
    END IF;
    
    -- 设置创建时间（如果未提供）
    IF NEW.`创建时间` IS NULL THEN
        SET NEW.`创建时间` = NOW();
    END IF;
END //

DELIMITER ;

-- 6. 高等级告警即时派单
DROP TRIGGER IF EXISTS `trg_高等级告警即时派单`;

DELIMITER //

CREATE TRIGGER `trg_高等级告警即时派单` AFTER INSERT ON `告警信息表` FOR EACH ROW
BEGIN
    DECLARE v_运维人员ID VARCHAR(20);
    DECLARE v_工单编号 VARCHAR(20);
    
    -- 只处理高等级且非误报的告警
    IF NEW.`告警等级` = '高' AND NEW.`是否误报` = 0 AND NEW.`处理状态` = '未处理' THEN
        -- 查找工作量最少的运维人员
        SELECT u.`用户ID` INTO v_运维人员ID
        FROM `用户表` u
        WHERE u.`角色` LIKE '%运维%'
        ORDER BY (
            SELECT COUNT(*) 
            FROM `运维工单数据表` wo 
            WHERE wo.`运维人员ID` = u.`用户ID`
              AND wo.`复查状态` IN ('待复查', '未通过')
        ) ASC
        LIMIT 1;
        
        -- 如果找到运维人员，立即创建工单
        IF v_运维人员ID IS NOT NULL THEN
            -- 生成20字符以内的工单编号：WO-月日时分秒
            SET v_工单编号 = CONCAT('WO-', DATE_FORMAT(NOW(), '%m%d%H%i%s'));
            
            INSERT INTO `运维工单数据表` (
                `工单编号`,
                `告警编号`,
                `运维人员ID`,
                `派单时间`,
                `复查状态`,
                `处理结果`
            ) VALUES (
                v_工单编号,
                NEW.`告警编号`,
                v_运维人员ID,
                NOW(),
                '待复查',
                '高等级告警，系统自动派单，请立即处理。'
            );
            
            -- 更新告警状态
            UPDATE `告警信息表`
            SET `处理状态` = '处理中',
                `自动派单状态` = 1,
                `最后派单时间` = NOW(),
                `派单尝试次数` = `派单尝试次数` + 1
            WHERE `告警编号` = NEW.`告警编号`;
        END IF;
    END IF;
END //

DELIMITER ;

-- ============================================
-- 第四部分：工单处理相关触发器
-- ============================================

-- 7. 防止重复工单
DROP TRIGGER IF EXISTS `trg_防止重复工单`;

DELIMITER //

CREATE TRIGGER `trg_防止重复工单` BEFORE INSERT ON `运维工单数据表` FOR EACH ROW
BEGIN
    DECLARE v_existing_count INT;
    
    -- 检查是否已存在处理中的相同告警工单
    SELECT COUNT(*) INTO v_existing_count
    FROM `运维工单数据表` wo
    WHERE wo.`告警编号` = NEW.`告警编号`
      AND wo.`复查状态` IN ('待复查', '未通过');
    
    IF v_existing_count > 0 THEN
        SIGNAL SQLSTATE '45000'
        SET MESSAGE_TEXT = '该告警已有处理中的工单，不能重复创建';
    END IF;
END //

DELIMITER ;

-- 8. 工单结案更新告警状态
DROP TRIGGER IF EXISTS `trg_工单结案更新告警状态`;

DELIMITER //

CREATE TRIGGER `trg_工单结案更新告警状态` AFTER UPDATE ON `运维工单数据表` FOR EACH ROW
BEGIN
    -- 当工单复查通过时，更新对应告警状态
    IF OLD.`复查状态` != '通过' AND NEW.`复查状态` = '通过' THEN
        UPDATE `告警信息表`
        SET `处理状态` = '已结案'
        WHERE `告警编号` = NEW.`告警编号`;
    END IF;
END //

DELIMITER ;

-- 9. 工单完成更新设备台账
DROP TRIGGER IF EXISTS `trg_工单完成更新设备台账`;

DELIMITER //

CREATE TRIGGER `trg_工单完成更新设备台账` AFTER UPDATE ON `运维工单数据表` FOR EACH ROW
BEGIN
    -- 当工单复查通过时，更新设备台账
    IF NEW.`复查状态` = '通过' AND OLD.`复查状态` != '通过' THEN
        -- 更新设备台账的维修记录
        UPDATE `设备台账数据表`
        SET `维修记录` = CONCAT(COALESCE(`维修记录`, ''), ';', NEW.`工单编号`),
            `更新时间` = NOW()
        WHERE `台账编号` IN (
            SELECT `关联设备编号` 
            FROM `告警信息表` 
            WHERE `告警编号` = NEW.`告警编号`
        );
        
        -- 如果告警是设备故障类型，更新设备运行状态
        UPDATE `光伏设备信息表` pv
        JOIN `告警信息表` a ON pv.`设备编号` = a.`关联设备编号`
        SET pv.`运行状态` = '正常',
            pv.`更新时间` = NOW()
        WHERE a.`告警编号` = NEW.`告警编号`
          AND a.`告警类型` = '设备故障';
          
        UPDATE `能耗计量设备信息表` em
        JOIN `告警信息表` a ON em.`设备编号` = a.`关联设备编号`
        SET em.`运行状态` = '正常',
            em.`更新时间` = NOW()
        WHERE a.`告警编号` = NEW.`告警编号`
          AND a.`告警类型` = '设备故障';
    END IF;
END //

DELIMITER ;

-- ============================================
-- 第五部分：其他业务触发器
-- ============================================

-- 10. 质保到期提醒
DROP TRIGGER IF EXISTS `trg_质保到期提醒`;

DELIMITER //

CREATE TRIGGER `trg_质保到期提醒` AFTER INSERT ON `设备台账数据表` FOR EACH ROW
BEGIN
    DECLARE v_warranty_end_date DATE;
    DECLARE v_days_remaining INT;
    
    -- 检查设备是否已报废且有质保期
    IF NEW.`报废状态` != '已报废' AND NEW.`质保期_年` IS NOT NULL THEN
        -- 计算质保到期日
        SET v_warranty_end_date = DATE_ADD(DATE(NEW.`安装时间`), INTERVAL NEW.`质保期_年` YEAR);
        SET v_days_remaining = DATEDIFF(v_warranty_end_date, CURDATE());
        
        -- 如果质保期在30天内到期，生成提醒告警
        IF v_days_remaining BETWEEN 1 AND 30 THEN
            INSERT INTO `告警信息表` (
                `告警编号`,
                `告警类型`,
                `关联设备编号`,
                `发生时间`,
                `告警等级`,
                `告警内容`,
                `处理状态`,
                `告警触发阈值`,
                `创建时间`
            ) VALUES (
                CONCAT('ALM-W-', NEW.`台账编号`),
                '设备故障',
                NEW.`台账编号`,
                NOW(),
                CASE 
                    WHEN v_days_remaining <= 7 THEN '高'
                    WHEN v_days_remaining <= 15 THEN '中'
                    ELSE '低'
                END,
                CONCAT('设备"', NEW.`设备名称`, '"质保期将于', 
                       DATE_FORMAT(v_warranty_end_date, '%Y-%m-%d'), 
                       '到期，剩余', v_days_remaining, '天'),
                '未处理',
                CONCAT('到期日:', DATE_FORMAT(v_warranty_end_date, '%Y-%m-%d')),
                NOW()
            );
        END IF;
    END IF;
END //

DELIMITER ;

-- 11. 光伏预测偏差提醒
DROP TRIGGER IF EXISTS `trg_光伏预测偏差提醒`;

DELIMITER //

CREATE TRIGGER `trg_光伏预测偏差提醒` AFTER UPDATE ON `光伏预测数据表` FOR EACH ROW
BEGIN
    -- 当实际发电量更新且偏差率超过15%时，生成告警
    IF NEW.`实际发电量kWh` IS NOT NULL 
       AND OLD.`实际发电量kWh` IS NULL 
       AND ABS(NEW.`偏差率`) > 15 
    THEN
        INSERT INTO `告警信息表` (
            `告警编号`,
            `告警类型`,
            `关联设备编号`,
            `发生时间`,
            `告警等级`,
            `告警内容`,
            `处理状态`,
            `告警触发阈值`
        ) VALUES (
            CONCAT('ALM-PV-', DATE_FORMAT(NOW(), '%y%m%d%H%i')),
            '设备故障',
            NEW.`并网点编号`,
            NOW(),
            '中',
            CONCAT('光伏预测偏差超15%：预测', ROUND(NEW.`预测发电量kWh`, 2), 
                   'kWh，实际', ROUND(NEW.`实际发电量kWh`, 2), 
                   'kWh，偏差率', ROUND(NEW.`偏差率`, 2), '%'),
            '未处理',
            '偏差率阈值:15%'
        );
    END IF;
END //

DELIMITER ;

-- 12. 变压器异常告警
DROP TRIGGER IF EXISTS `trg_变压器异常告警_基于规则`;

DELIMITER //

CREATE TRIGGER `trg_变压器异常告警` AFTER INSERT ON `变压器监测数据表` FOR EACH ROW
BEGIN
    DECLARE v_规则匹配 INT DEFAULT 0;
    
    -- 检查是否有匹配的规则
    SELECT COUNT(*) INTO v_规则匹配
    FROM `告警规则配置表`
    WHERE `设备类型` = '变压器'
      AND `是否启用` = 1
      AND (`最后触发时间` IS NULL OR TIMESTAMPDIFF(MINUTE, `最后触发时间`, NOW()) >= `告警抑制时长`);
    
    IF v_规则匹配 > 0 THEN
        -- 使用规则系统
        CALL `sp_基于规则生成告警`(
            '变压器',
            NEW.`变压器编号`,
            '变压器监测数据表',
            JSON_OBJECT(
                '负载率', NEW.`负载率`,
                '绕组温度', NEW.`绕组温度`,
                '运行状态', NEW.`运行状态`,
                '配电房编号', NEW.`配电房编号`
            )
        );
    ELSE
        -- 传统逻辑：运行状态异常时生成告警
        IF NEW.`运行状态` = '异常' THEN
            INSERT INTO `告警信息表` (
                `告警编号`,
                `告警类型`,
                `关联设备编号`,
                `发生时间`,
                `告警等级`,
                `告警内容`,
                `处理状态`,
                `告警触发阈值`
            ) VALUES (
                CONCAT('ALM-TF-', DATE_FORMAT(NOW(), '%y%m%d%H%i')),
                '设备故障',
                NEW.`变压器编号`,
                NOW(),
                CASE 
                    WHEN NEW.`绕组温度` > 120 THEN '高'
                    WHEN NEW.`绕组温度` > 100 THEN '中'
                    ELSE '低'
                END,
                CONCAT('变压器', NEW.`变压器编号`, '异常：温度', 
                       NEW.`绕组温度`, '℃，负载率', NEW.`负载率`, '%'),
                '未处理',
                CONCAT('温度阈值:95℃, 负载率阈值:100%')
            );
        END IF;
    END IF;
END //

DELIMITER ;