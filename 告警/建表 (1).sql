-- MySQL dump 10.13  Distrib 8.0.44, for Win64 (x86_64)
--
-- Host: 121.196.200.165    Database: smart_energy
-- ------------------------------------------------------
-- Server version	8.0.44

/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!50503 SET NAMES utf8 */;
/*!40103 SET @OLD_TIME_ZONE=@@TIME_ZONE */;
/*!40103 SET TIME_ZONE='+00:00' */;
/*!40014 SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0 */;
/*!40014 SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0 */;
/*!40101 SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_AUTO_VALUE_ON_ZERO' */;
/*!40111 SET @OLD_SQL_NOTES=@@SQL_NOTES, SQL_NOTES=0 */;

--
-- Temporary view structure for view `v_光伏预测偏差`
--

DROP TABLE IF EXISTS `v_光伏预测偏差`;
/*!50001 DROP VIEW IF EXISTS `v_光伏预测偏差`*/;
SET @saved_cs_client     = @@character_set_client;
/*!50503 SET character_set_client = utf8mb4 */;
/*!50001 CREATE VIEW `v_光伏预测偏差` AS SELECT 
 1 AS `预测编号`,
 1 AS `并网点编号`,
 1 AS `预测日期`,
 1 AS `预测时段`,
 1 AS `预测发电量kWh`,
 1 AS `实际发电量kWh`,
 1 AS `偏差率`,
 1 AS `预测模型版本`,
 1 AS `偏差等级`,
 1 AS `绝对偏差`*/;
SET character_set_client = @saved_cs_client;

--
-- Temporary view structure for view `v_厂区能耗汇总`
--

DROP TABLE IF EXISTS `v_厂区能耗汇总`;
/*!50001 DROP VIEW IF EXISTS `v_厂区能耗汇总`*/;
SET @saved_cs_client     = @@character_set_client;
/*!50503 SET character_set_client = utf8mb4 */;
/*!50001 CREATE VIEW `v_厂区能耗汇总` AS SELECT 
 1 AS `厂区编号`,
 1 AS `能源类型`,
 1 AS `数据记录数`,
 1 AS `总能耗`,
 1 AS `平均能耗`,
 1 AS `最大能耗`,
 1 AS `最小能耗`,
 1 AS `优质数据数`,
 1 AS `待核实数据数`,
 1 AS `最新数据时间`*/;
SET character_set_client = @saved_cs_client;

--
-- Temporary view structure for view `v_历史趋势分析`
--

DROP TABLE IF EXISTS `v_历史趋势分析`;
/*!50001 DROP VIEW IF EXISTS `v_历史趋势分析`*/;
SET @saved_cs_client     = @@character_set_client;
/*!50503 SET character_set_client = utf8mb4 */;
/*!50001 CREATE VIEW `v_历史趋势分析` AS SELECT 
 1 AS `趋势编号`,
 1 AS `能源类型`,
 1 AS `统计周期`,
 1 AS `统计时间`,
 1 AS `能耗发电量数值`,
 1 AS `同比增长率`,
 1 AS `环比增长率`,
 1 AS `行业均值`,
 1 AS `同比趋势`,
 1 AS `环比趋势`,
 1 AS `行业对比`*/;
SET character_set_client = @saved_cs_client;

--
-- Temporary view structure for view `v_变压器负载率趋势`
--

DROP TABLE IF EXISTS `v_变压器负载率趋势`;
/*!50001 DROP VIEW IF EXISTS `v_变压器负载率趋势`*/;
SET @saved_cs_client     = @@character_set_client;
/*!50503 SET character_set_client = utf8mb4 */;
/*!50001 CREATE VIEW `v_变压器负载率趋势` AS SELECT 
 1 AS `数据编号`,
 1 AS `配电房编号`,
 1 AS `配电房名称`,
 1 AS `变压器编号`,
 1 AS `采集时间`,
 1 AS `负载率`,
 1 AS `绕组温度`,
 1 AS `环境温度`,
 1 AS `运行状态`,
 1 AS `负载等级`*/;
SET character_set_client = @saved_cs_client;

--
-- Temporary view structure for view `v_告警发生频率统计`
--

DROP TABLE IF EXISTS `v_告警发生频率统计`;
/*!50001 DROP VIEW IF EXISTS `v_告警发生频率统计`*/;
SET @saved_cs_client     = @@character_set_client;
/*!50503 SET character_set_client = utf8mb4 */;
/*!50001 CREATE VIEW `v_告警发生频率统计` AS SELECT 
 1 AS `告警类型`,
 1 AS `告警等级`,
 1 AS `告警总数`,
 1 AS `今日告警数`,
 1 AS `昨日告警数`,
 1 AS `本月告警数`,
 1 AS `日均告警数`,
 1 AS `误报率百分比`*/;
SET character_set_client = @saved_cs_client;

--
-- Temporary view structure for view `v_告警处理及时率统计`
--

DROP TABLE IF EXISTS `v_告警处理及时率统计`;
/*!50001 DROP VIEW IF EXISTS `v_告警处理及时率统计`*/;
SET @saved_cs_client     = @@character_set_client;
/*!50503 SET character_set_client = utf8mb4 */;
/*!50001 CREATE VIEW `v_告警处理及时率统计` AS SELECT 
 1 AS `告警日期`,
 1 AS `总告警数`,
 1 AS `已派单数`,
 1 AS `已处理数`,
 1 AS `30分钟内响应数`,
 1 AS `2小时内解决数`,
 1 AS `响应及时率`,
 1 AS `解决及时率`*/;
SET character_set_client = @saved_cs_client;

--
-- Temporary view structure for view `v_告警规则执行情况`
--

DROP TABLE IF EXISTS `v_告警规则执行情况`;
/*!50001 DROP VIEW IF EXISTS `v_告警规则执行情况`*/;
SET @saved_cs_client     = @@character_set_client;
/*!50503 SET character_set_client = utf8mb4 */;
/*!50001 CREATE VIEW `v_告警规则执行情况` AS SELECT 
 1 AS `规则编号`,
 1 AS `规则名称`,
 1 AS `设备类型`,
 1 AS `设备子类型`,
 1 AS `触发字段`,
 1 AS `比较运算符`,
 1 AS `触发阈值`,
 1 AS `告警等级`,
 1 AS `启用状态`,
 1 AS `是否启用`,
 1 AS `触发条件表达式`,
 1 AS `最后触发时间`,
 1 AS `触发次数`,
 1 AS `今日触发次数`,
 1 AS `历史误报数`,
 1 AS `规则状态`,
 1 AS `维护建议`*/;
SET character_set_client = @saved_cs_client;

--
-- Temporary view structure for view `v_回路异常数据`
--

DROP TABLE IF EXISTS `v_回路异常数据`;
/*!50001 DROP VIEW IF EXISTS `v_回路异常数据`*/;
SET @saved_cs_client     = @@character_set_client;
/*!50503 SET character_set_client = utf8mb4 */;
/*!50001 CREATE VIEW `v_回路异常数据` AS SELECT 
 1 AS `数据编号`,
 1 AS `配电房编号`,
 1 AS `配电房名称`,
 1 AS `位置描述`,
 1 AS `回路编号`,
 1 AS `采集时间`,
 1 AS `电压kV`,
 1 AS `电流A`,
 1 AS `有功功率kW`,
 1 AS `功率因数`,
 1 AS `开关状态`,
 1 AS `电缆头温度`,
 1 AS `电容器温度`,
 1 AS `数据状态`,
 1 AS `异常类型`*/;
SET character_set_client = @saved_cs_client;

--
-- Temporary view structure for view `v_大屏配置权限`
--

DROP TABLE IF EXISTS `v_大屏配置权限`;
/*!50001 DROP VIEW IF EXISTS `v_大屏配置权限`*/;
SET @saved_cs_client     = @@character_set_client;
/*!50503 SET character_set_client = utf8mb4 */;
/*!50001 CREATE VIEW `v_大屏配置权限` AS SELECT 
 1 AS `配置编号`,
 1 AS `展示模块`,
 1 AS `数据刷新频率`,
 1 AS `展示字段`,
 1 AS `排序规则`,
 1 AS `权限等级`,
 1 AS `可访问模块说明`*/;
SET character_set_client = @saved_cs_client;

--
-- Temporary view structure for view `v_实时能源总览`
--

DROP TABLE IF EXISTS `v_实时能源总览`;
/*!50001 DROP VIEW IF EXISTS `v_实时能源总览`*/;
SET @saved_cs_client     = @@character_set_client;
/*!50503 SET character_set_client = utf8mb4 */;
/*!50001 CREATE VIEW `v_实时能源总览` AS SELECT 
 1 AS `汇总编号`,
 1 AS `统计时间`,
 1 AS `总用电量kWh`,
 1 AS `总用水量m3`,
 1 AS `总蒸汽消耗量t`,
 1 AS `总天然气消耗量m3`,
 1 AS `光伏总发电量kWh`,
 1 AS `光伏自用电量kWh`,
 1 AS `总告警次数`,
 1 AS `高等级告警数`,
 1 AS `中等级告警数`,
 1 AS `低等级告警数`,
 1 AS `系统状态`*/;
SET character_set_client = @saved_cs_client;

--
-- Temporary view structure for view `v_峰谷能耗分析`
--

DROP TABLE IF EXISTS `v_峰谷能耗分析`;
/*!50001 DROP VIEW IF EXISTS `v_峰谷能耗分析`*/;
SET @saved_cs_client     = @@character_set_client;
/*!50503 SET character_set_client = utf8mb4 */;
/*!50001 CREATE VIEW `v_峰谷能耗分析` AS SELECT 
 1 AS `厂区编号`,
 1 AS `能源类型`,
 1 AS `统计日期`,
 1 AS `尖峰时段能耗`,
 1 AS `高峰时段能耗`,
 1 AS `平段能耗`,
 1 AS `低谷时段能耗`,
 1 AS `总能耗`,
 1 AS `能耗成本`,
 1 AS `谷段占比`,
 1 AS `峰段占比`,
 1 AS `能耗评价`*/;
SET character_set_client = @saved_cs_client;

--
-- Temporary view structure for view `v_待审核误报告警`
--

DROP TABLE IF EXISTS `v_待审核误报告警`;
/*!50001 DROP VIEW IF EXISTS `v_待审核误报告警`*/;
SET @saved_cs_client     = @@character_set_client;
/*!50503 SET character_set_client = utf8mb4 */;
/*!50001 CREATE VIEW `v_待审核误报告警` AS SELECT 
 1 AS `告警编号`,
 1 AS `告警类型`,
 1 AS `告警等级`,
 1 AS `关联设备编号`,
 1 AS `发生时间`,
 1 AS `告警内容`,
 1 AS `处理状态`,
 1 AS `告警持续时间(分钟)`,
 1 AS `审核优先级`*/;
SET character_set_client = @saved_cs_client;

--
-- Temporary view structure for view `v_待审核误报告警_详细`
--

DROP TABLE IF EXISTS `v_待审核误报告警_详细`;
/*!50001 DROP VIEW IF EXISTS `v_待审核误报告警_详细`*/;
SET @saved_cs_client     = @@character_set_client;
/*!50503 SET character_set_client = utf8mb4 */;
/*!50001 CREATE VIEW `v_待审核误报告警_详细` AS SELECT 
 1 AS `告警编号`,
 1 AS `告警类型`,
 1 AS `告警等级`,
 1 AS `关联设备编号`,
 1 AS `设备描述`,
 1 AS `发生时间`,
 1 AS `持续时间分钟`,
 1 AS `告警内容`,
 1 AS `处理状态`,
 1 AS `告警触发阈值`,
 1 AS `创建时间`,
 1 AS `误报可能性`,
 1 AS `审核优先级`,
 1 AS `设备状态`*/;
SET character_set_client = @saved_cs_client;

--
-- Temporary view structure for view `v_能耗数据质量监控`
--

DROP TABLE IF EXISTS `v_能耗数据质量监控`;
/*!50001 DROP VIEW IF EXISTS `v_能耗数据质量监控`*/;
SET @saved_cs_client     = @@character_set_client;
/*!50503 SET character_set_client = utf8mb4 */;
/*!50001 CREATE VIEW `v_能耗数据质量监控` AS SELECT 
 1 AS `设备编号`,
 1 AS `能源类型`,
 1 AS `安装位置`,
 1 AS `运行状态`,
 1 AS `总数据数`,
 1 AS `优质数据数`,
 1 AS `良好数据数`,
 1 AS `中等数据数`,
 1 AS `差数据数`,
 1 AS `数据优良率`,
 1 AS `最新数据时间`,
 1 AS `设备状态`*/;
SET character_set_client = @saved_cs_client;

--
-- Temporary view structure for view `v_设备类型告警分布`
--

DROP TABLE IF EXISTS `v_设备类型告警分布`;
/*!50001 DROP VIEW IF EXISTS `v_设备类型告警分布`*/;
SET @saved_cs_client     = @@character_set_client;
/*!50503 SET character_set_client = utf8mb4 */;
/*!50001 CREATE VIEW `v_设备类型告警分布` AS SELECT 
 1 AS `设备类型`,
 1 AS `告警总数`,
 1 AS `高等级告警数`,
 1 AS `中等级告警数`,
 1 AS `低等级告警数`,
 1 AS `未处理告警数`,
 1 AS `已结案告警数`,
 1 AS `平均处理时长(分钟)`*/;
SET character_set_client = @saved_cs_client;

--
-- Temporary view structure for view `v_运维人员工作量统计`
--

DROP TABLE IF EXISTS `v_运维人员工作量统计`;
/*!50001 DROP VIEW IF EXISTS `v_运维人员工作量统计`*/;
SET @saved_cs_client     = @@character_set_client;
/*!50503 SET character_set_client = utf8mb4 */;
/*!50001 CREATE VIEW `v_运维人员工作量统计` AS SELECT 
 1 AS `运维人员ID`,
 1 AS `姓名`,
 1 AS `总工单数`,
 1 AS `已完成工单数`,
 1 AS `未通过工单数`,
 1 AS `未响应工单数`,
 1 AS `平均响应时间(分钟)`,
 1 AS `平均处理时间(分钟)`,
 1 AS `平均总耗时(分钟)`,
 1 AS `2小时内完成数`*/;
SET character_set_client = @saved_cs_client;

--
-- Temporary view structure for view `v_运维工单处理效率`
--

DROP TABLE IF EXISTS `v_运维工单处理效率`;
/*!50001 DROP VIEW IF EXISTS `v_运维工单处理效率`*/;
SET @saved_cs_client     = @@character_set_client;
/*!50503 SET character_set_client = utf8mb4 */;
/*!50001 CREATE VIEW `v_运维工单处理效率` AS SELECT 
 1 AS `工单编号`,
 1 AS `告警编号`,
 1 AS `告警类型`,
 1 AS `告警等级`,
 1 AS `运维人员ID`,
 1 AS `派单时间`,
 1 AS `响应时间`,
 1 AS `处理完成时间`,
 1 AS `复查状态`,
 1 AS `响应时长分钟`,
 1 AS `处理时长分钟`,
 1 AS `总处理时长分钟`,
 1 AS `工单状态`*/;
SET character_set_client = @saved_cs_client;

--
-- Temporary view structure for view `v_配电房运行状态汇总`
--

DROP TABLE IF EXISTS `v_配电房运行状态汇总`;
/*!50001 DROP VIEW IF EXISTS `v_配电房运行状态汇总`*/;
SET @saved_cs_client     = @@character_set_client;
/*!50503 SET character_set_client = utf8mb4 */;
/*!50001 CREATE VIEW `v_配电房运行状态汇总` AS SELECT 
 1 AS `配电房编号`,
 1 AS `配电房名称`,
 1 AS `电压等级`,
 1 AS `变压器数量`,
 1 AS `回路数量`,
 1 AS `异常回路数`,
 1 AS `异常变压器数`,
 1 AS `最新回路数据时间`,
 1 AS `最新变压器数据时间`*/;
SET character_set_client = @saved_cs_client;

--
-- Temporary view structure for view `v_高等级告警`
--

DROP TABLE IF EXISTS `v_高等级告警`;
/*!50001 DROP VIEW IF EXISTS `v_高等级告警`*/;
SET @saved_cs_client     = @@character_set_client;
/*!50503 SET character_set_client = utf8mb4 */;
/*!50001 CREATE VIEW `v_高等级告警` AS SELECT 
 1 AS `告警编号`,
 1 AS `告警类型`,
 1 AS `关联设备编号`,
 1 AS `发生时间`,
 1 AS `告警等级`,
 1 AS `告警内容`,
 1 AS `处理状态`,
 1 AS `告警触发阈值`,
 1 AS `告警持续时间分钟`,
 1 AS `告警状态`*/;
SET character_set_client = @saved_cs_client;

--
-- Table structure for table `光伏发电数据表`
--

DROP TABLE IF EXISTS `光伏发电数据表`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `光伏发电数据表` (
  `数据编号` varchar(20) NOT NULL COMMENT '唯一标识单条发电数据',
  `设备编号` varchar(20) NOT NULL COMMENT '关联光伏设备信息表',
  `并网点编号` varchar(20) NOT NULL COMMENT '关联并网点',
  `采集时间` datetime NOT NULL COMMENT '格式：YYYY-MM-DD HH:MM:SS',
  `发电量kWh` decimal(12,2) NOT NULL COMMENT '≥0',
  `上网电量kWh` decimal(12,2) NOT NULL COMMENT '≥0',
  `自用电量kWh` decimal(12,2) NOT NULL COMMENT '≥0',
  `逆变器效率` decimal(5,2) NOT NULL COMMENT '0-100%，低于85%标记为设备异常',
  `汇流箱组串电压V` decimal(8,2) DEFAULT NULL COMMENT '允许空',
  `组串电流A` decimal(8,2) DEFAULT NULL COMMENT '允许空',
  PRIMARY KEY (`数据编号`),
  KEY `idx_设备编号_发电` (`设备编号`),
  KEY `idx_采集时间_发电` (`采集时间`),
  KEY `idx_并网点编号` (`并网点编号`),
  CONSTRAINT `光伏发电数据表_ibfk_1` FOREIGN KEY (`设备编号`) REFERENCES `光伏设备信息表` (`设备编号`) ON DELETE CASCADE,
  CONSTRAINT `光伏发电数据表_chk_1` CHECK ((`发电量kWh` >= 0)),
  CONSTRAINT `光伏发电数据表_chk_2` CHECK ((`上网电量kWh` >= 0)),
  CONSTRAINT `光伏发电数据表_chk_3` CHECK ((`自用电量kWh` >= 0)),
  CONSTRAINT `光伏发电数据表_chk_4` CHECK (((`逆变器效率` >= 0) and (`逆变器效率` <= 100))),
  CONSTRAINT `光伏发电数据表_chk_5` CHECK ((`发电量kWh` >= (`上网电量kWh` + `自用电量kWh`)))
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci COMMENT='光伏发电数据表';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `光伏发电数据表`
--

LOCK TABLES `光伏发电数据表` WRITE;
/*!40000 ALTER TABLE `光伏发电数据表` DISABLE KEYS */;
INSERT INTO `光伏发电数据表` VALUES ('PV100','INV-100','BGD102','2026-01-04 09:00:00',25.50,15.25,10.25,92.50,650.25,12.50),('PV101','INV-100','BGD102','2026-01-04 10:00:00',30.75,18.50,12.25,93.20,655.80,12.80),('PV102','INV-101','BGD102','2026-01-04 09:00:00',48.25,30.75,17.50,91.80,660.45,25.60),('PV103','INV-101','BGD102','2026-01-04 10:00:00',52.80,32.25,20.55,92.10,662.80,26.80),('PV104','INV-102','BGD103','2026-01-04 09:00:00',0.00,0.00,0.00,0.00,0.00,0.00);
/*!40000 ALTER TABLE `光伏发电数据表` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `光伏设备信息表`
--

DROP TABLE IF EXISTS `光伏设备信息表`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `光伏设备信息表` (
  `设备编号` varchar(20) NOT NULL COMMENT '如SD-PV-001',
  `设备类型` varchar(50) NOT NULL COMMENT '逆变器、汇流箱',
  `安装位置` varchar(50) NOT NULL COMMENT '屋顶区域编号/园区片区',
  `装机容量kWp` decimal(10,2) NOT NULL COMMENT '单位：kWp',
  `投运时间` date NOT NULL COMMENT '格式：YYYY-MM-DD',
  `校准周期` int NOT NULL COMMENT '单位：月，≥3且≤24',
  `运行状态` varchar(10) NOT NULL COMMENT '正常、故障、离线',
  `通信协议` varchar(20) NOT NULL COMMENT 'RS485、Lora、以太网',
  `创建时间` datetime DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
  `更新时间` datetime DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '更新时间',
  PRIMARY KEY (`设备编号`),
  KEY `idx_运行状态_光伏` (`运行状态`),
  CONSTRAINT `光伏设备信息表_chk_1` CHECK (((`校准周期` >= 3) and (`校准周期` <= 24))),
  CONSTRAINT `光伏设备信息表_chk_2` CHECK ((`装机容量kWp` >= 0))
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci COMMENT='光伏设备信息表';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `光伏设备信息表`
--

LOCK TABLES `光伏设备信息表` WRITE;
/*!40000 ALTER TABLE `光伏设备信息表` DISABLE KEYS */;
INSERT INTO `光伏设备信息表` VALUES ('COMB-001','汇流箱','M区屋顶1号',200.00,'2024-01-20',24,'正常','RS485','2026-01-03 22:11:26','2026-01-04 17:25:04'),('COMB-002','汇流箱','N区屋顶1号',300.00,'2024-02-10',24,'正常','以太网','2026-01-03 22:11:26','2026-01-04 17:25:04'),('COMB-003','汇流箱','O区屋顶1号',250.00,'2024-03-01',24,'故障','Lora','2026-01-03 22:11:26','2026-01-04 17:25:04'),('COMB-004','汇流箱','P区屋顶1号',400.00,'2024-04-05',24,'正常','RS485','2026-01-03 22:11:26','2026-01-04 17:25:04'),('COMB-005','汇流箱','Q区屋顶1号',350.00,'2024-05-01',24,'正常','以太网','2026-01-03 22:11:26','2026-01-04 17:25:04'),('COMB-006','汇流箱','M区屋顶2号',280.00,'2024-06-01',24,'离线','Lora','2026-01-03 22:11:26','2026-01-04 17:25:04'),('COMB-007','汇流箱','N区屋顶2号',320.00,'2024-06-15',24,'正常','RS485','2026-01-03 22:11:26','2026-01-04 17:25:04'),('COMB-008','汇流箱','O区屋顶2号',380.00,'2024-07-01',24,'正常','以太网','2026-01-03 22:11:26','2026-01-04 17:25:04'),('COMB-009','汇流箱','P区屋顶2号',270.00,'2024-07-10',24,'故障','Lora','2026-01-03 22:11:26','2026-01-04 17:25:04'),('COMB-010','汇流箱','Q区屋顶2号',420.00,'2024-08-01',24,'正常','RS485','2026-01-03 22:11:26','2026-01-04 17:25:04'),('COMB-011','汇流箱','M区屋顶3号',220.00,'2024-08-15',24,'正常','以太网','2026-01-03 22:11:26','2026-01-04 17:25:04'),('COMB-012','汇流箱','N区屋顶3号',260.00,'2024-09-01',24,'正常','RS485','2026-01-03 22:11:26','2026-01-04 17:25:04'),('COMB-013','汇流箱','O区屋顶3号',310.00,'2024-09-10',24,'离线','Lora','2026-01-03 22:11:26','2026-01-04 17:25:04'),('COMB-014','汇流箱','P区屋顶3号',290.00,'2024-10-01',24,'正常','以太网','2026-01-03 22:11:26','2026-01-04 17:25:04'),('COMB-015','汇流箱','Q区屋顶3号',330.00,'2024-10-10',24,'正常','RS485','2026-01-03 22:11:26','2026-01-04 17:25:04'),('COMB-100','汇流箱','M区屋顶1号',200.00,'2024-01-20',24,'正常','RS485','2026-01-01 10:00:00','2026-01-04 17:25:04'),('COMB-101','汇流箱','N区屋顶1号',300.00,'2024-02-10',24,'正常','以太网','2026-01-01 10:00:00','2026-01-04 17:25:04'),('INV-001','逆变器','M区屋顶1号',50.00,'2024-01-20',12,'正常','RS485','2026-01-03 22:11:26','2026-01-04 17:25:04'),('INV-002','逆变器','M区屋顶2号',100.00,'2024-01-25',12,'正常','以太网','2026-01-03 22:11:26','2026-01-04 17:25:04'),('INV-003','逆变器','N区屋顶1号',80.00,'2024-02-10',12,'故障','Lora','2026-01-03 22:11:26','2026-01-04 17:25:04'),('INV-004','逆变器','N区屋顶2号',120.00,'2024-02-15',12,'正常','RS485','2026-01-03 22:11:26','2026-01-04 17:25:04'),('INV-005','逆变器','O区屋顶1号',60.00,'2024-03-01',12,'离线','Lora','2026-01-03 22:11:26','2026-01-04 17:25:04'),('INV-006','逆变器','O区屋顶2号',150.00,'2024-03-10',12,'正常','以太网','2026-01-03 22:11:26','2026-01-04 17:25:04'),('INV-007','逆变器','P区屋顶1号',200.00,'2024-04-05',12,'正常','RS485','2026-01-03 22:11:26','2026-01-04 17:25:04'),('INV-008','逆变器','P区屋顶2号',75.00,'2024-04-10',12,'故障','Lora','2026-01-03 22:11:26','2026-01-04 17:25:04'),('INV-009','逆变器','Q区屋顶1号',90.00,'2024-05-01',12,'正常','以太网','2026-01-03 22:11:26','2026-01-04 17:25:04'),('INV-010','逆变器','Q区屋顶2号',110.00,'2024-05-10',12,'正常','RS485','2026-01-03 22:11:26','2026-01-04 17:25:04'),('INV-011','逆变器','M区屋顶3号',130.00,'2024-06-01',12,'离线','Lora','2026-01-03 22:11:26','2026-01-04 17:25:04'),('INV-012','逆变器','N区屋顶3号',180.00,'2024-06-15',12,'正常','以太网','2026-01-03 22:11:26','2026-01-04 17:25:04'),('INV-013','逆变器','O区屋顶3号',70.00,'2024-07-01',12,'正常','RS485','2026-01-03 22:11:26','2026-01-04 17:25:04'),('INV-014','逆变器','P区屋顶3号',95.00,'2024-07-10',12,'故障','Lora','2026-01-03 22:11:26','2026-01-04 17:25:04'),('INV-015','逆变器','Q区屋顶3号',140.00,'2024-08-01',12,'正常','以太网','2026-01-03 22:11:26','2026-01-04 17:25:04'),('INV-100','逆变器','M区屋顶1号',50.00,'2024-01-20',12,'正常','RS485','2026-01-01 10:00:00','2026-01-04 17:25:04'),('INV-101','逆变器','M区屋顶2号',100.00,'2024-01-25',12,'正常','以太网','2026-01-01 10:00:00','2026-01-04 17:25:04'),('INV-102','逆变器','N区屋顶1号',80.00,'2024-02-10',12,'故障','Lora','2026-01-01 10:00:00','2026-01-04 17:25:04');
/*!40000 ALTER TABLE `光伏设备信息表` ENABLE KEYS */;
UNLOCK TABLES;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
/*!50003 CREATE*/ /*!50017 DEFINER=`jw`@`%`*/ /*!50003 TRIGGER `trg_光伏设备台账同步` AFTER INSERT ON `光伏设备信息表` FOR EACH ROW BEGIN
    -- 检查设备是否已存在于台账
    IF NOT EXISTS (
        SELECT 1 FROM `设备台账数据表`
        WHERE `台账编号` = NEW.`设备编号`
    ) THEN
        -- 插入新设备到台账
        INSERT INTO `设备台账数据表` (
            `台账编号`,
            `设备名称`,
            `设备类型`,
            `型号规格`,
            `安装时间`,
            `质保期_年`,
            `校准记录`,
            `报废状态`,
            `创建时间`,
            `更新时间`
        ) VALUES (
            NEW.`设备编号`,
            CONCAT('光伏', NEW.`设备类型`, '-', NEW.`设备编号`),
            NEW.`设备类型`,
            CONCAT('容量:', NEW.`装机容量kWp`, 'kWp, 协议:', NEW.`通信协议`),
            NEW.`投运时间`,
            5, -- 默认5年质保期
            CONCAT(DATE_FORMAT(NEW.`投运时间`, '%Y-%m-%d'), '-安装'),
            '正常使用',
            NOW(),
            NOW()
        );
    END IF;
END */;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;

--
-- Table structure for table `光伏预测数据表`
--

DROP TABLE IF EXISTS `光伏预测数据表`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `光伏预测数据表` (
  `预测编号` varchar(20) NOT NULL COMMENT '唯一标识预测记录',
  `并网点编号` varchar(20) NOT NULL COMMENT '关联并网点',
  `预测日期` date NOT NULL COMMENT '格式：YYYY-MM-DD',
  `预测时段` varchar(20) NOT NULL COMMENT '如08:00-09:00',
  `预测发电量kWh` decimal(12,2) NOT NULL COMMENT '≥0',
  `实际发电量kWh` decimal(12,2) DEFAULT NULL COMMENT '允许空，实际数据采集后更新',
  `偏差率` decimal(5,2) DEFAULT NULL COMMENT '允许空，超15%触发预测模型优化提醒',
  `预测模型版本` varchar(20) DEFAULT NULL COMMENT '允许空',
  PRIMARY KEY (`预测编号`),
  KEY `idx_并网点日期` (`并网点编号`,`预测日期`),
  CONSTRAINT `光伏预测数据表_chk_1` CHECK ((`预测发电量kWh` >= 0)),
  CONSTRAINT `光伏预测数据表_chk_2` CHECK (((`实际发电量kWh` is null) or (`实际发电量kWh` >= 0))),
  CONSTRAINT `光伏预测数据表_chk_3` CHECK (((`偏差率` is null) or (abs(`偏差率`) <= 100)))
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci COMMENT='光伏预测数据表';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `光伏预测数据表`
--

LOCK TABLES `光伏预测数据表` WRITE;
/*!40000 ALTER TABLE `光伏预测数据表` DISABLE KEYS */;
INSERT INTO `光伏预测数据表` VALUES ('PF100','BGD102','2026-01-04','09:00-10:00',120.50,115.25,-4.36,'V1.2'),('PF101','BGD102','2026-01-04','10:00-11:00',135.75,142.50,4.74,'V1.2'),('PF102','BGD102','2026-01-04','11:00-12:00',152.25,165.80,8.18,'V1.2'),('PF103','BGD103','2026-01-04','09:00-10:00',85.20,80.50,-5.52,'V1.2'),('PF104','BGD103','2026-01-04','10:00-11:00',92.50,105.30,13.84,'V1.2');
/*!40000 ALTER TABLE `光伏预测数据表` ENABLE KEYS */;
UNLOCK TABLES;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
/*!50003 CREATE*/ /*!50017 DEFINER=`jw`@`%`*/ /*!50003 TRIGGER `trg_光伏预测偏差提醒` AFTER UPDATE ON `光伏预测数据表` FOR EACH ROW BEGIN
    -- 当实际发电量更新且偏差率超过15%时，生成告警
    IF NEW.`实际发电量kWh` IS NOT NULL 
       AND OLD.`实际发电量kWh` IS NULL 
       AND ABS(NEW.`偏差率`) > 15 
    THEN
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
            CONCAT('ALM-PV-', DATE_FORMAT(NOW(), '%y%m%d%H%i')),
            '设备故障',
            NEW.`并网点编号`,
            NOW(),
            '中',
            CONCAT('光伏预测偏差超15%：预测', ROUND(NEW.`预测发电量kWh`, 2), 
                   'kWh，实际', ROUND(NEW.`实际发电量kWh`, 2), 
                   'kWh，偏差率', ROUND(NEW.`偏差率`, 2), '%'),
            '未处理',
            '偏差率阈值:15%'
        );
    END IF;
END */;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;

--
-- Table structure for table `历史趋势数据表`
--

DROP TABLE IF EXISTS `历史趋势数据表`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `历史趋势数据表` (
  `趋势编号` varchar(20) NOT NULL COMMENT '唯一标识趋势记录',
  `能源类型` varchar(10) NOT NULL COMMENT '电、水、蒸汽、天然气、光伏',
  `统计周期` varchar(10) NOT NULL COMMENT '日、周、月',
  `统计时间` date NOT NULL COMMENT '格式：YYYY-MM-DD',
  `能耗发电量数值` decimal(18,2) NOT NULL COMMENT '≥0',
  `同比增长率` decimal(6,2) DEFAULT NULL COMMENT '允许空',
  `环比增长率` decimal(6,2) DEFAULT NULL COMMENT '允许空',
  `行业均值` decimal(18,2) DEFAULT NULL COMMENT '允许空',
  PRIMARY KEY (`趋势编号`),
  KEY `idx_能源类型` (`能源类型`),
  KEY `idx_统计周期` (`统计周期`),
  KEY `idx_能源周期时间` (`能源类型`,`统计周期`,`统计时间`),
  CONSTRAINT `历史趋势数据表_chk_1` CHECK ((`能耗发电量数值` >= 0))
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci COMMENT='历史趋势数据表';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `历史趋势数据表`
--

LOCK TABLES `历史趋势数据表` WRITE;
/*!40000 ALTER TABLE `历史趋势数据表` DISABLE KEYS */;
INSERT INTO `历史趋势数据表` VALUES ('HT100','电','日','2026-01-03',32800.75,5.20,-2.50,31500.00),('HT101','水','日','2026-01-03',138.20,-3.50,-1.80,142.50),('HT102','光伏','日','2026-01-03',285.50,12.80,6.25,250.00),('HT103','电','月','2025-12-01',985000.50,8.50,7.20,920000.00),('HT104','天然气','周','2025-12-29',2150.80,4.80,3.50,2080.00);
/*!40000 ALTER TABLE `历史趋势数据表` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `变压器监测数据表`
--

DROP TABLE IF EXISTS `变压器监测数据表`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `变压器监测数据表` (
  `数据编号` varchar(20) NOT NULL COMMENT '按变压器编号+采集时间戳编码',
  `配电房编号` varchar(15) NOT NULL COMMENT '关联配电房信息表',
  `变压器编号` varchar(10) NOT NULL COMMENT '如BYSQ-001',
  `采集时间` datetime NOT NULL COMMENT '格式：YYYY-MM-DD HH:MM:SS',
  `负载率` decimal(5,2) NOT NULL COMMENT '正常≤80%，短期允许≤100%',
  `绕组温度` decimal(5,1) NOT NULL COMMENT '油浸式变压器：正常≤85℃，超95℃触发告警',
  `铁芯温度` decimal(5,1) NOT NULL COMMENT '一般比绕组温度低5-10℃',
  `环境温度` decimal(5,1) NOT NULL COMMENT '配电房内一般-5℃~40℃',
  `环境湿度` decimal(5,1) NOT NULL COMMENT '配电房内一般30%~70%',
  `运行状态` varchar(5) NOT NULL COMMENT '正常、异常',
  PRIMARY KEY (`数据编号`),
  KEY `idx_配电房编号_变压器` (`配电房编号`),
  KEY `idx_采集时间_变压器` (`采集时间`),
  KEY `idx_运行状态` (`运行状态`),
  CONSTRAINT `变压器监测数据表_ibfk_1` FOREIGN KEY (`配电房编号`) REFERENCES `配电房信息表` (`配电房编号`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci COMMENT='变压器监测数据表';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `变压器监测数据表`
--

LOCK TABLES `变压器监测数据表` WRITE;
/*!40000 ALTER TABLE `变压器监测数据表` DISABLE KEYS */;
INSERT INTO `变压器监测数据表` VALUES ('BYQ100','PDF100','BYQ-100','2026-01-04 08:00:00',75.50,82.5,75.0,25.5,45.2,'正常'),('BYQ101','PDF100','BYQ-101','2026-01-04 08:05:00',68.20,78.8,72.5,26.0,46.8,'正常'),('BYQ102','PDF101','BYQ-102','2026-01-04 08:10:00',55.75,72.5,68.2,24.8,42.5,'正常'),('BYQ103','PDF102','BYQ-103','2026-01-04 08:15:00',92.80,88.5,82.0,27.5,48.2,'正常'),('BYQ104','PDF102','BYQ-104','2026-01-04 08:20:00',85.40,85.2,78.5,26.8,47.5,'正常');
/*!40000 ALTER TABLE `变压器监测数据表` ENABLE KEYS */;
UNLOCK TABLES;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
/*!50003 CREATE*/ /*!50017 DEFINER=`jw`@`%`*/ /*!50003 TRIGGER `trg_变压器异常告警` AFTER INSERT ON `变压器监测数据表` FOR EACH ROW BEGIN
    DECLARE v_规则匹配 INT DEFAULT 0;
    
    -- 检查是否有匹配的规则
    SELECT COUNT(*) INTO v_规则匹配
    FROM `告警规则配置表`
    WHERE `设备类型` = '变压器'
      AND `是否启用` = 1
      AND (`最后触发时间` IS NULL OR TIMESTAMPDIFF(MINUTE, `最后触发时间`, NOW()) >= `告警抑制时长`);
    
    IF v_规则匹配 > 0 THEN
        -- 使用规则系统
        CALL `sp_基于规则生成告警`(
            '变压器',
            NEW.`变压器编号`,
            '变压器监测数据表',
            JSON_OBJECT(
                '负载率', NEW.`负载率`,
                '绕组温度', NEW.`绕组温度`,
                '运行状态', NEW.`运行状态`,
                '配电房编号', NEW.`配电房编号`
            )
        );
    ELSE
        -- 传统逻辑：运行状态异常时生成告警
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
                CONCAT('ALM-TF-', DATE_FORMAT(NOW(), '%y%m%d%H%i')),
                '设备故障',
                NEW.`变压器编号`,
                NOW(),
                CASE 
                    WHEN NEW.`绕组温度` > 120 THEN '高'
                    WHEN NEW.`绕组温度` > 100 THEN '中'
                    ELSE '低'
                END,
                CONCAT('变压器', NEW.`变压器编号`, '异常：温度', 
                       NEW.`绕组温度`, '℃，负载率', NEW.`负载率`, '%'),
                '未处理',
                CONCAT('温度阈值:95℃, 负载率阈值:100%')
            );
        END IF;
    END IF;
END */;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;

--
-- Table structure for table `告警信息表`
--

DROP TABLE IF EXISTS `告警信息表`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `告警信息表` (
  `告警编号` varchar(20) NOT NULL COMMENT '唯一标识告警',
  `告警类型` varchar(20) NOT NULL COMMENT '越限告警、通讯故障、设备故障',
  `关联设备编号` varchar(20) NOT NULL COMMENT '如变压器编号/光伏逆变器编号',
  `发生时间` datetime NOT NULL COMMENT '格式：YYYY-MM-DD HH:MM:SS',
  `告警等级` varchar(20) NOT NULL COMMENT '高、中、低',
  `告警内容` varchar(500) NOT NULL COMMENT '如35KV主变绕组温度超100℃',
  `处理状态` varchar(20) NOT NULL DEFAULT '未处理' COMMENT '未处理、处理中、已结案',
  `告警触发阈值` varchar(100) DEFAULT NULL COMMENT '允许空',
  `创建时间` datetime DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
  `是否误报` tinyint DEFAULT '0' COMMENT '0-真实告警，1-误报',
  `误报审核人` varchar(20) DEFAULT NULL COMMENT '误报审核人员ID',
  `误报审核时间` datetime DEFAULT NULL COMMENT '误报审核时间',
  `误报原因` varchar(200) DEFAULT NULL COMMENT '误报原因说明',
  `自动派单状态` tinyint DEFAULT '0' COMMENT '0-未派单，1-已派单，2-派单失败',
  `派单尝试次数` int DEFAULT '0' COMMENT '自动派单尝试次数',
  `最后派单时间` datetime DEFAULT NULL COMMENT '最后尝试派单时间',
  PRIMARY KEY (`告警编号`),
  KEY `idx_关联设备编号` (`关联设备编号`),
  KEY `idx_告警等级` (`告警等级`),
  KEY `idx_处理状态` (`处理状态`),
  KEY `idx_发生时间` (`发生时间`),
  KEY `idx_是否误报` (`是否误报`),
  KEY `idx_自动派单状态` (`自动派单状态`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci COMMENT='告警信息表';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `告警信息表`
--

LOCK TABLES `告警信息表` WRITE;
/*!40000 ALTER TABLE `告警信息表` DISABLE KEYS */;
INSERT INTO `告警信息表` VALUES ('ALM100','越限告警','UNKNOWN-DEVICE','2026-01-04 07:30:00','中','变压器绕组温度偏高','未处理','绕组温度阈值:85℃','2026-01-04 07:30:00',0,NULL,NULL,NULL,0,0,NULL),('ALM101','设备故障','INV-102','2026-01-04 07:00:00','高','光伏逆变器故障 【告警已超15分钟未自动派单，请手动处理！】','未处理','发电量阈值:>0','2026-01-04 07:00:00',0,NULL,NULL,NULL,0,0,NULL),('ALM102','越限告警','UNKNOWN-DEVICE','2026-01-04 06:45:00','低','回路电压接近上限','未处理','电压阈值:≤37kV','2026-01-04 06:45:00',0,NULL,NULL,NULL,0,0,NULL),('ALM103','设备故障','NH103','2026-01-04 06:00:00','中','水表通讯故障','已结案','通讯状态:正常','2026-01-04 06:00:00',0,NULL,NULL,NULL,0,0,NULL),('ALM104','通讯故障','COMB-101','2026-01-04 05:45:00','低','汇流箱通讯中断','处理中','通讯状态:正常','2026-01-04 05:45:00',0,NULL,NULL,NULL,0,0,NULL);
/*!40000 ALTER TABLE `告警信息表` ENABLE KEYS */;
UNLOCK TABLES;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
/*!50003 CREATE*/ /*!50017 DEFINER=`jw`@`%`*/ /*!50003 TRIGGER `trg_告警设备关联验证` BEFORE INSERT ON `告警信息表` FOR EACH ROW BEGIN
    DECLARE v_device_exists INT DEFAULT 0;
    DECLARE v_matched_device VARCHAR(20);
    
    -- 如果关联设备编号为空，尝试从告警内容中提取
    IF NEW.`关联设备编号` IS NULL OR NEW.`关联设备编号` = '' THEN
        -- 从告警内容中提取可能的设备编号
        CASE
            -- 变压器相关
            WHEN NEW.`告警内容` LIKE '%变压器%' THEN
                SET v_matched_device = REGEXP_SUBSTR(NEW.`告警内容`, 'BYQ-?[0-9]+');
                IF v_matched_device IS NULL THEN
                    SET v_matched_device = REGEXP_SUBSTR(NEW.`告警内容`, '变压器[0-9]+');
                    IF v_matched_device IS NOT NULL THEN
                        SET v_matched_device = CONCAT('BYQ-', REGEXP_SUBSTR(v_matched_device, '[0-9]+'));
                    END IF;
                END IF;
                
            -- 光伏设备相关
            WHEN NEW.`告警内容` LIKE '%光伏%' OR NEW.`告警内容` LIKE '%逆变器%' THEN
                SET v_matched_device = REGEXP_SUBSTR(NEW.`告警内容`, 'INV-?[0-9]+');
                IF v_matched_device IS NULL THEN
                    SET v_matched_device = REGEXP_SUBSTR(NEW.`告警内容`, '逆变器[0-9]+');
                    IF v_matched_device IS NOT NULL THEN
                        SET v_matched_device = CONCAT('INV-', REGEXP_SUBSTR(v_matched_device, '[0-9]+'));
                    END IF;
                END IF;
                
            -- 能耗设备相关
            WHEN NEW.`告警内容` LIKE '%水%' OR NEW.`告警内容` LIKE '%蒸汽%' OR NEW.`告警内容` LIKE '%天然气%' THEN
                SET v_matched_device = REGEXP_SUBSTR(NEW.`告警内容`, 'NH-?[0-9]+');
                
            -- 回路相关
            WHEN NEW.`告警内容` LIKE '%回路%' THEN
                SET v_matched_device = REGEXP_SUBSTR(NEW.`告警内容`, 'L[0-9]+');
                IF v_matched_device IS NOT NULL THEN
                    SET v_matched_device = CONCAT('CIRCUIT-', v_matched_device);
                END IF;
        END CASE;
        
        -- 验证提取的设备编号是否存在
        IF v_matched_device IS NOT NULL THEN
            -- 检查光伏设备表
            SELECT COUNT(*) INTO v_device_exists 
            FROM `光伏设备信息表` 
            WHERE `设备编号` = v_matched_device;
            
            IF v_device_exists = 0 THEN
                -- 检查能耗设备表
                SELECT COUNT(*) INTO v_device_exists 
                FROM `能耗计量设备信息表` 
                WHERE `设备编号` = v_matched_device;
            END IF;
            
            IF v_device_exists = 0 THEN
                -- 检查设备台账表
                SELECT COUNT(*) INTO v_device_exists 
                FROM `设备台账数据表` 
                WHERE `台账编号` = v_matched_device;
            END IF;
            
            IF v_device_exists > 0 THEN
                SET NEW.`关联设备编号` = v_matched_device;
            END IF;
        END IF;
        
        -- 如果仍然没有关联设备，设置为默认值
        IF NEW.`关联设备编号` IS NULL OR NEW.`关联设备编号` = '' THEN
            SET NEW.`关联设备编号` = 'SYS-UNKNOWN';
        END IF;
    END IF;
    
    -- 设置创建时间（如果未提供）
    IF NEW.`创建时间` IS NULL THEN
        SET NEW.`创建时间` = NOW();
    END IF;
END */;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
/*!50003 CREATE*/ /*!50017 DEFINER=`jw`@`%`*/ /*!50003 TRIGGER `trg_高等级告警即时派单` AFTER INSERT ON `告警信息表` FOR EACH ROW BEGIN
    DECLARE v_运维人员ID VARCHAR(20);
    DECLARE v_工单编号 VARCHAR(20);
    
    -- 只处理高等级且非误报的告警
    IF NEW.`告警等级` = '高' AND NEW.`是否误报` = 0 AND NEW.`处理状态` = '未处理' THEN
        -- 查找工作量最少的运维人员
        SELECT u.`用户ID` INTO v_运维人员ID
        FROM `用户表` u
        WHERE u.`角色` LIKE '%运维%'
        ORDER BY (
            SELECT COUNT(*) 
            FROM `运维工单数据表` wo 
            WHERE wo.`运维人员ID` = u.`用户ID`
              AND wo.`复查状态` IN ('待复查', '未通过')
        ) ASC
        LIMIT 1;
        
        -- 如果找到运维人员，立即创建工单
        IF v_运维人员ID IS NOT NULL THEN
            -- 生成20字符以内的工单编号：WO-月日时分秒
            SET v_工单编号 = CONCAT('WO-', DATE_FORMAT(NOW(), '%m%d%H%i%s'));
            
            INSERT INTO `运维工单数据表` (
                `工单编号`,
                `告警编号`,
                `运维人员ID`,
                `派单时间`,
                `复查状态`,
                `处理结果`
            ) VALUES (
                v_工单编号,
                NEW.`告警编号`,
                v_运维人员ID,
                NOW(),
                '待复查',
                '高等级告警，系统自动派单，请立即处理。'
            );
            
            -- 更新告警状态
            UPDATE `告警信息表`
            SET `处理状态` = '处理中',
                `自动派单状态` = 1,
                `最后派单时间` = NOW(),
                `派单尝试次数` = `派单尝试次数` + 1
            WHERE `告警编号` = NEW.`告警编号`;
        END IF;
    END IF;
END */;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;

--
-- Table structure for table `告警审核日志表`
--

DROP TABLE IF EXISTS `告警审核日志表`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `告警审核日志表` (
  `日志编号` varchar(30) NOT NULL COMMENT '审核日志唯一标识',
  `告警编号` varchar(20) NOT NULL COMMENT '关联的告警',
  `审核人ID` varchar(20) NOT NULL COMMENT '审核人员ID',
  `审核结果` varchar(10) NOT NULL COMMENT '误报、真实告警',
  `审核原因` varchar(200) NOT NULL COMMENT '审核原因说明',
  `审核备注` varchar(500) DEFAULT NULL COMMENT '审核备注信息',
  `审核时间` datetime DEFAULT CURRENT_TIMESTAMP COMMENT '审核时间',
  PRIMARY KEY (`日志编号`),
  KEY `idx_告警编号` (`告警编号`),
  KEY `idx_审核时间` (`审核时间`),
  KEY `idx_审核结果` (`审核结果`),
  CONSTRAINT `fk_审核日志_告警` FOREIGN KEY (`告警编号`) REFERENCES `告警信息表` (`告警编号`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci COMMENT='告警审核日志表';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `告警审核日志表`
--

LOCK TABLES `告警审核日志表` WRITE;
/*!40000 ALTER TABLE `告警审核日志表` DISABLE KEYS */;
/*!40000 ALTER TABLE `告警审核日志表` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `告警规则配置表`
--

DROP TABLE IF EXISTS `告警规则配置表`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `告警规则配置表` (
  `规则编号` varchar(20) NOT NULL COMMENT '唯一标识规则，如RULE-001',
  `规则名称` varchar(50) NOT NULL COMMENT '规则描述，如"变压器温度告警"',
  `告警类型` varchar(20) NOT NULL COMMENT '越限告警、通讯故障、设备故障',
  `设备类型` varchar(20) NOT NULL COMMENT '变压器、逆变器、水表、回路等',
  `触发字段` varchar(30) NOT NULL COMMENT '如绕组温度、电压kV、运行状态',
  `比较运算符` varchar(10) NOT NULL COMMENT '>、<、=、>=、<=、≠、包含',
  `触发阈值` varchar(100) DEFAULT NULL COMMENT '可以是数值范围、状态值或表达式',
  `告警等级` varchar(10) NOT NULL COMMENT '高、中、低',
  `告警内容模板` varchar(300) NOT NULL COMMENT '告警内容模板，可使用{字段名}占位符',
  `启用状态` tinyint NOT NULL DEFAULT '1' COMMENT '1-启用，0-禁用',
  `创建人` varchar(20) DEFAULT NULL COMMENT '规则创建人',
  `创建时间` datetime DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
  `更新时间` datetime DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '更新时间',
  `设备子类型` varchar(20) DEFAULT NULL COMMENT '更细分的设备类型，如：油浸式变压器、干式变压器',
  `触发条件表达式` varchar(200) DEFAULT NULL COMMENT '更灵活的SQL条件表达式，如：绕组温度 > 95 AND 负载率 > 80',
  `生效时间段` varchar(50) DEFAULT NULL COMMENT '规则生效时间段，如：08:00-18:00 或 全天',
  `告警抑制时长` int DEFAULT '30' COMMENT '单位：分钟，相同告警在此时间内不重复触发',
  `升级规则` varchar(100) DEFAULT NULL COMMENT '如：30分钟后升级为中等级,60分钟后升级为高等级',
  `通知方式` varchar(50) DEFAULT '系统消息' COMMENT '通知方式：系统消息,短信,邮件,APP推送',
  `通知模板` varchar(300) DEFAULT NULL COMMENT '通知内容模板',
  `处理建议` varchar(200) DEFAULT NULL COMMENT '告警处理建议',
  `优先级` int DEFAULT '1' COMMENT '规则优先级，数字越小优先级越高',
  `是否启用` tinyint DEFAULT '1' COMMENT '1-启用，0-禁用',
  `最后触发时间` datetime DEFAULT NULL COMMENT '规则最后触发时间',
  `触发次数` int DEFAULT '0' COMMENT '规则累计触发次数',
  PRIMARY KEY (`规则编号`),
  KEY `idx_设备类型` (`设备类型`),
  KEY `idx_启用状态` (`启用状态`),
  KEY `idx_规则优先级` (`优先级`,`是否启用`),
  KEY `idx_设备子类型` (`设备子类型`),
  KEY `idx_最后触发时间` (`最后触发时间`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci COMMENT='告警规则配置表';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `告警规则配置表`
--

LOCK TABLES `告警规则配置表` WRITE;
/*!40000 ALTER TABLE `告警规则配置表` DISABLE KEYS */;
INSERT INTO `告警规则配置表` VALUES ('RULE-CIRCUIT-001','回路电压越限','越限告警','回路','电压kV','>','37','中','回路{设备编号}电压异常：{实际值}kV（阈值:33-37kV）',1,'admin','2026-01-04 16:37:47','2026-01-04 16:37:47','高压回路','(电压kV > 37 OR 电压kV < 33) AND 开关状态 = \'合闸\'','全天',15,NULL,'系统消息','回路{设备编号}电压异常，请检查。','1. 检查电网电压\n2. 调整变压器分接头\n3. 检查负载平衡',2,1,NULL,0),('RULE-CIRCUIT-002','回路温度过高','越限告警','回路','电缆头温度','>','100','高','回路{设备编号}电缆头温度过高：{实际值}℃',1,'admin','2026-01-04 16:37:47','2026-01-04 16:37:47','所有类型','电缆头温度 > 100','全天',5,NULL,'短信,APP推送','回路{设备编号}电缆头温度过高，存在火灾风险！','1. 立即检查电缆接头\n2. 降低负载\n3. 加强通风',1,1,NULL,0),('RULE-CIRCUIT-003','回路功率因数低','越限告警','回路','功率因数','<','0.85','低','回路{设备编号}功率因数偏低：{实际值}',1,'admin','2026-01-04 16:37:47','2026-01-04 16:37:47','所有类型','功率因数 < 0.85','全天',120,NULL,'系统消息','回路{设备编号}功率因数偏低，建议补偿。','1. 检查无功补偿装置\n2. 调整负载类型\n3. 投入电容器',3,1,NULL,0),('RULE-COMM-001','设备通讯中断','通讯故障','设备','运行状态','=','离线','低','设备{设备编号}通讯中断，离线超过1小时',1,'admin','2026-01-04 16:37:47','2026-01-04 16:37:47','所有类型','运行状态 = \'离线\' AND TIMESTAMPDIFF(HOUR, 最后在线时间, NOW()) > 1','全天',30,'离线超过4小时升级为中等级','系统消息','设备{设备编号}通讯中断，请检查网络连接。','1. 检查网络连接\n2. 重启通讯模块\n3. 检查设备电源',3,1,NULL,0),('RULE-DATA-001','数据采集缺失','通讯故障','数据采集','采集时间','时间差','5分钟','低','数据采集异常：{设备类型}设备{设备编号}超过5分钟无数据',1,'admin','2026-01-04 16:37:47','2026-01-04 16:37:47','所有类型','TIMESTAMPDIFF(MINUTE, 上次采集时间, NOW()) > 5','全天',30,'超过30分钟升级为中等级','系统消息','数据采集中断，请检查采集设备。','1. 检查采集终端\n2. 检查网络连接\n3. 重启采集服务',3,1,NULL,0),('RULE-DEVICE-001','设备运行故障','设备故障','设备','运行状态','=','故障','中','设备{设备编号}运行故障，需要检修',1,'admin','2026-01-04 16:37:47','2026-01-04 16:37:47','所有类型','运行状态 = \'故障\'','全天',10,NULL,'短信,APP推送','设备{设备编号}运行故障，请及时处理。','1. 检查设备状态\n2. 联系维修人员\n3. 准备备件',2,1,NULL,0),('RULE-ENERGY-001','能耗数据质量异常','越限告警','能耗设备','数据质量','IN','中,差','低','能耗设备{设备编号}数据异常：质量{实际值}',1,'admin','2026-01-04 16:37:47','2026-01-04 16:37:47','所有类型','数据质量 IN (\'中\', \'差\')','全天',120,'连续24小时未处理升级为中等级','系统消息','能耗数据采集异常，可能影响计费。','1. 检查通讯线路\n2. 校准计量设备\n3. 联系厂家维护',3,1,NULL,0),('RULE-ENERGY-002','能耗波动异常','越限告警','能耗设备','能耗值','波动','20%','中','能耗设备{设备编号}能耗波动异常：{实际值}{单位}（平均{平均值}{单位}）',1,'admin','2026-01-04 16:37:47','2026-01-04 16:37:47','所有类型','能耗值 > 平均能耗 * 1.2 OR 能耗值 < 平均能耗 * 0.8','全天',60,NULL,'系统消息','能耗数据波动异常，请核实。','1. 检查设备运行状态\n2. 核实生产工艺\n3. 检查计量准确性',2,1,NULL,0),('RULE-PV-001','光伏逆变器效率低','设备故障','逆变器','逆变器效率','<','85','中','光伏逆变器{设备编号}效率偏低：{实际值}%（规则:{规则名称}）',1,'admin','2026-01-04 16:37:47','2026-01-04 16:37:47','组串式逆变器','逆变器效率 < 85 AND 发电量kWh > 0','06:00-18:00',120,'连续3次触发升级为高等级','系统消息','光伏逆变器{设备编号}运行效率偏低，建议检查。','1. 检查光伏板清洁度\n2. 检查接线情况\n3. 检查MPPT状态',2,1,NULL,0),('RULE-PV-002','光伏设备离线','通讯故障','逆变器','运行状态','=','离线','低','光伏设备{设备编号}通讯中断，离线超过1小时',1,'admin','2026-01-04 16:37:47','2026-01-04 16:37:47','所有类型','运行状态 = \'离线\' AND TIMESTAMPDIFF(HOUR, 最后在线时间, NOW()) > 1','全天',30,'离线超过4小时升级为中等级','系统消息','设备{设备编号}通讯中断，请检查网络连接。','1. 检查网络连接\n2. 重启通讯模块\n3. 检查设备电源',3,1,NULL,0),('RULE-PV-003','光伏预测偏差过大','越限告警','光伏预测','偏差率','>','15','中','光伏预测偏差率过大：预测{预测值}kWh，实际{实际值}kWh，偏差率{偏差率}%',1,'admin','2026-01-04 16:37:47','2026-01-04 16:37:47','发电预测','ABS(偏差率) > 15 AND 实际发电量kWh IS NOT NULL','全天',60,NULL,'系统消息','光伏预测偏差过大，建议优化预测模型。','1. 检查气象数据\n2. 校准预测模型\n3. 更新训练数据',2,1,NULL,0),('RULE-TF-001','变压器绕组温度超限','越限告警','变压器','绕组温度','>','95','中','变压器{设备编号}绕组温度{实际值}℃，超过阈值95℃（规则:{规则名称}）',1,'admin','2026-01-04 16:37:47','2026-01-04 16:37:47','油浸式变压器','绕组温度 > 95 AND 运行状态 != \'停机\'','全天',30,'30分钟后升级为中等级,60分钟后升级为高等级','短信,APP推送','【紧急告警】变压器{设备编号}温度异常，当前温度{实际值}℃，请立即处理！','1. 检查冷却系统\n2. 检查负载情况\n3. 联系运维人员',1,1,NULL,0),('RULE-TF-002','变压器超载运行','越限告警','变压器','负载率','>','100','高','变压器{设备编号}超载运行：负载率{实际值}%（规则:{规则名称}）',1,'admin','2026-01-04 16:37:47','2026-01-04 16:37:47','所有类型','负载率 > 100','全天',10,NULL,'短信,APP推送,邮件','【严重告警】变压器{设备编号}已超载，负载率{实际值}%，请立即处理！','1. 立即降低负载\n2. 检查供电回路\n3. 启动应急预案',1,1,NULL,0),('RULE-TF-003','变压器负载率过高','越限告警','变压器','负载率','>','80','中','变压器{设备编号}负载率过高：{实际值}%（规则:{规则名称}）',1,'admin','2026-01-04 16:37:47','2026-01-04 16:37:47','所有类型','负载率 > 80 AND 运行时间 > 30','08:00-18:00',60,NULL,'系统消息','变压器{设备编号}负载率过高，建议检查。','1. 检查负载分配\n2. 考虑增容\n3. 优化用电计划',2,1,NULL,0);
/*!40000 ALTER TABLE `告警规则配置表` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `告警通知记录表`
--

DROP TABLE IF EXISTS `告警通知记录表`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `告警通知记录表` (
  `通知编号` varchar(20) NOT NULL COMMENT '唯一标识通知',
  `告警编号` varchar(20) NOT NULL COMMENT '关联的告警',
  `通知方式` varchar(10) NOT NULL COMMENT '短信、APP推送、邮件、系统消息',
  `通知内容` varchar(500) NOT NULL COMMENT '通知内容',
  `接收人ID` varchar(20) NOT NULL COMMENT '接收人ID',
  `发送状态` varchar(10) NOT NULL COMMENT '待发送、发送中、发送成功、发送失败',
  `发送时间` datetime DEFAULT NULL COMMENT '实际发送时间',
  `创建时间` datetime DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
  `备注` varchar(200) DEFAULT NULL COMMENT '发送失败原因等备注',
  PRIMARY KEY (`通知编号`),
  KEY `idx_告警编号` (`告警编号`),
  KEY `idx_发送状态` (`发送状态`),
  KEY `idx_接收人ID` (`接收人ID`),
  CONSTRAINT `fk_通知_告警` FOREIGN KEY (`告警编号`) REFERENCES `告警信息表` (`告警编号`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci COMMENT='告警通知记录表';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `告警通知记录表`
--

LOCK TABLES `告警通知记录表` WRITE;
/*!40000 ALTER TABLE `告警通知记录表` DISABLE KEYS */;
/*!40000 ALTER TABLE `告警通知记录表` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `回路监测数据表`
--

DROP TABLE IF EXISTS `回路监测数据表`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `回路监测数据表` (
  `数据编号` varchar(20) NOT NULL COMMENT '按回路编号+采集时间戳编码',
  `配电房编号` varchar(15) NOT NULL COMMENT '关联配电房信息表',
  `回路编号` varchar(10) NOT NULL COMMENT '如L1、L2',
  `采集时间` datetime NOT NULL COMMENT '格式：YYYY-MM-DD HH:MM:SS',
  `电压kV` decimal(5,2) NOT NULL COMMENT '35kV回路：34.5-36.7kV；0.4kV回路：0.38-0.42kV',
  `电流A` decimal(8,2) NOT NULL COMMENT '0.4kV回路一般≤630A',
  `有功功率kW` decimal(10,2) NOT NULL COMMENT '0.4kV回路：0-400kW',
  `无功功率kVar` decimal(10,2) NOT NULL COMMENT '与有功功率匹配',
  `功率因数` decimal(4,2) NOT NULL COMMENT '0.85-1.00',
  `正向有功电量kWh` decimal(12,2) NOT NULL COMMENT '累计值',
  `反向有功电量kWh` decimal(12,2) NOT NULL COMMENT '一般≤正向电量的5%',
  `开关状态` varchar(5) NOT NULL COMMENT '分闸、合闸',
  `电缆头温度` decimal(5,1) NOT NULL COMMENT '正常≤90℃，超100℃触发告警',
  `电容器温度` decimal(5,1) NOT NULL COMMENT '正常≤65℃，超75℃触发告警',
  `数据状态` varchar(10) DEFAULT '正常' COMMENT '正常、异常、数据不完整',
  PRIMARY KEY (`数据编号`),
  KEY `idx_配电房编号` (`配电房编号`),
  KEY `idx_采集时间` (`采集时间`),
  KEY `idx_配电房时间` (`配电房编号`,`采集时间`),
  KEY `idx_数据状态` (`数据状态`),
  CONSTRAINT `回路监测数据表_ibfk_1` FOREIGN KEY (`配电房编号`) REFERENCES `配电房信息表` (`配电房编号`) ON DELETE CASCADE,
  CONSTRAINT `回路监测数据表_chk_1` CHECK (((`功率因数` >= 0.85) and (`功率因数` <= 1.00)))
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci COMMENT='回路监测数据表';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `回路监测数据表`
--

LOCK TABLES `回路监测数据表` WRITE;
/*!40000 ALTER TABLE `回路监测数据表` DISABLE KEYS */;
INSERT INTO `回路监测数据表` VALUES ('HL001','PDF026','L4','2025-11-09 01:00:21',10.34,401.20,7044.49,1430.44,0.98,6337.18,198.85,'合闸',52.7,47.5,'正常'),('HL002','PDF019','L5','2025-11-23 15:02:21',33.01,148.49,7979.83,2896.29,0.94,5204.37,83.90,'合闸',51.5,35.7,'正常'),('HL003','PDF017','L5','2025-11-20 11:53:21',36.48,584.97,35477.36,10347.56,0.96,32365.54,1532.29,'合闸',35.8,43.1,'正常'),('HL004','PDF001','L6','2025-12-01 11:17:21',10.28,222.08,3794.72,1106.79,0.96,2843.93,86.60,'合闸',46.2,44.4,'正常'),('HL005','PDF029','L4','2025-12-03 18:10:21',10.66,278.41,4936.03,1439.68,0.96,4156.07,35.89,'分闸',35.1,40.9,'正常'),('HL006','PDF025','L4','2025-11-12 13:58:21',10.34,183.19,2951.95,1429.70,0.90,2576.56,67.11,'分闸',53.8,58.8,'正常'),('HL007','PDF023','L3','2025-11-12 12:15:21',10.00,381.75,5618.15,3481.82,0.85,2923.21,60.01,'分闸',36.9,38.0,'正常'),('HL008','PDF007','L3','2025-11-18 07:34:21',32.70,110.19,6053.09,1517.05,0.97,4676.51,164.68,'分闸',50.9,34.0,'正常'),('HL009','PDF001','L2','2025-11-19 01:05:21',9.85,552.80,9244.50,1877.18,0.98,5771.96,245.97,'分闸',39.5,36.5,'正常'),('HL010','PDF030','L4','2025-11-21 09:15:21',9.94,484.99,7183.73,4262.58,0.86,1884.26,81.50,'分闸',41.0,33.0,'正常'),('HL011','PDF006','L3','2025-11-19 10:53:21',34.95,292.66,15060.21,9333.48,0.85,7439.46,367.82,'分闸',53.5,54.5,'正常'),('HL012','PDF025','L3','2025-11-20 21:38:21',9.85,422.84,6639.21,2828.29,0.92,3730.49,145.56,'分闸',54.2,58.6,'正常'),('HL013','PDF002','L1','2025-11-13 19:11:21',9.75,419.97,6171.20,3497.38,0.87,5296.16,175.67,'分闸',40.6,41.3,'正常'),('HL014','PDF014','L5','2025-11-30 14:50:21',32.66,599.30,29829.34,16100.17,0.88,25750.97,82.15,'合闸',36.5,56.0,'正常'),('HL015','PDF005','L1','2025-11-22 02:33:21',35.51,537.79,30102.74,13715.22,0.91,25289.35,1093.34,'分闸',54.4,30.3,'正常'),('HL016','PDF030','L2','2025-11-12 10:53:21',9.98,294.14,4370.54,2593.33,0.86,2357.69,111.71,'合闸',35.6,51.2,'正常'),('HL017','PDF026','L5','2025-11-19 17:57:21',9.52,150.46,2158.02,1223.00,0.87,1621.74,44.43,'分闸',39.2,53.0,'正常'),('HL018','PDF016','L1','2025-11-05 06:22:21',10.19,415.94,6311.12,3744.80,0.86,5925.29,199.07,'合闸',48.0,31.3,'正常'),('HL019','PDF002','L5','2025-11-26 21:45:21',9.34,430.13,5917.23,3667.17,0.85,2702.46,106.50,'合闸',50.6,47.1,'正常'),('HL020','PDF024','L1','2025-11-14 12:46:21',36.25,378.75,23778.91,0.00,1.00,21718.02,87.24,'分闸',54.3,40.1,'正常'),('HL021','PDF001','L1','2025-11-11 03:55:21',9.43,490.62,7775.92,1948.83,0.97,3534.42,39.12,'合闸',37.8,35.4,'正常'),('HL022','PDF008','L1','2025-11-06 09:40:21',33.23,436.80,22876.99,10423.07,0.91,18740.88,358.64,'合闸',36.6,30.3,'正常'),('HL023','PDF008','L3','2025-11-27 00:14:21',37.15,256.84,16362.48,2331.53,0.99,13755.35,612.09,'分闸',50.4,35.4,'正常'),('HL024','PDF018','L5','2025-11-30 09:03:21',34.26,276.65,14444.41,7796.27,0.88,13715.57,516.85,'合闸',39.2,47.5,'正常'),('HL025','PDF020','L4','2025-11-09 01:35:21',32.99,163.98,8056.79,4780.62,0.86,4867.73,212.52,'合闸',41.6,47.9,'正常'),('HL026','PDF010','L4','2025-11-21 21:46:21',9.63,576.93,9522.51,1356.88,0.99,2788.09,60.57,'分闸',36.9,32.2,'正常'),('HL027','PDF028','L1','2025-11-12 11:15:21',33.49,578.74,29542.63,15945.42,0.88,28559.01,986.58,'分闸',39.4,49.6,'正常'),('HL028','PDF007','L2','2025-11-29 13:30:21',36.95,157.03,9043.78,4380.10,0.90,2790.73,94.79,'合闸',61.3,38.8,'正常'),('HL029','PDF022','L1','2025-11-04 17:25:21',33.26,552.59,31194.50,6334.31,0.98,21948.21,225.45,'分闸',69.8,52.2,'正常'),('HL030','PDF006','L1','2025-12-03 05:22:21',32.14,74.57,4068.68,826.18,0.98,1991.93,75.35,'分闸',52.4,51.6,'正常'),('HL031','PDF001','L3','2025-11-09 23:53:21',9.42,145.85,2189.23,932.61,0.92,827.91,21.29,'分闸',39.7,39.3,'正常'),('HL032','PDF024','L3','2025-11-08 12:17:21',34.35,272.81,14769.54,6729.20,0.91,4131.44,91.41,'分闸',47.5,40.5,'正常'),('HL033','PDF003','L2','2025-11-10 08:30:21',35.20,200.50,12000.00,5000.00,0.92,10000.00,200.00,'合闸',45.0,42.0,'正常'),('HL100','PDF100','L1','2026-01-04 08:00:00',35.50,150.50,5000.25,1200.75,0.95,12500.50,25.75,'合闸',45.5,38.5,'正常'),('HL101','PDF100','L2','2026-01-04 08:05:00',35.20,180.75,5200.80,1100.25,0.96,12800.30,28.90,'合闸',48.2,40.1,'正常'),('HL102','PDF101','L1','2026-01-04 08:10:00',10.25,85.30,850.45,150.75,0.93,2100.80,5.25,'分闸',42.3,35.8,'正常'),('HL103','PDF102','L1','2026-01-04 08:15:00',36.50,200.45,7500.60,1800.90,0.94,18500.75,45.20,'合闸',55.2,42.6,'正常'),('HL104','PDF102','L2','2026-01-04 08:20:00',36.50,175.80,6800.35,1600.45,0.92,16800.40,38.75,'合闸',52.8,41.2,'正常');
/*!40000 ALTER TABLE `回路监测数据表` ENABLE KEYS */;
UNLOCK TABLES;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
/*!50003 CREATE*/ /*!50017 DEFINER=`jw`@`%`*/ /*!50003 TRIGGER `trg_回路监测数据异常检测` AFTER INSERT ON `回路监测数据表` FOR EACH ROW BEGIN
    DECLARE v_电压等级 VARCHAR(10);
    DECLARE v_告警内容 VARCHAR(500);
    DECLARE v_异常类型 VARCHAR(100);
    DECLARE v_告警等级 VARCHAR(10);
    DECLARE v_规则匹配 INT DEFAULT 0;
    
    -- 优先使用规则系统
    SELECT COUNT(*) INTO v_规则匹配 
    FROM `告警规则配置表` 
    WHERE `设备类型` = '回路' 
      AND `是否启用` = 1
      AND TIMESTAMPDIFF(MINUTE, `最后触发时间`, NOW()) >= `告警抑制时长`;
    
    IF v_规则匹配 > 0 THEN
        -- 使用规则系统
        CALL `sp_基于规则生成告警`(
            '回路',
            NEW.`回路编号`,
            '回路监测数据表',
            JSON_OBJECT(
                '电压kV', NEW.`电压kV`,
                '电缆头温度', NEW.`电缆头温度`,
                '电容器温度', NEW.`电容器温度`,
                '功率因数', NEW.`功率因数`,
                '配电房编号', NEW.`配电房编号`
            )
        );
    ELSE
        -- 传统检测逻辑（作为后备）
        SELECT `电压等级` INTO v_电压等级
        FROM `配电房信息表`
        WHERE `配电房编号` = NEW.`配电房编号`;
        
        SET v_异常类型 = '';
        SET v_告警等级 = '低';
        SET v_告警内容 = CONCAT('回路', NEW.`回路编号`, '异常：');
        
        -- 电压越限检测
        IF v_电压等级 LIKE '35kV%' AND (NEW.`电压kV` > 37.0 OR NEW.`电压kV` < 33.0) THEN
            SET v_异常类型 = CONCAT(v_异常类型, '电压越限,');
            SET v_告警等级 = '中';
        ELSEIF (v_电压等级 LIKE '10kV%' OR v_电压等级 LIKE '0.4kV%') 
               AND (NEW.`电压kV` > 0.42 OR NEW.`电压kV` < 0.38) THEN
            SET v_异常类型 = CONCAT(v_异常类型, '电压越限,');
            SET v_告警等级 = '中';
        END IF;
        
        -- 温度检测
        IF NEW.`电缆头温度` > 100 THEN
            SET v_异常类型 = CONCAT(v_异常类型, '电缆头温度过高,');
            SET v_告警等级 = '高';
        END IF;
        
        IF NEW.`电容器温度` > 75 THEN
            SET v_异常类型 = CONCAT(v_异常类型, '电容器温度过高,');
            SET v_告警等级 = '高';
        END IF;
        
        -- 功率因数检测
        IF NEW.`功率因数` < 0.85 THEN
            SET v_异常类型 = CONCAT(v_异常类型, '功率因数偏低,');
        END IF;
        
        -- 如果有异常
        IF LENGTH(v_异常类型) > 0 THEN
            -- 移除最后一个逗号
            SET v_异常类型 = TRIM(TRAILING ',' FROM v_异常类型);
            
            -- 更新数据状态
            UPDATE `回路监测数据表`
            SET `数据状态` = '异常'
            WHERE `数据编号` = NEW.`数据编号`;
            
            -- 生成告警
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
                CONCAT('ALM-C-', DATE_FORMAT(NOW(), '%y%m%d%H%i')),
                '越限告警',
                NEW.`回路编号`,
                NEW.`采集时间`,
                v_告警等级,
                CONCAT(v_告警内容, v_异常类型, '。电压:', NEW.`电压kV`, 'kV, 电缆头:', NEW.`电缆头温度`, '℃'),
                '未处理',
                CONCAT('电压阈值:正常范围, 温度:<100℃/75℃, 功率因数:>0.85')
            );
        END IF;
    END IF;
END */;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;

--
-- Table structure for table `大屏展示配置表`
--

DROP TABLE IF EXISTS `大屏展示配置表`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `大屏展示配置表` (
  `配置编号` varchar(20) NOT NULL COMMENT '唯一标识配置',
  `展示模块` varchar(50) NOT NULL COMMENT '能源总览、光伏总览、配电网运行状态、告警统计',
  `数据刷新频率` varchar(20) NOT NULL COMMENT '秒、分钟',
  `展示字段` varchar(500) DEFAULT NULL COMMENT '允许空，如总能耗/光伏发电量/高等级告警数',
  `排序规则` varchar(50) DEFAULT NULL COMMENT '允许空，按时间降序、按能耗降序',
  `权限等级` varchar(20) NOT NULL COMMENT '管理员、能源管理员、运维人员',
  `创建时间` datetime DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
  `更新时间` datetime DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '更新时间',
  PRIMARY KEY (`配置编号`),
  KEY `idx_权限等级` (`权限等级`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci COMMENT='大屏展示配置表';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `大屏展示配置表`
--

LOCK TABLES `大屏展示配置表` WRITE;
/*!40000 ALTER TABLE `大屏展示配置表` DISABLE KEYS */;
INSERT INTO `大屏展示配置表` VALUES ('DC100','能源总览','分钟','总能耗,总用电量,总用水量,总蒸汽消耗量,总天然气消耗量','按时间降序','管理员','2026-01-01 10:00:00','2026-01-01 10:00:00'),('DC101','光伏总览','秒','光伏总发电量,光伏自用电量,逆变器效率,上网电量','按发电量降序','能源管理员','2026-01-01 10:00:00','2026-01-01 10:00:00'),('DC102','配电网运行状态','分钟','回路状态,变压器负载率,电压电流,功率因数','按异常等级降序','运维人员','2026-01-01 10:00:00','2026-01-01 10:00:00'),('DC103','告警统计','秒','高等级告警数,中等级告警数,低等级告警数,总告警次数','按告警等级降序','管理员','2026-01-01 10:00:00','2026-01-01 10:00:00'),('DC104','峰谷能耗分析','分钟','峰段占比,谷段占比,能耗成本,总能耗','按成本降序','能源管理员','2026-01-01 10:00:00','2026-01-01 10:00:00');
/*!40000 ALTER TABLE `大屏展示配置表` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `实时汇总数据表`
--

DROP TABLE IF EXISTS `实时汇总数据表`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `实时汇总数据表` (
  `汇总编号` varchar(15) NOT NULL COMMENT '如001、002',
  `统计时间` datetime NOT NULL COMMENT '格式：YYYY-MM-DD HH:MM:SS',
  `总用电量kWh` decimal(18,2) DEFAULT NULL COMMENT '允许空',
  `总用水量m3` decimal(18,2) DEFAULT NULL COMMENT '允许空',
  `总蒸汽消耗量t` decimal(18,2) DEFAULT NULL COMMENT '允许空',
  `总天然气消耗量m3` decimal(18,2) DEFAULT NULL COMMENT '允许空',
  `光伏总发电量kWh` decimal(18,2) DEFAULT NULL COMMENT '允许空',
  `光伏自用电量kWh` decimal(18,2) DEFAULT NULL COMMENT '允许空',
  `总告警次数` int DEFAULT NULL COMMENT '允许空',
  `高等级告警数` int DEFAULT NULL COMMENT '允许空',
  `中等级告警数` int DEFAULT NULL COMMENT '允许空',
  `低等级告警数` int DEFAULT NULL COMMENT '允许空',
  PRIMARY KEY (`汇总编号`),
  KEY `idx_统计时间` (`统计时间`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci COMMENT='实时汇总数据表';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `实时汇总数据表`
--

LOCK TABLES `实时汇总数据表` WRITE;
/*!40000 ALTER TABLE `实时汇总数据表` DISABLE KEYS */;
INSERT INTO `实时汇总数据表` VALUES ('SUM100','2026-01-04 08:00:00',25600.50,85.25,35.50,256.80,199.00,75.25,5,1,2,2),('SUM101','2026-01-04 09:00:00',27800.25,98.50,42.75,285.30,225.75,85.50,5,1,2,2),('SUM102','2026-01-04 10:00:00',29500.80,112.80,48.90,310.25,245.20,92.75,5,1,2,2),('SUM103','2026-01-04 11:00:00',31200.45,125.30,52.40,328.50,268.80,102.25,5,1,2,2),('SUM104','2026-01-04 12:00:00',32800.75,138.20,58.75,345.80,285.50,108.50,5,1,2,2);
/*!40000 ALTER TABLE `实时汇总数据表` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `峰谷能耗数据表`
--

DROP TABLE IF EXISTS `峰谷能耗数据表`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `峰谷能耗数据表` (
  `记录编号` varchar(20) NOT NULL COMMENT '唯一标识记录',
  `能源类型` varchar(10) NOT NULL COMMENT '电、水、蒸汽、天然气',
  `厂区编号` varchar(10) NOT NULL COMMENT '关联具体厂区',
  `统计日期` date NOT NULL COMMENT '格式：YYYY-MM-DD',
  `尖峰时段能耗` decimal(12,2) NOT NULL COMMENT '10:00-12:00/16:00-18:00',
  `高峰时段能耗` decimal(12,2) NOT NULL COMMENT '8:00-10:00/12:00-16:00/18:00-22:00',
  `平段能耗` decimal(12,2) NOT NULL COMMENT '6:00-8:00/22:00-24:00',
  `低谷时段能耗` decimal(12,2) NOT NULL COMMENT '00:00-6:00',
  `总能耗` decimal(12,2) NOT NULL COMMENT '各时段能耗之和',
  `峰谷电价` decimal(8,4) NOT NULL COMMENT '单位：元/kWh或元/m³或元/t',
  `能耗成本` decimal(12,2) NOT NULL COMMENT '单位：元',
  PRIMARY KEY (`记录编号`),
  KEY `idx_厂区编号` (`厂区编号`),
  KEY `idx_统计日期` (`统计日期`),
  KEY `idx_厂区日期` (`厂区编号`,`统计日期`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci COMMENT='峰谷能耗数据表';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `峰谷能耗数据表`
--

LOCK TABLES `峰谷能耗数据表` WRITE;
/*!40000 ALTER TABLE `峰谷能耗数据表` DISABLE KEYS */;
INSERT INTO `峰谷能耗数据表` VALUES ('FG100','电','真旺厂','2026-01-03',1500.25,2800.50,1200.75,800.30,6301.80,0.8500,5356.53),('FG101','水','真旺厂','2026-01-03',25.50,45.25,18.75,12.30,101.80,3.5000,356.30),('FG102','电','豆果厂','2026-01-03',1800.75,3200.25,1500.50,950.80,7452.30,0.8500,6334.46),('FG103','蒸汽','A3厂区','2026-01-03',18.25,32.50,15.75,9.80,76.30,200.0000,15260.00),('FG104','天然气','综合办公区','2026-01-03',85.20,120.50,65.30,42.80,313.80,3.2000,1004.16);
/*!40000 ALTER TABLE `峰谷能耗数据表` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `并网点信息表`
--

DROP TABLE IF EXISTS `并网点信息表`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `并网点信息表` (
  `并网点编号` varchar(20) NOT NULL COMMENT '唯一标识并网点，如BGD-001',
  `并网点名称` varchar(50) NOT NULL COMMENT '并网点名称，如主并网点1',
  `位置描述` varchar(100) NOT NULL COMMENT '具体位置描述',
  `并网电压等级` varchar(20) NOT NULL COMMENT '如10kV、35kV',
  `并网容量kW` decimal(10,2) NOT NULL COMMENT '并网容量，单位kW',
  `投运时间` date NOT NULL COMMENT '格式：YYYY-MM-DD',
  `运行状态` varchar(10) NOT NULL DEFAULT '正常' COMMENT '正常、故障、维护',
  `创建时间` datetime DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
  `更新时间` datetime DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '更新时间',
  PRIMARY KEY (`并网点编号`),
  KEY `idx_运行状态_并网点` (`运行状态`),
  CONSTRAINT `并网点信息表_chk_1` CHECK ((`并网容量kW` >= 0))
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci COMMENT='并网点信息表';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `并网点信息表`
--

LOCK TABLES `并网点信息表` WRITE;
/*!40000 ALTER TABLE `并网点信息表` DISABLE KEYS */;
INSERT INTO `并网点信息表` VALUES ('BGD-001','主并网点1','A区配电室','10kV',5000.00,'2023-01-15','正常','2026-01-03 22:11:07','2026-01-03 22:11:07'),('BGD-002','主并网点2','B区配电室','10kV',6000.00,'2023-02-20','正常','2026-01-03 22:11:07','2026-01-03 22:11:07'),('BGD-003','主并网点3','C区配电室','10kV',4500.00,'2023-03-25','故障','2026-01-03 22:11:07','2026-01-03 22:11:07'),('BGD-004','主并网点4','D区配电室','10kV',5500.00,'2023-04-30','正常','2026-01-03 22:11:07','2026-01-03 22:11:07'),('BGD-005','主并网点5','E区配电室','10kV',7000.00,'2023-05-05','维护','2026-01-03 22:11:07','2026-01-03 22:11:07'),('BGD-006','副并网点1','F区配电室','35kV',8000.00,'2023-06-10','正常','2026-01-03 22:11:07','2026-01-03 22:11:07'),('BGD-007','副并网点2','G区配电室','35kV',7500.00,'2023-07-15','正常','2026-01-03 22:11:07','2026-01-03 22:11:07'),('BGD-008','副并网点3','H区配电室','10kV',4800.00,'2023-08-20','故障','2026-01-03 22:11:07','2026-01-03 22:11:07'),('BGD-009','副并网点4','I区配电室','10kV',5200.00,'2023-09-25','正常','2026-01-03 22:11:07','2026-01-03 22:11:07'),('BGD-010','副并网点5','J区配电室','35kV',9000.00,'2023-10-30','正常','2026-01-03 22:11:07','2026-01-03 22:11:07'),('BGD-011','光伏并网点1','M区光伏站','10kV',2500.00,'2024-01-15','正常','2026-01-03 22:11:07','2026-01-03 22:11:07'),('BGD-012','光伏并网点2','N区光伏站','10kV',2800.00,'2024-02-20','正常','2026-01-03 22:11:07','2026-01-03 22:11:07'),('BGD-013','光伏并网点3','O区光伏站','35kV',5000.00,'2024-03-25','正常','2026-01-03 22:11:07','2026-01-03 22:11:07'),('BGD-014','光伏并网点4','P区光伏站','10kV',3200.00,'2024-04-30','维护','2026-01-03 22:11:07','2026-01-03 22:11:07'),('BGD-015','光伏并网点5','Q区光伏站','10kV',3500.00,'2024-05-05','正常','2026-01-03 22:11:07','2026-01-03 22:11:07'),('BGD-016','备用并网点1','K区配电室','10kV',3000.00,'2023-11-05','正常','2026-01-03 22:11:07','2026-01-03 22:11:07'),('BGD-017','备用并网点2','L区配电室','10kV',3500.00,'2023-12-10','维护','2026-01-03 22:11:07','2026-01-03 22:11:07'),('BGD-018','扩建并网点1','R区扩建站','35kV',6500.00,'2024-06-10','正常','2026-01-03 22:11:07','2026-01-03 22:11:07'),('BGD-019','扩建并网点2','S区扩建站','35kV',7200.00,'2024-07-15','维护','2026-01-03 22:11:07','2026-01-03 22:11:07'),('BGD-020','应急并网点1','T区应急站','10kV',1500.00,'2024-08-30','正常','2026-01-03 22:11:07','2026-01-03 22:11:07'),('BGD-021','并网点21','U区厂房','10kV',4200.00,'2024-09-10','正常','2026-01-03 22:11:07','2026-01-03 22:11:07'),('BGD-022','并网点22','V区厂房','10kV',3800.00,'2024-09-15','正常','2026-01-03 22:11:07','2026-01-03 22:11:07'),('BGD-023','并网点23','W区厂房','35kV',5800.00,'2024-10-01','故障','2026-01-03 22:11:07','2026-01-03 22:11:07'),('BGD-024','并网点24','X区厂房','10kV',4600.00,'2024-10-10','正常','2026-01-03 22:11:07','2026-01-03 22:11:07'),('BGD-025','并网点25','Y区厂房','10kV',5100.00,'2024-10-20','正常','2026-01-03 22:11:07','2026-01-03 22:11:07'),('BGD-026','并网点26','Z区厂房','35kV',6700.00,'2024-11-01','正常','2026-01-03 22:11:07','2026-01-03 22:11:07'),('BGD-027','并网点27','AA区厂房','10kV',2900.00,'2024-11-10','维护','2026-01-03 22:11:07','2026-01-03 22:11:07'),('BGD-028','并网点28','BB区厂房','10kV',3300.00,'2024-11-15','正常','2026-01-03 22:11:07','2026-01-03 22:11:07'),('BGD-029','并网点29','CC区厂房','35kV',6100.00,'2024-12-01','正常','2026-01-03 22:11:07','2026-01-03 22:11:07'),('BGD-030','总并网点','总配电中心','35kV',12000.00,'2023-01-01','正常','2026-01-03 22:11:07','2026-01-03 22:11:07'),('BGD100','主并网点1','A区配电室','10kV',5000.00,'2023-01-15','正常','2026-01-01 10:00:00','2026-01-01 10:00:00'),('BGD101','主并网点2','B区配电室','10kV',6000.00,'2023-02-20','正常','2026-01-01 10:00:00','2026-01-01 10:00:00'),('BGD102','光伏并网点1','M区光伏站','10kV',2500.00,'2024-01-15','正常','2026-01-01 10:00:00','2026-01-01 10:00:00'),('BGD103','光伏并网点2','N区光伏站','10kV',2800.00,'2024-02-20','正常','2026-01-01 10:00:00','2026-01-01 10:00:00'),('BGD104','总并网点','总配电中心','35kV',12000.00,'2023-01-01','正常','2026-01-01 10:00:00','2026-01-01 10:00:00');
/*!40000 ALTER TABLE `并网点信息表` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `用户表`
--

DROP TABLE IF EXISTS `用户表`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `用户表` (
  `用户ID` char(3) NOT NULL COMMENT '唯一标识用户，如001、002',
  `姓名` varchar(50) NOT NULL COMMENT '用户真实姓名',
  `密码` varchar(100) NOT NULL COMMENT '哈希后的密码字符串（MD5或SHA-256）',
  `角色` varchar(50) NOT NULL COMMENT '系统管理员/能源管理员/运维人员/数据分析师/企业管理层/运维工单管理员',
  `登录失败次数` int DEFAULT '0' COMMENT '登录失败次数，5次后锁定',
  `账号锁定时间` datetime DEFAULT NULL COMMENT '账号锁定时间',
  `最后登录时间` datetime DEFAULT NULL COMMENT '最后登录时间',
  `创建时间` datetime DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
  PRIMARY KEY (`用户ID`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci COMMENT='用户表';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `用户表`
--

LOCK TABLES `用户表` WRITE;
/*!40000 ALTER TABLE `用户表` DISABLE KEYS */;
INSERT INTO `用户表` VALUES ('001','用户1','8d969eef6ecad3c29a3a629280e686cf0c3f5d5a86aff3ca12020c923adc6c92','能源管理员',0,NULL,'2026-01-05 20:27:00','2026-01-02 14:40:00'),('002','用户2','8d969eef6ecad3c29a3a629280e686cf0c3f5d5a86aff3ca12020c923adc6c92','运维工单管理员',0,NULL,'2026-01-02 14:53:48','2026-01-02 14:40:00'),('003','用户3','8d969eef6ecad3c29a3a629280e686cf0c3f5d5a86aff3ca12020c923adc6c92','数据分析师',0,NULL,NULL,'2026-01-02 14:40:00'),('004','用户4','8d969eef6ecad3c29a3a629280e686cf0c3f5d5a86aff3ca12020c923adc6c92','系统管理员',0,NULL,'2026-01-03 11:43:07','2026-01-02 14:40:00'),('005','用户5','8d969eef6ecad3c29a3a629280e686cf0c3f5d5a86aff3ca12020c923adc6c92','企业管理层',0,NULL,NULL,'2026-01-02 14:40:00'),('006','用户6','8d969eef6ecad3c29a3a629280e686cf0c3f5d5a86aff3ca12020c923adc6c92','运维人员',0,NULL,'2026-01-03 11:19:07','2026-01-02 14:40:00'),('007','用户7','8d969eef6ecad3c29a3a629280e686cf0c3f5d5a86aff3ca12020c923adc6c92','运维工单管理员',0,NULL,NULL,'2026-01-02 14:40:00'),('008','用户8','8d969eef6ecad3c29a3a629280e686cf0c3f5d5a86aff3ca12020c923adc6c92','运维工单管理员',0,NULL,NULL,'2026-01-02 14:40:00'),('009','用户9','8d969eef6ecad3c29a3a629280e686cf0c3f5d5a86aff3ca12020c923adc6c92','运维工单管理员',0,NULL,NULL,'2026-01-02 14:40:00'),('010','用户10','8d969eef6ecad3c29a3a629280e686cf0c3f5d5a86aff3ca12020c923adc6c92','运维工单管理员',0,NULL,NULL,'2026-01-02 14:40:00'),('011','用户11','8d969eef6ecad3c29a3a629280e686cf0c3f5d5a86aff3ca12020c923adc6c92','能源管理员',0,NULL,'2026-01-03 11:50:57','2026-01-02 14:40:00'),('012','用户12','8d969eef6ecad3c29a3a629280e686cf0c3f5d5a86aff3ca12020c923adc6c92','系统管理员',0,NULL,NULL,'2026-01-02 14:40:00'),('013','用户13','8d969eef6ecad3c29a3a629280e686cf0c3f5d5a86aff3ca12020c923adc6c92','数据分析师',0,NULL,NULL,'2026-01-02 14:40:00'),('014','用户14','8d969eef6ecad3c29a3a629280e686cf0c3f5d5a86aff3ca12020c923adc6c92','企业管理层',0,NULL,'2026-01-02 16:11:55','2026-01-02 14:40:00'),('015','用户15','8d969eef6ecad3c29a3a629280e686cf0c3f5d5a86aff3ca12020c923adc6c92','运维人员',0,NULL,'2026-01-05 20:27:21','2026-01-02 14:40:00'),('016','用户16','8d969eef6ecad3c29a3a629280e686cf0c3f5d5a86aff3ca12020c923adc6c92','能源管理员',0,NULL,NULL,'2026-01-02 14:40:00'),('017','用户17','8d969eef6ecad3c29a3a629280e686cf0c3f5d5a86aff3ca12020c923adc6c92','运维人员',0,NULL,NULL,'2026-01-02 14:40:00'),('018','用户18','8d969eef6ecad3c29a3a629280e686cf0c3f5d5a86aff3ca12020c923adc6c92','数据分析师',0,NULL,NULL,'2026-01-02 14:40:00'),('019','用户19','8d969eef6ecad3c29a3a629280e686cf0c3f5d5a86aff3ca12020c923adc6c92','企业管理层',0,NULL,NULL,'2026-01-02 14:40:00'),('020','用户20','8d969eef6ecad3c29a3a629280e686cf0c3f5d5a86aff3ca12020c923adc6c92','系统管理员',0,NULL,'2026-01-05 20:48:07','2026-01-02 14:40:00'),('021','测试用户','8d969eef6ecad3c29a3a629280e686cf0c3f5d5a86aff3ca12020c923adc6c92','能源管理员',0,NULL,'2026-01-03 11:17:17','2026-01-03 10:49:45');
/*!40000 ALTER TABLE `用户表` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `系统日志表`
--

DROP TABLE IF EXISTS `系统日志表`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `系统日志表` (
  `日志编号` varchar(30) NOT NULL COMMENT '日志唯一标识',
  `日志内容` varchar(500) NOT NULL COMMENT '日志详细内容',
  `日志类型` varchar(20) NOT NULL COMMENT '操作日志、错误日志、告警日志等',
  `关联ID` varchar(20) DEFAULT NULL COMMENT '关联的告警编号/工单编号等',
  `操作用户` varchar(20) DEFAULT NULL COMMENT '操作人ID',
  `日志级别` varchar(10) DEFAULT 'INFO' COMMENT 'DEBUG, INFO, WARN, ERROR',
  `创建时间` datetime DEFAULT CURRENT_TIMESTAMP COMMENT '日志创建时间',
  PRIMARY KEY (`日志编号`),
  KEY `idx_日志类型` (`日志类型`),
  KEY `idx_创建时间` (`创建时间`),
  KEY `idx_关联ID` (`关联ID`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci COMMENT='系统操作日志表';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `系统日志表`
--

LOCK TABLES `系统日志表` WRITE;
/*!40000 ALTER TABLE `系统日志表` DISABLE KEYS */;
/*!40000 ALTER TABLE `系统日志表` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `能耗监测数据表`
--

DROP TABLE IF EXISTS `能耗监测数据表`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `能耗监测数据表` (
  `数据编号` varchar(20) NOT NULL COMMENT '唯一标识单条监测数据',
  `设备编号` varchar(20) NOT NULL COMMENT '关联能耗计量设备信息表',
  `采集时间` datetime NOT NULL COMMENT '格式：YYYY-MM-DD HH:MM:SS',
  `能耗值` decimal(10,2) NOT NULL COMMENT '水：m³；蒸汽：t；天然气：m³，≥0',
  `单位` varchar(5) NOT NULL COMMENT 'm³、t',
  `数据质量` varchar(5) NOT NULL COMMENT '优、良、中、差',
  `所属厂区编号` varchar(10) NOT NULL COMMENT '如真旺厂、豆果厂、A3厂区',
  PRIMARY KEY (`数据编号`),
  KEY `idx_设备编号_能耗` (`设备编号`),
  KEY `idx_所属厂区编号` (`所属厂区编号`),
  KEY `idx_采集时间_能耗` (`采集时间`),
  KEY `idx_数据质量` (`数据质量`),
  CONSTRAINT `能耗监测数据表_ibfk_1` FOREIGN KEY (`设备编号`) REFERENCES `能耗计量设备信息表` (`设备编号`) ON DELETE CASCADE,
  CONSTRAINT `能耗监测数据表_chk_1` CHECK ((`能耗值` >= 0))
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci COMMENT='能耗监测数据表';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `能耗监测数据表`
--

LOCK TABLES `能耗监测数据表` WRITE;
/*!40000 ALTER TABLE `能耗监测数据表` DISABLE KEYS */;
INSERT INTO `能耗监测数据表` VALUES ('EM100','NH100','2026-01-04 08:00:00',25.50,'m³','优','真旺厂'),('EM101','NH100','2026-01-04 09:00:00',26.75,'m³','优','真旺厂'),('EM102','NH101','2026-01-04 08:00:00',120.80,'m³','优','真旺厂'),('EM103','NH102','2026-01-04 08:00:00',15.25,'t','优','豆果厂'),('EM104','NH103','2026-01-04 08:00:00',12.50,'m³','优','A3厂区');
/*!40000 ALTER TABLE `能耗监测数据表` ENABLE KEYS */;
UNLOCK TABLES;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
/*!50003 CREATE*/ /*!50017 DEFINER=`jw`@`%`*/ /*!50003 TRIGGER `trg_能耗数据异常告警` AFTER INSERT ON `能耗监测数据表` FOR EACH ROW BEGIN
    DECLARE v_avg_能耗 DECIMAL(12,2);
    DECLARE v_规则匹配 INT DEFAULT 0;
    
    -- 优先使用规则系统
    SELECT COUNT(*) INTO v_规则匹配 
    FROM `告警规则配置表` 
    WHERE `设备类型` IN ('能耗设备', '所有类型') 
      AND `是否启用` = 1
      AND TIMESTAMPDIFF(MINUTE, `最后触发时间`, NOW()) >= `告警抑制时长`;
    
    IF v_规则匹配 > 0 THEN
        -- 使用规则系统
        CALL `sp_基于规则生成告警`(
            '能耗设备',
            NEW.`设备编号`,
            '能耗监测数据表',
            JSON_OBJECT(
                '能耗值', NEW.`能耗值`,
                '数据质量', NEW.`数据质量`,
                '单位', NEW.`单位`,
                '所属厂区编号', NEW.`所属厂区编号`
            )
        );
    ELSE
        -- 默认逻辑：数据质量中/差 或 能耗值波动超20%
        SELECT AVG(`能耗值`) INTO v_avg_能耗 
        FROM (
            SELECT `能耗值` 
            FROM `能耗监测数据表` 
            WHERE `设备编号` = NEW.`设备编号` 
            ORDER BY `采集时间` DESC 
            LIMIT 3
        ) AS t;
        
        IF NEW.`数据质量` IN ('中', '差') 
           OR (v_avg_能耗 > 0 AND (NEW.`能耗值` > v_avg_能耗 * 1.2 OR NEW.`能耗值` < v_avg_能耗 * 0.8)) 
        THEN
            -- 生成告警编号（确保不超过告警编号字段长度）
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
                CONCAT('ALM-NH-', DATE_FORMAT(NOW(), '%y%m%d%H%i')), -- 简化格式
                '越限告警',
                NEW.`设备编号`,
                NOW(),
                '低',
                CONCAT('能耗设备', NEW.`设备编号`, '（', NEW.`所属厂区编号`, '）数据异常：', 
                       NEW.`能耗值`, NEW.`单位`, '，质量:', NEW.`数据质量`),
                '未处理',
                CONCAT('质量阈值:良以上, 波动阈值:±20%')
            );
        END IF;
    END IF;
END */;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;

--
-- Table structure for table `能耗计量设备信息表`
--

DROP TABLE IF EXISTS `能耗计量设备信息表`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `能耗计量设备信息表` (
  `设备编号` varchar(20) NOT NULL COMMENT '唯一标识计量设备',
  `能源类型` varchar(10) NOT NULL COMMENT '水、蒸汽、天然气',
  `安装位置` varchar(50) NOT NULL COMMENT '如VOCS下面、糕饼一厂东北角',
  `管径规格` varchar(10) DEFAULT NULL COMMENT '允许空，如DN25、DN50、DN100',
  `通讯协议` varchar(10) NOT NULL COMMENT 'RS485、Lora',
  `运行状态` varchar(10) NOT NULL COMMENT '正常、故障',
  `校准周期` int NOT NULL COMMENT '单位：月，≥3且≤24',
  `生产厂家` varchar(30) DEFAULT NULL COMMENT '允许空',
  `创建时间` datetime DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
  `更新时间` datetime DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '更新时间',
  PRIMARY KEY (`设备编号`),
  KEY `idx_能源类型` (`能源类型`),
  KEY `idx_运行状态_能耗` (`运行状态`),
  CONSTRAINT `能耗计量设备信息表_chk_1` CHECK (((`校准周期` >= 3) and (`校准周期` <= 24)))
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci COMMENT='能耗计量设备信息表';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `能耗计量设备信息表`
--

LOCK TABLES `能耗计量设备信息表` WRITE;
/*!40000 ALTER TABLE `能耗计量设备信息表` DISABLE KEYS */;
INSERT INTO `能耗计量设备信息表` VALUES ('NH001','水','豆果厂 西北角','DN50','Lora','正常',12,'上仪','2026-01-02 14:03:57','2026-01-02 14:03:57'),('NH002','天然气','综合办公区 中部','DN50','Lora','正常',8,'上仪','2026-01-02 14:03:57','2026-01-02 14:03:57'),('NH003','水','A3厂区 西南角','DN50','RS485','正常',9,'上仪','2026-01-02 14:03:57','2026-01-02 14:03:57'),('NH004','天然气','豆果厂 东北角','DN50','RS485','正常',15,'南自','2026-01-02 14:03:57','2026-01-02 14:03:57'),('NH005','蒸汽','综合办公区 西南角','DN25','RS485','正常',12,'上仪','2026-01-02 14:03:57','2026-01-02 14:03:57'),('NH006','天然气','真旺厂 东南角','DN100','Lora','正常',17,'上仪','2026-01-02 14:03:57','2026-01-02 14:03:57'),('NH007','水','综合办公区 西北角','DN110','Lora','正常',19,'华仪科技','2026-01-02 14:03:57','2026-01-02 14:03:57'),('NH008','水','A3厂区 东北角','DN50','RS485','正常',13,'上仪','2026-01-02 14:03:57','2026-01-02 14:03:57'),('NH009','水','A3厂区 西北角','DN110','RS485','正常',22,'南自','2026-01-02 14:03:57','2026-01-02 14:03:57'),('NH010','蒸汽','A3厂区 中部','DN100','Lora','正常',24,'上仪','2026-01-02 14:03:57','2026-01-02 14:03:57'),('NH011','天然气','豆果厂 西南角','DN100','Lora','正常',13,'南自','2026-01-02 14:03:57','2026-01-02 14:03:57'),('NH012','水','真旺厂 西北角','DN100','RS485','正常',18,'上仪','2026-01-02 14:03:57','2026-01-02 14:03:57'),('NH013','蒸汽','豆果厂 东南角','DN100','RS485','正常',6,'上仪','2026-01-02 14:03:57','2026-01-02 14:03:57'),('NH014','蒸汽','真旺厂 西南角','DN100','Lora','正常',9,'华仪科技','2026-01-02 14:03:57','2026-01-02 14:03:57'),('NH015','水','综合办公区 中部','DN110','RS485','正常',6,'上仪','2026-01-02 14:03:57','2026-01-02 14:03:57'),('NH016','蒸汽','豆果厂 西南角','DN100','RS485','正常',24,'上仪','2026-01-02 14:03:57','2026-01-02 14:03:57'),('NH017','天然气','真旺厂 中部','DN50','Lora','正常',10,'上仪','2026-01-02 14:03:57','2026-01-02 14:03:57'),('NH018','水','真旺厂 东北角','DN50','RS485','正常',11,'南自','2026-01-02 14:03:57','2026-01-02 14:03:57'),('NH019','天然气','A3厂区 东南角','DN100','Lora','正常',14,'华仪科技','2026-01-02 14:03:57','2026-01-02 14:03:57'),('NH020','蒸汽','真旺厂 北部','DN100','RS485','正常',16,'上仪','2026-01-02 14:03:57','2026-01-02 14:03:57'),('NH100','水','真旺厂A区','DN50','RS485','正常',12,'华仪科技','2026-01-01 10:00:00','2026-01-01 10:00:00'),('NH101','天然气','真旺厂B区','DN100','Lora','正常',8,'上仪','2026-01-01 10:00:00','2026-01-01 10:00:00'),('NH102','蒸汽','豆果厂A区','DN80','RS485','正常',10,'南自','2026-01-01 10:00:00','2026-01-01 10:00:00'),('NH103','水','A3厂区C区','DN65','Lora','故障',12,'华仪科技','2026-01-01 10:00:00','2026-01-01 10:00:00'),('NH104','天然气','综合办公区','DN80','RS485','正常',6,'上仪','2026-01-01 10:00:00','2026-01-01 10:00:00');
/*!40000 ALTER TABLE `能耗计量设备信息表` ENABLE KEYS */;
UNLOCK TABLES;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
/*!50003 CREATE*/ /*!50017 DEFINER=`jw`@`%`*/ /*!50003 TRIGGER `trg_能耗设备台账同步` AFTER INSERT ON `能耗计量设备信息表` FOR EACH ROW BEGIN
    -- 检查设备是否已存在于台账
    IF NOT EXISTS (
        SELECT 1 FROM `设备台账数据表`
        WHERE `台账编号` = NEW.`设备编号`
    ) THEN
        -- 插入新设备到台账
        INSERT INTO `设备台账数据表` (
            `台账编号`,
            `设备名称`,
            `设备类型`,
            `型号规格`,
            `安装时间`,
            `质保期_年`,
            `校准记录`,
            `报废状态`,
            `创建时间`,
            `更新时间`
        ) VALUES (
            NEW.`设备编号`,
            CONCAT(NEW.`能源类型`, '计量设备-', NEW.`设备编号`),
            NEW.`能源类型`,
            CONCAT('管径:', NEW.`管径规格`, ', 协议:', NEW.`通讯协议`),
            CURDATE(), -- 使用当前日期作为安装时间
            CEILING(NEW.`校准周期` / 12.0), -- 将月转换为年（向上取整）
            CONCAT(DATE_FORMAT(CURDATE(), '%Y-%m-%d'), '-安装'),
            '正常使用',
            NOW(),
            NOW()
        );
    END IF;
END */;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;

--
-- Table structure for table `设备台账数据表`
--

DROP TABLE IF EXISTS `设备台账数据表`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `设备台账数据表` (
  `台账编号` varchar(20) NOT NULL COMMENT '唯一标识台账',
  `设备名称` varchar(50) NOT NULL COMMENT '设备名称',
  `设备类型` varchar(20) NOT NULL COMMENT '变压器、水表、逆变器、汇流箱',
  `型号规格` varchar(50) DEFAULT NULL COMMENT '允许空',
  `安装时间` datetime NOT NULL COMMENT '格式：YYYY-MM-DD HH:MM:SS',
  `质保期_年` int DEFAULT NULL COMMENT '单位：年，质保期到期前30天触发提醒',
  `维修记录` varchar(20) DEFAULT NULL COMMENT '允许空，关联工单编号',
  `校准记录` varchar(50) DEFAULT NULL COMMENT '允许空，格式：校准时间-校准人员（如2025-01-01-张三）',
  `报废状态` varchar(10) DEFAULT '正常使用' COMMENT '正常使用、已报废',
  `创建时间` datetime DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
  `更新时间` datetime DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '更新时间',
  PRIMARY KEY (`台账编号`),
  KEY `idx_设备类型` (`设备类型`),
  KEY `idx_报废状态` (`报废状态`),
  CONSTRAINT `设备台账数据表_chk_1` CHECK (((`质保期_年` is null) or (`质保期_年` >= 0)))
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci COMMENT='设备台账数据表';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `设备台账数据表`
--

LOCK TABLES `设备台账数据表` WRITE;
/*!40000 ALTER TABLE `设备台账数据表` DISABLE KEYS */;
INSERT INTO `设备台账数据表` VALUES ('TEST-WARRANTY-001','测试设备-即将到期','变压器','TEST-MODEL','2025-01-04 00:00:00',1,NULL,'2026-01-01/测试','正常使用','2026-01-04 20:56:05','2026-01-04 20:56:05'),('TZ100','35kV变压器A','变压器','S11-M-2000/35','2023-01-15 10:00:00',10,'WO103','2024-12-20/张三','正常使用','2026-01-01 10:00:00','2026-01-04 15:33:50'),('TZ101','光伏逆变器A','逆变器','SG100KTL-M','2024-01-20 09:00:00',5,'WO100','2024-12-25/李四','正常使用','2026-01-01 10:00:00','2026-01-04 15:33:50'),('TZ102','智能水表A','水表','LXS-50E','2023-03-15 14:00:00',3,'WO101','2024-09-10/王五','正常使用','2026-01-01 10:00:00','2026-01-04 15:33:50'),('TZ103','天然气流量计A','天然气表','TDS-100H','2023-05-20 11:00:00',5,NULL,'2024-10-15/赵六','正常使用','2026-01-01 10:00:00','2026-01-01 10:00:00'),('TZ104','蒸汽流量计A','蒸汽表','LUGB-100','2023-07-10 13:00:00',4,NULL,'2024-11-20/孙七','正常使用','2026-01-01 10:00:00','2026-01-01 10:00:00');
/*!40000 ALTER TABLE `设备台账数据表` ENABLE KEYS */;
UNLOCK TABLES;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
/*!50003 CREATE*/ /*!50017 DEFINER=`jw`@`%`*/ /*!50003 TRIGGER `trg_质保到期提醒` AFTER INSERT ON `设备台账数据表` FOR EACH ROW BEGIN
    DECLARE v_warranty_end_date DATE;
    DECLARE v_days_remaining INT;
    
    -- 检查设备是否已报废且有质保期
    IF NEW.`报废状态` != '已报废' AND NEW.`质保期_年` IS NOT NULL THEN
        -- 计算质保到期日
        SET v_warranty_end_date = DATE_ADD(DATE(NEW.`安装时间`), INTERVAL NEW.`质保期_年` YEAR);
        SET v_days_remaining = DATEDIFF(v_warranty_end_date, CURDATE());
        
        -- 如果质保期在30天内到期，生成提醒告警
        IF v_days_remaining BETWEEN 1 AND 30 THEN
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
            ) VALUES (
                CONCAT('ALM-W-', NEW.`台账编号`),
                '设备故障',
                NEW.`台账编号`,
                NOW(),
                CASE 
                    WHEN v_days_remaining <= 7 THEN '高'
                    WHEN v_days_remaining <= 15 THEN '中'
                    ELSE '低'
                END,
                CONCAT('设备"', NEW.`设备名称`, '"质保期将于', 
                       DATE_FORMAT(v_warranty_end_date, '%Y-%m-%d'), 
                       '到期，剩余', v_days_remaining, '天'),
                '未处理',
                CONCAT('到期日:', DATE_FORMAT(v_warranty_end_date, '%Y-%m-%d')),
                NOW()
            );
        END IF;
    END IF;
END */;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;

--
-- Table structure for table `运维工单数据表`
--

DROP TABLE IF EXISTS `运维工单数据表`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `运维工单数据表` (
  `工单编号` varchar(20) NOT NULL COMMENT '唯一标识工单',
  `告警编号` varchar(20) NOT NULL COMMENT '关联告警信息表，一对一关系',
  `运维人员ID` varchar(20) NOT NULL COMMENT '关联人员管理系统ID',
  `派单时间` datetime NOT NULL COMMENT '格式：YYYY-MM-DD HH:MM:SS',
  `响应时间` datetime DEFAULT NULL COMMENT '允许空',
  `处理完成时间` datetime DEFAULT NULL COMMENT '允许空',
  `处理结果` varchar(500) DEFAULT NULL COMMENT '允许空，如更换电缆头温度传感器',
  `复查状态` varchar(10) DEFAULT NULL COMMENT '通过、未通过',
  `附件路径` varchar(200) DEFAULT NULL COMMENT '允许空，如故障现场照片路径',
  PRIMARY KEY (`工单编号`),
  UNIQUE KEY `告警编号` (`告警编号`),
  KEY `idx_告警编号` (`告警编号`),
  KEY `idx_运维人员ID` (`运维人员ID`),
  CONSTRAINT `运维工单数据表_ibfk_1` FOREIGN KEY (`告警编号`) REFERENCES `告警信息表` (`告警编号`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci COMMENT='运维工单数据表';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `运维工单数据表`
--

LOCK TABLES `运维工单数据表` WRITE;
/*!40000 ALTER TABLE `运维工单数据表` DISABLE KEYS */;
INSERT INTO `运维工单数据表` VALUES ('WO100','ALM101','USR102','2026-01-04 07:05:00','2026-01-04 07:30:00','2026-01-04 09:00:00','更换逆变器主板，恢复发电','通过','/attachments/wo100_1.jpg'),('WO101','ALM103','USR102','2026-01-04 06:05:00','2026-01-04 06:30:00','2026-01-04 07:45:00','修复通讯线路，恢复数据采集','通过','/attachments/wo101_1.jpg'),('WO102','ALM104','USR102','2026-01-04 05:50:00','2026-01-04 06:15:00','2026-01-04 08:00:00','更换通讯模块，恢复通讯','通过','/attachments/wo102_1.jpg'),('WO103','ALM100','USR102','2026-01-04 07:35:00','2026-01-04 08:00:00','2026-01-04 09:30:00','检查变压器，温度恢复正常','通过','/attachments/wo103_1.jpg'),('WO104','ALM102','USR102','2026-01-04 06:50:00','2026-01-04 07:15:00','2026-01-04 08:45:00','调整电压设置，恢复正常','通过','/attachments/wo104_1.jpg');
/*!40000 ALTER TABLE `运维工单数据表` ENABLE KEYS */;
UNLOCK TABLES;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
/*!50003 CREATE*/ /*!50017 DEFINER=`jw`@`%`*/ /*!50003 TRIGGER `trg_防止重复工单` BEFORE INSERT ON `运维工单数据表` FOR EACH ROW BEGIN
    DECLARE v_existing_count INT;
    
    -- 检查是否已存在处理中的相同告警工单
    SELECT COUNT(*) INTO v_existing_count
    FROM `运维工单数据表` wo
    WHERE wo.`告警编号` = NEW.`告警编号`
      AND wo.`复查状态` IN ('待复查', '未通过');
    
    IF v_existing_count > 0 THEN
        SIGNAL SQLSTATE '45000'
        SET MESSAGE_TEXT = '该告警已有处理中的工单，不能重复创建';
    END IF;
END */;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
/*!50003 CREATE*/ /*!50017 DEFINER=`jw`@`%`*/ /*!50003 TRIGGER `trg_工单结案更新告警状态` AFTER UPDATE ON `运维工单数据表` FOR EACH ROW BEGIN
    -- 当工单复查通过时，更新对应告警状态
    IF OLD.`复查状态` != '通过' AND NEW.`复查状态` = '通过' THEN
        UPDATE `告警信息表`
        SET `处理状态` = '已结案'
        WHERE `告警编号` = NEW.`告警编号`;
    END IF;
END */;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
/*!50003 CREATE*/ /*!50017 DEFINER=`jw`@`%`*/ /*!50003 TRIGGER `trg_工单完成更新设备台账` AFTER UPDATE ON `运维工单数据表` FOR EACH ROW BEGIN
    -- 当工单复查通过时，更新设备台账
    IF NEW.`复查状态` = '通过' AND OLD.`复查状态` != '通过' THEN
        -- 更新设备台账的维修记录
        UPDATE `设备台账数据表`
        SET `维修记录` = CONCAT(COALESCE(`维修记录`, ''), ';', NEW.`工单编号`),
            `更新时间` = NOW()
        WHERE `台账编号` IN (
            SELECT `关联设备编号` 
            FROM `告警信息表` 
            WHERE `告警编号` = NEW.`告警编号`
        );
        
        -- 如果告警是设备故障类型，更新设备运行状态
        UPDATE `光伏设备信息表` pv
        JOIN `告警信息表` a ON pv.`设备编号` = a.`关联设备编号`
        SET pv.`运行状态` = '正常',
            pv.`更新时间` = NOW()
        WHERE a.`告警编号` = NEW.`告警编号`
          AND a.`告警类型` = '设备故障';
          
        UPDATE `能耗计量设备信息表` em
        JOIN `告警信息表` a ON em.`设备编号` = a.`关联设备编号`
        SET em.`运行状态` = '正常',
            em.`更新时间` = NOW()
        WHERE a.`告警编号` = NEW.`告警编号`
          AND a.`告警类型` = '设备故障';
    END IF;
END */;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;

--
-- Table structure for table `配电房信息表`
--

DROP TABLE IF EXISTS `配电房信息表`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `配电房信息表` (
  `配电房编号` varchar(15) NOT NULL COMMENT '唯一标识配电房，如PD-35kV-001',
  `名称` varchar(20) NOT NULL COMMENT '配电房名称，如总配电房、分配电房1',
  `位置描述` varchar(50) NOT NULL COMMENT '具体地址+区域，如XX园区A栋地下1层',
  `电压等级` varchar(10) NOT NULL COMMENT '符合国标，如35kV/0.4kV、10kV/0.4kV',
  `变压器数量` tinyint NOT NULL COMMENT '一般1-5台',
  `投运时间` date NOT NULL COMMENT '格式：YYYY-MM-DD',
  `负责人ID` varchar(20) NOT NULL COMMENT '关联人员管理系统ID',
  `联系方式` varchar(20) NOT NULL COMMENT '手机号（11位）或固定电话',
  `创建时间` datetime DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
  `更新时间` datetime DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '更新时间',
  PRIMARY KEY (`配电房编号`),
  KEY `idx_负责人ID` (`负责人ID`),
  CONSTRAINT `配电房信息表_chk_1` CHECK ((`变压器数量` >= 1))
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci COMMENT='配电房信息表';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `配电房信息表`
--

LOCK TABLES `配电房信息表` WRITE;
/*!40000 ALTER TABLE `配电房信息表` DISABLE KEYS */;
INSERT INTO `配电房信息表` VALUES ('PDF001','配电房1','真旺厂 一期生产车间 主配电房','null',4,'2025-09-23','FZR001','13814668135','2026-01-02 12:16:32','2026-01-04 14:22:04'),('PDF002','配电房2','真旺厂 二期生产车间 北侧配电室','10kV/0.4kV',5,'2025-09-13','FZR002','13875370459','2026-01-02 12:16:32','2026-01-02 12:16:32'),('PDF003','配电房3','真旺厂 原料预处理区 东侧变电间','35kV/0.4kV',1,'2025-11-20','FZR003','13826349502','2026-01-02 12:16:32','2026-01-02 12:16:32'),('PDF004','配电房4','真旺厂 成品仓库 西侧低压配电房','10kV/0.4kV',4,'2025-11-14','FZR004','13828372676','2026-01-02 12:16:32','2026-01-02 12:16:32'),('PDF005','配电房5','真旺厂 锅炉房 专用配电室','35kV/0.4kV',2,'2025-10-15','FZR005','13885717229','2026-01-02 12:16:33','2026-01-02 12:16:33'),('PDF006','配电房6','豆果厂 包装车间 地下1层配电室','35kV/0.4kV',1,'2025-10-06','FZR006','13833867805','2026-01-02 12:16:33','2026-01-02 12:16:33'),('PDF007','配电房7','豆果厂 原料库 中央配电站','35kV/0.4kV',5,'2025-09-13','FZR007','13862739951','2026-01-02 12:16:33','2026-01-02 12:16:33'),('PDF008','配电房8','豆果厂 动力中心 10kV配电间','35kV/0.4kV',1,'2025-10-27','FZR008','13851398304','2026-01-02 12:16:33','2026-01-02 12:16:33'),('PDF009','配电房9','豆果厂 生活区 A栋地下配电房','35kV/0.4kV',1,'2025-09-23','FZR009','13867524435','2026-01-02 12:16:33','2026-01-02 12:16:33'),('PDF010','配电房10','豆果厂 二期扩建区 变电所','10kV/0.4kV',5,'2025-10-03','FZR010','13897183659','2026-01-02 12:16:33','2026-01-02 12:16:33'),('PDF011','配电房11','A3厂区 北区 仓储一号配电房','10kV/0.4kV',2,'2025-11-04','FZR011','13832942058','2026-01-02 12:16:33','2026-01-02 12:16:33'),('PDF012','配电房12','A3厂区 北区 仓储二号配电房','10kV/0.4kV',1,'2025-12-01','FZR012','13888236955','2026-01-02 12:16:33','2026-01-02 12:16:33'),('PDF013','配电房13','A3厂区 南区 厂房A东侧变电间','10kV/0.4kV',4,'2025-11-08','FZR013','13835812250','2026-01-02 12:16:33','2026-01-02 12:16:33'),('PDF014','配电房14','A3厂区 南区 厂房B西侧配电室','35kV/0.4kV',5,'2025-10-04','FZR014','13847757664','2026-01-02 12:16:33','2026-01-02 12:16:33'),('PDF015','配电房15','A3厂区 原料处理区 主变电站','10kV/0.4kV',3,'2025-10-02','FZR015','13826979562','2026-01-02 12:16:33','2026-01-02 12:16:33'),('PDF016','配电房16','A3厂区 包装成品区 地下配电房','10kV/0.4kV',4,'2025-11-10','FZR016','13841145596','2026-01-02 12:16:33','2026-01-02 12:16:33'),('PDF017','配电房17','A3厂区 风机房 专用配电室','35kV/0.4kV',2,'2025-11-01','FZR017','13876632948','2026-01-02 12:16:33','2026-01-02 12:16:33'),('PDF018','配电房18','A3厂区 水泵房 控制配电间','35kV/0.4kV',4,'2025-11-24','FZR018','13830950096','2026-01-02 12:16:33','2026-01-02 12:16:33'),('PDF019','配电房19','A3厂区 消防泵房 低压配电间','35kV/0.4kV',3,'2025-10-20','FZR019','13882733433','2026-01-02 12:16:33','2026-01-02 12:16:33'),('PDF020','配电房20','A3厂区 综合仓库 配电站','35kV/0.4kV',3,'2025-11-15','FZR020','13878478792','2026-01-02 12:16:33','2026-01-02 12:16:33'),('PDF021','配电房21','综合办公区 办公楼A 地下1层配电室','35kV/0.4kV',1,'2025-11-23','FZR021','13863248970','2026-01-02 12:16:33','2026-01-02 12:16:33'),('PDF022','配电房22','综合办公区 办公楼B 地下配电间','35kV/0.4kV',2,'2025-10-21','FZR022','13882453783','2026-01-02 12:16:33','2026-01-02 12:16:33'),('PDF023','配电房23','综合办公区 科研中心 靠南侧变电间','10kV/0.4kV',4,'2025-12-03','FZR023','13843536600','2026-01-02 12:16:33','2026-01-02 12:16:33'),('PDF024','配电房24','综合办公区 科研楼 实验区配电室','35kV/0.4kV',2,'2025-11-07','FZR024','13831567670','2026-01-02 12:16:33','2026-01-02 12:16:33'),('PDF025','配电房25','综合办公区 宿舍区1栋 北侧低压室','10kV/0.4kV',1,'2025-10-27','FZR025','13827388208','2026-01-02 12:16:33','2026-01-02 12:16:33'),('PDF026','配电房26','综合办公区 宿舍区2栋 西侧低压室','10kV/0.4kV',1,'2025-10-15','FZR026','13836546296','2026-01-02 12:16:33','2026-01-02 12:16:33'),('PDF027','配电房27','综合办公区 食堂一楼 配电房','10kV/0.4kV',1,'2025-10-10','FZR027','13833076473','2026-01-02 12:16:33','2026-01-02 12:16:33'),('PDF028','配电房28','综合办公区 公共服务楼 变电所','35kV/0.4kV',2,'2025-11-07','FZR028','13898195984','2026-01-02 12:16:33','2026-01-02 12:16:33'),('PDF029','配电房29','综合办公区 健身中心 配电室','10kV/0.4kV',5,'2025-11-27','FZR029','13811608797','2026-01-02 12:16:33','2026-01-02 12:16:33'),('PDF030','配电房30','综合办公区 地下停车场 主配电房','10kV/0.4kV',2,'2025-09-09','FZR030','13831882123','2026-01-02 12:16:34','2026-01-02 12:16:34'),('PDF100','总配电房','园区A栋地下1层','35kV/0.4kV',2,'2023-01-15','USR100','13800138100','2026-01-01 10:00:00','2026-01-01 10:00:00'),('PDF101','分配电房1','园区B栋1层','10kV/0.4kV',1,'2023-03-20','USR101','13800138101','2026-01-01 10:00:00','2026-01-01 10:00:00'),('PDF102','分配电房2','园区C栋2层','35kV/0.4kV',3,'2023-05-25','USR102','13800138102','2026-01-01 10:00:00','2026-01-01 10:00:00'),('PDF103','光伏配电房','屋顶光伏区','10kV/0.4kV',1,'2023-07-30','USR103','13800138103','2026-01-01 10:00:00','2026-01-01 10:00:00'),('PDF104','备用配电房','园区备用区','35kV/0.4kV',2,'2023-09-10','USR104','13800138104','2026-01-01 10:00:00','2026-01-01 10:00:00');
/*!40000 ALTER TABLE `配电房信息表` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Dumping events for database 'smart_energy'
--
/*!50106 SET @save_time_zone= @@TIME_ZONE */ ;
/*!50106 DROP EVENT IF EXISTS `event_每日质保检查` */;
DELIMITER ;;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;;
/*!50003 SET character_set_client  = utf8mb4 */ ;;
/*!50003 SET character_set_results = utf8mb4 */ ;;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;;
/*!50003 SET @saved_time_zone      = @@time_zone */ ;;
/*!50003 SET time_zone             = 'SYSTEM' */ ;;
/*!50106 CREATE*/ /*!50117 DEFINER=`jw`@`%`*/ /*!50106 EVENT `event_每日质保检查` ON SCHEDULE EVERY 1 DAY STARTS '2026-01-05 00:00:00' ON COMPLETION PRESERVE ENABLE DO BEGIN
    DECLARE v_台账编号 VARCHAR(20);
    DECLARE v_设备名称 VARCHAR(50);
    DECLARE v_安装时间 DATETIME;
    DECLARE v_质保期_年 INT;
    DECLARE v_warranty_end_date DATE;
    DECLARE v_days_remaining INT;
    DECLARE done INT DEFAULT FALSE;
    
    -- 游标查找需要提醒的设备
    DECLARE cur_devices CURSOR FOR
        SELECT 
            t.`台账编号`,
            t.`设备名称`,
            t.`安装时间`,
            t.`质保期_年`
        FROM `设备台账数据表` t
        WHERE t.`报废状态` = '正常使用'
          AND t.`质保期_年` IS NOT NULL
          AND DATE_ADD(DATE(t.`安装时间`), INTERVAL t.`质保期_年` YEAR) 
              BETWEEN CURDATE() AND DATE_ADD(CURDATE(), INTERVAL 30 DAY);
    
    DECLARE CONTINUE HANDLER FOR NOT FOUND SET done = TRUE;
    
    OPEN cur_devices;
    
    read_loop: LOOP
        FETCH cur_devices INTO v_台账编号, v_设备名称, v_安装时间, v_质保期_年;
        IF done THEN
            LEAVE read_loop;
        END IF;
        
        SET v_warranty_end_date = DATE_ADD(DATE(v_安装时间), INTERVAL v_质保期_年 YEAR);
        SET v_days_remaining = DATEDIFF(v_warranty_end_date, CURDATE());
        
        -- 检查是否已存在今日的告警
        IF NOT EXISTS (
            SELECT 1 FROM `告警信息表` a
            WHERE a.`关联设备编号` = v_台账编号
              AND a.`告警类型` = '设备故障'
              AND a.`告警内容` LIKE CONCAT('%质保期将于', DATE_FORMAT(v_warranty_end_date, '%Y-%m-%d'), '%到期%')
              AND DATE(a.`发生时间`) = CURDATE()
        ) THEN
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
            ) VALUES (
                CONCAT('ALM-WARRANTY-DAILY-', v_台账编号, '-', DATE_FORMAT(NOW(), '%Y%m%d')),
                '设备故障',
                v_台账编号,
                NOW(),
                CASE 
                    WHEN v_days_remaining <= 7 THEN '高'
                    WHEN v_days_remaining <= 15 THEN '中'
                    ELSE '低'
                END,
                CONCAT('设备"', v_设备名称, '"质保期将于', 
                       DATE_FORMAT(v_warranty_end_date, '%Y-%m-%d'), 
                       '到期，剩余', v_days_remaining, '天。请及时联系厂家处理。'),
                '未处理',
                CONCAT('质保到期日:', DATE_FORMAT(v_warranty_end_date, '%Y-%m-%d')),
                NOW()
            );
        END IF;
    END LOOP;
    
    CLOSE cur_devices;
    
    -- 记录执行日志
    INSERT INTO `系统日志表` (`日志内容`, `日志类型`, `创建时间`)
    VALUES ('每日质保检查完成', '定时任务', NOW());
END */ ;;
/*!50003 SET time_zone             = @saved_time_zone */ ;;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;;
/*!50003 SET character_set_client  = @saved_cs_client */ ;;
/*!50003 SET character_set_results = @saved_cs_results */ ;;
/*!50003 SET collation_connection  = @saved_col_connection */ ;;
/*!50106 DROP EVENT IF EXISTS `event_高等级告警自动派单检查` */;;
DELIMITER ;;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;;
/*!50003 SET character_set_client  = utf8mb4 */ ;;
/*!50003 SET character_set_results = utf8mb4 */ ;;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;;
/*!50003 SET @saved_time_zone      = @@time_zone */ ;;
/*!50003 SET time_zone             = 'SYSTEM' */ ;;
/*!50106 CREATE*/ /*!50117 DEFINER=`jw`@`%`*/ /*!50106 EVENT `event_高等级告警自动派单检查` ON SCHEDULE EVERY 1 MINUTE STARTS '2026-01-04 16:22:01' ON COMPLETION NOT PRESERVE ENABLE DO BEGIN
    -- 调用自动派单存储过程
    CALL sp_高等级告警自动派单_优化();
    
    -- 超时提醒
    UPDATE 告警信息表
    SET 告警内容 = CONCAT(告警内容, ' 【已超15分钟自动派单！】')
    WHERE 告警等级 = '高'
      AND 处理状态 = '未处理'
      AND TIMESTAMPDIFF(MINUTE, 发生时间, NOW()) >= 15
      AND 告警内容 NOT LIKE '%自动派单%';
END */ ;;
/*!50003 SET time_zone             = @saved_time_zone */ ;;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;;
/*!50003 SET character_set_client  = @saved_cs_client */ ;;
/*!50003 SET character_set_results = @saved_cs_results */ ;;
/*!50003 SET collation_connection  = @saved_col_connection */ ;;
/*!50106 DROP EVENT IF EXISTS `event_高等级告警自动派单检查_优化版` */;;
DELIMITER ;;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;;
/*!50003 SET character_set_client  = utf8mb4 */ ;;
/*!50003 SET character_set_results = utf8mb4 */ ;;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;;
/*!50003 SET @saved_time_zone      = @@time_zone */ ;;
/*!50003 SET time_zone             = 'SYSTEM' */ ;;
/*!50106 CREATE*/ /*!50117 DEFINER=`jw`@`%`*/ /*!50106 EVENT `event_高等级告警自动派单检查_优化版` ON SCHEDULE EVERY 5 MINUTE STARTS '2026-01-04 20:04:49' ON COMPLETION NOT PRESERVE ENABLE DO BEGIN
    DECLARE done INT DEFAULT FALSE;
    DECLARE v_告警编号 VARCHAR(20);
    DECLARE v_发生时间 DATETIME;
    DECLARE v_告警等级 VARCHAR(20);
    
    DECLARE alarm_cursor CURSOR FOR 
        SELECT a.`告警编号`, a.`发生时间`, a.`告警等级`
        FROM `告警信息表` a
        WHERE a.`告警等级` IN ('高', '中')
          AND a.`处理状态` = '未处理'
          AND a.`是否误报` = 0
          AND a.`自动派单状态` = 0
          AND TIMESTAMPDIFF(MINUTE, a.`发生时间`, NOW()) >= 5  -- 5分钟后自动派单
        ORDER BY 
            CASE a.`告警等级`
                WHEN '高' THEN 1
                WHEN '中' THEN 2
                ELSE 3
            END,
            a.`发生时间` ASC;
    
    DECLARE CONTINUE HANDLER FOR NOT FOUND SET done = TRUE;
    
    OPEN alarm_cursor;
    
    read_loop: LOOP
        FETCH alarm_cursor INTO v_告警编号, v_发生时间, v_告警等级;
        IF done THEN
            LEAVE read_loop;
        END IF;
        
        -- 使用优化的派单逻辑
        CALL `sp_优化运维工单分配`(v_告警编号);
        
    END LOOP;
    
    CLOSE alarm_cursor;
    
    -- 记录执行日志
    INSERT INTO `系统日志表` (`日志内容`, `日志类型`, `创建时间`)
    VALUES ('高等级告警自动派单检查完成', '定时任务', NOW());
END */ ;;
/*!50003 SET time_zone             = @saved_time_zone */ ;;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;;
/*!50003 SET character_set_client  = @saved_cs_client */ ;;
/*!50003 SET character_set_results = @saved_cs_results */ ;;
/*!50003 SET collation_connection  = @saved_col_connection */ ;;
/*!50106 DROP EVENT IF EXISTS `event_高等级告警超时检查` */;;
DELIMITER ;;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;;
/*!50003 SET character_set_client  = utf8mb4 */ ;;
/*!50003 SET character_set_results = utf8mb4 */ ;;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;;
/*!50003 SET @saved_time_zone      = @@time_zone */ ;;
/*!50003 SET time_zone             = 'SYSTEM' */ ;;
/*!50106 CREATE*/ /*!50117 DEFINER=`jw`@`%`*/ /*!50106 EVENT `event_高等级告警超时检查` ON SCHEDULE EVERY 1 MINUTE STARTS '2026-01-04 22:08:42' ON COMPLETION NOT PRESERVE ENABLE DO BEGIN
    -- 标记超时告警内容
    UPDATE `告警信息表`
    SET `告警内容` = CONCAT(`告警内容`, ' 【告警已超15分钟未自动派单，请手动处理！】')
    WHERE `告警等级` = '高'
      AND `处理状态` = '未处理'
      AND `是否误报` = 0
      AND `自动派单状态` = 0
      AND TIMESTAMPDIFF(MINUTE, `发生时间`, NOW()) > 15
      AND `告警内容` NOT LIKE '%【告警已超15分钟未自动派单%';
    
    -- 生成超时通知
    INSERT INTO `告警通知记录表` (
        `通知编号`, `告警编号`, `通知方式`, `通知内容`, `接收人ID`, `发送状态`, `发送时间`
    )
    SELECT 
        CONCAT('NOTIFY-', DATE_FORMAT(NOW(), '%Y%m%d%H%i%s'), '-', SUBSTRING(MD5(RAND()), 1, 6)),
        a.`告警编号`, '系统消息',
        CONCAT('高等级告警"', LEFT(a.`告警内容`, 50), '..."已超15分钟未自动派单，请及时处理！'),
        'admin', '待发送', NOW()
    FROM `告警信息表` a
    WHERE a.`告警等级` = '高'
      AND a.`处理状态` = '未处理'
      AND a.`是否误报` = 0
      AND TIMESTAMPDIFF(MINUTE, a.`发生时间`, NOW()) > 15
      AND NOT EXISTS (
          SELECT 1 FROM `告警通知记录表` n 
          WHERE n.`告警编号` = a.`告警编号`
            AND n.`通知内容` LIKE '%已超15分钟未自动派单%'
            AND DATE(n.`发送时间`) = CURDATE()
      );
END */ ;;
/*!50003 SET time_zone             = @saved_time_zone */ ;;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;;
/*!50003 SET character_set_client  = @saved_cs_client */ ;;
/*!50003 SET character_set_results = @saved_cs_results */ ;;
/*!50003 SET collation_connection  = @saved_col_connection */ ;;
DELIMITER ;
/*!50106 SET TIME_ZONE= @save_time_zone */ ;

--
-- Dumping routines for database 'smart_energy'
--
/*!50003 DROP PROCEDURE IF EXISTS `sp_优化运维工单分配` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`jw`@`%` PROCEDURE `sp_优化运维工单分配`(IN p_告警编号 VARCHAR(20))
BEGIN
    DECLARE v_设备类型 VARCHAR(20);
    DECLARE v_设备位置 VARCHAR(50);
    DECLARE v_运维人员ID VARCHAR(20);
    DECLARE v_匹配规则 VARCHAR(50);
    DECLARE v_工单编号 VARCHAR(20);
    
    -- 获取告警关联设备信息
    SELECT 
        CASE 
            WHEN a.`关联设备编号` LIKE 'INV%' OR a.`关联设备编号` LIKE 'COMB%' THEN '光伏'
            WHEN a.`关联设备编号` LIKE 'BYQ%' THEN '变压器'
            WHEN a.`关联设备编号` LIKE 'NH%' THEN '能耗'
            ELSE '通用'
        END AS device_type,
        COALESCE(pv.`安装位置`, em.`安装位置`, s.`位置描述`, '未知位置') AS location
    INTO v_设备类型, v_设备位置
    FROM `告警信息表` a
    LEFT JOIN `光伏设备信息表` pv ON a.`关联设备编号` = pv.`设备编号`
    LEFT JOIN `能耗计量设备信息表` em ON a.`关联设备编号` = em.`设备编号`
    LEFT JOIN `配电房信息表` s ON a.`关联设备编号` = s.`配电房编号`
    WHERE a.`告警编号` = p_告警编号;
    
    -- 规则1：按设备类型匹配专业运维人员
    IF v_设备类型 = '光伏' THEN
        SELECT u.`用户ID` INTO v_运维人员ID
        FROM `用户表` u
        WHERE u.`角色` LIKE '%运维%'
          AND EXISTS (
              SELECT 1 FROM `运维工单数据表` wo
              JOIN `告警信息表` a2 ON wo.`告警编号` = a2.`告警编号`
              WHERE wo.`运维人员ID` = u.`用户ID`
                AND (a2.`关联设备编号` LIKE 'INV%' OR a2.`关联设备编号` LIKE 'COMB%')
                AND wo.`复查状态` = '通过'
          )
        ORDER BY (
            SELECT COUNT(*) FROM `运维工单数据表` wo2
            WHERE wo2.`运维人员ID` = u.`用户ID` AND wo2.`复查状态` = '待复查'
        ) ASC LIMIT 1;
        SET v_匹配规则 = '光伏设备专家';
    ELSEIF v_设备类型 = '变压器' THEN
        SELECT u.`用户ID` INTO v_运维人员ID
        FROM `用户表` u
        WHERE u.`角色` LIKE '%运维%'
          AND EXISTS (
              SELECT 1 FROM `运维工单数据表` wo
              JOIN `告警信息表` a2 ON wo.`告警编号` = a2.`告警编号`
              WHERE wo.`运维人员ID` = u.`用户ID`
                AND a2.`关联设备编号` LIKE 'BYQ%'
                AND wo.`复查状态` = '通过'
          )
        ORDER BY (
            SELECT COUNT(*) FROM `运维工单数据表` wo2
            WHERE wo2.`运维人员ID` = u.`用户ID` AND wo2.`复查状态` = '待复查'
        ) ASC LIMIT 1;
        SET v_匹配规则 = '变压器专家';
    END IF;
    
    -- 规则2：无专业人员则随机分配
    IF v_运维人员ID IS NULL THEN
        SELECT u.`用户ID` INTO v_运维人员ID FROM `用户表` 
        WHERE `角色` LIKE '%运维%' ORDER BY RAND() LIMIT 1;
        SET v_匹配规则 = '随机分配';
    END IF;
    
    -- 创建工单并更新告警状态
    IF v_运维人员ID IS NOT NULL THEN
        SET v_工单编号 = CONCAT('WO-OPT-', DATE_FORMAT(NOW(), '%m%d%H%i'));
        INSERT INTO `运维工单数据表` (
            `工单编号`, `告警编号`, `运维人员ID`, `派单时间`, `处理结果`, `复查状态`
        ) VALUES (
            v_工单编号, p_告警编号, v_运维人员ID, NOW(), 
            CONCAT('自动派单 - ', v_匹配规则), '待复查'
        );
        
        UPDATE `告警信息表` SET 
            `处理状态` = '处理中', `自动派单状态` = 1
        WHERE `告警编号` = p_告警编号;
        
        SELECT CONCAT('工单已创建:', v_工单编号, ', 分配给:', v_运维人员ID) AS result;
    ELSE
        SELECT '未找到合适的运维人员' AS result;
    END IF;
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `sp_修复告警设备关联` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`jw`@`%` PROCEDURE `sp_修复告警设备关联`()
BEGIN
    DECLARE done INT DEFAULT FALSE;
    DECLARE v_alarm_id VARCHAR(20);
    DECLARE v_alarm_content VARCHAR(500);
    DECLARE v_current_device VARCHAR(20);
    DECLARE v_new_device VARCHAR(20);
    DECLARE v_device_exists INT;
    
    -- 游标：查询关联设备异常的告警
    DECLARE alarm_cursor CURSOR FOR 
        SELECT 告警编号, 告警内容, 关联设备编号
        FROM 告警信息表
        WHERE 关联设备编号 = 'UNKNOWN-DEVICE' 
           OR 关联设备编号 LIKE 'INVALID%'
           OR 关联设备编号 NOT IN (
               SELECT 设备编号 FROM 光伏设备信息表
               UNION 
               SELECT 设备编号 FROM 能耗计量设备信息表
               UNION
               SELECT 台账编号 FROM 设备台账数据表
           );
           
    DECLARE CONTINUE HANDLER FOR NOT FOUND SET done = TRUE;
    
    OPEN alarm_cursor;
    
    read_loop: LOOP
        FETCH alarm_cursor INTO v_alarm_id, v_alarm_content, v_current_device;
        IF done THEN
            LEAVE read_loop;
        END IF;
        
        -- 从告警内容提取变压器编号（示例规则）
        IF v_alarm_content LIKE '%变压器%' AND v_alarm_content REGEXP '[B|T][Y|Z]Q[0-9]{3}' THEN
            SET v_new_device = REGEXP_SUBSTR(v_alarm_content, '[B|T][Y|Z]Q[0-9]{3}');
            
            -- 验证设备是否存在
            SELECT COUNT(*) INTO v_device_exists 
            FROM 设备台账数据表 
            WHERE 台账编号 = v_new_device;
            
            IF v_device_exists > 0 THEN
                UPDATE 告警信息表
                SET 关联设备编号 = v_new_device
                WHERE 告警编号 = v_alarm_id;
            END IF;
        END IF;
    END LOOP;
    
    CLOSE alarm_cursor;
    SELECT CONCAT('已尝试修复 ', ROW_COUNT(), ' 条告警的设备关联') AS result;
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `sp_基于规则生成告警` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`jw`@`%` PROCEDURE `sp_基于规则生成告警`(
    IN p_设备类型 VARCHAR(20),
    IN p_设备编号 VARCHAR(20),
    IN p_数据表名 VARCHAR(50),
    IN p_数据记录 JSON
)
BEGIN
    DECLARE done INT DEFAULT FALSE;
    DECLARE v_规则编号 VARCHAR(20);
    DECLARE v_规则名称 VARCHAR(50);
    DECLARE v_触发条件 VARCHAR(200);
    DECLARE v_告警内容模板 VARCHAR(300);
    DECLARE v_告警等级 VARCHAR(10);
    DECLARE v_告警类型 VARCHAR(20);
    DECLARE v_最后触发时间 DATETIME;
    DECLARE v_抑制时长 INT;
    DECLARE v_实际条件 VARCHAR(500);
    DECLARE v_告警内容 VARCHAR(500);
    DECLARE v_check_sql VARCHAR(1000);
    DECLARE v_condition_met INT DEFAULT 0;
    
    DECLARE rule_cursor CURSOR FOR
        SELECT 
            r.`规则编号`, r.`规则名称`, r.`触发条件表达式`,
            r.`告警内容模板`, r.`告警等级`, r.`告警类型`,
            r.`最后触发时间`, r.`告警抑制时长`
        FROM `告警规则配置表` r
        WHERE r.`设备类型` = p_设备类型
          AND r.`是否启用` = 1
          AND (r.`设备子类型` IS NULL OR r.`设备子类型` = '所有类型' 
               OR EXISTS (
                   SELECT 1 FROM `设备台账数据表` d 
                   WHERE d.`台账编号` = p_设备编号 
                     AND d.`设备类型` LIKE CONCAT('%', r.`设备子类型`, '%')
               ))
        ORDER BY r.`优先级`;
    
    DECLARE CONTINUE HANDLER FOR NOT FOUND SET done = TRUE;
    OPEN rule_cursor;
    
    rule_loop: LOOP
        FETCH rule_cursor INTO 
            v_规则编号, v_规则名称, v_触发条件, v_告警内容模板,
            v_告警等级, v_告警类型, v_最后触发时间, v_抑制时长;
        
        IF done THEN LEAVE rule_loop; END IF;
        
        -- 抑制期内跳过
        IF v_最后触发时间 IS NOT NULL AND v_抑制时长 > 0 THEN
            IF TIMESTAMPDIFF(MINUTE, v_最后触发时间, NOW()) < v_抑制时长 THEN
                ITERATE rule_loop;
            END IF;
        END IF;
        
        -- 动态构建条件SQL
        SET v_实际条件 = REPLACE(v_触发条件, '{设备编号}', p_设备编号);
        SET v_check_sql = NULL;
        
        CASE p_数据表名
            WHEN '变压器监测数据表' THEN
                SET v_check_sql = CONCAT(
                    'SELECT COUNT(*) INTO @condition_met FROM `变压器监测数据表` ',
                    'WHERE `变压器编号` = ''', p_设备编号, ''' ',
                    'AND ', v_实际条件, ' AND `采集时间` >= DATE_SUB(NOW(), INTERVAL 5 MINUTE)'
                );
            WHEN '回路监测数据表' THEN
                SET v_check_sql = CONCAT(
                    'SELECT COUNT(*) INTO @condition_met FROM `回路监测数据表` ',
                    'WHERE `回路编号` = ''', p_设备编号, ''' ',
                    'AND ', v_实际条件, ' AND `采集时间` >= DATE_SUB(NOW(), INTERVAL 5 MINUTE)'
                );
            WHEN '光伏发电数据表' THEN
                SET v_check_sql = CONCAT(
                    'SELECT COUNT(*) INTO @condition_met FROM `光伏发电数据表` ',
                    'WHERE `设备编号` = ''', p_设备编号, ''' ',
                    'AND ', v_实际条件, ' AND `采集时间` >= DATE_SUB(NOW(), INTERVAL 5 MINUTE)'
                );
            WHEN '能耗监测数据表' THEN
                SET v_check_sql = CONCAT(
                    'SELECT COUNT(*) INTO @condition_met FROM `能耗监测数据表` ',
                    'WHERE `设备编号` = ''', p_设备编号, ''' ',
                    'AND ', v_实际条件, ' AND `采集时间` >= DATE_SUB(NOW(), INTERVAL 5 MINUTE)'
                );
        END CASE;
        
        -- 执行条件检查
        IF v_check_sql IS NOT NULL THEN
            SET @sql = v_check_sql;
            PREPARE stmt FROM @sql;
            EXECUTE stmt;
            DEALLOCATE PREPARE stmt;
            SET v_condition_met = @condition_met;
        END IF;
        
        -- 条件满足则生成告警
        IF v_condition_met > 0 THEN
            SET v_告警内容 = REPLACE(REPLACE(v_告警内容模板, '{设备编号}', p_设备编号), '{规则名称}', v_规则名称);
            
            INSERT INTO `告警信息表` (
                `告警编号`, `告警类型`, `关联设备编号`, `发生时间`,
                `告警等级`, `告警内容`, `处理状态`, `告警触发阈值`, `创建时间`
            ) VALUES (
                CONCAT('ALM-RULE-', v_规则编号, '-', DATE_FORMAT(NOW(), '%Y%m%d%H%i%s')),
                v_告警类型, p_设备编号, NOW(), v_告警等级, v_告警内容,
                '未处理', CONCAT('规则:', v_规则名称), NOW()
            );
            
            -- 更新规则触发记录
            UPDATE `告警规则配置表` SET 
                `最后触发时间` = NOW(), `触发次数` = `触发次数` + 1
            WHERE `规则编号` = v_规则编号;
        END IF;
        
        SET v_condition_met = 0;
    END LOOP;
    
    CLOSE rule_cursor;
    SELECT CONCAT('规则检查完成，设备:', p_设备编号) AS result;
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `sp_完善误报审核流程` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`jw`@`%` PROCEDURE `sp_完善误报审核流程`(
    IN p_告警编号 VARCHAR(20),
    IN p_审核人ID VARCHAR(20),
    IN p_是否误报 TINYINT,
    IN p_误报原因 VARCHAR(200),
    IN p_审核备注 VARCHAR(500)
)
BEGIN
    DECLARE v_工单编号 VARCHAR(20);
    DECLARE v_告警内容 VARCHAR(500);
    DECLARE v_设备编号 VARCHAR(20);
    DECLARE v_误报标记 INT DEFAULT 0;
    
    START TRANSACTION; -- 开启事务保证数据一致性
    
    -- 获取告警基础信息
    SELECT `告警内容`, `关联设备编号` INTO v_告警内容, v_设备编号
    FROM `告警信息表` WHERE `告警编号` = p_告警编号;
    
    IF v_告警内容 IS NOT NULL THEN
        IF p_是否误报 = 1 THEN
            -- 标记为误报并结案
            UPDATE `告警信息表` SET 
                `是否误报` = 1, `误报审核人` = p_审核人ID, `误报审核时间` = NOW(),
                `误报原因` = p_误报原因, `处理状态` = '已结案', `自动派单状态` = 0,
                `告警内容` = CONCAT(`告警内容`, ' 【误报审核:', p_审核备注, '】')
            WHERE `告警编号` = p_告警编号;
            
            SET v_误报标记 = 1;
            
            -- 联动更新关联工单
            SELECT `工单编号` INTO v_工单编号
            FROM `运维工单数据表`
            WHERE `告警编号` = p_告警编号 AND `复查状态` != '通过';
            
            IF v_工单编号 IS NOT NULL THEN
                UPDATE `运维工单数据表` SET 
                    `处理结果` = CONCAT('告警经审核为误报：', p_误报原因, '。备注：', p_审核备注),
                    `复查状态` = '通过', `处理完成时间` = NOW()
                WHERE `工单编号` = v_工单编号;
                
                -- 记录系统日志
                INSERT INTO `系统日志表` (`日志内容`, `日志类型`, `关联ID`, `创建时间`)
                VALUES (
                    CONCAT('误报审核完成，告警:', p_告警编号, '，工单:', v_工单编号, '已取消'),
                    '误报处理', p_告警编号, NOW()
                );
            END IF;
            
            -- 通讯误报自动恢复设备状态
            IF p_误报原因 LIKE '%通讯%' OR p_误报原因 LIKE '%网络%' THEN
                UPDATE `光伏设备信息表` SET `运行状态` = '正常', `更新时间` = NOW()
                WHERE `设备编号` = v_设备编号 AND `运行状态` != '正常';
                
                UPDATE `能耗计量设备信息表` SET `运行状态` = '正常', `更新时间` = NOW()
                WHERE `设备编号` = v_设备编号 AND `运行状态` != '正常';
            END IF;
            
            SELECT '告警已标记为误报并结案' AS result;
        ELSE
            -- 确认为真实告警
            UPDATE `告警信息表` SET 
                `是否误报` = 0, `误报审核人` = p_审核人ID, `误报审核时间` = NOW(),
                `误报原因` = NULL, `告警内容` = CONCAT(`告警内容`, ' 【确认为真实告警:', p_审核备注, '】')
            WHERE `告警编号` = p_告警编号;
            
            -- 高/中等级未派单告警自动触发派单
            IF EXISTS (
                SELECT 1 FROM `告警信息表`
                WHERE `告警编号` = p_告警编号
                  AND `告警等级` IN ('高', '中')
                  AND `自动派单状态` = 0
            ) THEN
                CALL `sp_优化运维工单分配`(p_告警编号);
            END IF;
            
            SELECT '告警已确认为真实告警' AS result;
        END IF;
        
        -- 记录审核日志
        INSERT INTO `告警审核日志表` (
            `日志编号`, `告警编号`, `审核人ID`, `审核结果`, `审核原因`, `审核备注`, `审核时间`
        ) VALUES (
            CONCAT('AUDIT-', DATE_FORMAT(NOW(), '%Y%m%d%H%i%s')),
            p_告警编号, p_审核人ID,
            IF(p_是否误报 = 1, '误报', '真实告警'),
            p_误报原因, p_审核备注, NOW()
        );
    ELSE
        SELECT '告警不存在' AS result;
    END IF;
    
    COMMIT; -- 提交事务
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `sp_检测设备通讯状态` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`jw`@`%` PROCEDURE `sp_检测设备通讯状态`()
BEGIN
    -- 检测光伏设备离线状态
    INSERT INTO `告警信息表` (
        `告警编号`,
        `告警类型`,
        `关联设备编号`,
        `发生时间`,
        `告警等级`,
        `告警内容`,
        `处理状态`,
        `告警触发阈值`
    )
    SELECT 
        CONCAT('ALM-OFFLINE-', pv.`设备编号`, '-', DATE_FORMAT(NOW(), '%Y%m%d%H%i%s')),
        '通讯故障',
        pv.`设备编号`,
        NOW(),
        CASE 
            WHEN TIMESTAMPDIFF(HOUR, pv.`更新时间`, NOW()) > 24 THEN '高'
            WHEN TIMESTAMPDIFF(HOUR, pv.`更新时间`, NOW()) > 4 THEN '中'
            ELSE '低'
        END,
        CONCAT('光伏设备', pv.`设备编号`, '(', pv.`设备类型`, ')已离线',
               TIMESTAMPDIFF(HOUR, pv.`更新时间`, NOW()), '小时'),
        '未处理',
        '离线时间阈值:>1小时'
    FROM `光伏设备信息表` pv
    WHERE pv.`运行状态` = '离线'
      AND TIMESTAMPDIFF(HOUR, pv.`更新时间`, NOW()) > 1
      AND NOT EXISTS (
          SELECT 1 FROM `告警信息表` a 
          WHERE a.`关联设备编号` = pv.`设备编号`
            AND a.`告警类型` = '通讯故障'
            AND a.`处理状态` IN ('未处理', '处理中')
            AND DATE(a.`发生时间`) = CURDATE()
      );
    
    -- 检测能耗计量设备通讯状态
    INSERT INTO `告警信息表` (
        `告警编号`,
        `告警类型`,
        `关联设备编号`,
        `发生时间`,
        `告警等级`,
        `告警内容`,
        `处理状态`,
        `告警触发阈值`
    )
    SELECT 
        CONCAT('ALM-OFFLINE-', em.`设备编号`, '-', DATE_FORMAT(NOW(), '%Y%m%d%H%i%s')),
        '通讯故障',
        em.`设备编号`,
        NOW(),
        '低',
        CONCAT('能耗设备', em.`设备编号`, '(', em.`能源类型`, ')超过12小时无数据'),
        '未处理',
        '无数据时间阈值:>12小时'
    FROM `能耗计量设备信息表` em
    WHERE em.`运行状态` = '正常'
      AND NOT EXISTS (
          SELECT 1 FROM `能耗监测数据表` emd
          WHERE emd.`设备编号` = em.`设备编号`
            AND emd.`采集时间` >= DATE_SUB(NOW(), INTERVAL 12 HOUR)
      )
      AND NOT EXISTS (
          SELECT 1 FROM `告警信息表` a 
          WHERE a.`关联设备编号` = em.`设备编号`
            AND a.`告警类型` = '通讯故障'
            AND a.`处理状态` IN ('未处理', '处理中')
            AND DATE(a.`发生时间`) = CURDATE()
      );
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `sp_清理过期告警` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`jw`@`%` PROCEDURE `sp_清理过期告警`(IN p_保留天数 INT)
BEGIN
    DELETE wo, alm
    FROM `告警信息表` alm
    LEFT JOIN `运维工单数据表` wo ON alm.`告警编号` = wo.`告警编号`
    WHERE alm.`处理状态` = '已结案'
      AND alm.`发生时间` < DATE_SUB(NOW(), INTERVAL p_保留天数 DAY);
    
    SELECT CONCAT('清理完成，共删除过期告警', ROW_COUNT(), '条') AS 清理结果;
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `sp_生成实时汇总数据` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`jw`@`%` PROCEDURE `sp_生成实时汇总数据`()
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
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `sp_统计未处理告警` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`jw`@`%` PROCEDURE `sp_统计未处理告警`(
    OUT p_变压器告警 INT, 
    OUT p_光伏设备告警 INT, 
    OUT p_能耗设备告警 INT
)
BEGIN
    -- 变压器告警统计
    SELECT COUNT(*) INTO p_变压器告警
    FROM `告警信息表`
    WHERE `处理状态` IN ('未处理', '处理中')
      AND `关联设备编号` IN (SELECT `设备编号` FROM `设备台账数据表` WHERE `设备类型` = '变压器');
    
    -- 光伏设备告警统计
    SELECT COUNT(*) INTO p_光伏设备告警
    FROM `告警信息表`
    WHERE `处理状态` IN ('未处理', '处理中')
      AND `关联设备编号` IN (SELECT `设备编号` FROM `光伏设备信息表`);
    
    -- 能耗设备告警统计
    SELECT COUNT(*) INTO p_能耗设备告警
    FROM `告警信息表`
    WHERE `处理状态` IN ('未处理', '处理中')
      AND `关联设备编号` IN (SELECT `设备编号` FROM `能耗计量设备信息表`);
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `sp_计算峰谷能耗` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`jw`@`%` PROCEDURE `sp_计算峰谷能耗`(
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
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `sp_设备通讯状态检测` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`jw`@`%` PROCEDURE `sp_设备通讯状态检测`()
BEGIN
    -- 光伏设备离线告警
    INSERT INTO `告警信息表` (
        `告警编号`, `告警类型`, `关联设备编号`, `发生时间`,
        `告警等级`, `告警内容`, `处理状态`, `告警触发阈值`
    )
    SELECT 
        CONCAT('ALM-OFFLINE-', pv.`设备编号`, '-', DATE_FORMAT(NOW(), '%Y%m%d%H%i%s')),
        '通讯故障', pv.`设备编号`, NOW(),
        CASE 
            WHEN TIMESTAMPDIFF(HOUR, pv.`更新时间`, NOW()) > 24 THEN '高'
            WHEN TIMESTAMPDIFF(HOUR, pv.`更新时间`, NOW()) > 4 THEN '中'
            ELSE '低'
        END,
        CONCAT('光伏设备', pv.`设备编号`, '(', pv.`设备类型`, ')已离线',
               TIMESTAMPDIFF(HOUR, pv.`更新时间`, NOW()), '小时'),
        '未处理', '离线时间阈值:>1小时'
    FROM `光伏设备信息表` pv
    WHERE pv.`运行状态` = '离线'
      AND TIMESTAMPDIFF(HOUR, pv.`更新时间`, NOW()) > 1
      AND NOT EXISTS (
          SELECT 1 FROM `告警信息表` a 
          WHERE a.`关联设备编号` = pv.`设备编号`
            AND a.`告警类型` = '通讯故障'
            AND a.`处理状态` IN ('未处理', '处理中')
            AND DATE(a.`发生时间`) = CURDATE()
      );
    
    -- 能耗设备离线告警
    INSERT INTO `告警信息表` (
        `告警编号`, `告警类型`, `关联设备编号`, `发生时间`,
        `告警等级`, `告警内容`, `处理状态`, `告警触发阈值`
    )
    SELECT 
        CONCAT('ALM-OFFLINE-', em.`设备编号`, '-', DATE_FORMAT(NOW(), '%Y%m%d%H%i%s')),
        '通讯故障', em.`设备编号`, NOW(), '低',
        CONCAT('能耗设备', em.`设备编号`, '(', em.`能源类型`, ')超过12小时无数据'),
        '未处理', '无数据时间阈值:>12小时'
    FROM `能耗计量设备信息表` em
    WHERE em.`运行状态` = '正常'
      AND NOT EXISTS (
          SELECT 1 FROM `能耗监测数据表` emd
          WHERE emd.`设备编号` = em.`设备编号`
            AND emd.`采集时间` >= DATE_SUB(NOW(), INTERVAL 12 HOUR)
      )
      AND NOT EXISTS (
          SELECT 1 FROM `告警信息表` a 
          WHERE a.`关联设备编号` = em.`设备编号`
            AND a.`告警类型` = '通讯故障'
            AND a.`处理状态` IN ('未处理', '处理中')
            AND DATE(a.`发生时间`) = CURDATE()
      );
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `sp_高等级告警自动派单` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`jw`@`%` PROCEDURE `sp_高等级告警自动派单`(
    IN p_告警编号 VARCHAR(20),
    IN p_运维人员ID VARCHAR(20)
)
BEGIN
    DECLARE v_工单编号 VARCHAR(20);
    DECLARE v_告警等级 VARCHAR(20);
    
    SELECT `告警等级` INTO v_告警等级 FROM `告警信息表` WHERE `告警编号` = p_告警编号;
    
    -- 仅高等级告警执行派单
    IF v_告警等级 = '高' THEN
        SET v_工单编号 = LEFT(CONCAT('WO-H-', DATE_FORMAT(NOW(), '%d%H%i%s')), 20);
        
        INSERT INTO `运维工单数据表` (
            `工单编号`, `告警编号`, `运维人员ID`, `派单时间`, `复查状态`
        ) VALUES (
            v_工单编号, p_告警编号, p_运维人员ID, NOW(), '待复查'
        );
        
        UPDATE `告警信息表` SET `处理状态` = '处理中' WHERE `告警编号` = p_告警编号;
        SELECT CONCAT('工单已创建：', v_工单编号) AS result;
    ELSE
        SELECT '非高等级告警，不支持自动派单' AS result;
    END IF;
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `sp_高等级告警自动派单_V2` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`jw`@`%` PROCEDURE `sp_高等级告警自动派单_V2`()
BEGIN
    DECLARE done INT DEFAULT FALSE;
    DECLARE v_告警编号 VARCHAR(20);
    DECLARE v_发生时间 DATETIME;
    DECLARE v_告警等级 VARCHAR(20);
    DECLARE v_关联设备编号 VARCHAR(20);
    DECLARE v_运维人员ID VARCHAR(20);
    DECLARE v_超时分钟 INT;
    
    DECLARE alarm_cursor CURSOR FOR 
        SELECT a.`告警编号`, a.`发生时间`, a.`告警等级`, a.`关联设备编号`
        FROM `告警信息表` a
        WHERE a.`告警等级` = '高'
          AND a.`处理状态` = '未处理'
          AND a.`是否误报` = 0
          AND a.`自动派单状态` = 0
        ORDER BY a.`发生时间` ASC;
    
    DECLARE CONTINUE HANDLER FOR NOT FOUND SET done = TRUE;
    SET GLOBAL event_scheduler = ON; -- 启用事件调度器
    OPEN alarm_cursor;
    
    read_loop: LOOP
        FETCH alarm_cursor INTO v_告警编号, v_发生时间, v_告警等级, v_关联设备编号;
        IF done THEN LEAVE read_loop; END IF;
        
        SET v_超时分钟 = TIMESTAMPDIFF(MINUTE, v_发生时间, NOW());
        -- 15分钟内未派单的高等级告警执行分配
        IF v_超时分钟 <= 15 THEN
            SELECT `用户ID` INTO v_运维人员ID FROM `用户表` 
            WHERE `角色` LIKE '%运维%' ORDER BY RAND() LIMIT 1;
            
            IF v_运维人员ID IS NOT NULL THEN
                CALL `sp_高等级告警自动派单`(v_告警编号, v_运维人员ID);
                UPDATE `告警信息表` SET 
                    `自动派单状态` = 1, `最后派单时间` = NOW(), `派单尝试次数` = `派单尝试次数` + 1
                WHERE `告警编号` = v_告警编号;
            ELSE
                UPDATE `告警信息表` SET 
                    `自动派单状态` = 2, `最后派单时间` = NOW(), `派单尝试次数` = `派单尝试次数` + 1
                WHERE `告警编号` = v_告警编号;
            END IF;
        END IF;
    END LOOP;
    
    CLOSE alarm_cursor;
    SELECT CONCAT('已处理 ', FOUND_ROWS(), ' 条高等级告警派单检查') AS result;
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `sp_高等级告警自动派单_优化` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`jw`@`%` PROCEDURE `sp_高等级告警自动派单_优化`()
BEGIN
    DECLARE done INT DEFAULT FALSE;
    DECLARE v_告警编号 VARCHAR(20);
    DECLARE v_发生时间 DATETIME;
    DECLARE v_关联设备编号 VARCHAR(20);
    DECLARE v_运维人员ID VARCHAR(20);
    DECLARE v_最近运维人员 VARCHAR(20);
    DECLARE v_工单编号 VARCHAR(20);
    
    DECLARE alarm_cursor CURSOR FOR 
        SELECT a.告警编号, a.发生时间, a.关联设备编号
        FROM 告警信息表 a
        WHERE a.告警等级 = '高'
          AND a.处理状态 = '未处理'
          AND a.是否误报 = 0
          AND a.自动派单状态 = 0
          AND TIMESTAMPDIFF(MINUTE, a.发生时间, NOW()) >= 15
        ORDER BY a.发生时间;
    
    DECLARE CONTINUE HANDLER FOR NOT FOUND SET done = TRUE;
    OPEN alarm_cursor;
    
    alarm_loop: LOOP
        FETCH alarm_cursor INTO v_告警编号, v_发生时间, v_关联设备编号;
        IF done THEN LEAVE alarm_loop; END IF;
        
        SET v_运维人员ID = NULL;
        -- 规则1：按设备类型匹配有经验的运维人员
        IF v_关联设备编号 LIKE 'INV%' OR v_关联设备编号 LIKE 'COMB%' THEN
            SELECT 运维人员ID INTO v_最近运维人员
            FROM (
                SELECT wo.运维人员ID, MAX(wo.处理完成时间) as last_time
                FROM 运维工单数据表 wo
                JOIN 告警信息表 a ON wo.告警编号 = a.告警编号
                WHERE (a.关联设备编号 LIKE 'INV%' OR a.关联设备编号 LIKE 'COMB%')
                  AND wo.复查状态 = '通过'
                GROUP BY wo.运维人员ID
                ORDER BY last_time DESC LIMIT 1
            ) AS recent_workers;
            SET v_运维人员ID = v_最近运维人员;
        ELSEIF v_关联设备编号 LIKE 'BYQ%' THEN
            SELECT 运维人员ID INTO v_最近运维人员
            FROM (
                SELECT wo.运维人员ID, MAX(wo.处理完成时间) as last_time
                FROM 运维工单数据表 wo
                JOIN 告警信息表 a ON wo.告警编号 = a.告警编号
                WHERE a.关联设备编号 LIKE 'BYQ%' AND wo.复查状态 = '通过'
                GROUP BY wo.运维人员ID
                ORDER BY last_time DESC LIMIT 1
            ) AS recent_workers;
            SET v_运维人员ID = v_最近运维人员;
        END IF;
        
        -- 规则2：无匹配人员则随机分配
        IF v_运维人员ID IS NULL THEN
            SELECT `用户ID` INTO v_运维人员ID FROM `用户表` 
            WHERE `角色` LIKE '%运维%' ORDER BY RAND() LIMIT 1;
        END IF;
        
        -- 执行派单
        IF v_运维人员ID IS NOT NULL THEN
            SET v_工单编号 = LEFT(CONCAT('WO-A-', DATE_FORMAT(NOW(), '%d%H%i%s')), 20);
            INSERT INTO 运维工单数据表 (
                工单编号, 告警编号, 运维人员ID, 派单时间, 复查状态
            ) VALUES (v_工单编号, v_告警编号, v_运维人员ID, NOW(), '待复查');
            
            UPDATE 告警信息表 SET 
                处理状态 = '处理中', 自动派单状态 = 1, 
                最后派单时间 = NOW(), 派单尝试次数 = 派单尝试次数 + 1
            WHERE 告警编号 = v_告警编号;
        ELSE
            UPDATE 告警信息表 SET 
                自动派单状态 = 2, 最后派单时间 = NOW(), 
                派单尝试次数 = 派单尝试次数 + 1
            WHERE 告警编号 = v_告警编号;
        END IF;
    END LOOP;
    
    CLOSE alarm_cursor;
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;

--
-- Final view structure for view `v_光伏预测偏差`
--

/*!50001 DROP VIEW IF EXISTS `v_光伏预测偏差`*/;
/*!50001 SET @saved_cs_client          = @@character_set_client */;
/*!50001 SET @saved_cs_results         = @@character_set_results */;
/*!50001 SET @saved_col_connection     = @@collation_connection */;
/*!50001 SET character_set_client      = utf8mb4 */;
/*!50001 SET character_set_results     = utf8mb4 */;
/*!50001 SET collation_connection      = utf8mb4_0900_ai_ci */;
/*!50001 CREATE ALGORITHM=UNDEFINED */
/*!50013 DEFINER=`jw`@`%` SQL SECURITY DEFINER */
/*!50001 VIEW `v_光伏预测偏差` AS select `pf`.`预测编号` AS `预测编号`,`pf`.`并网点编号` AS `并网点编号`,`pf`.`预测日期` AS `预测日期`,`pf`.`预测时段` AS `预测时段`,`pf`.`预测发电量kWh` AS `预测发电量kWh`,`pf`.`实际发电量kWh` AS `实际发电量kWh`,`pf`.`偏差率` AS `偏差率`,`pf`.`预测模型版本` AS `预测模型版本`,(case when (`pf`.`偏差率` > 15) then '需要优化' when (`pf`.`偏差率` > 10) then '偏差较大' when (`pf`.`偏差率` > 5) then '偏差适中' else '偏差较小' end) AS `偏差等级`,abs((`pf`.`预测发电量kWh` - coalesce(`pf`.`实际发电量kWh`,0))) AS `绝对偏差` from `光伏预测数据表` `pf` where (`pf`.`实际发电量kWh` is not null) order by `pf`.`预测日期` desc,abs(`pf`.`偏差率`) desc */;
/*!50001 SET character_set_client      = @saved_cs_client */;
/*!50001 SET character_set_results     = @saved_cs_results */;
/*!50001 SET collation_connection      = @saved_col_connection */;

--
-- Final view structure for view `v_厂区能耗汇总`
--

/*!50001 DROP VIEW IF EXISTS `v_厂区能耗汇总`*/;
/*!50001 SET @saved_cs_client          = @@character_set_client */;
/*!50001 SET @saved_cs_results         = @@character_set_results */;
/*!50001 SET @saved_col_connection     = @@collation_connection */;
/*!50001 SET character_set_client      = utf8mb4 */;
/*!50001 SET character_set_results     = utf8mb4 */;
/*!50001 SET collation_connection      = utf8mb4_0900_ai_ci */;
/*!50001 CREATE ALGORITHM=UNDEFINED */
/*!50013 DEFINER=`jw`@`%` SQL SECURITY DEFINER */
/*!50001 VIEW `v_厂区能耗汇总` AS select `emd`.`所属厂区编号` AS `厂区编号`,`em`.`能源类型` AS `能源类型`,count(0) AS `数据记录数`,sum(`emd`.`能耗值`) AS `总能耗`,avg(`emd`.`能耗值`) AS `平均能耗`,max(`emd`.`能耗值`) AS `最大能耗`,min(`emd`.`能耗值`) AS `最小能耗`,count((case when (`emd`.`数据质量` = '优') then 1 end)) AS `优质数据数`,count((case when (`emd`.`数据质量` in ('中','差')) then 1 end)) AS `待核实数据数`,max(`emd`.`采集时间`) AS `最新数据时间` from (`能耗监测数据表` `emd` join `能耗计量设备信息表` `em` on((`emd`.`设备编号` = `em`.`设备编号`))) group by `emd`.`所属厂区编号`,`em`.`能源类型` order by `emd`.`所属厂区编号`,`总能耗` desc */;
/*!50001 SET character_set_client      = @saved_cs_client */;
/*!50001 SET character_set_results     = @saved_cs_results */;
/*!50001 SET collation_connection      = @saved_col_connection */;

--
-- Final view structure for view `v_历史趋势分析`
--

/*!50001 DROP VIEW IF EXISTS `v_历史趋势分析`*/;
/*!50001 SET @saved_cs_client          = @@character_set_client */;
/*!50001 SET @saved_cs_results         = @@character_set_results */;
/*!50001 SET @saved_col_connection     = @@collation_connection */;
/*!50001 SET character_set_client      = utf8mb4 */;
/*!50001 SET character_set_results     = utf8mb4 */;
/*!50001 SET collation_connection      = utf8mb4_0900_ai_ci */;
/*!50001 CREATE ALGORITHM=UNDEFINED */
/*!50013 DEFINER=`jw`@`%` SQL SECURITY DEFINER */
/*!50001 VIEW `v_历史趋势分析` AS select `htd`.`趋势编号` AS `趋势编号`,`htd`.`能源类型` AS `能源类型`,`htd`.`统计周期` AS `统计周期`,`htd`.`统计时间` AS `统计时间`,`htd`.`能耗发电量数值` AS `能耗发电量数值`,`htd`.`同比增长率` AS `同比增长率`,`htd`.`环比增长率` AS `环比增长率`,`htd`.`行业均值` AS `行业均值`,(case when (`htd`.`同比增长率` < 0) then '能耗下降' when (`htd`.`同比增长率` > 0) then '能耗上升' else '能耗持平' end) AS `同比趋势`,(case when (`htd`.`环比增长率` < 0) then '环比下降' when (`htd`.`环比增长率` > 0) then '环比上升' else '环比持平' end) AS `环比趋势`,(case when ((`htd`.`行业均值` is not null) and (`htd`.`能耗发电量数值` > (`htd`.`行业均值` * 1.2))) then '高于行业均值20%以上' when ((`htd`.`行业均值` is not null) and (`htd`.`能耗发电量数值` < (`htd`.`行业均值` * 0.8))) then '低于行业均值20%以上' else '接近行业均值' end) AS `行业对比` from `历史趋势数据表` `htd` order by `htd`.`统计时间` desc,`htd`.`能源类型` */;
/*!50001 SET character_set_client      = @saved_cs_client */;
/*!50001 SET character_set_results     = @saved_cs_results */;
/*!50001 SET collation_connection      = @saved_col_connection */;

--
-- Final view structure for view `v_变压器负载率趋势`
--

/*!50001 DROP VIEW IF EXISTS `v_变压器负载率趋势`*/;
/*!50001 SET @saved_cs_client          = @@character_set_client */;
/*!50001 SET @saved_cs_results         = @@character_set_results */;
/*!50001 SET @saved_col_connection     = @@collation_connection */;
/*!50001 SET character_set_client      = utf8mb4 */;
/*!50001 SET character_set_results     = utf8mb4 */;
/*!50001 SET collation_connection      = utf8mb4_0900_ai_ci */;
/*!50001 CREATE ALGORITHM=UNDEFINED */
/*!50013 DEFINER=`jw`@`%` SQL SECURITY DEFINER */
/*!50001 VIEW `v_变压器负载率趋势` AS select `td`.`数据编号` AS `数据编号`,`td`.`配电房编号` AS `配电房编号`,`s`.`名称` AS `配电房名称`,`td`.`变压器编号` AS `变压器编号`,`td`.`采集时间` AS `采集时间`,`td`.`负载率` AS `负载率`,`td`.`绕组温度` AS `绕组温度`,`td`.`环境温度` AS `环境温度`,`td`.`运行状态` AS `运行状态`,(case when (`td`.`负载率` > 100) then '超载' when (`td`.`负载率` > 80) then '高负载' when (`td`.`负载率` > 50) then '中负载' else '低负载' end) AS `负载等级` from (`变压器监测数据表` `td` join `配电房信息表` `s` on((`td`.`配电房编号` = `s`.`配电房编号`))) order by `td`.`采集时间` desc */;
/*!50001 SET character_set_client      = @saved_cs_client */;
/*!50001 SET character_set_results     = @saved_cs_results */;
/*!50001 SET collation_connection      = @saved_col_connection */;

--
-- Final view structure for view `v_告警发生频率统计`
--

/*!50001 DROP VIEW IF EXISTS `v_告警发生频率统计`*/;
/*!50001 SET @saved_cs_client          = @@character_set_client */;
/*!50001 SET @saved_cs_results         = @@character_set_results */;
/*!50001 SET @saved_col_connection     = @@collation_connection */;
/*!50001 SET character_set_client      = utf8mb4 */;
/*!50001 SET character_set_results     = utf8mb4 */;
/*!50001 SET collation_connection      = utf8mb4_0900_ai_ci */;
/*!50001 CREATE ALGORITHM=UNDEFINED */
/*!50013 DEFINER=`jw`@`%` SQL SECURITY DEFINER */
/*!50001 VIEW `v_告警发生频率统计` AS select `告警信息表`.`告警类型` AS `告警类型`,`告警信息表`.`告警等级` AS `告警等级`,count(0) AS `告警总数`,count((case when (cast(`告警信息表`.`发生时间` as date) = curdate()) then 1 end)) AS `今日告警数`,count((case when (cast(`告警信息表`.`发生时间` as date) = (curdate() - interval 1 day)) then 1 end)) AS `昨日告警数`,count((case when ((month(`告警信息表`.`发生时间`) = month(curdate())) and (year(`告警信息表`.`发生时间`) = year(curdate()))) then 1 end)) AS `本月告警数`,round((count(0) / nullif(((to_days(max(`告警信息表`.`发生时间`)) - to_days(min(`告警信息表`.`发生时间`))) + 1),0)),2) AS `日均告警数`,round(((sum((case when (`告警信息表`.`是否误报` = 1) then 1 else 0 end)) * 100.0) / count(0)),2) AS `误报率百分比` from `告警信息表` group by `告警信息表`.`告警类型`,`告警信息表`.`告警等级` order by `告警总数` desc */;
/*!50001 SET character_set_client      = @saved_cs_client */;
/*!50001 SET character_set_results     = @saved_cs_results */;
/*!50001 SET collation_connection      = @saved_col_connection */;

--
-- Final view structure for view `v_告警处理及时率统计`
--

/*!50001 DROP VIEW IF EXISTS `v_告警处理及时率统计`*/;
/*!50001 SET @saved_cs_client          = @@character_set_client */;
/*!50001 SET @saved_cs_results         = @@character_set_results */;
/*!50001 SET @saved_col_connection     = @@collation_connection */;
/*!50001 SET character_set_client      = utf8mb4 */;
/*!50001 SET character_set_results     = utf8mb4 */;
/*!50001 SET collation_connection      = utf8mb4_0900_ai_ci */;
/*!50001 CREATE ALGORITHM=UNDEFINED */
/*!50013 DEFINER=`jw`@`%` SQL SECURITY DEFINER */
/*!50001 VIEW `v_告警处理及时率统计` AS select cast(`a`.`发生时间` as date) AS `告警日期`,count(0) AS `总告警数`,count((case when (`wo`.`工单编号` is not null) then 1 end)) AS `已派单数`,count((case when (`wo`.`复查状态` = '通过') then 1 end)) AS `已处理数`,count((case when ((`wo`.`响应时间` is not null) and (timestampdiff(MINUTE,`a`.`发生时间`,`wo`.`响应时间`) <= 30)) then 1 end)) AS `30分钟内响应数`,count((case when ((`wo`.`处理完成时间` is not null) and (timestampdiff(MINUTE,`a`.`发生时间`,`wo`.`处理完成时间`) <= 120)) then 1 end)) AS `2小时内解决数`,round(((count((case when ((`wo`.`响应时间` is not null) and (timestampdiff(MINUTE,`a`.`发生时间`,`wo`.`响应时间`) <= 30)) then 1 end)) * 100.0) / nullif(count((case when (`wo`.`工单编号` is not null) then 1 end)),0)),2) AS `响应及时率`,round(((count((case when ((`wo`.`处理完成时间` is not null) and (timestampdiff(MINUTE,`a`.`发生时间`,`wo`.`处理完成时间`) <= 120)) then 1 end)) * 100.0) / nullif(count((case when (`wo`.`复查状态` = '通过') then 1 end)),0)),2) AS `解决及时率` from (`告警信息表` `a` left join `运维工单数据表` `wo` on((`a`.`告警编号` = `wo`.`告警编号`))) where (`a`.`是否误报` = 0) group by cast(`a`.`发生时间` as date) order by `告警日期` desc */;
/*!50001 SET character_set_client      = @saved_cs_client */;
/*!50001 SET character_set_results     = @saved_cs_results */;
/*!50001 SET collation_connection      = @saved_col_connection */;

--
-- Final view structure for view `v_告警规则执行情况`
--

/*!50001 DROP VIEW IF EXISTS `v_告警规则执行情况`*/;
/*!50001 SET @saved_cs_client          = @@character_set_client */;
/*!50001 SET @saved_cs_results         = @@character_set_results */;
/*!50001 SET @saved_col_connection     = @@collation_connection */;
/*!50001 SET character_set_client      = utf8mb4 */;
/*!50001 SET character_set_results     = utf8mb4 */;
/*!50001 SET collation_connection      = utf8mb4_0900_ai_ci */;
/*!50001 CREATE ALGORITHM=UNDEFINED */
/*!50013 DEFINER=`jw`@`%` SQL SECURITY DEFINER */
/*!50001 VIEW `v_告警规则执行情况` AS select `r`.`规则编号` AS `规则编号`,`r`.`规则名称` AS `规则名称`,`r`.`设备类型` AS `设备类型`,`r`.`设备子类型` AS `设备子类型`,`r`.`触发字段` AS `触发字段`,`r`.`比较运算符` AS `比较运算符`,`r`.`触发阈值` AS `触发阈值`,`r`.`告警等级` AS `告警等级`,`r`.`启用状态` AS `启用状态`,`r`.`是否启用` AS `是否启用`,`r`.`触发条件表达式` AS `触发条件表达式`,`r`.`最后触发时间` AS `最后触发时间`,`r`.`触发次数` AS `触发次数`,coalesce((select count(0) from `告警信息表` `a` where ((`a`.`告警内容` like concat('%规则:',`r`.`规则名称`,'%')) and (cast(`a`.`发生时间` as date) = curdate()))),0) AS `今日触发次数`,coalesce((select count(0) from `告警信息表` `a` where ((`a`.`告警内容` like concat('%规则:',`r`.`规则名称`,'%')) and (`a`.`是否误报` = 1))),0) AS `历史误报数`,(case when (`r`.`触发次数` = 0) then '从未触发' when (timestampdiff(DAY,`r`.`最后触发时间`,now()) > 30) then '长期未触发' when ((select count(0) from `告警信息表` `a` where ((`a`.`告警内容` like concat('%规则:',`r`.`规则名称`,'%')) and (`a`.`是否误报` = 1))) > (`r`.`触发次数` * 0.5)) then '高误报率' else '正常执行' end) AS `规则状态`,(case when ((`r`.`触发次数` = 0) and (timestampdiff(DAY,`r`.`创建时间`,now()) > 7)) then '建议检查规则配置' when ((select count(0) from `告警信息表` `a` where ((`a`.`告警内容` like concat('%规则:',`r`.`规则名称`,'%')) and (`a`.`是否误报` = 1))) > 5) then '建议优化阈值' else '保持启用' end) AS `维护建议` from `告警规则配置表` `r` order by `r`.`触发次数` desc,`r`.`最后触发时间` desc */;
/*!50001 SET character_set_client      = @saved_cs_client */;
/*!50001 SET character_set_results     = @saved_cs_results */;
/*!50001 SET collation_connection      = @saved_col_connection */;

--
-- Final view structure for view `v_回路异常数据`
--

/*!50001 DROP VIEW IF EXISTS `v_回路异常数据`*/;
/*!50001 SET @saved_cs_client          = @@character_set_client */;
/*!50001 SET @saved_cs_results         = @@character_set_results */;
/*!50001 SET @saved_col_connection     = @@collation_connection */;
/*!50001 SET character_set_client      = utf8mb4 */;
/*!50001 SET character_set_results     = utf8mb4 */;
/*!50001 SET collation_connection      = utf8mb4_0900_ai_ci */;
/*!50001 CREATE ALGORITHM=UNDEFINED */
/*!50013 DEFINER=`jw`@`%` SQL SECURITY DEFINER */
/*!50001 VIEW `v_回路异常数据` AS select `cd`.`数据编号` AS `数据编号`,`cd`.`配电房编号` AS `配电房编号`,`s`.`名称` AS `配电房名称`,`s`.`位置描述` AS `位置描述`,`cd`.`回路编号` AS `回路编号`,`cd`.`采集时间` AS `采集时间`,`cd`.`电压kV` AS `电压kV`,`cd`.`电流A` AS `电流A`,`cd`.`有功功率kW` AS `有功功率kW`,`cd`.`功率因数` AS `功率因数`,`cd`.`开关状态` AS `开关状态`,`cd`.`电缆头温度` AS `电缆头温度`,`cd`.`电容器温度` AS `电容器温度`,`cd`.`数据状态` AS `数据状态`,(case when ((`cd`.`电压kV` > 37.0) or (`cd`.`电压kV` < 33.0)) then '电压越限' when (`cd`.`电缆头温度` > 100) then '电缆头温度过高' when (`cd`.`电容器温度` > 75) then '电容器温度过高' when (`cd`.`功率因数` < 0.85) then '功率因数偏低' else '其他异常' end) AS `异常类型` from (`回路监测数据表` `cd` join `配电房信息表` `s` on((`cd`.`配电房编号` = `s`.`配电房编号`))) where (`cd`.`数据状态` = '异常') order by `cd`.`采集时间` desc */;
/*!50001 SET character_set_client      = @saved_cs_client */;
/*!50001 SET character_set_results     = @saved_cs_results */;
/*!50001 SET collation_connection      = @saved_col_connection */;

--
-- Final view structure for view `v_大屏配置权限`
--

/*!50001 DROP VIEW IF EXISTS `v_大屏配置权限`*/;
/*!50001 SET @saved_cs_client          = @@character_set_client */;
/*!50001 SET @saved_cs_results         = @@character_set_results */;
/*!50001 SET @saved_col_connection     = @@collation_connection */;
/*!50001 SET character_set_client      = utf8mb4 */;
/*!50001 SET character_set_results     = utf8mb4 */;
/*!50001 SET collation_connection      = utf8mb4_0900_ai_ci */;
/*!50001 CREATE ALGORITHM=UNDEFINED */
/*!50013 DEFINER=`jw`@`%` SQL SECURITY DEFINER */
/*!50001 VIEW `v_大屏配置权限` AS select `dc`.`配置编号` AS `配置编号`,`dc`.`展示模块` AS `展示模块`,`dc`.`数据刷新频率` AS `数据刷新频率`,`dc`.`展示字段` AS `展示字段`,`dc`.`排序规则` AS `排序规则`,`dc`.`权限等级` AS `权限等级`,(case when (`dc`.`权限等级` = '管理员') then '所有模块' when (`dc`.`权限等级` = '能源管理员') then '能源相关模块' when (`dc`.`权限等级` = '运维人员') then '运维相关模块' else '基础模块' end) AS `可访问模块说明` from `大屏展示配置表` `dc` order by `dc`.`权限等级`,`dc`.`展示模块` */;
/*!50001 SET character_set_client      = @saved_cs_client */;
/*!50001 SET character_set_results     = @saved_cs_results */;
/*!50001 SET collation_connection      = @saved_col_connection */;

--
-- Final view structure for view `v_实时能源总览`
--

/*!50001 DROP VIEW IF EXISTS `v_实时能源总览`*/;
/*!50001 SET @saved_cs_client          = @@character_set_client */;
/*!50001 SET @saved_cs_results         = @@character_set_results */;
/*!50001 SET @saved_col_connection     = @@collation_connection */;
/*!50001 SET character_set_client      = utf8mb4 */;
/*!50001 SET character_set_results     = utf8mb4 */;
/*!50001 SET collation_connection      = utf8mb4_0900_ai_ci */;
/*!50001 CREATE ALGORITHM=UNDEFINED */
/*!50013 DEFINER=`jw`@`%` SQL SECURITY DEFINER */
/*!50001 VIEW `v_实时能源总览` AS select `rsd`.`汇总编号` AS `汇总编号`,`rsd`.`统计时间` AS `统计时间`,`rsd`.`总用电量kWh` AS `总用电量kWh`,`rsd`.`总用水量m3` AS `总用水量m3`,`rsd`.`总蒸汽消耗量t` AS `总蒸汽消耗量t`,`rsd`.`总天然气消耗量m3` AS `总天然气消耗量m3`,`rsd`.`光伏总发电量kWh` AS `光伏总发电量kWh`,`rsd`.`光伏自用电量kWh` AS `光伏自用电量kWh`,`rsd`.`总告警次数` AS `总告警次数`,`rsd`.`高等级告警数` AS `高等级告警数`,`rsd`.`中等级告警数` AS `中等级告警数`,`rsd`.`低等级告警数` AS `低等级告警数`,(case when (`rsd`.`高等级告警数` > 0) then '有高等级告警' when (`rsd`.`总告警次数` > 10) then '告警较多' else '运行正常' end) AS `系统状态` from `实时汇总数据表` `rsd` order by `rsd`.`统计时间` desc limit 1 */;
/*!50001 SET character_set_client      = @saved_cs_client */;
/*!50001 SET character_set_results     = @saved_cs_results */;
/*!50001 SET collation_connection      = @saved_col_connection */;

--
-- Final view structure for view `v_峰谷能耗分析`
--

/*!50001 DROP VIEW IF EXISTS `v_峰谷能耗分析`*/;
/*!50001 SET @saved_cs_client          = @@character_set_client */;
/*!50001 SET @saved_cs_results         = @@character_set_results */;
/*!50001 SET @saved_col_connection     = @@collation_connection */;
/*!50001 SET character_set_client      = utf8mb4 */;
/*!50001 SET character_set_results     = utf8mb4 */;
/*!50001 SET collation_connection      = utf8mb4_0900_ai_ci */;
/*!50001 CREATE ALGORITHM=UNDEFINED */
/*!50013 DEFINER=`jw`@`%` SQL SECURITY DEFINER */
/*!50001 VIEW `v_峰谷能耗分析` AS select `峰谷能耗数据表`.`厂区编号` AS `厂区编号`,`峰谷能耗数据表`.`能源类型` AS `能源类型`,`峰谷能耗数据表`.`统计日期` AS `统计日期`,`峰谷能耗数据表`.`尖峰时段能耗` AS `尖峰时段能耗`,`峰谷能耗数据表`.`高峰时段能耗` AS `高峰时段能耗`,`峰谷能耗数据表`.`平段能耗` AS `平段能耗`,`峰谷能耗数据表`.`低谷时段能耗` AS `低谷时段能耗`,`峰谷能耗数据表`.`总能耗` AS `总能耗`,`峰谷能耗数据表`.`能耗成本` AS `能耗成本`,round(((`峰谷能耗数据表`.`低谷时段能耗` / `峰谷能耗数据表`.`总能耗`) * 100),2) AS `谷段占比`,round((((`峰谷能耗数据表`.`尖峰时段能耗` + `峰谷能耗数据表`.`高峰时段能耗`) / `峰谷能耗数据表`.`总能耗`) * 100),2) AS `峰段占比`,(case when (((`峰谷能耗数据表`.`低谷时段能耗` / `峰谷能耗数据表`.`总能耗`) * 100) < 30) then '谷段占比偏低' when (((`峰谷能耗数据表`.`低谷时段能耗` / `峰谷能耗数据表`.`总能耗`) * 100) > 50) then '谷段占比偏高' else '谷段占比正常' end) AS `能耗评价` from `峰谷能耗数据表` order by `峰谷能耗数据表`.`统计日期` desc,`峰谷能耗数据表`.`能耗成本` desc */;
/*!50001 SET character_set_client      = @saved_cs_client */;
/*!50001 SET character_set_results     = @saved_cs_results */;
/*!50001 SET collation_connection      = @saved_col_connection */;

--
-- Final view structure for view `v_待审核误报告警`
--

/*!50001 DROP VIEW IF EXISTS `v_待审核误报告警`*/;
/*!50001 SET @saved_cs_client          = @@character_set_client */;
/*!50001 SET @saved_cs_results         = @@character_set_results */;
/*!50001 SET @saved_col_connection     = @@collation_connection */;
/*!50001 SET character_set_client      = utf8mb4 */;
/*!50001 SET character_set_results     = utf8mb4 */;
/*!50001 SET collation_connection      = utf8mb4_0900_ai_ci */;
/*!50001 CREATE ALGORITHM=UNDEFINED */
/*!50013 DEFINER=`jw`@`%` SQL SECURITY DEFINER */
/*!50001 VIEW `v_待审核误报告警` AS select `a`.`告警编号` AS `告警编号`,`a`.`告警类型` AS `告警类型`,`a`.`告警等级` AS `告警等级`,`a`.`关联设备编号` AS `关联设备编号`,`a`.`发生时间` AS `发生时间`,`a`.`告警内容` AS `告警内容`,`a`.`处理状态` AS `处理状态`,timestampdiff(MINUTE,`a`.`发生时间`,now()) AS `告警持续时间(分钟)`,(case when ((`a`.`告警等级` = '高') and (timestampdiff(MINUTE,`a`.`发生时间`,now()) > 15)) then '需优先审核' when ((`a`.`告警内容` like '%波动%') or (`a`.`告警内容` like '%通讯%')) then '可能为误报' else '待审核' end) AS `审核优先级` from `告警信息表` `a` where ((`a`.`是否误报` = 0) and (`a`.`处理状态` = '未处理') and (`a`.`发生时间` >= (now() - interval 7 day))) order by (case `审核优先级` when '需优先审核' then 1 when '可能为误报' then 2 else 3 end),`a`.`发生时间` desc */;
/*!50001 SET character_set_client      = @saved_cs_client */;
/*!50001 SET character_set_results     = @saved_cs_results */;
/*!50001 SET collation_connection      = @saved_col_connection */;

--
-- Final view structure for view `v_待审核误报告警_详细`
--

/*!50001 DROP VIEW IF EXISTS `v_待审核误报告警_详细`*/;
/*!50001 SET @saved_cs_client          = @@character_set_client */;
/*!50001 SET @saved_cs_results         = @@character_set_results */;
/*!50001 SET @saved_col_connection     = @@collation_connection */;
/*!50001 SET character_set_client      = utf8mb4 */;
/*!50001 SET character_set_results     = utf8mb4 */;
/*!50001 SET collation_connection      = utf8mb4_0900_ai_ci */;
/*!50001 CREATE ALGORITHM=UNDEFINED */
/*!50013 DEFINER=`jw`@`%` SQL SECURITY DEFINER */
/*!50001 VIEW `v_待审核误报告警_详细` AS select `a`.`告警编号` AS `告警编号`,`a`.`告警类型` AS `告警类型`,`a`.`告警等级` AS `告警等级`,`a`.`关联设备编号` AS `关联设备编号`,coalesce(`d`.`设备名称`,`pv`.`设备类型`,`em`.`能源类型`,'未知设备') AS `设备描述`,`a`.`发生时间` AS `发生时间`,timestampdiff(MINUTE,`a`.`发生时间`,now()) AS `持续时间分钟`,`a`.`告警内容` AS `告警内容`,`a`.`处理状态` AS `处理状态`,`a`.`告警触发阈值` AS `告警触发阈值`,`a`.`创建时间` AS `创建时间`,(case when ((`a`.`告警内容` like '%通讯%') or (`a`.`告警内容` like '%离线%')) then '高误报可能性（通讯问题）' when ((`a`.`告警内容` like '%波动%') or (`a`.`告警内容` like '%瞬时%')) then '高误报可能性（数据波动）' when (`a`.`告警类型` = '通讯故障') then '中误报可能性' when (timestampdiff(HOUR,`a`.`发生时间`,now()) > 24) then '长期未处理需关注' else '正常告警需审核' end) AS `误报可能性`,(case when ((`a`.`告警等级` = '高') and (timestampdiff(MINUTE,`a`.`发生时间`,now()) > 15)) then '紧急审核' when (`a`.`告警等级` = '高') then '高优先级' when (`a`.`告警内容` like '%通讯%') then '中优先级（可能误报）' else '常规审核' end) AS `审核优先级`,coalesce(`pv`.`运行状态`,`em`.`运行状态`,`d`.`报废状态`,'未知') AS `设备状态` from (((`告警信息表` `a` left join `设备台账数据表` `d` on((`a`.`关联设备编号` = `d`.`台账编号`))) left join `光伏设备信息表` `pv` on((`a`.`关联设备编号` = `pv`.`设备编号`))) left join `能耗计量设备信息表` `em` on((`a`.`关联设备编号` = `em`.`设备编号`))) where ((`a`.`是否误报` = 0) and (`a`.`处理状态` in ('未处理','处理中')) and (`a`.`发生时间` >= (now() - interval 7 day))) order by (case `审核优先级` when '紧急审核' then 1 when '高优先级' then 2 when '中优先级（可能误报）' then 3 else 4 end),`a`.`发生时间` desc */;
/*!50001 SET character_set_client      = @saved_cs_client */;
/*!50001 SET character_set_results     = @saved_cs_results */;
/*!50001 SET collation_connection      = @saved_col_connection */;

--
-- Final view structure for view `v_能耗数据质量监控`
--

/*!50001 DROP VIEW IF EXISTS `v_能耗数据质量监控`*/;
/*!50001 SET @saved_cs_client          = @@character_set_client */;
/*!50001 SET @saved_cs_results         = @@character_set_results */;
/*!50001 SET @saved_col_connection     = @@collation_connection */;
/*!50001 SET character_set_client      = utf8mb4 */;
/*!50001 SET character_set_results     = utf8mb4 */;
/*!50001 SET collation_connection      = utf8mb4_0900_ai_ci */;
/*!50001 CREATE ALGORITHM=UNDEFINED */
/*!50013 DEFINER=`jw`@`%` SQL SECURITY DEFINER */
/*!50001 VIEW `v_能耗数据质量监控` AS select `em`.`设备编号` AS `设备编号`,`em`.`能源类型` AS `能源类型`,`em`.`安装位置` AS `安装位置`,`em`.`运行状态` AS `运行状态`,count(`emd`.`数据编号`) AS `总数据数`,count((case when (`emd`.`数据质量` = '优') then 1 end)) AS `优质数据数`,count((case when (`emd`.`数据质量` = '良') then 1 end)) AS `良好数据数`,count((case when (`emd`.`数据质量` = '中') then 1 end)) AS `中等数据数`,count((case when (`emd`.`数据质量` = '差') then 1 end)) AS `差数据数`,round(((count((case when (`emd`.`数据质量` in ('优','良')) then 1 end)) / count(0)) * 100),2) AS `数据优良率`,max(`emd`.`采集时间`) AS `最新数据时间`,(case when (count((case when (`emd`.`数据质量` in ('中','差')) then 1 end)) > (count(0) * 0.2)) then '需要校准' when (`em`.`运行状态` = '故障') then '需要维修' else '运行正常' end) AS `设备状态` from (`能耗计量设备信息表` `em` left join `能耗监测数据表` `emd` on((`em`.`设备编号` = `emd`.`设备编号`))) group by `em`.`设备编号`,`em`.`能源类型`,`em`.`安装位置`,`em`.`运行状态` order by `数据优良率`,`最新数据时间` desc */;
/*!50001 SET character_set_client      = @saved_cs_client */;
/*!50001 SET character_set_results     = @saved_cs_results */;
/*!50001 SET collation_connection      = @saved_col_connection */;

--
-- Final view structure for view `v_设备类型告警分布`
--

/*!50001 DROP VIEW IF EXISTS `v_设备类型告警分布`*/;
/*!50001 SET @saved_cs_client          = @@character_set_client */;
/*!50001 SET @saved_cs_results         = @@character_set_results */;
/*!50001 SET @saved_col_connection     = @@collation_connection */;
/*!50001 SET character_set_client      = utf8mb4 */;
/*!50001 SET character_set_results     = utf8mb4 */;
/*!50001 SET collation_connection      = utf8mb4_0900_ai_ci */;
/*!50001 CREATE ALGORITHM=UNDEFINED */
/*!50013 DEFINER=`jw`@`%` SQL SECURITY DEFINER */
/*!50001 VIEW `v_设备类型告警分布` AS select (case when (`a`.`关联设备编号` like 'BYQ%') then '变压器' when ((`a`.`关联设备编号` like 'INV%') or (`a`.`关联设备编号` like 'COMB%')) then '光伏设备' when (`a`.`关联设备编号` like 'NH%') then '能耗设备' when (`a`.`关联设备编号` like 'TZ%') then '台账设备' else '其他设备' end) AS `设备类型`,count(0) AS `告警总数`,count((case when (`a`.`告警等级` = '高') then 1 end)) AS `高等级告警数`,count((case when (`a`.`告警等级` = '中') then 1 end)) AS `中等级告警数`,count((case when (`a`.`告警等级` = '低') then 1 end)) AS `低等级告警数`,count((case when (`a`.`处理状态` = '未处理') then 1 end)) AS `未处理告警数`,count((case when (`a`.`处理状态` = '已结案') then 1 end)) AS `已结案告警数`,round(avg((case when (`wo`.`处理完成时间` is not null) then timestampdiff(MINUTE,`wo`.`派单时间`,`wo`.`处理完成时间`) end)),2) AS `平均处理时长(分钟)` from (`告警信息表` `a` left join `运维工单数据表` `wo` on((`a`.`告警编号` = `wo`.`告警编号`))) group by `设备类型` order by `告警总数` desc */;
/*!50001 SET character_set_client      = @saved_cs_client */;
/*!50001 SET character_set_results     = @saved_cs_results */;
/*!50001 SET collation_connection      = @saved_col_connection */;

--
-- Final view structure for view `v_运维人员工作量统计`
--

/*!50001 DROP VIEW IF EXISTS `v_运维人员工作量统计`*/;
/*!50001 SET @saved_cs_client          = @@character_set_client */;
/*!50001 SET @saved_cs_results         = @@character_set_results */;
/*!50001 SET @saved_col_connection     = @@collation_connection */;
/*!50001 SET character_set_client      = utf8mb4 */;
/*!50001 SET character_set_results     = utf8mb4 */;
/*!50001 SET collation_connection      = utf8mb4_0900_ai_ci */;
/*!50001 CREATE ALGORITHM=UNDEFINED */
/*!50013 DEFINER=`jw`@`%` SQL SECURITY DEFINER */
/*!50001 VIEW `v_运维人员工作量统计` AS select `wo`.`运维人员ID` AS `运维人员ID`,`u`.`姓名` AS `姓名`,count(distinct `wo`.`工单编号`) AS `总工单数`,count(distinct (case when (`wo`.`复查状态` = '通过') then `wo`.`工单编号` end)) AS `已完成工单数`,count(distinct (case when (`wo`.`复查状态` = '未通过') then `wo`.`工单编号` end)) AS `未通过工单数`,count(distinct (case when (`wo`.`响应时间` is null) then `wo`.`工单编号` end)) AS `未响应工单数`,round(avg(timestampdiff(MINUTE,`wo`.`派单时间`,`wo`.`响应时间`)),2) AS `平均响应时间(分钟)`,round(avg(timestampdiff(MINUTE,`wo`.`响应时间`,`wo`.`处理完成时间`)),2) AS `平均处理时间(分钟)`,round(avg(timestampdiff(MINUTE,`wo`.`派单时间`,`wo`.`处理完成时间`)),2) AS `平均总耗时(分钟)`,count(distinct (case when ((`wo`.`处理完成时间` is not null) and (timestampdiff(MINUTE,`wo`.`派单时间`,`wo`.`处理完成时间`) <= 120)) then `wo`.`工单编号` end)) AS `2小时内完成数` from (`运维工单数据表` `wo` left join `用户表` `u` on((`wo`.`运维人员ID` = `u`.`用户ID`))) group by `wo`.`运维人员ID`,`u`.`姓名` order by `总工单数` desc */;
/*!50001 SET character_set_client      = @saved_cs_client */;
/*!50001 SET character_set_results     = @saved_cs_results */;
/*!50001 SET collation_connection      = @saved_col_connection */;

--
-- Final view structure for view `v_运维工单处理效率`
--

/*!50001 DROP VIEW IF EXISTS `v_运维工单处理效率`*/;
/*!50001 SET @saved_cs_client          = @@character_set_client */;
/*!50001 SET @saved_cs_results         = @@character_set_results */;
/*!50001 SET @saved_col_connection     = @@collation_connection */;
/*!50001 SET character_set_client      = utf8mb4 */;
/*!50001 SET character_set_results     = utf8mb4 */;
/*!50001 SET collation_connection      = utf8mb4_0900_ai_ci */;
/*!50001 CREATE ALGORITHM=UNDEFINED */
/*!50013 DEFINER=`jw`@`%` SQL SECURITY DEFINER */
/*!50001 VIEW `v_运维工单处理效率` AS select `wo`.`工单编号` AS `工单编号`,`wo`.`告警编号` AS `告警编号`,`a`.`告警类型` AS `告警类型`,`a`.`告警等级` AS `告警等级`,`wo`.`运维人员ID` AS `运维人员ID`,`wo`.`派单时间` AS `派单时间`,`wo`.`响应时间` AS `响应时间`,`wo`.`处理完成时间` AS `处理完成时间`,`wo`.`复查状态` AS `复查状态`,timestampdiff(MINUTE,`wo`.`派单时间`,`wo`.`响应时间`) AS `响应时长分钟`,timestampdiff(MINUTE,`wo`.`响应时间`,`wo`.`处理完成时间`) AS `处理时长分钟`,timestampdiff(MINUTE,`wo`.`派单时间`,`wo`.`处理完成时间`) AS `总处理时长分钟`,(case when (`wo`.`处理完成时间` is null) then '未完成' when (`wo`.`复查状态` = '通过') then '已完成' when (`wo`.`复查状态` = '未通过') then '需重新处理' else '待复查' end) AS `工单状态` from (`运维工单数据表` `wo` join `告警信息表` `a` on((`wo`.`告警编号` = `a`.`告警编号`))) order by `wo`.`派单时间` desc */;
/*!50001 SET character_set_client      = @saved_cs_client */;
/*!50001 SET character_set_results     = @saved_cs_results */;
/*!50001 SET collation_connection      = @saved_col_connection */;

--
-- Final view structure for view `v_配电房运行状态汇总`
--

/*!50001 DROP VIEW IF EXISTS `v_配电房运行状态汇总`*/;
/*!50001 SET @saved_cs_client          = @@character_set_client */;
/*!50001 SET @saved_cs_results         = @@character_set_results */;
/*!50001 SET @saved_col_connection     = @@collation_connection */;
/*!50001 SET character_set_client      = utf8mb4 */;
/*!50001 SET character_set_results     = utf8mb4 */;
/*!50001 SET collation_connection      = utf8mb4_0900_ai_ci */;
/*!50001 CREATE ALGORITHM=UNDEFINED */
/*!50013 DEFINER=`jw`@`%` SQL SECURITY DEFINER */
/*!50001 VIEW `v_配电房运行状态汇总` AS select `s`.`配电房编号` AS `配电房编号`,`s`.`名称` AS `配电房名称`,`s`.`电压等级` AS `电压等级`,`s`.`变压器数量` AS `变压器数量`,count(distinct `cd`.`回路编号`) AS `回路数量`,count((case when (`cd`.`数据状态` = '异常') then 1 end)) AS `异常回路数`,count((case when (`td`.`运行状态` = '异常') then 1 end)) AS `异常变压器数`,max(`cd`.`采集时间`) AS `最新回路数据时间`,max(`td`.`采集时间`) AS `最新变压器数据时间` from ((`配电房信息表` `s` left join `回路监测数据表` `cd` on((`s`.`配电房编号` = `cd`.`配电房编号`))) left join `变压器监测数据表` `td` on((`s`.`配电房编号` = `td`.`配电房编号`))) group by `s`.`配电房编号`,`s`.`名称`,`s`.`电压等级`,`s`.`变压器数量` */;
/*!50001 SET character_set_client      = @saved_cs_client */;
/*!50001 SET character_set_results     = @saved_cs_results */;
/*!50001 SET collation_connection      = @saved_col_connection */;

--
-- Final view structure for view `v_高等级告警`
--

/*!50001 DROP VIEW IF EXISTS `v_高等级告警`*/;
/*!50001 SET @saved_cs_client          = @@character_set_client */;
/*!50001 SET @saved_cs_results         = @@character_set_results */;
/*!50001 SET @saved_col_connection     = @@collation_connection */;
/*!50001 SET character_set_client      = utf8mb4 */;
/*!50001 SET character_set_results     = utf8mb4 */;
/*!50001 SET collation_connection      = utf8mb4_0900_ai_ci */;
/*!50001 CREATE ALGORITHM=UNDEFINED */
/*!50013 DEFINER=`jw`@`%` SQL SECURITY DEFINER */
/*!50001 VIEW `v_高等级告警` AS select `a`.`告警编号` AS `告警编号`,`a`.`告警类型` AS `告警类型`,`a`.`关联设备编号` AS `关联设备编号`,`a`.`发生时间` AS `发生时间`,`a`.`告警等级` AS `告警等级`,`a`.`告警内容` AS `告警内容`,`a`.`处理状态` AS `处理状态`,`a`.`告警触发阈值` AS `告警触发阈值`,timestampdiff(MINUTE,`a`.`发生时间`,now()) AS `告警持续时间分钟`,(case when ((`a`.`告警等级` = '高') and (timestampdiff(MINUTE,`a`.`发生时间`,now()) > 15) and (`a`.`处理状态` = '未处理')) then '超时未处理' when (`a`.`处理状态` = '未处理') then '待处理' when (`a`.`处理状态` = '处理中') then '处理中' else '已处理' end) AS `告警状态` from `告警信息表` `a` where (`a`.`告警等级` = '高') order by `a`.`发生时间` desc */;
/*!50001 SET character_set_client      = @saved_cs_client */;
/*!50001 SET character_set_results     = @saved_cs_results */;
/*!50001 SET collation_connection      = @saved_col_connection */;
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

-- Dump completed on 2026-01-05 20:52:31
