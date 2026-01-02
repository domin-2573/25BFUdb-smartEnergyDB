-- 一、配电房信息表索引
ALTER TABLE `配电房信息表` ADD INDEX `idx_负责人ID` (`负责人ID`);
ALTER TABLE `配电房信息表` ADD INDEX `idx_投运时间` (`投运时间`);

-- 二、回路监测数据表索引
ALTER TABLE `回路监测数据表` ADD INDEX `idx_配电房编号` (`配电房编号`);
ALTER TABLE `回路监测数据表` ADD INDEX `idx_采集时间` (`采集时间`);
ALTER TABLE `回路监测数据表` ADD INDEX `idx_配电房回路` (`配电房编号`, `回路编号`);
ALTER TABLE `回路监测数据表` ADD INDEX `idx_时间开关状态` (`采集时间`, `开关状态`);
ALTER TABLE `回路监测数据表` ADD INDEX `idx_回路采集时间` (`回路编号`, `采集时间`);

-- 三、变压器监测数据表索引
ALTER TABLE `变压器监测数据表` ADD INDEX `idx_配电房编号` (`配电房编号`);
ALTER TABLE `变压器监测数据表` ADD INDEX `idx_采集时间` (`采集时间`);
ALTER TABLE `变压器监测数据表` ADD INDEX `idx_变压器编号` (`变压器编号`);
ALTER TABLE `变压器监测数据表` ADD INDEX `idx_运行状态` (`运行状态`);
ALTER TABLE `变压器监测数据表` ADD INDEX `idx_配电房变压器` (`配电房编号`, `变压器编号`);
ALTER TABLE `变压器监测数据表` ADD INDEX `idx_时间运行状态` (`采集时间`, `运行状态`);

-- 四、光伏设备信息索引
ALTER TABLE `光伏设备信息` ADD INDEX `idx_运行状态` (`运行状态`);
ALTER TABLE `光伏设备信息` ADD INDEX `idx_投运时间` (`投运时间`);
ALTER TABLE `光伏设备信息` ADD INDEX `idx_安装位置` (`安装位置`);
ALTER TABLE `光伏设备信息` ADD INDEX `idx_设备类型` (`设备类型`);

-- 五、光伏发电数据索引
ALTER TABLE `光伏发电数据` ADD INDEX `idx_设备编号` (`设备编号`);
ALTER TABLE `光伏发电数据` ADD INDEX `idx_采集时间` (`采集时间`);
ALTER TABLE `光伏发电数据` ADD INDEX `idx_并网点编号` (`并网点编号`);
ALTER TABLE `光伏发电数据` ADD INDEX `idx_设备采集时间` (`设备编号`, `采集时间`);
ALTER TABLE `光伏发电数据` ADD INDEX `idx_并网点时间` (`并网点编号`, `采集时间`);

-- 六、光伏预测数据索引
ALTER TABLE `光伏预测数据` ADD INDEX `idx_并网点编号` (`并网点编号`);
ALTER TABLE `光伏预测数据` ADD INDEX `idx_预测日期` (`预测日期`);
ALTER TABLE `光伏预测数据` ADD INDEX `idx_并网点预测日期` (`并网点编号`, `预测日期`);
ALTER TABLE `光伏预测数据` ADD INDEX `idx_预测时段` (`预测时段`);

-- 七、能耗计量设备信息索引
ALTER TABLE `能耗计量设备信息` ADD INDEX `idx_能源类型` (`能源类型`);
ALTER TABLE `能耗计量设备信息` ADD INDEX `idx_运行状态` (`运行状态`);
ALTER TABLE `能耗计量设备信息` ADD INDEX `idx_安装位置` (`安装位置`);
ALTER TABLE `能耗计量设备信息` ADD INDEX `idx_能源安装位置` (`能源类型`, `安装位置`);

-- 八、能耗监测数据索引
ALTER TABLE `能耗监测数据` ADD INDEX `idx_设备编号` (`设备编号`);
ALTER TABLE `能耗监测数据` ADD INDEX `idx_采集时间` (`采集时间`);
ALTER TABLE `能耗监测数据` ADD INDEX `idx_所属厂区编号` (`所属厂区编号`);
ALTER TABLE `能耗监测数据` ADD INDEX `idx_设备采集时间` (`设备编号`, `采集时间`);
ALTER TABLE `能耗监测数据` ADD INDEX `idx_厂区采集时间` (`所属厂区编号`, `采集时间`);
ALTER TABLE `能耗监测数据` ADD INDEX `idx_数据质量` (`数据质量`);

-- 九、峰谷能耗数据索引
ALTER TABLE `峰谷能耗数据` ADD INDEX `idx_能源类型` (`能源类型`);
ALTER TABLE `峰谷能耗数据` ADD INDEX `idx_厂区编号` (`厂区编号`);
ALTER TABLE `峰谷能耗数据` ADD INDEX `idx_统计日期` (`统计日期`);
ALTER TABLE `峰谷能耗数据` ADD INDEX `idx_能源厂区日期` (`能源类型`, `厂区编号`, `统计日期`);
ALTER TABLE `峰谷能耗数据` ADD INDEX `idx_厂区日期` (`厂区编号`, `统计日期`);

-- 十、告警信息表索引
ALTER TABLE `告警信息表` ADD INDEX `idx_关联设备编号` (`关联设备编号`);
ALTER TABLE `告警信息表` ADD INDEX `idx_发生时间` (`发生时间`);
ALTER TABLE `告警信息表` ADD INDEX `idx_告警等级` (`告警等级`);
ALTER TABLE `告警信息表` ADD INDEX `idx_处理状态` (`处理状态`);
ALTER TABLE `告警信息表` ADD INDEX `idx_告警类型` (`告警类型`);
ALTER TABLE `告警信息表` ADD INDEX `idx_设备时间状态` (`关联设备编号`, `发生时间`, `处理状态`);
ALTER TABLE `告警信息表` ADD INDEX `idx_时间等级状态` (`发生时间`, `告警等级`, `处理状态`);

-- 十一、运维工单数据索引
ALTER TABLE `运维工单数据` ADD INDEX `idx_告警编号` (`告警编号`);
ALTER TABLE `运维工单数据` ADD INDEX `idx_运维人员ID` (`运维人员ID`);
ALTER TABLE `运维工单数据` ADD INDEX `idx_派单时间` (`派单时间`);
ALTER TABLE `运维工单数据` ADD INDEX `idx_处理完成时间` (`处理完成时间`);
ALTER TABLE `运维工单数据` ADD INDEX `idx_复查状态` (`复查状态`);
ALTER TABLE `运维工单数据` ADD INDEX `idx_人员派单时间` (`运维人员ID`, `派单时间`);

-- 十二、设备台账数据索引
ALTER TABLE `设备台账数据` ADD INDEX `idx_设备类型` (`设备类型`);
ALTER TABLE `设备台账数据` ADD INDEX `idx_安装时间` (`安装时间`);
ALTER TABLE `设备台账数据` ADD INDEX `idx_报废状态` (`报废状态`);
ALTER TABLE `设备台账数据` ADD INDEX `idx_设备名称` (`设备名称`);
ALTER TABLE `设备台账数据` ADD INDEX `idx_类型安装时间` (`设备类型`, `安装时间`);

-- 十三、大屏展示配置索引
ALTER TABLE `大屏展示配置` ADD INDEX `idx_展示模块` (`展示模块`);
ALTER TABLE `大屏展示配置` ADD INDEX `idx_权限等级` (`权限等级`);

-- 十四、实时汇总数据索引
ALTER TABLE `实时汇总数据` ADD INDEX `idx_统计时间` (`统计时间`);

-- 十五、历史趋势数据索引
ALTER TABLE `历史趋势数据` ADD INDEX `idx_能源类型` (`能源类型`);
ALTER TABLE `历史趋势数据` ADD INDEX `idx_统计周期` (`统计周期`);
ALTER TABLE `历史趋势数据` ADD INDEX `idx_统计时间` (`统计时间`);
ALTER TABLE `历史趋势数据` ADD INDEX `idx_能源统计时间` (`能源类型`, `统计时间`);
ALTER TABLE `历史趋势数据` ADD INDEX `idx_周期统计时间` (`统计周期`, `统计时间`);

-- 十六、用户表索引
ALTER TABLE `用户表` ADD INDEX `idx_角色` (`角色`);
ALTER TABLE `用户表` ADD INDEX `idx_姓名` (`姓名`);