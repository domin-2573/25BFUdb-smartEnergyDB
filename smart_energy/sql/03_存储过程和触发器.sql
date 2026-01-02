-- ============================================
-- SmartEnergy智慧能源管理系统 - 存储过程和触发器
-- 每条业务线1个存储过程或触发器，共5个
-- ============================================

USE smart_energy;

-- ============================================
-- 1. 配电网监测业务线 - 触发器
-- ============================================

-- 触发器1：变压器运行状态异常时自动生成告警
DELIMITER //
CREATE TRIGGER `trg_变压器异常告警`
AFTER INSERT ON `变压器监测数据表`
FOR EACH ROW
BEGIN
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
            CONCAT('ALM-', DATE_FORMAT(NOW(), '%Y%m%d%H%i%s'), '-', SUBSTRING(MD5(RAND()), 1, 6)),
            '设备故障',
            NEW.`变压器编号`,
            NOW(),
            CASE 
                WHEN NEW.`绕组温度` > 120 THEN '高'
                WHEN NEW.`绕组温度` > 100 THEN '中'
                ELSE '低'
            END,
            CONCAT('变压器', NEW.`变压器编号`, '运行异常：绕组温度', NEW.`绕组温度`, '℃，负载率', NEW.`负载率`, '%'),
            '未处理',
            CONCAT('绕组温度阈值:95℃, 负载率阈值:100%')
        );
    END IF;
END//
DELIMITER ;

-- ============================================
-- 2. 分布式光伏管理业务线 - 触发器
-- ============================================

-- 触发器2：光伏预测偏差率超15%时触发模型优化提醒
DELIMITER //
CREATE TRIGGER `trg_光伏预测偏差提醒`
AFTER UPDATE ON `光伏预测数据表`
FOR EACH ROW
BEGIN
    -- 当实际发电量更新且偏差率超过15%时，生成告警提醒
    IF NEW.`实际发电量kWh` IS NOT NULL 
       AND OLD.`实际发电量kWh` IS NULL 
       AND ABS(NEW.`偏差率`) > 15 THEN
        
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
            CONCAT('ALM-PV-', DATE_FORMAT(NOW(), '%Y%m%d%H%i%s'), '-', SUBSTRING(MD5(RAND()), 1, 6)),
            '设备故障',
            NEW.`并网点编号`,
            NOW(),
            '中',
            CONCAT('光伏预测偏差率超15%：预测', NEW.`预测发电量kWh`, 'kWh，实际', NEW.`实际发电量kWh`, 'kWh，偏差率', NEW.`偏差率`, '%，建议优化预测模型'),
            '未处理',
            '偏差率阈值:15%'
        );
    END IF;
END//
DELIMITER ;

-- ============================================
-- 3. 综合能耗管理业务线 - 存储过程
-- ============================================

-- 存储过程1：自动计算并插入峰谷能耗数据
DELIMITER //
CREATE PROCEDURE `sp_计算峰谷能耗`(
    IN p_能源类型 VARCHAR(10),
    IN p_厂区编号 VARCHAR(10),
    IN p_统计日期 DATE
)
BEGIN
    DECLARE v_尖峰能耗 DECIMAL(12,2) DEFAULT 0;
    DECLARE v_高峰能耗 DECIMAL(12,2) DEFAULT 0;
    DECLARE v_平段能耗 DECIMAL(12,2) DEFAULT 0;
    DECLARE v_低谷能耗 DECIMAL(12,2) DEFAULT 0;
    DECLARE v_总能耗 DECIMAL(12,2) DEFAULT 0;
    DECLARE v_峰谷电价 DECIMAL(8,4) DEFAULT 0;
    DECLARE v_能耗成本 DECIMAL(12,2) DEFAULT 0;
    DECLARE v_记录编号 VARCHAR(20);
    
    -- 计算各时段能耗
    -- 尖峰：10:00-12:00, 16:00-18:00
    SELECT COALESCE(SUM(`能耗值`), 0) INTO v_尖峰能耗
    FROM `能耗监测数据表` emd
    INNER JOIN `能耗计量设备信息表` em ON emd.`设备编号` = em.`设备编号`
    WHERE em.`能源类型` = p_能源类型
      AND emd.`所属厂区编号` = p_厂区编号
      AND DATE(emd.`采集时间`) = p_统计日期
      AND (
          (HOUR(emd.`采集时间`) >= 10 AND HOUR(emd.`采集时间`) < 12)
          OR (HOUR(emd.`采集时间`) >= 16 AND HOUR(emd.`采集时间`) < 18)
      );
    
    -- 高峰：8:00-10:00, 12:00-16:00, 18:00-22:00
    SELECT COALESCE(SUM(`能耗值`), 0) INTO v_高峰能耗
    FROM `能耗监测数据表` emd
    INNER JOIN `能耗计量设备信息表` em ON emd.`设备编号` = em.`设备编号`
    WHERE em.`能源类型` = p_能源类型
      AND emd.`所属厂区编号` = p_厂区编号
      AND DATE(emd.`采集时间`) = p_统计日期
      AND (
          (HOUR(emd.`采集时间`) >= 8 AND HOUR(emd.`采集时间`) < 10)
          OR (HOUR(emd.`采集时间`) >= 12 AND HOUR(emd.`采集时间`) < 16)
          OR (HOUR(emd.`采集时间`) >= 18 AND HOUR(emd.`采集时间`) < 22)
      );
    
    -- 平段：6:00-8:00, 22:00-24:00
    SELECT COALESCE(SUM(`能耗值`), 0) INTO v_平段能耗
    FROM `能耗监测数据表` emd
    INNER JOIN `能耗计量设备信息表` em ON emd.`设备编号` = em.`设备编号`
    WHERE em.`能源类型` = p_能源类型
      AND emd.`所属厂区编号` = p_厂区编号
      AND DATE(emd.`采集时间`) = p_统计日期
      AND (
          (HOUR(emd.`采集时间`) >= 6 AND HOUR(emd.`采集时间`) < 8)
          OR (HOUR(emd.`采集时间`) >= 22)
      );
    
    -- 低谷：00:00-6:00
    SELECT COALESCE(SUM(`能耗值`), 0) INTO v_低谷能耗
    FROM `能耗监测数据表` emd
    INNER JOIN `能耗计量设备信息表` em ON emd.`设备编号` = em.`设备编号`
    WHERE em.`能源类型` = p_能源类型
      AND emd.`所属厂区编号` = p_厂区编号
      AND DATE(emd.`采集时间`) = p_统计日期
      AND HOUR(emd.`采集时间`) >= 0 AND HOUR(emd.`采集时间`) < 6;
    
    -- 计算总能耗
    SET v_总能耗 = v_尖峰能耗 + v_高峰能耗 + v_平段能耗 + v_低谷能耗;
    
    -- 设置电价（根据能源类型，这里使用示例值）
    SET v_峰谷电价 = CASE p_能源类型
        WHEN '电' THEN 0.85
        WHEN '水' THEN 3.50
        WHEN '蒸汽' THEN 200.00
        WHEN '天然气' THEN 3.20
        ELSE 0
    END;
    
    -- 计算成本（简化计算）
    SET v_能耗成本 = v_总能耗 * v_峰谷电价;
    
    -- 生成记录编号
    SET v_记录编号 = CONCAT('PV-', p_能源类型, '-', p_厂区编号, '-', DATE_FORMAT(p_统计日期, '%Y%m%d'));
    
    -- 插入或更新数据
    INSERT INTO `峰谷能耗数据表` (
        `记录编号`,
        `能源类型`,
        `厂区编号`,
        `统计日期`,
        `尖峰时段能耗`,
        `高峰时段能耗`,
        `平段能耗`,
        `低谷时段能耗`,
        `总能耗`,
        `峰谷电价`,
        `能耗成本`
    ) VALUES (
        v_记录编号,
        p_能源类型,
        p_厂区编号,
        p_统计日期,
        v_尖峰能耗,
        v_高峰能耗,
        v_平段能耗,
        v_低谷能耗,
        v_总能耗,
        v_峰谷电价,
        v_能耗成本
    ) ON DUPLICATE KEY UPDATE
        `尖峰时段能耗` = v_尖峰能耗,
        `高峰时段能耗` = v_高峰能耗,
        `平段能耗` = v_平段能耗,
        `低谷时段能耗` = v_低谷能耗,
        `总能耗` = v_总能耗,
        `能耗成本` = v_能耗成本;
END//
DELIMITER ;

-- ============================================
-- 4. 告警运维管理业务线 - 存储过程
-- ============================================

-- 存储过程2：高等级告警自动派单
DELIMITER //
CREATE PROCEDURE `sp_高等级告警自动派单`(
    IN p_告警编号 VARCHAR(20),
    IN p_运维人员ID VARCHAR(20)
)
BEGIN
    DECLARE v_工单编号 VARCHAR(20);
    DECLARE v_告警等级 VARCHAR(20);
    
    -- 检查告警等级
    SELECT `告警等级` INTO v_告警等级
    FROM `告警信息表`
    WHERE `告警编号` = p_告警编号;
    
    -- 只有高等级告警才自动派单
    IF v_告警等级 = '高' THEN
        -- 生成工单编号
        SET v_工单编号 = CONCAT('WO-', DATE_FORMAT(NOW(), '%Y%m%d%H%i%s'), '-', SUBSTRING(MD5(RAND()), 1, 6));
        
        -- 创建运维工单
        INSERT INTO `运维工单数据表` (
            `工单编号`,
            `告警编号`,
            `运维人员ID`,
            `派单时间`,
            `复查状态`
        ) VALUES (
            v_工单编号,
            p_告警编号,
            p_运维人员ID,
            NOW(),
            '待复查'
        );
        
        -- 更新告警状态为处理中
        UPDATE `告警信息表`
        SET `处理状态` = '处理中'
        WHERE `告警编号` = p_告警编号;
        
        SELECT CONCAT('工单已创建：', v_工单编号) AS result;
    ELSE
        SELECT '该告警等级不是高等级，无法自动派单' AS result;
    END IF;
END//
DELIMITER ;

-- ============================================
-- 5. 大屏数据展示业务线 - 存储过程
-- ============================================

-- 存储过程3：自动生成实时汇总数据
DELIMITER //
CREATE PROCEDURE `sp_生成实时汇总数据`()
BEGIN
    DECLARE v_汇总编号 VARCHAR(15);
    DECLARE v_总用电量 DECIMAL(18,2);
    DECLARE v_总用水量 DECIMAL(18,2);
    DECLARE v_总蒸汽消耗量 DECIMAL(18,2);
    DECLARE v_总天然气消耗量 DECIMAL(18,2);
    DECLARE v_光伏总发电量 DECIMAL(18,2);
    DECLARE v_光伏自用电量 DECIMAL(18,2);
    DECLARE v_总告警次数 INT;
    DECLARE v_高等级告警数 INT;
    DECLARE v_中等级告警数 INT;
    DECLARE v_低等级告警数 INT;
    
    -- 生成汇总编号
    SET v_汇总编号 = CONCAT('SUM-', DATE_FORMAT(NOW(), '%Y%m%d%H%i%s'));
    
    -- 计算总用电量（从回路监测数据表）
    SELECT COALESCE(SUM(`正向有功电量kWh`), 0) INTO v_总用电量
    FROM `回路监测数据表`
    WHERE DATE(`采集时间`) = CURDATE();
    
    -- 计算总用水量
    SELECT COALESCE(SUM(`能耗值`), 0) INTO v_总用水量
    FROM `能耗监测数据表` emd
    INNER JOIN `能耗计量设备信息表` em ON emd.`设备编号` = em.`设备编号`
    WHERE em.`能源类型` = '水'
      AND DATE(emd.`采集时间`) = CURDATE();
    
    -- 计算总蒸汽消耗量
    SELECT COALESCE(SUM(`能耗值`), 0) INTO v_总蒸汽消耗量
    FROM `能耗监测数据表` emd
    INNER JOIN `能耗计量设备信息表` em ON emd.`设备编号` = em.`设备编号`
    WHERE em.`能源类型` = '蒸汽'
      AND DATE(emd.`采集时间`) = CURDATE();
    
    -- 计算总天然气消耗量
    SELECT COALESCE(SUM(`能耗值`), 0) INTO v_总天然气消耗量
    FROM `能耗监测数据表` emd
    INNER JOIN `能耗计量设备信息表` em ON emd.`设备编号` = em.`设备编号`
    WHERE em.`能源类型` = '天然气'
      AND DATE(emd.`采集时间`) = CURDATE();
    
    -- 计算光伏总发电量和自用电量
    SELECT 
        COALESCE(SUM(`发电量kWh`), 0),
        COALESCE(SUM(`自用电量kWh`), 0)
    INTO v_光伏总发电量, v_光伏自用电量
    FROM `光伏发电数据表`
    WHERE DATE(`采集时间`) = CURDATE();
    
    -- 计算告警统计
    SELECT 
        COUNT(*),
        COUNT(CASE WHEN `告警等级` = '高' THEN 1 END),
        COUNT(CASE WHEN `告警等级` = '中' THEN 1 END),
        COUNT(CASE WHEN `告警等级` = '低' THEN 1 END)
    INTO v_总告警次数, v_高等级告警数, v_中等级告警数, v_低等级告警数
    FROM `告警信息表`
    WHERE DATE(`发生时间`) = CURDATE();
    
    -- 插入实时汇总数据
    INSERT INTO `实时汇总数据表` (
        `汇总编号`,
        `统计时间`,
        `总用电量kWh`,
        `总用水量m3`,
        `总蒸汽消耗量t`,
        `总天然气消耗量m3`,
        `光伏总发电量kWh`,
        `光伏自用电量kWh`,
        `总告警次数`,
        `高等级告警数`,
        `中等级告警数`,
        `低等级告警数`
    ) VALUES (
        v_汇总编号,
        NOW(),
        v_总用电量,
        v_总用水量,
        v_总蒸汽消耗量,
        v_总天然气消耗量,
        v_光伏总发电量,
        v_光伏自用电量,
        v_总告警次数,
        v_高等级告警数,
        v_中等级告警数,
        v_低等级告警数
    );
    
    SELECT CONCAT('实时汇总数据已生成：', v_汇总编号) AS result;
END//
DELIMITER ;

-- ============================================
-- 完成
-- ============================================
SELECT '所有存储过程和触发器创建完成！' AS message;

