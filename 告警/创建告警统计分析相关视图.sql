-- 创建告警统计分析相关视图
-- 1. 各类告警发生频率统计视图
CREATE OR REPLACE VIEW `v_告警发生频率统计` AS
SELECT 
    `告警类型`,
    `告警等级`,
    COUNT(*) AS `告警总数`,
    COUNT(CASE WHEN DATE(`发生时间`) = CURDATE() THEN 1 END) AS `今日告警数`,
    COUNT(CASE WHEN DATE(`发生时间`) = DATE_SUB(CURDATE(), INTERVAL 1 DAY) THEN 1 END) AS `昨日告警数`,
    COUNT(CASE WHEN MONTH(`发生时间`) = MONTH(CURDATE()) AND YEAR(`发生时间`) = YEAR(CURDATE()) THEN 1 END) AS `本月告警数`,
    ROUND(COUNT(*) / NULLIF(DATEDIFF(MAX(`发生时间`), MIN(`发生时间`)) + 1, 0), 2) AS `日均告警数`,
    ROUND(SUM(CASE WHEN `是否误报` = 1 THEN 1 ELSE 0 END) * 100.0 / COUNT(*), 2) AS `误报率百分比`
FROM `告警信息表`
GROUP BY `告警类型`, `告警等级`
ORDER BY `告警总数` DESC;

-- 2. 不同设备类型的告警分布视图
CREATE OR REPLACE VIEW `v_设备类型告警分布` AS
SELECT 
    CASE 
        WHEN a.`关联设备编号` LIKE 'BYQ%' THEN '变压器'
        WHEN a.`关联设备编号` LIKE 'INV%' OR a.`关联设备编号` LIKE 'COMB%' THEN '光伏设备'
        WHEN a.`关联设备编号` LIKE 'NH%' THEN '能耗设备'
        WHEN a.`关联设备编号` LIKE 'TZ%' THEN '台账设备'
        ELSE '其他设备'
    END AS `设备类型`,
    COUNT(*) AS `告警总数`,
    COUNT(CASE WHEN a.`告警等级` = '高' THEN 1 END) AS `高等级告警数`,
    COUNT(CASE WHEN a.`告警等级` = '中' THEN 1 END) AS `中等级告警数`,
    COUNT(CASE WHEN a.`告警等级` = '低' THEN 1 END) AS `低等级告警数`,
    COUNT(CASE WHEN a.`处理状态` = '未处理' THEN 1 END) AS `未处理告警数`,
    COUNT(CASE WHEN a.`处理状态` = '已结案' THEN 1 END) AS `已结案告警数`,
    ROUND(AVG(CASE WHEN wo.`处理完成时间` IS NOT NULL THEN 
        TIMESTAMPDIFF(MINUTE, wo.`派单时间`, wo.`处理完成时间`) END), 2) AS `平均处理时长(分钟)`
FROM `告警信息表` a
LEFT JOIN `运维工单数据表` wo ON a.`告警编号` = wo.`告警编号`
GROUP BY `设备类型`
ORDER BY `告警总数` DESC;

-- 3. 告警处理及时率统计视图
CREATE OR REPLACE VIEW `v_告警处理及时率统计` AS
SELECT 
    DATE(a.`发生时间`) AS `告警日期`,
    COUNT(*) AS `总告警数`,
    COUNT(CASE WHEN wo.`工单编号` IS NOT NULL THEN 1 END) AS `已派单数`,
    COUNT(CASE WHEN wo.`复查状态` = '通过' THEN 1 END) AS `已处理数`,
    COUNT(CASE WHEN wo.`响应时间` IS NOT NULL AND 
        TIMESTAMPDIFF(MINUTE, a.`发生时间`, wo.`响应时间`) <= 30 THEN 1 END) AS `30分钟内响应数`,
    COUNT(CASE WHEN wo.`处理完成时间` IS NOT NULL AND 
        TIMESTAMPDIFF(MINUTE, a.`发生时间`, wo.`处理完成时间`) <= 120 THEN 1 END) AS `2小时内解决数`,
    ROUND(COUNT(CASE WHEN wo.`响应时间` IS NOT NULL AND 
        TIMESTAMPDIFF(MINUTE, a.`发生时间`, wo.`响应时间`) <= 30 THEN 1 END) * 100.0 / 
        NULLIF(COUNT(CASE WHEN wo.`工单编号` IS NOT NULL THEN 1 END), 0), 2) AS `响应及时率`,
    ROUND(COUNT(CASE WHEN wo.`处理完成时间` IS NOT NULL AND 
        TIMESTAMPDIFF(MINUTE, a.`发生时间`, wo.`处理完成时间`) <= 120 THEN 1 END) * 100.0 / 
        NULLIF(COUNT(CASE WHEN wo.`复查状态` = '通过' THEN 1 END), 0), 2) AS `解决及时率`
FROM `告警信息表` a
LEFT JOIN `运维工单数据表` wo ON a.`告警编号` = wo.`告警编号`
WHERE a.`是否误报` = 0
GROUP BY DATE(a.`发生时间`)
ORDER BY `告警日期` DESC;

-- 4. 运维人员工作量统计视图
CREATE OR REPLACE VIEW `v_运维人员工作量统计` AS
SELECT 
    wo.`运维人员ID`,
    u.`姓名`,
    COUNT(DISTINCT wo.`工单编号`) AS `总工单数`,
    COUNT(DISTINCT CASE WHEN wo.`复查状态` = '通过' THEN wo.`工单编号` END) AS `已完成工单数`,
    COUNT(DISTINCT CASE WHEN wo.`复查状态` = '未通过' THEN wo.`工单编号` END) AS `未通过工单数`,
    COUNT(DISTINCT CASE WHEN wo.`响应时间` IS NULL THEN wo.`工单编号` END) AS `未响应工单数`,
    ROUND(AVG(TIMESTAMPDIFF(MINUTE, wo.`派单时间`, wo.`响应时间`)), 2) AS `平均响应时间(分钟)`,
    ROUND(AVG(TIMESTAMPDIFF(MINUTE, wo.`响应时间`, wo.`处理完成时间`)), 2) AS `平均处理时间(分钟)`,
    ROUND(AVG(TIMESTAMPDIFF(MINUTE, wo.`派单时间`, wo.`处理完成时间`)), 2) AS `平均总耗时(分钟)`,
    COUNT(DISTINCT CASE WHEN wo.`处理完成时间` IS NOT NULL AND 
        TIMESTAMPDIFF(MINUTE, wo.`派单时间`, wo.`处理完成时间`) <= 120 THEN wo.`工单编号` END) AS `2小时内完成数`
FROM `运维工单数据表` wo
LEFT JOIN `用户表` u ON wo.`运维人员ID` = u.`用户ID`
GROUP BY wo.`运维人员ID`, u.`姓名`
ORDER BY `总工单数` DESC;