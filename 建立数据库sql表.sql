SET NAMES utf8mb4;
SET FOREIGN_KEY_CHECKS = 0;

############################################################
# 一、配电网监测业务
############################################################

# 1. 配电房信息表
CREATE TABLE `配电房信息表` (
    `配电房编号` VARCHAR(15) PRIMARY KEY,
    `名称` VARCHAR(20) NOT NULL,
    `位置描述` VARCHAR(50) NOT NULL,
    `电压等级` VARCHAR(10) NOT NULL,
    `变压器数量` TINYINT NOT NULL CHECK (`变压器数量` >= 1),
    `投运时间` DATE NOT NULL,
    `负责人ID` VARCHAR(20) NOT NULL,
    `联系方式` VARCHAR(20) NOT NULL
);

# 2. 回路监测数据表
CREATE TABLE `回路监测数据表` (
    `数据编号` VARCHAR(20) PRIMARY KEY,
    `配电房编号` VARCHAR(15) NOT NULL,
    `回路编号` VARCHAR(10) NOT NULL,
    `采集时间` DATETIME NOT NULL,
    `电压kV` DECIMAL(5,2) NOT NULL,
    `电流A` DECIMAL(8,2) NOT NULL,
    `有功功率kW` DECIMAL(10,2) NOT NULL,
    `无功功率kVar` DECIMAL(10,2) NOT NULL,
    `功率因数` DECIMAL(4,2) NOT NULL CHECK (`功率因数` >= 0.85 AND `功率因数` <= 1.00),
    `正向有功电量kWh` DECIMAL(12,2) NOT NULL,
    `反向有功电量kWh` DECIMAL(12,2) NOT NULL,
    `开关状态` VARCHAR(5) NOT NULL CHECK (`开关状态` IN ('分闸','合闸')),
    `电缆头温度` DECIMAL(5,1) NOT NULL,
    `电容器温度` DECIMAL(5,1) NOT NULL,
    FOREIGN KEY (`配电房编号`) REFERENCES `配电房信息表`(`配电房编号`)
);

# 3. 变压器监测数据表
CREATE TABLE `变压器监测数据表` (
    `数据编号` VARCHAR(20) PRIMARY KEY,
    `配电房编号` VARCHAR(15) NOT NULL,
    `变压器编号` VARCHAR(10) NOT NULL,
    `采集时间` DATETIME NOT NULL,
    `负载率` DECIMAL(5,2) NOT NULL,
    `绕组温度` DECIMAL(5,1) NOT NULL,
    `铁芯温度` DECIMAL(5,1) NOT NULL,
    `环境温度` DECIMAL(5,1) NOT NULL,
    `环境湿度` DECIMAL(5,1) NOT NULL,
    `运行状态` VARCHAR(5) NOT NULL CHECK (`运行状态` IN ('正常','异常')),
    FOREIGN KEY (`配电房编号`) REFERENCES `配电房信息表`(`配电房编号`)
);

############################################################
# 二、光伏业务
############################################################

# 1. 光伏设备信息
CREATE TABLE `光伏设备信息` (
    `设备编号` VARCHAR(20) PRIMARY KEY,
    `设备类型` VARCHAR(50) NOT NULL,
    `安装位置` VARCHAR(50) NOT NULL,
    `装机容量` VARCHAR(50) NOT NULL,
    `投运时间` DATE NOT NULL,
    `校准周期` INT NOT NULL,
    `运行状态` VARCHAR(10) NOT NULL CHECK (`运行状态` IN ('正常','故障','离线')),
    `通信协议` VARCHAR(20) NOT NULL
);

# 2. 光伏发电数据
CREATE TABLE `光伏发电数据` (
    `数据编号` VARCHAR(30) PRIMARY KEY,
    `设备编号` VARCHAR(20) NOT NULL,
    `并网点编号` VARCHAR(20) NOT NULL,
    `采集时间` DATETIME NOT NULL,
    `发电量` DECIMAL(18,2) NOT NULL,
    `上网电量` DECIMAL(18,2) NOT NULL,
    `自用电量` DECIMAL(18,2) NOT NULL,
    `汇流箱组串电压V` DECIMAL(10,2) NOT NULL,
    `组串电流A` DECIMAL(10,2) NOT NULL,
    `逆变器效率` DECIMAL(5,2) NOT NULL,
    FOREIGN KEY (`设备编号`) REFERENCES `光伏设备信息`(`设备编号`)
);

# 3. 光伏预测数据
CREATE TABLE `光伏预测数据` (
    `预测编号` VARCHAR(30) PRIMARY KEY,
    `并网点编号` VARCHAR(20) NOT NULL,
    `预测日期` DATE NOT NULL,
    `预测时段` VARCHAR(20) NOT NULL,
    `预测发电量` DECIMAL(18,2) NOT NULL,
    `实际发电量` DECIMAL(18,2) NOT NULL,
    `偏差率` DECIMAL(8,2) NOT NULL,
    `预测模型版本` VARCHAR(20) NOT NULL,
);

############################################################
# 三、综合能耗管理
############################################################

# 1. 能耗计量设备信息
CREATE TABLE `能耗计量设备信息` (
    `设备编号` VARCHAR(20) PRIMARY KEY,
    `能源类型` VARCHAR(10) NOT NULL CHECK (`能源类型` IN ('水','蒸汽','天然气')),
    `安装位置` VARCHAR(50) NOT NULL,
    `管径规格` VARCHAR(10),
    `通信协议` VARCHAR(10) NOT NULL,
    `运行状态` VARCHAR(10) NOT NULL CHECK (`运行状态` IN ('正常','故障')),
    `校准周期` INT NOT NULL CHECK (`校准周期` >= 3 AND `校准周期` <= 24),
    `生产厂家` VARCHAR(30)
);

# 2. 能耗监测数据
CREATE TABLE `能耗监测数据` (
    `数据编号` VARCHAR(20) PRIMARY KEY,
    `设备编号` VARCHAR(20) NOT NULL,
    `采集时间` DATETIME NOT NULL,
    `能耗值` DECIMAL(10,2) NOT NULL CHECK (`能耗值` >= 0),
    `单位` VARCHAR(5) NOT NULL CHECK (`单位` IN ('m³','t')),
    `数据质量` VARCHAR(5) NOT NULL CHECK (`数据质量` IN ('优','良','中','差')),
    `所属厂区编号` VARCHAR(10) NOT NULL,
    FOREIGN KEY (`设备编号`) REFERENCES `能耗计量设备信息`(`设备编号`)
);

# 3. 峰谷能耗数据
CREATE TABLE `峰谷能耗数据` (
    `记录编号` VARCHAR(20) PRIMARY KEY,
    `能源类型` VARCHAR(10) NOT NULL CHECK (`能源类型` IN ('水','蒸汽','天然气')),
    `厂区编号` VARCHAR(10) NOT NULL,
    `统计日期` DATE NOT NULL,
    `尖峰时段能耗` DECIMAL(10,2) NOT NULL,
    `高峰时段能耗` DECIMAL(10,2) NOT NULL,
    `平段能耗` DECIMAL(10,2) NOT NULL,
    `低谷时段能耗` DECIMAL(10,2) NOT NULL,
    `总能耗` DECIMAL(10,2) NOT NULL,
    `峰谷电价` DECIMAL(6,4) NOT NULL,
    `能耗成本` DECIMAL(12,2) NOT NULL
);

############################################################
# 四、告警与运维管理
############################################################

# 1. 告警信息表
CREATE TABLE `告警信息表` (
    `告警编号` VARCHAR(20) PRIMARY KEY,
    `告警类型` VARCHAR(20) NOT NULL,
    `关联设备编号` VARCHAR(20) NOT NULL,
    `发生时间` DATETIME NOT NULL,
    `告警等级` VARCHAR(20) NOT NULL CHECK (`告警等级` IN ('高','中','低')),
    `告警内容` VARCHAR(500) NOT NULL,
    `处理状态` VARCHAR(20) NOT NULL DEFAULT '未处理'
        CHECK (`处理状态` IN ('未处理','处理中','已结案')),
    `告警触发阈值` VARCHAR(100)
);

# 2. 运维工单数据
CREATE TABLE `运维工单数据` (
    `工单编号` VARCHAR(20) PRIMARY KEY,
    `告警编号` VARCHAR(20) NOT NULL,
    `运维人员ID` VARCHAR(20) NOT NULL,
    `派单时间` DATETIME NOT NULL,
    `响应时间` DATETIME,
    `处理完成时间` DATETIME,
    `处理结果` VARCHAR(500),
    `复查状态` VARCHAR(10) CHECK (`复查状态` IN ('通过','未通过')),
    `附件路径` VARCHAR(200),
    FOREIGN KEY (`告警编号`) REFERENCES `告警信息表`(`告警编号`),
    FOREIGN KEY (`运维人员ID`) REFERENCES `用户表`(`用户ID`)
);

# 3. 设备台账数据
CREATE TABLE `设备台账数据` (
    `台账编号` VARCHAR(20) PRIMARY KEY,
    `设备名称` VARCHAR(50) NOT NULL,
    `设备类型` VARCHAR(10) NOT NULL,
    `型号规格` VARCHAR(50),
    `安装时间` DATE NOT NULL,
    `质保期年` INT,
    `维修记录` VARCHAR(20),
    `校准记录` VARCHAR(20),
    `报废状态` VARCHAR(10) CHECK (`报废状态` IN ('正常使用','已报废'))
);

############################################################
# 五、大屏展示业务
############################################################

# 1. 大屏展示配置
CREATE TABLE `大屏展示配置` (
    `配置编号` VARCHAR(15) PRIMARY KEY,
    `展示模块` VARCHAR(50) NOT NULL,
    `数据刷新频率` INT NOT NULL,
    `展示字段` VARCHAR(50) NOT NULL,
    `排序规则` VARCHAR(50),
    `权限等级` VARCHAR(50) NOT NULL,
    UNIQUE (`展示模块`,`权限等级`)
);

# 2. 实时汇总数据
CREATE TABLE `实时汇总数据` (
    `汇总编号` VARCHAR(15) PRIMARY KEY,
    `统计时间` DATETIME NOT NULL,
    `总用电量` DECIMAL(18,2),
    `总用水量` DECIMAL(18,2),
    `总蒸汽消耗量` DECIMAL(18,2),
    `总天然气消耗量` DECIMAL(18,2),
    `光伏总发电量` DECIMAL(18,2),
    `光伏自用电量` DECIMAL(18,2),
    `总告警次数` INT,
    `高等级告警数` INT,
    `中等级告警数` INT,
    `低等级告警数` INT
);

# 3. 历史趋势数据
CREATE TABLE `历史趋势数据` (
    `趋势编号` VARCHAR(15) PRIMARY KEY,
    `能源类型` VARCHAR(20) NOT NULL,
    `统计周期` VARCHAR(20) NOT NULL,
    `统计时间` DATE NOT NULL,
    `能耗或发电量数值` DECIMAL(18,2) NOT NULL,
    `同比增长率` DECIMAL(8,2),
    `环比增长率` DECIMAL(8,2),
    `行业均值` VARCHAR(20)
);

############################################################
# 六、用户表
############################################################

CREATE TABLE `用户表` (
    `用户ID` CHAR(3) PRIMARY KEY,
    `姓名` VARCHAR(50) NOT NULL,
    `密码` VARCHAR(100) NOT NULL,
    `角色` VARCHAR(50) NOT NULL CHECK (`角色` IN (
        '系统管理员','能源管理员','运维人员','数据分析师','企业管理层','运维工单管理员'
    ))
);

SET FOREIGN_KEY_CHECKS = 1;
