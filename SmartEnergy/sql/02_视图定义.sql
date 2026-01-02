-- ============================================
-- SmartEnergy智慧能源管理系统 - 视图定义
-- 每条业务线至少3个视图，共15个视图
-- ============================================

USE smart_energy;

-- ============================================
-- 1. 配电网监测业务线视图（3个）
-- ============================================

-- 视图1：回路异常数据视图
-- 用途：查询所有异常回路数据，关联配电房信息
CREATE OR REPLACE VIEW `v_回路异常数据` AS
SELECT 
    cd.`数据编号`,
    cd.`配电房编号`,
    s.`名称` AS `配电房名称`,
    s.`位置描述`,
    cd.`回路编号`,
    cd.`采集时间`,
    cd.`电压kV`,
    cd.`电流A`,
    cd.`有功功率kW`,
    cd.`功率因数`,
    cd.`开关状态`,
    cd.`电缆头温度`,
    cd.`电容器温度`,
    cd.`数据状态`,
    CASE 
        WHEN cd.`电压kV` > 37.0 OR cd.`电压kV` < 33.0 THEN '电压越限'
        WHEN cd.`电缆头温度` > 100 THEN '电缆头温度过高'
        WHEN cd.`电容器温度` > 75 THEN '电容器温度过高'
        WHEN cd.`功率因数` < 0.85 THEN '功率因数偏低'
        ELSE '其他异常'
    END AS `异常类型`
FROM `回路监测数据表` cd
INNER JOIN `配电房信息表` s ON cd.`配电房编号` = s.`配电房编号`
WHERE cd.`数据状态` = '异常'
ORDER BY cd.`采集时间` DESC;

-- 视图2：配电房运行状态汇总视图
-- 用途：汇总每个配电房的回路和变压器运行状态
CREATE OR REPLACE VIEW `v_配电房运行状态汇总` AS
SELECT 
    s.`配电房编号`,
    s.`名称` AS `配电房名称`,
    s.`电压等级`,
    s.`变压器数量`,
    COUNT(DISTINCT cd.`回路编号`) AS `回路数量`,
    COUNT(CASE WHEN cd.`数据状态` = '异常' THEN 1 END) AS `异常回路数`,
    COUNT(CASE WHEN td.`运行状态` = '异常' THEN 1 END) AS `异常变压器数`,
    MAX(cd.`采集时间`) AS `最新回路数据时间`,
    MAX(td.`采集时间`) AS `最新变压器数据时间`
FROM `配电房信息表` s
LEFT JOIN `回路监测数据表` cd ON s.`配电房编号` = cd.`配电房编号`
LEFT JOIN `变压器监测数据表` td ON s.`配电房编号` = td.`配电房编号`
GROUP BY s.`配电房编号`, s.`名称`, s.`电压等级`, s.`变压器数量`;

-- 视图3：变压器负载率趋势视图
-- 用途：查询变压器负载率变化趋势，关联配电房信息
CREATE OR REPLACE VIEW `v_变压器负载率趋势` AS
SELECT 
    td.`数据编号`,
    td.`配电房编号`,
    s.`名称` AS `配电房名称`,
    td.`变压器编号`,
    td.`采集时间`,
    td.`负载率`,
    td.`绕组温度`,
    td.`环境温度`,
    td.`运行状态`,
    CASE 
        WHEN td.`负载率` > 100 THEN '超载'
        WHEN td.`负载率` > 80 THEN '高负载'
        WHEN td.`负载率` > 50 THEN '中负载'
        ELSE '低负载'
    END AS `负载等级`
FROM `变压器监测数据表` td
INNER JOIN `配电房信息表` s ON td.`配电房编号` = s.`配电房编号`
ORDER BY td.`采集时间` DESC;

-- ============================================
-- 2. 分布式光伏管理业务线视图（3个）
-- ============================================

-- 视图4：光伏日发电量视图
-- 用途：按日期汇总每个设备的总发电量
CREATE OR REPLACE VIEW `v_光伏日发电量` AS
SELECT 
    DATE(pgd.`采集时间`) AS `统计日期`,
    pgd.`设备编号`,
    pd.`设备类型`,
    pd.`安装位置`,
    pd.`装机容量`,
    COUNT(*) AS `数据条数`,
    SUM(pgd.`发电量kWh`) AS `日总发电量`,
    SUM(pgd.`上网电量kWh`) AS `日总上网电量`,
    SUM(pgd.`自用电量kWh`) AS `日总自用电量`,
    AVG(pgd.`逆变器效率`) AS `平均效率`,
    MIN(pgd.`采集时间`) AS `最早采集时间`,
    MAX(pgd.`采集时间`) AS `最晚采集时间`
FROM `光伏发电数据表` pgd
INNER JOIN `光伏设备信息表` pd ON pgd.`设备编号` = pd.`设备编号`
GROUP BY DATE(pgd.`采集时间`), pgd.`设备编号`, pd.`设备类型`, pd.`安装位置`, pd.`装机容量`
ORDER BY `统计日期` DESC, `日总发电量` DESC;

-- 视图5：光伏预测偏差视图
-- 用途：对比预测数据与实际数据，计算偏差率
CREATE OR REPLACE VIEW `v_光伏预测偏差` AS
SELECT 
    pf.`预测编号`,
    pf.`并网点编号`,
    pf.`预测日期`,
    pf.`预测时段`,
    pf.`预测发电量kWh`,
    pf.`实际发电量kWh`,
    pf.`偏差率`,
    pf.`预测模型版本`,
    CASE 
        WHEN pf.`偏差率` > 15 THEN '需要优化'
        WHEN pf.`偏差率` > 10 THEN '偏差较大'
        WHEN pf.`偏差率` > 5 THEN '偏差适中'
        ELSE '偏差较小'
    END AS `偏差等级`,
    ABS(pf.`预测发电量kWh` - COALESCE(pf.`实际发电量kWh`, 0)) AS `绝对偏差`
FROM `光伏预测数据表` pf
WHERE pf.`实际发电量kWh` IS NOT NULL
ORDER BY pf.`预测日期` DESC, ABS(pf.`偏差率`) DESC;

-- 视图6：光伏设备运行状态视图
-- 用途：汇总每个光伏设备的运行状态和最新数据
CREATE OR REPLACE VIEW `v_光伏设备运行状态` AS
SELECT 
    pd.`设备编号`,
    pd.`设备类型`,
    pd.`安装位置`,
    pd.`装机容量`,
    pd.`运行状态`,
    pd.`通信协议`,
    COUNT(pgd.`数据编号`) AS `数据记录数`,
    MAX(pgd.`采集时间`) AS `最新数据时间`,
    AVG(pgd.`逆变器效率`) AS `平均效率`,
    SUM(pgd.`发电量kWh`) AS `累计发电量`,
    CASE 
        WHEN pd.`运行状态` = '故障' THEN '需要维修'
        WHEN pd.`运行状态` = '离线' THEN '需要检查通讯'
        WHEN AVG(pgd.`逆变器效率`) < 85 THEN '效率偏低'
        ELSE '运行正常'
    END AS `状态说明`
FROM `光伏设备信息表` pd
LEFT JOIN `光伏发电数据表` pgd ON pd.`设备编号` = pgd.`设备编号`
GROUP BY pd.`设备编号`, pd.`设备类型`, pd.`安装位置`, pd.`装机容量`, pd.`运行状态`, pd.`通信协议`
ORDER BY pd.`运行状态`, `最新数据时间` DESC;

-- ============================================
-- 3. 综合能耗管理业务线视图（3个）
-- ============================================

-- 视图7：厂区能耗汇总视图
-- 用途：按厂区汇总各能源类型的总能耗
CREATE OR REPLACE VIEW `v_厂区能耗汇总` AS
SELECT 
    emd.`所属厂区编号` AS `厂区编号`,
    em.`能源类型`,
    COUNT(*) AS `数据记录数`,
    SUM(emd.`能耗值`) AS `总能耗`,
    AVG(emd.`能耗值`) AS `平均能耗`,
    MAX(emd.`能耗值`) AS `最大能耗`,
    MIN(emd.`能耗值`) AS `最小能耗`,
    COUNT(CASE WHEN emd.`数据质量` = '优' THEN 1 END) AS `优质数据数`,
    COUNT(CASE WHEN emd.`数据质量` IN ('中', '差') THEN 1 END) AS `待核实数据数`,
    MAX(emd.`采集时间`) AS `最新数据时间`
FROM `能耗监测数据表` emd
INNER JOIN `能耗计量设备信息表` em ON emd.`设备编号` = em.`设备编号`
GROUP BY emd.`所属厂区编号`, em.`能源类型`
ORDER BY emd.`所属厂区编号`, `总能耗` DESC;

-- 视图8：峰谷能耗分析视图
-- 用途：分析各厂区的峰谷能耗占比和成本
CREATE OR REPLACE VIEW `v_峰谷能耗分析` AS
SELECT 
    `厂区编号`,
    `能源类型`,
    `统计日期`,
    `尖峰时段能耗`,
    `高峰时段能耗`,
    `平段能耗`,
    `低谷时段能耗`,
    `总能耗`,
    `能耗成本`,
    ROUND((`低谷时段能耗` / `总能耗` * 100), 2) AS `谷段占比`,
    ROUND(((`尖峰时段能耗` + `高峰时段能耗`) / `总能耗` * 100), 2) AS `峰段占比`,
    CASE 
        WHEN (`低谷时段能耗` / `总能耗` * 100) < 30 THEN '谷段占比偏低'
        WHEN (`低谷时段能耗` / `总能耗` * 100) > 50 THEN '谷段占比偏高'
        ELSE '谷段占比正常'
    END AS `能耗评价`
FROM `峰谷能耗数据表`
ORDER BY `统计日期` DESC, `能耗成本` DESC;

-- 视图9：能耗数据质量监控视图
-- 用途：监控各设备的数据质量情况
CREATE OR REPLACE VIEW `v_能耗数据质量监控` AS
SELECT 
    em.`设备编号`,
    em.`能源类型`,
    em.`安装位置`,
    em.`运行状态`,
    COUNT(emd.`数据编号`) AS `总数据数`,
    COUNT(CASE WHEN emd.`数据质量` = '优' THEN 1 END) AS `优质数据数`,
    COUNT(CASE WHEN emd.`数据质量` = '良' THEN 1 END) AS `良好数据数`,
    COUNT(CASE WHEN emd.`数据质量` = '中' THEN 1 END) AS `中等数据数`,
    COUNT(CASE WHEN emd.`数据质量` = '差' THEN 1 END) AS `差数据数`,
    ROUND(COUNT(CASE WHEN emd.`数据质量` IN ('优', '良') THEN 1 END) / COUNT(*) * 100, 2) AS `数据优良率`,
    MAX(emd.`采集时间`) AS `最新数据时间`,
    CASE 
        WHEN COUNT(CASE WHEN emd.`数据质量` IN ('中', '差') THEN 1 END) > COUNT(*) * 0.2 THEN '需要校准'
        WHEN em.`运行状态` = '故障' THEN '需要维修'
        ELSE '运行正常'
    END AS `设备状态`
FROM `能耗计量设备信息表` em
LEFT JOIN `能耗监测数据表` emd ON em.`设备编号` = emd.`设备编号`
GROUP BY em.`设备编号`, em.`能源类型`, em.`安装位置`, em.`运行状态`
ORDER BY `数据优良率` ASC, `最新数据时间` DESC;

-- ============================================
-- 4. 告警运维管理业务线视图（3个）
-- ============================================

-- 视图10：高等级告警视图
-- 用途：查询所有高等级未处理告警，关联设备信息
CREATE OR REPLACE VIEW `v_高等级告警` AS
SELECT 
    a.`告警编号`,
    a.`告警类型`,
    a.`关联设备编号`,
    a.`发生时间`,
    a.`告警等级`,
    a.`告警内容`,
    a.`处理状态`,
    a.`告警触发阈值`,
    TIMESTAMPDIFF(MINUTE, a.`发生时间`, NOW()) AS `告警持续时间分钟`,
    CASE 
        WHEN a.`告警等级` = '高' AND TIMESTAMPDIFF(MINUTE, a.`发生时间`, NOW()) > 15 AND a.`处理状态` = '未处理' THEN '超时未处理'
        WHEN a.`处理状态` = '未处理' THEN '待处理'
        WHEN a.`处理状态` = '处理中' THEN '处理中'
        ELSE '已处理'
    END AS `告警状态`
FROM `告警信息表` a
WHERE a.`告警等级` = '高'
ORDER BY a.`发生时间` DESC;

-- 视图11：运维工单处理效率视图
-- 用途：统计运维工单的处理效率和人员工作量
CREATE OR REPLACE VIEW `v_运维工单处理效率` AS
SELECT 
    wo.`工单编号`,
    wo.`告警编号`,
    a.`告警类型`,
    a.`告警等级`,
    wo.`运维人员ID`,
    wo.`派单时间`,
    wo.`响应时间`,
    wo.`处理完成时间`,
    wo.`复查状态`,
    TIMESTAMPDIFF(MINUTE, wo.`派单时间`, wo.`响应时间`) AS `响应时长分钟`,
    TIMESTAMPDIFF(MINUTE, wo.`响应时间`, wo.`处理完成时间`) AS `处理时长分钟`,
    TIMESTAMPDIFF(MINUTE, wo.`派单时间`, wo.`处理完成时间`) AS `总处理时长分钟`,
    CASE 
        WHEN wo.`处理完成时间` IS NULL THEN '未完成'
        WHEN wo.`复查状态` = '通过' THEN '已完成'
        WHEN wo.`复查状态` = '未通过' THEN '需重新处理'
        ELSE '待复查'
    END AS `工单状态`
FROM `运维工单数据表` wo
INNER JOIN `告警信息表` a ON wo.`告警编号` = a.`告警编号`
ORDER BY wo.`派单时间` DESC;

-- 视图12：设备台账全生命周期视图
-- 用途：汇总设备台账信息，包括维修和校准记录
CREATE OR REPLACE VIEW `v_设备台账全生命周期` AS
SELECT 
    el.`台账编号`,
    el.`设备名称`,
    el.`设备类型`,
    el.`型号规格`,
    el.`安装时间`,
    el.`质保期`,
    DATE_ADD(el.`安装时间`, INTERVAL el.`质保期` YEAR) AS `质保到期时间`,
    DATEDIFF(DATE_ADD(el.`安装时间`, INTERVAL el.`质保期` YEAR), CURDATE()) AS `距离质保到期天数`,
    el.`维修记录`,
    el.`校准记录`,
    el.`报废状态`,
    COUNT(DISTINCT a.`告警编号`) AS `关联告警数`,
    COUNT(DISTINCT wo.`工单编号`) AS `关联工单数`,
    CASE 
        WHEN DATEDIFF(DATE_ADD(el.`安装时间`, INTERVAL el.`质保期` YEAR), CURDATE()) <= 30 
             AND DATEDIFF(DATE_ADD(el.`安装时间`, INTERVAL el.`质保期` YEAR), CURDATE()) > 0 THEN '质保即将到期'
        WHEN DATEDIFF(DATE_ADD(el.`安装时间`, INTERVAL el.`质保期` YEAR), CURDATE()) <= 0 THEN '质保已过期'
        WHEN el.`报废状态` = '已报废' THEN '已报废'
        ELSE '正常使用'
    END AS `设备状态`
FROM `设备台账数据表` el
LEFT JOIN `告警信息表` a ON el.`台账编号` = a.`关联设备编号`
LEFT JOIN `运维工单数据表` wo ON a.`告警编号` = wo.`告警编号`
GROUP BY el.`台账编号`, el.`设备名称`, el.`设备类型`, el.`型号规格`, el.`安装时间`, 
         el.`质保期`, el.`维修记录`, el.`校准记录`, el.`报废状态`
ORDER BY `距离质保到期天数` ASC;

-- ============================================
-- 5. 大屏数据展示业务线视图（3个）
-- ============================================

-- 视图13：实时能源总览视图
-- 用途：汇总最新的能源数据，用于大屏展示
CREATE OR REPLACE VIEW `v_实时能源总览` AS
SELECT 
    rsd.`汇总编号`,
    rsd.`统计时间`,
    rsd.`总用电量kWh`,
    rsd.`总用水量m3`,
    rsd.`总蒸汽消耗量t`,
    rsd.`总天然气消耗量m3`,
    rsd.`光伏总发电量kWh`,
    rsd.`光伏自用电量kWh`,
    rsd.`总告警次数`,
    rsd.`高等级告警数`,
    rsd.`中等级告警数`,
    rsd.`低等级告警数`,
    CASE 
        WHEN rsd.`高等级告警数` > 0 THEN '有高等级告警'
        WHEN rsd.`总告警次数` > 10 THEN '告警较多'
        ELSE '运行正常'
    END AS `系统状态`
FROM `实时汇总数据表` rsd
ORDER BY rsd.`统计时间` DESC
LIMIT 1;

-- 视图14：历史趋势分析视图
-- 用途：分析各能源类型的历史趋势，包括同比环比
CREATE OR REPLACE VIEW `v_历史趋势分析` AS
SELECT 
    htd.`趋势编号`,
    htd.`能源类型`,
    htd.`统计周期`,
    htd.`统计时间`,
    htd.`能耗发电量数值`,
    htd.`同比增长率`,
    htd.`环比增长率`,
    htd.`行业均值`,
    CASE 
        WHEN htd.`同比增长率` < 0 THEN '能耗下降'
        WHEN htd.`同比增长率` > 0 THEN '能耗上升'
        ELSE '能耗持平'
    END AS `同比趋势`,
    CASE 
        WHEN htd.`环比增长率` < 0 THEN '环比下降'
        WHEN htd.`环比增长率` > 0 THEN '环比上升'
        ELSE '环比持平'
    END AS `环比趋势`,
    CASE 
        WHEN htd.`行业均值` IS NOT NULL AND htd.`能耗发电量数值` > htd.`行业均值` * 1.2 THEN '高于行业均值20%以上'
        WHEN htd.`行业均值` IS NOT NULL AND htd.`能耗发电量数值` < htd.`行业均值` * 0.8 THEN '低于行业均值20%以上'
        ELSE '接近行业均值'
    END AS `行业对比`
FROM `历史趋势数据表` htd
ORDER BY htd.`统计时间` DESC, htd.`能源类型`;

-- 视图15：大屏配置权限视图
-- 用途：根据权限等级展示不同的配置信息
CREATE OR REPLACE VIEW `v_大屏配置权限` AS
SELECT 
    dc.`配置编号`,
    dc.`展示模块`,
    dc.`数据刷新频率`,
    dc.`展示字段`,
    dc.`排序规则`,
    dc.`权限等级`,
    CASE 
        WHEN dc.`权限等级` = '管理员' THEN '所有模块'
        WHEN dc.`权限等级` = '能源管理员' THEN '能源相关模块'
        WHEN dc.`权限等级` = '运维人员' THEN '运维相关模块'
        ELSE '基础模块'
    END AS `可访问模块说明`
FROM `大屏展示配置表` dc
ORDER BY dc.`权限等级`, dc.`展示模块`;

-- ============================================
-- 完成
-- ============================================
SELECT '所有视图创建完成！' AS message;

