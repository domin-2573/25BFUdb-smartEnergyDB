-- ============================================
-- SmartEnergy智慧能源管理系统 - DDL语句
-- 创建所有数据表、约束、索引
-- ============================================

-- 创建数据库（如果不存在）
CREATE DATABASE IF NOT EXISTS smart_energy CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;
USE smart_energy;

-- ============================================
-- 1. 用户管理
-- ============================================

-- 用户表
CREATE TABLE IF NOT EXISTS `用户表` (
    `用户ID` CHAR(3) PRIMARY KEY COMMENT '唯一标识用户，如001、002',
    `姓名` VARCHAR(50) NOT NULL COMMENT '用户真实姓名',
    `密码` VARCHAR(100) NOT NULL COMMENT '哈希后的密码字符串（MD5或SHA-256）',
    `角色` VARCHAR(50) NOT NULL COMMENT '系统管理员/能源管理员/运维人员/数据分析师/企业管理层/运维工单管理员',
    `登录失败次数` INT DEFAULT 0 COMMENT '登录失败次数，5次后锁定',
    `账号锁定时间` DATETIME NULL COMMENT '账号锁定时间',
    `最后登录时间` DATETIME NULL COMMENT '最后登录时间',
    `创建时间` DATETIME DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间'
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COMMENT='用户表';

-- ============================================
-- 2. 配电网监测业务线
-- ============================================

-- 配电房信息表
CREATE TABLE IF NOT EXISTS `配电房信息表` (
    `配电房编号` VARCHAR(15) PRIMARY KEY COMMENT '唯一标识配电房，如PD-35kV-001',
    `名称` VARCHAR(20) NOT NULL COMMENT '配电房名称，如总配电房、分配电房1',
    `位置描述` VARCHAR(50) NOT NULL COMMENT '具体地址+区域，如XX园区A栋地下1层',
    `电压等级` VARCHAR(10) NOT NULL COMMENT '符合国标，如35kV/0.4kV、10kV/0.4kV',
    `变压器数量` TINYINT NOT NULL CHECK (`变压器数量` >= 1) COMMENT '一般1-5台',
    `投运时间` DATE NOT NULL COMMENT '格式：YYYY-MM-DD',
    `负责人ID` VARCHAR(20) NOT NULL COMMENT '关联人员管理系统ID',
    `联系方式` VARCHAR(20) NOT NULL COMMENT '手机号（11位）或固定电话',
    `创建时间` DATETIME DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
    `更新时间` DATETIME DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '更新时间'
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COMMENT='配电房信息表';

-- 创建索引
CREATE INDEX `idx_负责人ID` ON `配电房信息表`(`负责人ID`);

-- 回路监测数据表
CREATE TABLE IF NOT EXISTS `回路监测数据表` (
    `数据编号` VARCHAR(20) PRIMARY KEY COMMENT '按回路编号+采集时间戳编码',
    `配电房编号` VARCHAR(15) NOT NULL COMMENT '关联配电房信息表',
    `回路编号` VARCHAR(10) NOT NULL COMMENT '如L1、L2',
    `采集时间` DATETIME NOT NULL COMMENT '格式：YYYY-MM-DD HH:MM:SS',
    `电压kV` DECIMAL(5,2) NOT NULL COMMENT '35kV回路：34.5-36.7kV；0.4kV回路：0.38-0.42kV',
    `电流A` DECIMAL(8,2) NOT NULL COMMENT '0.4kV回路一般≤630A',
    `有功功率kW` DECIMAL(10,2) NOT NULL COMMENT '0.4kV回路：0-400kW',
    `无功功率kVar` DECIMAL(10,2) NOT NULL COMMENT '与有功功率匹配',
    `功率因数` DECIMAL(4,2) NOT NULL CHECK (`功率因数` >= 0.85 AND `功率因数` <= 1.00) COMMENT '0.85-1.00',
    `正向有功电量kWh` DECIMAL(12,2) NOT NULL COMMENT '累计值',
    `反向有功电量kWh` DECIMAL(12,2) NOT NULL COMMENT '一般≤正向电量的5%',
    `开关状态` VARCHAR(5) NOT NULL COMMENT '分闸、合闸',
    `电缆头温度` DECIMAL(5,1) NOT NULL COMMENT '正常≤90℃，超100℃触发告警',
    `电容器温度` DECIMAL(5,1) NOT NULL COMMENT '正常≤65℃，超75℃触发告警',
    `数据状态` VARCHAR(10) DEFAULT '正常' COMMENT '正常、异常、数据不完整',
    FOREIGN KEY (`配电房编号`) REFERENCES `配电房信息表`(`配电房编号`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COMMENT='回路监测数据表';

-- 创建索引
CREATE INDEX `idx_配电房编号` ON `回路监测数据表`(`配电房编号`);
CREATE INDEX `idx_采集时间` ON `回路监测数据表`(`采集时间`);
CREATE INDEX `idx_配电房时间` ON `回路监测数据表`(`配电房编号`, `采集时间`);
CREATE INDEX `idx_数据状态` ON `回路监测数据表`(`数据状态`);

-- 变压器监测数据表
CREATE TABLE IF NOT EXISTS `变压器监测数据表` (
    `数据编号` VARCHAR(20) PRIMARY KEY COMMENT '按变压器编号+采集时间戳编码',
    `配电房编号` VARCHAR(15) NOT NULL COMMENT '关联配电房信息表',
    `变压器编号` VARCHAR(10) NOT NULL COMMENT '如BYSQ-001',
    `采集时间` DATETIME NOT NULL COMMENT '格式：YYYY-MM-DD HH:MM:SS',
    `负载率` DECIMAL(5,2) NOT NULL COMMENT '正常≤80%，短期允许≤100%',
    `绕组温度` DECIMAL(5,1) NOT NULL COMMENT '油浸式变压器：正常≤85℃，超95℃触发告警',
    `铁芯温度` DECIMAL(5,1) NOT NULL COMMENT '一般比绕组温度低5-10℃',
    `环境温度` DECIMAL(5,1) NOT NULL COMMENT '配电房内一般-5℃~40℃',
    `环境湿度` DECIMAL(5,1) NOT NULL COMMENT '配电房内一般30%~70%',
    `运行状态` VARCHAR(5) NOT NULL COMMENT '正常、异常',
    FOREIGN KEY (`配电房编号`) REFERENCES `配电房信息表`(`配电房编号`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COMMENT='变压器监测数据表';

-- 创建索引
CREATE INDEX `idx_配电房编号_变压器` ON `变压器监测数据表`(`配电房编号`);
CREATE INDEX `idx_采集时间_变压器` ON `变压器监测数据表`(`采集时间`);
CREATE INDEX `idx_运行状态` ON `变压器监测数据表`(`运行状态`);

-- ============================================
-- 3. 分布式光伏管理业务线
-- ============================================

-- 光伏设备信息表
CREATE TABLE IF NOT EXISTS `光伏设备信息表` (
    `设备编号` VARCHAR(20) PRIMARY KEY COMMENT '如SD-PV-001',
    `设备类型` VARCHAR(50) NOT NULL COMMENT '逆变器、汇流箱',
    `安装位置` VARCHAR(50) NOT NULL COMMENT '屋顶区域编号/园区片区',
    `装机容量` VARCHAR(50) NOT NULL COMMENT '单位：kWp',
    `投运时间` DATE NOT NULL COMMENT '格式：YYYY-MM-DD',
    `校准周期` INT NOT NULL CHECK (`校准周期` >= 3 AND `校准周期` <= 24) COMMENT '单位：月，≥3且≤24',
    `运行状态` VARCHAR(10) NOT NULL COMMENT '正常、故障、离线',
    `通信协议` VARCHAR(20) NOT NULL COMMENT 'RS485、Lora、以太网',
    `创建时间` DATETIME DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
    `更新时间` DATETIME DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '更新时间'
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COMMENT='光伏设备信息表';

-- 创建索引
CREATE INDEX `idx_运行状态_光伏` ON `光伏设备信息表`(`运行状态`);

-- 并网点信息表
CREATE TABLE IF NOT EXISTS `并网点信息表` (
    `并网点编号` VARCHAR(20) PRIMARY KEY COMMENT '唯一标识并网点，如BGD-001',
    `并网点名称` VARCHAR(50) NOT NULL COMMENT '并网点名称，如主并网点1',
    `位置描述` VARCHAR(100) NOT NULL COMMENT '具体位置描述',
    `并网电压等级` VARCHAR(20) NOT NULL COMMENT '如10kV、35kV',
    `并网容量kW` DECIMAL(10,2) NOT NULL COMMENT '并网容量，单位kW',
    `投运时间` DATE NOT NULL COMMENT '格式：YYYY-MM-DD',
    `运行状态` VARCHAR(10) NOT NULL DEFAULT '正常' COMMENT '正常、故障、维护',
    `创建时间` DATETIME DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
    `更新时间` DATETIME DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '更新时间'
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COMMENT='并网点信息表';

-- 创建索引
CREATE INDEX `idx_运行状态_并网点` ON `并网点信息表`(`运行状态`);

-- 光伏发电数据表
CREATE TABLE IF NOT EXISTS `光伏发电数据表` (
    `数据编号` VARCHAR(20) PRIMARY KEY COMMENT '唯一标识单条发电数据',
    `设备编号` VARCHAR(20) NOT NULL COMMENT '关联光伏设备信息表',
    `并网点编号` VARCHAR(20) NOT NULL COMMENT '关联并网点信息表',
    `采集时间` DATETIME NOT NULL COMMENT '格式：YYYY-MM-DD HH:MM:SS',
    `发电量kWh` DECIMAL(12,2) NOT NULL CHECK (`发电量kWh` >= 0) COMMENT '≥0',
    `上网电量kWh` DECIMAL(12,2) NOT NULL CHECK (`上网电量kWh` >= 0) COMMENT '≥0',
    `自用电量kWh` DECIMAL(12,2) NOT NULL CHECK (`自用电量kWh` >= 0) COMMENT '≥0',
    `逆变器效率` DECIMAL(5,2) NOT NULL COMMENT '0-100%，低于85%标记为设备异常',
    `汇流箱组串电压V` DECIMAL(8,2) NULL COMMENT '允许空',
    `组串电流A` DECIMAL(8,2) NULL COMMENT '允许空',
    FOREIGN KEY (`设备编号`) REFERENCES `光伏设备信息表`(`设备编号`) ON DELETE CASCADE,
    FOREIGN KEY (`并网点编号`) REFERENCES `并网点信息表`(`并网点编号`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COMMENT='光伏发电数据表';

-- 创建索引
CREATE INDEX `idx_设备编号_发电` ON `光伏发电数据表`(`设备编号`);
CREATE INDEX `idx_采集时间_发电` ON `光伏发电数据表`(`采集时间`);
CREATE INDEX `idx_并网点编号` ON `光伏发电数据表`(`并网点编号`);

-- 光伏预测数据表
CREATE TABLE IF NOT EXISTS `光伏预测数据表` (
    `预测编号` VARCHAR(20) PRIMARY KEY COMMENT '唯一标识预测记录',
    `并网点编号` VARCHAR(20) NOT NULL COMMENT '关联并网点信息表',
    `预测日期` DATE NOT NULL COMMENT '格式：YYYY-MM-DD',
    `预测时段` VARCHAR(20) NOT NULL COMMENT '如08:00-09:00',
    `预测发电量kWh` DECIMAL(12,2) NOT NULL CHECK (`预测发电量kWh` >= 0) COMMENT '≥0',
    `实际发电量kWh` DECIMAL(12,2) NULL COMMENT '允许空，实际数据采集后更新',
    `偏差率` DECIMAL(5,2) NULL COMMENT '允许空，超15%触发预测模型优化提醒',
    `预测模型版本` VARCHAR(20) NULL COMMENT '允许空',
    FOREIGN KEY (`并网点编号`) REFERENCES `并网点信息表`(`并网点编号`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COMMENT='光伏预测数据表';

-- 创建索引
CREATE INDEX `idx_并网点日期` ON `光伏预测数据表`(`并网点编号`, `预测日期`);

-- ============================================
-- 4. 综合能耗管理业务线
-- ============================================

-- 能耗计量设备信息表
CREATE TABLE IF NOT EXISTS `能耗计量设备信息表` (
    `设备编号` VARCHAR(20) PRIMARY KEY COMMENT '唯一标识计量设备',
    `能源类型` VARCHAR(10) NOT NULL COMMENT '水、蒸汽、天然气',
    `安装位置` VARCHAR(50) NOT NULL COMMENT '如VOCS下面、糕饼一厂东北角',
    `管径规格` VARCHAR(10) NULL COMMENT '允许空，如DN25、DN50、DN100',
    `通讯协议` VARCHAR(10) NOT NULL COMMENT 'RS485、Lora',
    `运行状态` VARCHAR(10) NOT NULL COMMENT '正常、故障',
    `校准周期` INT NOT NULL CHECK (`校准周期` >= 3 AND `校准周期` <= 24) COMMENT '单位：月，≥3且≤24',
    `生产厂家` VARCHAR(30) NULL COMMENT '允许空',
    `创建时间` DATETIME DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
    `更新时间` DATETIME DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '更新时间'
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COMMENT='能耗计量设备信息表';

-- 创建索引
CREATE INDEX `idx_能源类型` ON `能耗计量设备信息表`(`能源类型`);
CREATE INDEX `idx_运行状态_能耗` ON `能耗计量设备信息表`(`运行状态`);

-- 能耗监测数据表
CREATE TABLE IF NOT EXISTS `能耗监测数据表` (
    `数据编号` VARCHAR(20) PRIMARY KEY COMMENT '唯一标识单条监测数据',
    `设备编号` VARCHAR(20) NOT NULL COMMENT '关联能耗计量设备信息表',
    `采集时间` DATETIME NOT NULL COMMENT '格式：YYYY-MM-DD HH:MM:SS',
    `能耗值` DECIMAL(10,2) NOT NULL CHECK (`能耗值` >= 0) COMMENT '水：m³；蒸汽：t；天然气：m³，≥0',
    `单位` VARCHAR(5) NOT NULL COMMENT 'm³、t',
    `数据质量` VARCHAR(5) NOT NULL COMMENT '优、良、中、差',
    `核实状态` VARCHAR(10) DEFAULT '已核实' COMMENT '已核实、待核实（数据质量为中/差时标记）',
    `所属厂区编号` VARCHAR(10) NOT NULL COMMENT '如真旺厂、豆果厂、A3厂区',
    FOREIGN KEY (`设备编号`) REFERENCES `能耗计量设备信息表`(`设备编号`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COMMENT='能耗监测数据表';

-- 创建索引
CREATE INDEX `idx_设备编号_能耗` ON `能耗监测数据表`(`设备编号`);
CREATE INDEX `idx_所属厂区编号` ON `能耗监测数据表`(`所属厂区编号`);
CREATE INDEX `idx_采集时间_能耗` ON `能耗监测数据表`(`采集时间`);
CREATE INDEX `idx_数据质量` ON `能耗监测数据表`(`数据质量`);
CREATE INDEX `idx_核实状态` ON `能耗监测数据表`(`核实状态`);

-- 峰谷能耗数据表
CREATE TABLE IF NOT EXISTS `峰谷能耗数据表` (
    `记录编号` VARCHAR(20) PRIMARY KEY COMMENT '唯一标识记录',
    `能源类型` VARCHAR(10) NOT NULL COMMENT '电、水、蒸汽、天然气',
    `厂区编号` VARCHAR(10) NOT NULL COMMENT '关联具体厂区',
    `统计日期` DATE NOT NULL COMMENT '格式：YYYY-MM-DD',
    `尖峰时段能耗` DECIMAL(12,2) NOT NULL COMMENT '10:00-12:00/16:00-18:00',
    `高峰时段能耗` DECIMAL(12,2) NOT NULL COMMENT '8:00-10:00/12:00-16:00/18:00-22:00',
    `平段能耗` DECIMAL(12,2) NOT NULL COMMENT '6:00-8:00/22:00-24:00',
    `低谷时段能耗` DECIMAL(12,2) NOT NULL COMMENT '00:00-6:00',
    `总能耗` DECIMAL(12,2) NOT NULL COMMENT '各时段能耗之和',
    `峰谷电价` DECIMAL(8,4) NOT NULL COMMENT '单位：元/kWh或元/m³或元/t',
    `能耗成本` DECIMAL(12,2) NOT NULL COMMENT '单位：元'
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COMMENT='峰谷能耗数据表';

-- 创建索引
CREATE INDEX `idx_厂区编号` ON `峰谷能耗数据表`(`厂区编号`);
CREATE INDEX `idx_统计日期` ON `峰谷能耗数据表`(`统计日期`);
CREATE INDEX `idx_厂区日期` ON `峰谷能耗数据表`(`厂区编号`, `统计日期`);

-- ============================================
-- 5. 告警运维管理业务线
-- ============================================

-- 告警信息表
CREATE TABLE IF NOT EXISTS `告警信息表` (
    `告警编号` VARCHAR(20) PRIMARY KEY COMMENT '唯一标识告警',
    `告警类型` VARCHAR(20) NOT NULL COMMENT '越限告警、通讯故障、设备故障',
    `关联设备编号` VARCHAR(20) NOT NULL COMMENT '如变压器编号/光伏逆变器编号',
    `发生时间` DATETIME NOT NULL COMMENT '格式：YYYY-MM-DD HH:MM:SS',
    `告警等级` VARCHAR(20) NOT NULL COMMENT '高、中、低',
    `告警内容` VARCHAR(500) NOT NULL COMMENT '如35KV主变绕组温度超100℃',
    `处理状态` VARCHAR(20) NOT NULL DEFAULT '未处理' COMMENT '未处理、处理中、已结案',
    `告警触发阈值` VARCHAR(100) NULL COMMENT '允许空',
    `创建时间` DATETIME DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间'
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COMMENT='告警信息表';

-- 创建索引
CREATE INDEX `idx_关联设备编号` ON `告警信息表`(`关联设备编号`);
CREATE INDEX `idx_告警等级` ON `告警信息表`(`告警等级`);
CREATE INDEX `idx_处理状态` ON `告警信息表`(`处理状态`);
CREATE INDEX `idx_发生时间` ON `告警信息表`(`发生时间`);

-- 运维工单数据表
CREATE TABLE IF NOT EXISTS `运维工单数据表` (
    `工单编号` VARCHAR(20) PRIMARY KEY COMMENT '唯一标识工单',
    `告警编号` VARCHAR(20) NOT NULL UNIQUE COMMENT '关联告警信息表，一对一关系',
    `运维人员ID` VARCHAR(20) NOT NULL COMMENT '关联人员管理系统ID',
    `派单时间` DATETIME NOT NULL COMMENT '格式：YYYY-MM-DD HH:MM:SS',
    `响应时间` DATETIME NULL COMMENT '允许空',
    `处理完成时间` DATETIME NULL COMMENT '允许空',
    `处理结果` VARCHAR(500) NULL COMMENT '允许空，如更换电缆头温度传感器',
    `复查状态` VARCHAR(10) NULL COMMENT '通过、未通过',
    `附件路径` VARCHAR(200) NULL COMMENT '允许空，如故障现场照片路径',
    FOREIGN KEY (`告警编号`) REFERENCES `告警信息表`(`告警编号`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COMMENT='运维工单数据表';

-- 创建索引
CREATE INDEX `idx_告警编号` ON `运维工单数据表`(`告警编号`);
CREATE INDEX `idx_运维人员ID` ON `运维工单数据表`(`运维人员ID`);

-- 设备台账数据表
CREATE TABLE IF NOT EXISTS `设备台账数据表` (
    `台账编号` VARCHAR(20) PRIMARY KEY COMMENT '唯一标识台账',
    `设备名称` VARCHAR(50) NOT NULL COMMENT '设备名称',
    `设备类型` VARCHAR(10) NOT NULL COMMENT '变压器、水表、逆变器',
    `型号规格` VARCHAR(50) NULL COMMENT '允许空',
    `安装时间` DATETIME NOT NULL COMMENT '格式：YYYY-MM-DD HH:MM:SS',
    `质保期` INT NULL COMMENT '单位：年，质保期到期前30天触发提醒',
    `维修记录` VARCHAR(20) NULL COMMENT '允许空，关联工单编号',
    `校准记录` VARCHAR(20) NULL COMMENT '允许空，校准时间/校准人员',
    `报废状态` VARCHAR(10) NULL DEFAULT '正常使用' COMMENT '正常使用、已报废',
    `创建时间` DATETIME DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
    `更新时间` DATETIME DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '更新时间'
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COMMENT='设备台账数据表';

-- 创建索引
CREATE INDEX `idx_设备类型` ON `设备台账数据表`(`设备类型`);
CREATE INDEX `idx_报废状态` ON `设备台账数据表`(`报废状态`);

-- 执法人员信息表
CREATE TABLE IF NOT EXISTS `执法人员信息表` (
    `执法ID` VARCHAR(20) PRIMARY KEY COMMENT '唯一标识执法人员，如ZF-001',
    `姓名` VARCHAR(50) NOT NULL COMMENT '执法人员姓名',
    `所属部门` VARCHAR(50) NOT NULL COMMENT '所属部门名称',
    `执法权限` VARCHAR(100) NOT NULL COMMENT '执法权限描述，如设备检查、数据审核',
    `联系方式` VARCHAR(20) NOT NULL COMMENT '手机号或固定电话',
    `执法设备编号` VARCHAR(20) NULL COMMENT '关联执法设备编号，允许空',
    `创建时间` DATETIME DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
    `更新时间` DATETIME DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '更新时间'
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COMMENT='执法人员信息表';

-- 创建索引
CREATE INDEX `idx_所属部门` ON `执法人员信息表`(`所属部门`);
CREATE INDEX `idx_执法权限` ON `执法人员信息表`(`执法权限`);

-- ============================================
-- 6. 大屏数据展示业务线
-- ============================================

-- 大屏展示配置表
CREATE TABLE IF NOT EXISTS `大屏展示配置表` (
    `配置编号` VARCHAR(20) PRIMARY KEY COMMENT '唯一标识配置',
    `展示模块` VARCHAR(50) NOT NULL COMMENT '能源总览、光伏总览、配电网运行状态、告警统计',
    `数据刷新频率` VARCHAR(20) NOT NULL COMMENT '秒、分钟',
    `展示字段` VARCHAR(500) NULL COMMENT '允许空，如总能耗/光伏发电量/高等级告警数',
    `排序规则` VARCHAR(50) NULL COMMENT '允许空，按时间降序、按能耗降序',
    `权限等级` VARCHAR(20) NOT NULL COMMENT '管理员、能源管理员、运维人员',
    `创建时间` DATETIME DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
    `更新时间` DATETIME DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '更新时间'
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COMMENT='大屏展示配置表';

-- 创建索引
CREATE INDEX `idx_权限等级` ON `大屏展示配置表`(`权限等级`);

-- 实时汇总数据表
CREATE TABLE IF NOT EXISTS `实时汇总数据表` (
    `汇总编号` VARCHAR(15) PRIMARY KEY COMMENT '如001、002',
    `统计时间` DATETIME NOT NULL COMMENT '格式：YYYY-MM-DD HH:MM:SS',
    `总用电量kWh` DECIMAL(18,2) NULL COMMENT '允许空',
    `总用水量m3` DECIMAL(18,2) NULL COMMENT '允许空',
    `总蒸汽消耗量t` DECIMAL(18,2) NULL COMMENT '允许空',
    `总天然气消耗量m3` DECIMAL(18,2) NULL COMMENT '允许空',
    `光伏总发电量kWh` DECIMAL(18,2) NULL COMMENT '允许空',
    `光伏自用电量kWh` DECIMAL(18,2) NULL COMMENT '允许空',
    `总告警次数` INT NULL COMMENT '允许空',
    `高等级告警数` INT NULL COMMENT '允许空',
    `中等级告警数` INT NULL COMMENT '允许空',
    `低等级告警数` INT NULL COMMENT '允许空'
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COMMENT='实时汇总数据表';

-- 创建索引
CREATE INDEX `idx_统计时间` ON `实时汇总数据表`(`统计时间`);

-- 历史趋势数据表
CREATE TABLE IF NOT EXISTS `历史趋势数据表` (
    `趋势编号` VARCHAR(20) PRIMARY KEY COMMENT '唯一标识趋势记录',
    `能源类型` VARCHAR(10) NOT NULL COMMENT '电、水、蒸汽、天然气、光伏',
    `统计周期` VARCHAR(10) NOT NULL COMMENT '日、周、月',
    `统计时间` DATE NOT NULL COMMENT '格式：YYYY-MM-DD',
    `能耗发电量数值` DECIMAL(18,2) NOT NULL CHECK (`能耗发电量数值` >= 0) COMMENT '≥0',
    `同比增长率` DECIMAL(6,2) NULL COMMENT '允许空',
    `环比增长率` DECIMAL(6,2) NULL COMMENT '允许空',
    `行业均值` DECIMAL(18,2) NULL COMMENT '允许空'
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COMMENT='历史趋势数据表';

-- 创建索引
CREATE INDEX `idx_能源类型` ON `历史趋势数据表`(`能源类型`);
CREATE INDEX `idx_统计周期` ON `历史趋势数据表`(`统计周期`);
CREATE INDEX `idx_能源周期时间` ON `历史趋势数据表`(`能源类型`, `统计周期`, `统计时间`);

-- ============================================
-- 完成
-- ============================================
SELECT '所有表结构创建完成！' AS message;

