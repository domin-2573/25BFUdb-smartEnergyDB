-- 创建事件：每天检查质保到期设备
DELIMITER //
CREATE EVENT `event_每日质保检查`
ON SCHEDULE EVERY 1 DAY
STARTS CURRENT_TIMESTAMP
DO
BEGIN
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
    )
    SELECT 
        CONCAT('ALM-WARRANTY-', DATE_FORMAT(NOW(), '%Y%m%d%H%i%s'), '-', SUBSTRING(MD5(RAND()), 1, 6)),
        '设备故障',
        t.`台账编号`,
        NOW(),
        '低',
        CONCAT('设备"', t.`设备名称`, '"质保期将于', 
               DATE_FORMAT(DATE_ADD(t.`安装时间`, INTERVAL t.`质保期（年）` YEAR), '%Y-%m-%d'), 
               '到期，请及时联系厂家处理'),
        '未处理',
        CONCAT('质保到期日:', DATE_FORMAT(DATE_ADD(t.`安装时间`, INTERVAL t.`质保期（年）` YEAR), '%Y-%m-%d')),
        NOW()
    FROM `设备台账数据表` t
    WHERE t.`报废状态` = '正常使用'
      AND t.`质保期（年）` IS NOT NULL
      AND DATE_ADD(t.`安装时间`, INTERVAL t.`质保期（年）` YEAR) 
          BETWEEN CURDATE() AND DATE_ADD(CURDATE(), INTERVAL 30 DAY)
      AND NOT EXISTS (
          SELECT 1 FROM `告警信息表` a 
          WHERE a.`关联设备编号` = t.`台账编号`
            AND a.`告警内容` LIKE CONCAT('%', t.`设备名称`, '%质保期将于%')
            AND DATE(a.`发生时间`) = CURDATE()
      );
END//
DELIMITER ;

-- 2. 创建事件调度器，每分钟检查一次
DELIMITER //

CREATE EVENT event_高等级告警自动派单检查
ON SCHEDULE EVERY 1 MINUTE
STARTS CURRENT_TIMESTAMP
DO
BEGIN
    -- 调用自动派单存储过程
    CALL sp_高等级告警自动派单_优化();
    
    -- 超时提醒
    UPDATE 告警信息表
    SET 告警内容 = CONCAT(告警内容, ' 【已超15分钟自动派单！】')
    WHERE 告警等级 = '高'
      AND 处理状态 = '未处理'
      AND TIMESTAMPDIFF(MINUTE, 发生时间, NOW()) >= 15
      AND 告警内容 NOT LIKE '%自动派单%';
END //

DELIMITER ;

