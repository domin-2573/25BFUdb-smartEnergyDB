-- ============================================
-- SmartEnergy智慧能源管理系统 - 复杂查询语句
-- 5条连接3个及以上关系的SQL查询
-- ============================================

USE smart_energy;

-- ============================================
-- 查询1：查询某分厂配电房近7天的回路峰谷用电数据及对应变压器负载率
-- 连接关系：配电房信息表 + 回路监测数据表 + 变压器监测数据表（3个关系）
-- ============================================
SELECT 
    s.`配电房编号`,
    s.`名称` AS `配电房名称`,
    s.`位置描述`,
    DATE(cd.`采集时间`) AS `统计日期`,
    -- 回路数据统计
    COUNT(DISTINCT cd.`回路编号`) AS `回路数量`,
    SUM(CASE 
        WHEN HOUR(cd.`采集时间`) >= 10 AND HOUR(cd.`采集时间`) < 12 
             OR HOUR(cd.`采集时间`) >= 16 AND HOUR(cd.`采集时间`) < 18 
        THEN cd.`正向有功电量kWh` ELSE 0 
    END) AS `尖峰用电量`,
    SUM(CASE 
        WHEN (HOUR(cd.`采集时间`) >= 8 AND HOUR(cd.`采集时间`) < 10)
             OR (HOUR(cd.`采集时间`) >= 12 AND HOUR(cd.`采集时间`) < 16)
             OR (HOUR(cd.`采集时间`) >= 18 AND HOUR(cd.`采集时间`) < 22)
        THEN cd.`正向有功电量kWh` ELSE 0 
    END) AS `高峰用电量`,
    SUM(CASE 
        WHEN (HOUR(cd.`采集时间`) >= 6 AND HOUR(cd.`采集时间`) < 8)
             OR HOUR(cd.`采集时间`) >= 22
        THEN cd.`正向有功电量kWh` ELSE 0 
    END) AS `平段用电量`,
    SUM(CASE 
        WHEN HOUR(cd.`采集时间`) >= 0 AND HOUR(cd.`采集时间`) < 6
        THEN cd.`正向有功电量kWh` ELSE 0 
    END) AS `低谷用电量`,
    SUM(cd.`正向有功电量kWh`) AS `总用电量`,
    -- 变压器负载率统计
    AVG(td.`负载率`) AS `平均负载率`,
    MAX(td.`负载率`) AS `最大负载率`,
    MIN(td.`负载率`) AS `最小负载率`,
    AVG(td.`绕组温度`) AS `平均绕组温度`,
    COUNT(CASE WHEN td.`运行状态` = '异常' THEN 1 END) AS `异常变压器数`
FROM `配电房信息表` s
INNER JOIN `回路监测数据表` cd ON s.`配电房编号` = cd.`配电房编号`
LEFT JOIN `变压器监测数据表` td ON s.`配电房编号` = td.`配电房编号`
    AND DATE(td.`采集时间`) = DATE(cd.`采集时间`)
WHERE s.`位置描述` LIKE '%分厂%'
  AND cd.`采集时间` >= DATE_SUB(CURDATE(), INTERVAL 7 DAY)
  AND cd.`采集时间` < CURDATE()
GROUP BY s.`配电房编号`, s.`名称`, s.`位置描述`, DATE(cd.`采集时间`)
ORDER BY s.`配电房编号`, DATE(cd.`采集时间`) DESC;

-- ============================================
-- 查询2：统计各配电房高等级告警处理效率（平均处理时长）及运维人员工作量
-- 连接关系：配电房信息表 + 告警信息表 + 运维工单数据表 + 回路监测数据表/变压器监测数据表（4个关系）
-- ============================================
SELECT 
    s.`配电房编号`,
    s.`名称` AS `配电房名称`,
    s.`负责人ID`,
    -- 告警统计
    COUNT(DISTINCT a.`告警编号`) AS `高等级告警总数`,
    COUNT(CASE WHEN a.`处理状态` = '已结案' THEN 1 END) AS `已处理告警数`,
    COUNT(CASE WHEN a.`处理状态` = '未处理' THEN 1 END) AS `未处理告警数`,
    COUNT(CASE WHEN a.`处理状态` = '处理中' THEN 1 END) AS `处理中告警数`,
    -- 处理效率统计
    AVG(CASE 
        WHEN wo.`处理完成时间` IS NOT NULL 
        THEN TIMESTAMPDIFF(MINUTE, wo.`派单时间`, wo.`处理完成时间`)
        ELSE NULL 
    END) AS `平均处理时长分钟`,
    MIN(CASE 
        WHEN wo.`处理完成时间` IS NOT NULL 
        THEN TIMESTAMPDIFF(MINUTE, wo.`派单时间`, wo.`处理完成时间`)
        ELSE NULL 
    END) AS `最短处理时长分钟`,
    MAX(CASE 
        WHEN wo.`处理完成时间` IS NOT NULL 
        THEN TIMESTAMPDIFF(MINUTE, wo.`派单时间`, wo.`处理完成时间`)
        ELSE NULL 
    END) AS `最长处理时长分钟`,
    -- 运维人员工作量统计
    wo.`运维人员ID`,
    COUNT(DISTINCT wo.`工单编号`) AS `处理工单数`,
    COUNT(CASE WHEN wo.`复查状态` = '通过' THEN 1 END) AS `通过复查工单数`,
    COUNT(CASE WHEN wo.`复查状态` = '未通过' THEN 1 END) AS `未通过复查工单数`,
    -- 处理效率评价
    CASE 
        WHEN AVG(CASE WHEN wo.`处理完成时间` IS NOT NULL 
                      THEN TIMESTAMPDIFF(MINUTE, wo.`派单时间`, wo.`处理完成时间`)
                      ELSE NULL END) <= 30 THEN '高效'
        WHEN AVG(CASE WHEN wo.`处理完成时间` IS NOT NULL 
                      THEN TIMESTAMPDIFF(MINUTE, wo.`派单时间`, wo.`处理完成时间`)
                      ELSE NULL END) <= 60 THEN '正常'
        ELSE '需改进'
    END AS `处理效率评价`
FROM `配电房信息表` s
INNER JOIN `告警信息表` a ON (
    a.`关联设备编号` IN (
        SELECT CONCAT(s.`配电房编号`, '-', cd.`回路编号`)
        FROM `回路监测数据表` cd
        WHERE cd.`配电房编号` = s.`配电房编号`
        UNION
        SELECT td.`变压器编号`
        FROM `变压器监测数据表` td
        WHERE td.`配电房编号` = s.`配电房编号`
    )
)
LEFT JOIN `运维工单数据表` wo ON a.`告警编号` = wo.`告警编号`
WHERE a.`告警等级` = '高'
GROUP BY s.`配电房编号`, s.`名称`, s.`负责人ID`, wo.`运维人员ID`
ORDER BY `平均处理时长分钟` ASC, `处理工单数` DESC;

-- ============================================
-- 查询3：统计各厂区上月峰段/谷段用电量占比，筛选谷段用电占比低于30%的厂区
-- 连接关系：峰谷能耗数据表 + 能耗监测数据表 + 能耗计量设备信息表（3个关系）
-- ============================================
SELECT 
    pv.`厂区编号`,
    pv.`能源类型`,
    DATE_FORMAT(pv.`统计日期`, '%Y-%m') AS `统计月份`,
    -- 各时段能耗
    SUM(pv.`尖峰时段能耗`) AS `总尖峰能耗`,
    SUM(pv.`高峰时段能耗`) AS `总高峰能耗`,
    SUM(pv.`平段能耗`) AS `总平段能耗`,
    SUM(pv.`低谷时段能耗`) AS `总低谷能耗`,
    SUM(pv.`总能耗`) AS `总能耗`,
    -- 占比计算
    ROUND(SUM(pv.`尖峰时段能耗`) / SUM(pv.`总能耗`) * 100, 2) AS `尖峰占比`,
    ROUND(SUM(pv.`高峰时段能耗`) / SUM(pv.`总能耗`) * 100, 2) AS `高峰占比`,
    ROUND(SUM(pv.`平段能耗`) / SUM(pv.`总能耗`) * 100, 2) AS `平段占比`,
    ROUND(SUM(pv.`低谷时段能耗`) / SUM(pv.`总能耗`) * 100, 2) AS `谷段占比`,
    ROUND((SUM(pv.`尖峰时段能耗`) + SUM(pv.`高峰时段能耗`)) / SUM(pv.`总能耗`) * 100, 2) AS `峰段占比`,
    -- 成本统计
    SUM(pv.`能耗成本`) AS `总成本`,
    -- 能耗设备数量
    COUNT(DISTINCT em.`设备编号`) AS `设备数量`,
    -- 数据质量
    COUNT(CASE WHEN emd.`数据质量` IN ('优', '良') THEN 1 END) AS `优质数据数`,
    COUNT(CASE WHEN emd.`数据质量` IN ('中', '差') THEN 1 END) AS `待核实数据数`
FROM `峰谷能耗数据表` pv
LEFT JOIN `能耗监测数据表` emd ON pv.`厂区编号` = emd.`所属厂区编号`
    AND pv.`能源类型` = (
        SELECT em.`能源类型`
        FROM `能耗计量设备信息表` em
        WHERE em.`设备编号` = emd.`设备编号`
        LIMIT 1
    )
LEFT JOIN `能耗计量设备信息表` em ON emd.`设备编号` = em.`设备编号`
WHERE DATE_FORMAT(pv.`统计日期`, '%Y-%m') = DATE_FORMAT(DATE_SUB(CURDATE(), INTERVAL 1 MONTH), '%Y-%m')
  AND pv.`能源类型` = '电'
GROUP BY pv.`厂区编号`, pv.`能源类型`, DATE_FORMAT(pv.`统计日期`, '%Y-%m')
HAVING ROUND(SUM(pv.`低谷时段能耗`) / SUM(pv.`总能耗`) * 100, 2) < 30
ORDER BY `谷段占比` ASC, `总成本` DESC;

-- ============================================
-- 查询4：查询光伏设备发电效率与预测偏差的综合分析
-- 连接关系：光伏设备信息表 + 光伏发电数据表 + 光伏预测数据表（3个关系）
-- ============================================
SELECT 
    pd.`设备编号`,
    pd.`设备类型`,
    pd.`安装位置`,
    pd.`装机容量`,
    pd.`运行状态`,
    -- 发电数据统计
    COUNT(DISTINCT DATE(pgd.`采集时间`)) AS `有数据天数`,
    SUM(pgd.`发电量kWh`) AS `累计发电量`,
    AVG(pgd.`逆变器效率`) AS `平均效率`,
    MIN(pgd.`逆变器效率`) AS `最低效率`,
    MAX(pgd.`逆变器效率`) AS `最高效率`,
    -- 预测数据统计
    COUNT(DISTINCT pf.`预测编号`) AS `预测记录数`,
    SUM(pf.`预测发电量kWh`) AS `累计预测发电量`,
    SUM(COALESCE(pf.`实际发电量kWh`, 0)) AS `累计实际发电量`,
    AVG(ABS(pf.`偏差率`)) AS `平均偏差率`,
    COUNT(CASE WHEN ABS(pf.`偏差率`) > 15 THEN 1 END) AS `偏差超15%次数`,
    -- 效率评价
    CASE 
        WHEN AVG(pgd.`逆变器效率`) >= 90 THEN '优秀'
        WHEN AVG(pgd.`逆变器效率`) >= 85 THEN '良好'
        WHEN AVG(pgd.`逆变器效率`) >= 80 THEN '一般'
        ELSE '需优化'
    END AS `效率评价`,
    -- 预测准确性评价
    CASE 
        WHEN AVG(ABS(pf.`偏差率`)) <= 5 THEN '预测准确'
        WHEN AVG(ABS(pf.`偏差率`)) <= 10 THEN '预测较准确'
        WHEN AVG(ABS(pf.`偏差率`)) <= 15 THEN '预测一般'
        ELSE '预测需优化'
    END AS `预测准确性评价`
FROM `光伏设备信息表` pd
LEFT JOIN `光伏发电数据表` pgd ON pd.`设备编号` = pgd.`设备编号`
LEFT JOIN `光伏预测数据表` pf ON pgd.`并网点编号` = pf.`并网点编号`
    AND DATE(pgd.`采集时间`) = pf.`预测日期`
WHERE pd.`设备类型` = '逆变器'
GROUP BY pd.`设备编号`, pd.`设备类型`, pd.`安装位置`, pd.`装机容量`, pd.`运行状态`
HAVING `有数据天数` > 0
ORDER BY `平均效率` DESC, `平均偏差率` ASC;

-- ============================================
-- 查询5：综合能耗与告警关联分析（高耗能区域与设备故障关联）
-- 连接关系：能耗监测数据表 + 能耗计量设备信息表 + 告警信息表 + 运维工单数据表（4个关系）
-- ============================================
SELECT 
    emd.`所属厂区编号` AS `厂区编号`,
    em.`能源类型`,
    -- 能耗统计
    COUNT(DISTINCT emd.`设备编号`) AS `设备数量`,
    SUM(emd.`能耗值`) AS `总能耗`,
    AVG(emd.`能耗值`) AS `平均能耗`,
    MAX(emd.`能耗值`) AS `最大能耗`,
    -- 数据质量统计
    COUNT(CASE WHEN emd.`数据质量` = '优' THEN 1 END) AS `优质数据数`,
    COUNT(CASE WHEN emd.`数据质量` IN ('中', '差') THEN 1 END) AS `待核实数据数`,
    ROUND(COUNT(CASE WHEN emd.`数据质量` IN ('中', '差') THEN 1 END) / COUNT(*) * 100, 2) AS `待核实数据占比`,
    -- 告警统计
    COUNT(DISTINCT a.`告警编号`) AS `关联告警数`,
    COUNT(CASE WHEN a.`告警等级` = '高' THEN 1 END) AS `高等级告警数`,
    COUNT(CASE WHEN a.`告警等级` = '中' THEN 1 END) AS `中等级告警数`,
    COUNT(CASE WHEN a.`告警等级` = '低' THEN 1 END) AS `低等级告警数`,
    -- 工单统计
    COUNT(DISTINCT wo.`工单编号`) AS `关联工单数`,
    COUNT(CASE WHEN wo.`复查状态` = '通过' THEN 1 END) AS `通过复查工单数`,
    -- 能耗异常判断
    CASE 
        WHEN AVG(emd.`能耗值`) > (
            SELECT AVG(`能耗值`) * 1.3
            FROM `能耗监测数据表`
            WHERE `所属厂区编号` = emd.`所属厂区编号`
        ) THEN '高耗能区域'
        ELSE '正常能耗'
    END AS `能耗评价`,
    -- 综合风险评价
    CASE 
        WHEN COUNT(DISTINCT a.`告警编号`) > 5 
             AND COUNT(CASE WHEN emd.`数据质量` IN ('中', '差') THEN 1 END) > COUNT(*) * 0.2
        THEN '高风险'
        WHEN COUNT(DISTINCT a.`告警编号`) > 3
        THEN '中风险'
        ELSE '低风险'
    END AS `综合风险评价`
FROM `能耗监测数据表` emd
INNER JOIN `能耗计量设备信息表` em ON emd.`设备编号` = em.`设备编号`
LEFT JOIN `告警信息表` a ON em.`设备编号` = a.`关联设备编号`
LEFT JOIN `运维工单数据表` wo ON a.`告警编号` = wo.`告警编号`
WHERE emd.`采集时间` >= DATE_SUB(CURDATE(), INTERVAL 30 DAY)
GROUP BY emd.`所属厂区编号`, em.`能源类型`
HAVING `总能耗` > 0
ORDER BY `总能耗` DESC, `关联告警数` DESC;

-- ============================================
-- 完成
-- ============================================
SELECT '所有复杂查询语句创建完成！' AS message;

