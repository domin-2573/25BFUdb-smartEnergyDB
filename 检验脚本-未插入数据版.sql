-- =============================================
-- 智能能源管理系统完整性检查脚本
-- 检查所有触发器、存储过程、视图是否创建成功
-- =============================================

USE smart_energy;

-- 显示检查开始时间和数据库信息
SELECT NOW() AS '检查开始时间';
SELECT DATABASE() AS '当前数据库';
SELECT VERSION() AS 'MySQL版本';

-- =============================================
-- 第一部分：检查触发器 (TRIGGERS)
-- =============================================

SELECT '=====================================' AS '=== 触发器检查 ===';
SELECT COUNT(*) AS '总触发器数量' FROM information_schema.triggers WHERE trigger_schema = 'smart_energy';

-- 详细列出所有触发器
SELECT
    TRIGGER_NAME AS '触发器名称',
    EVENT_OBJECT_TABLE AS '目标表',
    EVENT_MANIPULATION AS '触发事件',
    ACTION_TIMING AS '触发时机',
    ACTION_STATEMENT AS '触发动作(前50字符)'
FROM information_schema.triggers
WHERE trigger_schema = 'smart_energy'
ORDER BY EVENT_OBJECT_TABLE, TRIGGER_NAME;

-- 检查关键触发器是否存在
SELECT '检查关键触发器是否存在:' AS '触发器验证';

SELECT '光伏设备台账同步' AS '触发器名称',
       CASE WHEN COUNT(*) > 0 THEN '✓ 存在' ELSE '✗ 缺失' END AS '状态'
FROM information_schema.triggers
WHERE trigger_schema = 'smart_energy' AND trigger_name = 'trg_光伏设备台账同步';

SELECT '能耗设备台账同步' AS '触发器名称',
       CASE WHEN COUNT(*) > 0 THEN '✓ 存在' ELSE '✗ 缺失' END AS '状态'
FROM information_schema.triggers
WHERE trigger_schema = 'smart_energy' AND trigger_name = 'trg_能耗设备台账同步';

SELECT '变压器异常告警' AS '触发器名称',
       CASE WHEN COUNT(*) > 0 THEN '✓ 存在' ELSE '✗ 缺失' END AS '状态'
FROM information_schema.triggers
WHERE trigger_schema = 'smart_energy' AND trigger_name = 'trg_变压器异常告警';

SELECT '回路监测数据异常检测' AS '触发器名称',
       CASE WHEN COUNT(*) > 0 THEN '✓ 存在' ELSE '✗ 缺失' END AS '状态'
FROM information_schema.triggers
WHERE trigger_schema = 'smart_energy' AND trigger_name = 'trg_回路监测数据异常检测';

SELECT '高等级告警即时派单' AS '触发器名称',
       CASE WHEN COUNT(*) > 0 THEN '✓ 存在' ELSE '✗ 缺失' END AS '状态'
FROM information_schema.triggers
WHERE trigger_schema = 'smart_energy' AND trigger_name = 'trg_高等级告警即时派单';

-- 新增的配电房设备触发器检查
SELECT '变压器新设备台账同步' AS '触发器名称',
       CASE WHEN COUNT(*) > 0 THEN '✓ 存在' ELSE '✗ 缺失' END AS '状态'
FROM information_schema.triggers
WHERE trigger_schema = 'smart_energy' AND trigger_name = 'trg_变压器新设备台账同步';

SELECT '回路新设备台账同步' AS '触发器名称',
       CASE WHEN COUNT(*) > 0 THEN '✓ 存在' ELSE '✗ 缺失' END AS '状态'
FROM information_schema.triggers
WHERE trigger_schema = 'smart_energy' AND trigger_name = 'trg_回路新设备台账同步';

SELECT '变压器安装工单' AS '触发器名称',
       CASE WHEN COUNT(*) > 0 THEN '✓ 存在' ELSE '✗ 缺失' END AS '状态'
FROM information_schema.triggers
WHERE trigger_schema = 'smart_energy' AND trigger_name = 'trg_变压器安装工单';

SELECT '回路设备安装工单' AS '触发器名称',
       CASE WHEN COUNT(*) > 0 THEN '✓ 存在' ELSE '✗ 缺失' END AS '状态'
FROM information_schema.triggers
WHERE trigger_schema = 'smart_energy' AND trigger_name = 'trg_回路设备安装工单';

-- =============================================
-- 第二部分：检查存储过程 (STORED PROCEDURES)
-- =============================================

SELECT '=====================================' AS '=== 存储过程检查 ===';
SELECT COUNT(*) AS '总存储过程数量' FROM information_schema.routines
WHERE routine_schema = 'smart_energy' AND routine_type = 'PROCEDURE';

-- 详细列出所有存储过程
SELECT
    ROUTINE_NAME AS '存储过程名称',
    ROUTINE_DEFINITION AS '定义(前100字符)'
FROM information_schema.routines
WHERE routine_schema = 'smart_energy' AND routine_type = 'PROCEDURE'
ORDER BY ROUTINE_NAME;

-- 检查关键存储过程是否存在
SELECT '检查关键存储过程是否存在:' AS '存储过程验证';

SELECT '优化运维工单分配' AS '存储过程名称',
       CASE WHEN COUNT(*) > 0 THEN '✓ 存在' ELSE '✗ 缺失' END AS '状态'
FROM information_schema.routines
WHERE routine_schema = 'smart_energy' AND routine_name = 'sp_优化运维工单分配' AND routine_type = 'PROCEDURE';

SELECT '高等级告警自动派单_优化' AS '存储过程名称',
       CASE WHEN COUNT(*) > 0 THEN '✓ 存在' ELSE '✗ 缺失' END AS '状态'
FROM information_schema.routines
WHERE routine_schema = 'smart_energy' AND routine_name = 'sp_高等级告警自动派单_优化' AND routine_type = 'PROCEDURE';

-- 新增的存储过程检查
SELECT '分配安装调试工单' AS '存储过程名称',
       CASE WHEN COUNT(*) > 0 THEN '✓ 存在' ELSE '✗ 缺失' END AS '状态'
FROM information_schema.routines
WHERE routine_schema = 'smart_energy' AND routine_name = 'sp_分配安装调试工单' AND routine_type = 'PROCEDURE';

-- =============================================
-- 第三部分：检查视图 (VIEWS)
-- =============================================

SELECT '=====================================' AS '=== 视图检查 ===';
SELECT COUNT(*) AS '总视图数量' FROM information_schema.views WHERE table_schema = 'smart_energy';

-- 详细列出所有视图
SELECT
    TABLE_NAME AS '视图名称',
    VIEW_DEFINITION AS '定义(前150字符)'
FROM information_schema.views
WHERE table_schema = 'smart_energy'
ORDER BY TABLE_NAME;

-- 检查关键视图是否存在
SELECT '检查关键视图是否存在:' AS '视图验证';

-- 光伏相关视图
SELECT '光伏预测偏差' AS '视图名称',
       CASE WHEN COUNT(*) > 0 THEN '✓ 存在' ELSE '✗ 缺失' END AS '状态'
FROM information_schema.views
WHERE table_schema = 'smart_energy' AND table_name = 'v_光伏预测偏差';

-- 能耗相关视图
SELECT '厂区能耗汇总' AS '视图名称',
       CASE WHEN COUNT(*) > 0 THEN '✓ 存在' ELSE '✗ 缺失' END AS '状态'
FROM information_schema.views
WHERE table_schema = 'smart_energy' AND table_name = 'v_厂区能耗汇总';

SELECT '能耗数据质量监控' AS '视图名称',
       CASE WHEN COUNT(*) > 0 THEN '✓ 存在' ELSE '✗ 缺失' END AS '状态'
FROM information_schema.views
WHERE table_schema = 'smart_energy' AND table_name = 'v_能耗数据质量监控';

SELECT '峰谷能耗分析' AS '视图名称',
       CASE WHEN COUNT(*) > 0 THEN '✓ 存在' ELSE '✗ 缺失' END AS '状态'
FROM information_schema.views
WHERE table_schema = 'smart_energy' AND table_name = 'v_峰谷能耗分析';

-- 告警相关视图
SELECT '告警发生频率统计' AS '视图名称',
       CASE WHEN COUNT(*) > 0 THEN '✓ 存在' ELSE '✗ 缺失' END AS '状态'
FROM information_schema.views
WHERE table_schema = 'smart_energy' AND table_name = 'v_告警发生频率统计';

SELECT '告警处理及时率统计' AS '视图名称',
       CASE WHEN COUNT(*) > 0 THEN '✓ 存在' ELSE '✗ 缺失' END AS '状态'
FROM information_schema.views
WHERE table_schema = 'smart_energy' AND table_name = 'v_告警处理及时率统计';

SELECT '告警规则执行情况' AS '视图名称',
       CASE WHEN COUNT(*) > 0 THEN '✓ 存在' ELSE '✗ 缺失' END AS '状态'
FROM information_schema.views
WHERE table_schema = 'smart_energy' AND table_name = 'v_告警规则执行情况';

SELECT '待审核误报告警' AS '视图名称',
       CASE WHEN COUNT(*) > 0 THEN '✓ 存在' ELSE '✗ 缺失' END AS '状态'
FROM information_schema.views
WHERE table_schema = 'smart_energy' AND table_name = 'v_待审核误报告警';

SELECT '待审核误报告警_详细' AS '视图名称',
       CASE WHEN COUNT(*) > 0 THEN '✓ 存在' ELSE '✗ 缺失' END AS '状态'
FROM information_schema.views
WHERE table_schema = 'smart_energy' AND table_name = 'v_待审核误报告警_详细';

-- 回路相关视图
SELECT '回路异常数据' AS '视图名称',
       CASE WHEN COUNT(*) > 0 THEN '✓ 存在' ELSE '✗ 缺失' END AS '状态'
FROM information_schema.views
WHERE table_schema = 'smart_energy' AND table_name = 'v_回路异常数据';

-- 变压器相关视图
SELECT '变压器负载率趋势' AS '视图名称',
       CASE WHEN COUNT(*) > 0 THEN '✓ 存在' ELSE '✗ 缺失' END AS '状态'
FROM information_schema.views
WHERE table_schema = 'smart_energy' AND table_name = 'v_变压器负载率趋势';

-- 大屏展示视图
SELECT '大屏_能源总览' AS '视图名称',
       CASE WHEN COUNT(*) > 0 THEN '✓ 存在' ELSE '✗ 缺失' END AS '状态'
FROM information_schema.views
WHERE table_schema = 'smart_energy' AND table_name = 'v_大屏_能源总览';

SELECT '大屏_光伏总览' AS '视图名称',
       CASE WHEN COUNT(*) > 0 THEN '✓ 存在' ELSE '✗ 缺失' END AS '状态'
FROM information_schema.views
WHERE table_schema = 'smart_energy' AND table_name = 'v_大屏_光伏总览';

SELECT '大屏_配电网状态' AS '视图名称',
       CASE WHEN COUNT(*) > 0 THEN '✓ 存在' ELSE '✗ 缺失' END AS '状态'
FROM information_schema.views
WHERE table_schema = 'smart_energy' AND table_name = 'v_大屏_配电网状态';

SELECT '大屏_告警统计' AS '视图名称',
       CASE WHEN COUNT(*) > 0 THEN '✓ 存在' ELSE '✗ 缺失' END AS '状态'
FROM information_schema.views
WHERE table_schema = 'smart_energy' AND table_name = 'v_大屏_告警统计';

SELECT '大屏配置权限' AS '视图名称',
       CASE WHEN COUNT(*) > 0 THEN '✓ 存在' ELSE '✗ 缺失' END AS '状态'
FROM information_schema.views
WHERE table_schema = 'smart_energy' AND table_name = 'v_大屏配置权限';

-- 历史趋势视图
SELECT '历史趋势分析' AS '视图名称',
       CASE WHEN COUNT(*) > 0 THEN '✓ 存在' ELSE '✗ 缺失' END AS '状态'
FROM information_schema.views
WHERE table_schema = 'smart_energy' AND table_name = 'v_历史趋势分析';

SELECT '趋势_多周期对比' AS '视图名称',
       CASE WHEN COUNT(*) > 0 THEN '✓ 存在' ELSE '✗ 缺失' END AS '状态'
FROM information_schema.views
WHERE table_schema = 'smart_energy' AND table_name = 'v_趋势_多周期对比';

-- 运维相关视图
SELECT '运维人员工作量统计' AS '视图名称',
       CASE WHEN COUNT(*) > 0 THEN '✓ 存在' ELSE '✗ 缺失' END AS '状态'
FROM information_schema.views
WHERE table_schema = 'smart_energy' AND table_name = 'v_运维人员工作量统计';

SELECT '运维工单处理效率' AS '视图名称',
       CASE WHEN COUNT(*) > 0 THEN '✓ 存在' ELSE '✗ 缺失' END AS '状态'
FROM information_schema.views
WHERE table_schema = 'smart_energy' AND table_name = 'v_运维工单处理效率';

SELECT '设备类型告警分布' AS '视图名称',
       CASE WHEN COUNT(*) > 0 THEN '✓ 存在' ELSE '✗ 缺失' END AS '状态'
FROM information_schema.views
WHERE table_schema = 'smart_energy' AND table_name = 'v_设备类型告警分布';

-- 配电房相关视图
SELECT '配电房运行状态汇总' AS '视图名称',
       CASE WHEN COUNT(*) > 0 THEN '✓ 存在' ELSE '✗ 缺失' END AS '状态'
FROM information_schema.views
WHERE table_schema = 'smart_energy' AND table_name = 'v_配电房运行状态汇总';

-- 其他视图
SELECT '高等级告警' AS '视图名称',
       CASE WHEN COUNT(*) > 0 THEN '✓ 存在' ELSE '✗ 缺失' END AS '状态'
FROM information_schema.views
WHERE table_schema = 'smart_energy' AND table_name = 'v_高等级告警';

SELECT '实时能源总览' AS '视图名称',
       CASE WHEN COUNT(*) > 0 THEN '✓ 存在' ELSE '✗ 缺失' END AS '状态'
FROM information_schema.views
WHERE table_schema = 'smart_energy' AND table_name = 'v_实时能源总览';

-- =============================================
-- 第四部分：检查定时事件 (EVENTS)
-- =============================================

SELECT '=====================================' AS '=== 定时事件检查 ===';
SELECT COUNT(*) AS '总事件数量' FROM information_schema.events WHERE event_schema = 'smart_energy';

-- 详细列出所有事件
SELECT
    EVENT_NAME AS '事件名称',
    EVENT_TYPE AS '事件类型',
    EXECUTE_AT AS '执行时间',
    INTERVAL_VALUE AS '间隔值',
    INTERVAL_FIELD AS '间隔单位',
    STATUS AS '状态',
    ON_COMPLETION AS '完成时',
    CREATED AS '创建时间'
FROM information_schema.events
WHERE event_schema = 'smart_energy'
ORDER BY EVENT_NAME;

-- 检查关键事件是否存在
SELECT '检查关键事件是否存在:' AS '事件验证';

SELECT '高等级告警自动派单检查_优化版' AS '事件名称',
       CASE WHEN COUNT(*) > 0 THEN '✓ 存在' ELSE '✗ 缺失' END AS '状态'
FROM information_schema.events
WHERE event_schema = 'smart_energy' AND event_name = 'event_高等级告警自动派单检查_优化版';

-- 新增的事件检查
SELECT '新设备安装工单检查' AS '事件名称',
       CASE WHEN COUNT(*) > 0 THEN '✓ 存在' ELSE '✗ 缺失' END AS '状态'
FROM information_schema.events
WHERE event_schema = 'smart_energy' AND event_name = 'event_新设备安装工单检查';

-- 检查事件调度器状态
SELECT '=====================================' AS '=== 事件调度器状态 ===';
SELECT @@event_scheduler AS '事件调度器状态(1=开启,0=关闭)';

-- =============================================
-- 第五部分：检查关键表结构
-- =============================================

SELECT '=====================================' AS '=== 关键表结构检查 ===';

-- 检查主要数据表
SELECT '检查主要数据表是否存在:' AS '表结构验证';

-- 基础信息表
SELECT '用户表' AS '表名', CASE WHEN COUNT(*) > 0 THEN '✓ 存在' ELSE '✗ 缺失' END AS '状态'
FROM information_schema.tables WHERE table_schema = 'smart_energy' AND table_name = '用户表';

SELECT '配电房信息表' AS '表名', CASE WHEN COUNT(*) > 0 THEN '✓ 存在' ELSE '✗ 缺失' END AS '状态'
FROM information_schema.tables WHERE table_schema = 'smart_energy' AND table_name = '配电房信息表';

-- 设备信息表
SELECT '光伏设备信息表' AS '表名', CASE WHEN COUNT(*) > 0 THEN '✓ 存在' ELSE '✗ 缺失' END AS '状态'
FROM information_schema.tables WHERE table_schema = 'smart_energy' AND table_name = '光伏设备信息表';

SELECT '能耗计量设备信息表' AS '表名', CASE WHEN COUNT(*) > 0 THEN '✓ 存在' ELSE '✗ 缺失' END AS '状态'
FROM information_schema.tables WHERE table_schema = 'smart_energy' AND table_name = '能耗计量设备信息表';

-- 监测数据表
SELECT '变压器监测数据表' AS '表名', CASE WHEN COUNT(*) > 0 THEN '✓ 存在' ELSE '✗ 缺失' END AS '状态'
FROM information_schema.tables WHERE table_schema = 'smart_energy' AND table_name = '变压器监测数据表';

SELECT '回路监测数据表' AS '表名', CASE WHEN COUNT(*) > 0 THEN '✓ 存在' ELSE '✗ 缺失' END AS '状态'
FROM information_schema.tables WHERE table_schema = 'smart_energy' AND table_name = '回路监测数据表';

SELECT '能耗监测数据表' AS '表名', CASE WHEN COUNT(*) > 0 THEN '✓ 存在' ELSE '✗ 缺失' END AS '状态'
FROM information_schema.tables WHERE table_schema = 'smart_energy' AND table_name = '能耗监测数据表';

SELECT '光伏发电数据表' AS '表名', CASE WHEN COUNT(*) > 0 THEN '✓ 存在' ELSE '✗ 缺失' END AS '状态'
FROM information_schema.tables WHERE table_schema = 'smart_energy' AND table_name = '光伏发电数据表';

-- 业务处理表
SELECT '告警信息表' AS '表名', CASE WHEN COUNT(*) > 0 THEN '✓ 存在' ELSE '✗ 缺失' END AS '状态'
FROM information_schema.tables WHERE table_schema = 'smart_energy' AND table_name = '告警信息表';

SELECT '运维工单数据表' AS '表名', CASE WHEN COUNT(*) > 0 THEN '✓ 存在' ELSE '✗ 缺失' END AS '状态'
FROM information_schema.tables WHERE table_schema = 'smart_energy' AND table_name = '运维工单数据表';

SELECT '设备台账数据表' AS '表名', CASE WHEN COUNT(*) > 0 THEN '✓ 存在' ELSE '✗ 缺失' END AS '状态'
FROM information_schema.tables WHERE table_schema = 'smart_energy' AND table_name = '设备台账数据表';

-- 配置表
SELECT '告警规则配置表' AS '表名', CASE WHEN COUNT(*) > 0 THEN '✓ 存在' ELSE '✗ 缺失' END AS '状态'
FROM information_schema.tables WHERE table_schema = 'smart_energy' AND table_name = '告警规则配置表';

SELECT '大屏展示配置表' AS '表名', CASE WHEN COUNT(*) > 0 THEN '✓ 存在' ELSE '✗ 缺失' END AS '状态'
FROM information_schema.tables WHERE table_schema = 'smart_energy' AND table_name = '大屏展示配置表';

-- 日志表
SELECT '系统日志表' AS '表名', CASE WHEN COUNT(*) > 0 THEN '✓ 存在' ELSE '✗ 缺失' END AS '状态'
FROM information_schema.tables WHERE table_schema = 'smart_energy' AND table_name = '系统日志表';

-- =============================================
-- 第六部分：数据完整性检查
-- =============================================

SELECT '=====================================' AS '=== 数据完整性检查 ===';

-- 检查各表的数据量
SELECT '用户表' AS '表名', COUNT(*) AS '记录数' FROM `用户表`
UNION ALL
SELECT '配电房信息表', COUNT(*) FROM `配电房信息表`
UNION ALL
SELECT '光伏设备信息表', COUNT(*) FROM `光伏设备信息表`
UNION ALL
SELECT '能耗计量设备信息表', COUNT(*) FROM `能耗计量设备信息表`
UNION ALL
SELECT '变压器监测数据表', COUNT(*) FROM `变压器监测数据表`
UNION ALL
SELECT '回路监测数据表', COUNT(*) FROM `回路监测数据表`
UNION ALL
SELECT '能耗监测数据表', COUNT(*) FROM `能耗监测数据表`
UNION ALL
SELECT '光伏发电数据表', COUNT(*) FROM `光伏发电数据表`
UNION ALL
SELECT '告警信息表', COUNT(*) FROM `告警信息表`
UNION ALL
SELECT '运维工单数据表', COUNT(*) FROM `运维工单数据表`
UNION ALL
SELECT '设备台账数据表', COUNT(*) FROM `设备台账数据表`
ORDER BY 2 DESC;

-- =============================================
-- 第七部分：综合验证报告
-- =============================================

SELECT '=====================================' AS '=== 综合验证报告 ===';

SELECT NOW() AS '检查完成时间';

-- 生成综合报告
SELECT
    (SELECT COUNT(*) FROM information_schema.triggers WHERE trigger_schema = 'smart_energy') AS '触发器总数',
    (SELECT COUNT(*) FROM information_schema.routines WHERE routine_schema = 'smart_energy' AND routine_type = 'PROCEDURE') AS '存储过程总数',
    (SELECT COUNT(*) FROM information_schema.views WHERE table_schema = 'smart_energy') AS '视图总数',
    (SELECT COUNT(*) FROM information_schema.events WHERE event_schema = 'smart_energy') AS '事件总数',
    (SELECT COUNT(*) FROM information_schema.tables WHERE table_schema = 'smart_energy') AS '表总数'
FROM dual;

-- 检查核心功能是否完整
SELECT '核心功能完整性检查:' AS '验证项目';

SELECT '光伏设备管理系统' AS '业务模块',
       CASE
           WHEN (SELECT COUNT(*) FROM information_schema.triggers WHERE trigger_schema = 'smart_energy' AND trigger_name = 'trg_光伏设备台账同步') > 0
                AND (SELECT COUNT(*) FROM information_schema.views WHERE table_schema = 'smart_energy' AND table_name = 'v_光伏预测偏差') > 0
           THEN '✓ 完整'
           ELSE '✗ 缺失组件'
       END AS '状态';

SELECT '能耗管理系统' AS '业务模块',
       CASE
           WHEN (SELECT COUNT(*) FROM information_schema.triggers WHERE trigger_schema = 'smart_energy' AND trigger_name = 'trg_能耗设备台账同步') > 0
                AND (SELECT COUNT(*) FROM information_schema.views WHERE table_schema = 'smart_energy' AND table_name = 'v_厂区能耗汇总') > 0
                AND (SELECT COUNT(*) FROM information_schema.views WHERE table_schema = 'smart_energy' AND table_name = 'v_峰谷能耗分析') > 0
           THEN '✓ 完整'
           ELSE '✗ 缺失组件'
       END AS '状态';

SELECT '配电房监测系统' AS '业务模块',
       CASE
           WHEN (SELECT COUNT(*) FROM information_schema.triggers WHERE trigger_schema = 'smart_energy' AND trigger_name = 'trg_变压器异常告警') > 0
                AND (SELECT COUNT(*) FROM information_schema.triggers WHERE trigger_schema = 'smart_energy' AND trigger_name = 'trg_回路监测数据异常检测') > 0
                AND (SELECT COUNT(*) FROM information_schema.views WHERE table_schema = 'smart_energy' AND table_name = 'v_回路异常数据') > 0
                AND (SELECT COUNT(*) FROM information_schema.views WHERE table_schema = 'smart_energy' AND table_name = 'v_配电房运行状态汇总') > 0
           THEN '✓ 完整'
           ELSE '✗ 缺失组件'
       END AS '状态';

SELECT '告警运维系统' AS '业务模块',
       CASE
           WHEN (SELECT COUNT(*) FROM information_schema.triggers WHERE trigger_schema = 'smart_energy' AND trigger_name = 'trg_高等级告警即时派单') > 0
                AND (SELECT COUNT(*) FROM information_schema.routines WHERE routine_schema = 'smart_energy' AND routine_name = 'sp_优化运维工单分配' AND routine_type = 'PROCEDURE') > 0
                AND (SELECT COUNT(*) FROM information_schema.events WHERE event_schema = 'smart_energy' AND event_name = 'event_高等级告警自动派单检查_优化版') > 0
                AND (SELECT COUNT(*) FROM information_schema.views WHERE table_schema = 'smart_energy' AND table_name = 'v_告警处理及时率统计') > 0
           THEN '✓ 完整'
           ELSE '✗ 缺失组件'
       END AS '状态';

SELECT '大屏展示系统' AS '业务模块',
       CASE
           WHEN (SELECT COUNT(*) FROM information_schema.views WHERE table_schema = 'smart_energy' AND table_name = 'v_大屏_能源总览') > 0
                AND (SELECT COUNT(*) FROM information_schema.views WHERE table_schema = 'smart_energy' AND table_name = 'v_大屏_配电网状态') > 0
                AND (SELECT COUNT(*) FROM information_schema.views WHERE table_schema = 'smart_energy' AND table_name = 'v_大屏_告警统计') > 0
           THEN '✓ 完整'
           ELSE '✗ 缺失组件'
       END AS '状态';

-- 新增的配电房设备工单系统检查
SELECT '配电房设备工单系统' AS '新增功能',
       CASE
           WHEN (SELECT COUNT(*) FROM information_schema.triggers WHERE trigger_schema = 'smart_energy' AND trigger_name = 'trg_变压器新设备台账同步') > 0
                AND (SELECT COUNT(*) FROM information_schema.triggers WHERE trigger_schema = 'smart_energy' AND trigger_name = 'trg_回路新设备台账同步') > 0
                AND (SELECT COUNT(*) FROM information_schema.triggers WHERE trigger_schema = 'smart_energy' AND trigger_name = 'trg_变压器安装工单') > 0
                AND (SELECT COUNT(*) FROM information_schema.triggers WHERE trigger_schema = 'smart_energy' AND trigger_name = 'trg_回路设备安装工单') > 0
                AND (SELECT COUNT(*) FROM information_schema.routines WHERE routine_schema = 'smart_energy' AND routine_name = 'sp_分配安装调试工单' AND routine_type = 'PROCEDURE') > 0
                AND (SELECT COUNT(*) FROM information_schema.events WHERE event_schema = 'smart_energy' AND event_name = 'event_新设备安装工单检查') > 0
           THEN '✓ 已部署'
           ELSE '✗ 未部署'
       END AS '状态';

SELECT '=====================================' AS '=== 检查完成 ===';
SELECT '数据库完整性检查已完成！请查看上述详细报告确认所有组件状态。' AS '检查结果';