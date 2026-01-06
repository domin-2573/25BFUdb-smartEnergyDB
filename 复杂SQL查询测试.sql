-- =====================================================
-- 复杂SQL查询测试脚本
-- 按照用户需求实现5条连接3个及以上关系的复杂查询
-- =====================================================

USE smart_energy;

-- =====================================================
-- 查询1: 查询某分厂配电房近7天的回路峰谷用电数据及对应变压器负载率
-- 涉及表: 配电房信息表、回路监测数据表、变压器监测数据表
-- =====================================================

SELECT '=== 查询1: 某分厂配电房近7天的回路峰谷用电数据及对应变压器负载率 ===' AS INFO;

SELECT
    p.名称 AS 配电房名称,
    p.位置描述 AS 位置,
    h.回路编号,
    DATE(h.采集时间) AS 数据日期,
    -- 峰谷时段判断 (06:00-22:00为峰时段，22:00-06:00为谷时段)
    CASE
        WHEN HOUR(h.采集时间) >= 6 AND HOUR(h.采集时间) < 22 THEN '峰时段'
        ELSE '谷时段'
    END AS 时段类型,
    ROUND(AVG(h.有功功率kW), 2) AS 平均有功功率kW,
    ROUND(AVG(h.无功功率kVar), 2) AS 平均无功功率kVar,
    ROUND(AVG(h.正向有功电量kWh), 2) AS 平均正向电量kWh,
    ROUND(AVG(b.负载率), 2) AS 变压器平均负载率,
    COUNT(*) AS 数据点数量
FROM 配电房信息表 p
INNER JOIN 回路监测数据表 h ON p.配电房编号 = h.配电房编号
LEFT JOIN 变压器监测数据表 b ON p.配电房编号 = b.配电房编号
    AND DATE(h.采集时间) = DATE(b.采集时间)
    AND HOUR(h.采集时间) = HOUR(b.采集时间)
WHERE p.位置描述 LIKE '%真旺厂%'
    AND h.采集时间 >= DATE_SUB(CURDATE(), INTERVAL 7 DAY)
    AND h.采集时间 < CURDATE()
GROUP BY p.配电房编号, p.名称, p.位置描述, h.回路编号, DATE(h.采集时间),
    CASE
        WHEN HOUR(h.采集时间) >= 6 AND HOUR(h.采集时间) < 22 THEN '峰时段'
        ELSE '谷时段'
    END
ORDER BY p.名称, h.回路编号, 数据日期, 时段类型;

-- =====================================================
-- 查询2: 统计各配电房高等级告警处理效率（平均处理时长）及运维人员工作量
-- 涉及表: 配电房信息表、告警信息表、运维工单数据表、用户表
-- =====================================================

SELECT '=== 查询2: 各配电房高等级告警处理效率及运维人员工作量 ===' AS INFO;

SELECT
    p.名称 AS 配电房名称,
    p.位置描述 AS 位置,
    COUNT(a.告警编号) AS 高等级告警总数,
    COUNT(CASE WHEN a.处理状态 = '已结案' THEN 1 END) AS 已处理告警数,
    ROUND(
        AVG(
            CASE
                WHEN w.处理完成时间 IS NOT NULL AND w.派单时间 IS NOT NULL
                THEN TIMESTAMPDIFF(MINUTE, w.派单时间, w.处理完成时间)
                ELSE NULL
            END
        ), 1
    ) AS 平均处理时长分钟,
    COUNT(DISTINCT w.运维人员ID) AS 涉及运维人员数,
    COUNT(w.工单编号) AS 运维工单总数,
    ROUND(
        COUNT(CASE WHEN w.复查状态 = '通过' THEN 1 END) * 100.0 / COUNT(w.工单编号), 2
    ) AS 工单复查通过率
FROM 配电房信息表 p
LEFT JOIN 回路监测数据表 h ON p.配电房编号 = h.配电房编号
LEFT JOIN 变压器监测数据表 b ON p.配电房编号 = b.配电房编号
LEFT JOIN 告警信息表 a ON (
    (a.关联设备编号 = h.回路编号 AND a.告警类型 IN ('越限告警', '设备故障')) OR
    (a.关联设备编号 = b.变压器编号 AND a.告警类型 = '设备故障')
)
LEFT JOIN 运维工单数据表 w ON a.告警编号 = w.告警编号
WHERE a.告警等级 IN ('高', '中')
    AND a.发生时间 >= DATE_SUB(CURDATE(), INTERVAL 30 DAY)
GROUP BY p.配电房编号, p.名称, p.位置描述
HAVING 高等级告警总数 > 0
ORDER BY 高等级告警总数 DESC, 平均处理时长分钟 DESC;

-- =====================================================
-- 查询3: 统计各厂区上月峰段/谷段用电量占比，筛选谷段用电占比低于30%的厂区
-- 涉及表: 配电房信息表、回路监测数据表、峰谷能耗数据表
-- =====================================================

SELECT '=== 查询3: 各厂区上月峰段/谷段用电量占比分析 ===' AS INFO;

WITH 厂区用电统计 AS (
    SELECT
        -- 从配电房位置描述提取厂区信息
        CASE
            WHEN p.位置描述 LIKE '%真旺厂%' THEN '真旺厂'
            WHEN p.位置描述 LIKE '%豆果厂%' THEN '豆果厂'
            WHEN p.位置描述 LIKE '%A3厂区%' THEN 'A3厂区'
            WHEN p.位置描述 LIKE '%综合办公区%' THEN '综合办公区'
            ELSE '其他区域'
        END AS 厂区名称,
        -- 峰谷时段判断
        CASE
            WHEN HOUR(h.采集时间) >= 6 AND HOUR(h.采集时间) < 22 THEN '峰时段'
            ELSE '谷时段'
        END AS 时段类型,
        SUM(h.正向有功电量kWh) AS 总用电量kWh,
        AVG(h.有功功率kW) AS 平均负荷kW,
        COUNT(*) AS 数据记录数
    FROM 配电房信息表 p
    INNER JOIN 回路监测数据表 h ON p.配电房编号 = h.配电房编号
    WHERE h.采集时间 >= DATE_SUB(CURDATE(), INTERVAL 1 MONTH)
        AND h.采集时间 < CURDATE()
        AND h.正向有功电量kWh > 0
    GROUP BY
        CASE
            WHEN p.位置描述 LIKE '%真旺厂%' THEN '真旺厂'
            WHEN p.位置描述 LIKE '%豆果厂%' THEN '豆果厂'
            WHEN p.位置描述 LIKE '%A3厂区%' THEN 'A3厂区'
            WHEN p.位置描述 LIKE '%综合办公区%' THEN '综合办公区'
            ELSE '其他区域'
        END,
        CASE
            WHEN HOUR(h.采集时间) >= 6 AND HOUR(h.采集时间) < 22 THEN '峰时段'
            ELSE '谷时段'
        END
),
厂区汇总 AS (
    SELECT
        厂区名称,
        SUM(CASE WHEN 时段类型 = '峰时段' THEN 总用电量kWh ELSE 0 END) AS 峰时段总用电量,
        SUM(CASE WHEN 时段类型 = '谷时段' THEN 总用电量kWh ELSE 0 END) AS 谷时段总用电量,
        SUM(总用电量kWh) AS 全时段总用电量,
        SUM(数据记录数) AS 总记录数
    FROM 厂区用电统计
    GROUP BY 厂区名称
)
SELECT
    厂区名称,
    ROUND(峰时段总用电量, 2) AS 峰时段用电量kWh,
    ROUND(谷时段总用电量, 2) AS 谷时段用电量kWh,
    ROUND(全时段总用电量, 2) AS 总用电量kWh,
    ROUND(峰时段总用电量 * 100.0 / 全时段总用电量, 2) AS 峰时段占比百分比,
    ROUND(谷时段总用电量 * 100.0 / 全时段总用电量, 2) AS 谷时段占比百分比,
    ROUND(峰时段总用电量 / 谷时段总用电量, 2) AS 峰谷比,
    总记录数
FROM 厂区汇总
WHERE 谷时段总用电量 * 100.0 / 全时段总用电量 < 30.0  -- 谷段占比低于30%
ORDER BY 谷时段占比百分比 ASC;

-- =====================================================
-- 查询4: 光伏发电效率与预测准确性综合分析
-- 涉及表: 光伏设备信息表、光伏发电数据表、光伏预测数据表、并网点信息表
-- =====================================================

SELECT '=== 查询4: 光伏发电效率与预测准确性综合分析 ===' AS INFO;

SELECT
    pv.设备编号,
    pv.设备类型,
    pv.安装位置,
    pv.装机容量kWp,
    bgd.并网点名称,
    -- 发电效率统计
    ROUND(AVG(pvd.逆变器效率), 2) AS 平均逆变器效率,
    ROUND(MIN(pvd.逆变器效率), 2) AS 最低逆变器效率,
    ROUND(MAX(pvd.逆变器效率), 2) AS 最高逆变器效率,
    COUNT(CASE WHEN pvd.逆变器效率 < 85 THEN 1 END) AS 低效记录数,

    -- 发电量统计
    ROUND(SUM(pvd.发电量kWh), 2) AS 总发电量kWh,
    ROUND(SUM(pvd.上网电量kWh), 2) AS 总上网电量kWh,
    ROUND(SUM(pvd.自用电量kWh), 2) AS 总自用电量kWh,
    ROUND(AVG(pvd.自用电量kWh * 100.0 / pvd.发电量kWh), 2) AS 平均自用率,

    -- 预测准确性统计
    COUNT(pf.预测编号) AS 预测记录数,
    ROUND(AVG(ABS(pf.偏差率)), 2) AS 平均偏差率百分比,
    ROUND(MIN(pf.偏差率), 2) AS 最小偏差率百分比,
    ROUND(MAX(pf.偏差率), 2) AS 最大偏差率百分比,
    COUNT(CASE WHEN ABS(pf.偏差率) > 15 THEN 1 END) AS 大偏差记录数,

    -- 设备运行状态
    pv.运行状态,
    pv.通信协议,
    DATEDIFF(CURDATE(), pv.投运时间) AS 运行天数

FROM 光伏设备信息表 pv
LEFT JOIN 光伏发电数据表 pvd ON pv.设备编号 = pvd.设备编号
LEFT JOIN 并网点信息表 bgd ON pvd.并网点编号 = bgd.并网点编号
LEFT JOIN 光伏预测数据表 pf ON bgd.并网点编号 = pf.并网点编号
    AND DATE(pvd.采集时间) = pf.预测日期
    AND CONCAT(LPAD(HOUR(pvd.采集时间), 2, '0'), ':00-', LPAD(HOUR(pvd.采集时间)+1, 2, '0'), ':00') = pf.预测时段

WHERE pvd.采集时间 >= DATE_SUB(CURDATE(), INTERVAL 30 DAY)
GROUP BY pv.设备编号, pv.设备类型, pv.安装位置, pv.装机容量kWp,
         bgd.并网点名称, pv.运行状态, pv.通信协议, pv.投运时间
ORDER BY 平均逆变器效率 DESC, 平均偏差率百分比 ASC;

-- =====================================================
-- 查询5: 综合能耗分析报告（按能源类型和区域）
-- 涉及表: 能耗监测数据表、能耗计量设备信息表、峰谷能耗数据表
-- =====================================================

SELECT '=== 查询5: 综合能耗分析报告 ===' AS INFO;

WITH 能耗统计 AS (
    SELECT
        e.能源类型,
        -- 从设备位置提取厂区信息
        CASE
            WHEN e.安装位置 LIKE '%真旺厂%' THEN '真旺厂'
            WHEN e.安装位置 LIKE '%豆果厂%' THEN '豆果厂'
            WHEN e.安装位置 LIKE '%A3厂区%' THEN 'A3厂区'
            WHEN e.安装位置 LIKE '%综合办公区%' THEN '综合办公区'
            ELSE '其他区域'
        END AS 厂区名称,
        m.所属厂区编号,
        DATE(m.采集时间) AS 统计日期,
        SUM(m.能耗值) AS 日能耗总量,
        AVG(m.数据质量) AS 平均数据质量,
        COUNT(*) AS 监测点数量,
        COUNT(CASE WHEN m.数据质量 IN ('差', '中') THEN 1 END) AS 低质量数据点数
    FROM 能耗计量设备信息表 e
    INNER JOIN 能耗监测数据表 m ON e.设备编号 = m.设备编号
    WHERE m.采集时间 >= DATE_SUB(CURDATE(), INTERVAL 30 DAY)
        AND m.能耗值 > 0
    GROUP BY e.能源类型,
        CASE
            WHEN e.安装位置 LIKE '%真旺厂%' THEN '真旺厂'
            WHEN e.安装位置 LIKE '%豆果厂%' THEN '豆果厂'
            WHEN e.安装位置 LIKE '%A3厂区%' THEN 'A3厂区'
            WHEN e.安装位置 LIKE '%综合办公区%' THEN '综合办公区'
            ELSE '其他区域'
        END,
        m.所属厂区编号,
        DATE(m.采集时间)
),
能耗汇总 AS (
    SELECT
        能源类型,
        厂区名称,
        SUM(日能耗总量) AS 月总能耗,
        AVG(日能耗总量) AS 日均能耗,
        ROUND(AVG(平均数据质量), 2) AS 平均数据质量,
        SUM(监测点数量) AS 总监测点数,
        SUM(低质量数据点数) AS 低质量数据点总数,
        COUNT(DISTINCT 统计日期) AS 有效监测天数
    FROM 能耗统计
    GROUP BY 能源类型, 厂区名称
)
SELECT
    能源类型,
    厂区名称,
    ROUND(月总能耗, 2) AS 月总能耗,
    ROUND(日均能耗, 2) AS 日均能耗,
    平均数据质量,
    总监测点数,
    ROUND(低质量数据点总数 * 100.0 / 总监测点数, 2) AS 低质量数据占比,
    有效监测天数,
    -- 能耗等级评估
    CASE
        WHEN 日均能耗 > (SELECT AVG(日均能耗) FROM 能耗汇总 h2 WHERE h2.能源类型 = 能耗汇总.能源类型) * 1.2 THEN '高耗能'
        WHEN 日均能耗 < (SELECT AVG(日均能耗) FROM 能耗汇总 h2 WHERE h2.能源类型 = 能耗汇总.能源类型) * 0.8 THEN '低耗能'
        ELSE '正常水平'
    END AS 能耗等级
FROM 能耗汇总
ORDER BY 能源类型, 月总能耗 DESC;

SELECT '=== 复杂SQL查询测试完成 ===' AS INFO;
