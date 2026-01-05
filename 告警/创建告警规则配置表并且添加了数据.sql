-- 创建告警规则配置表
DROP TABLE IF EXISTS `告警规则配置表`;
CREATE TABLE `告警规则配置表` (
  `规则编号` VARCHAR(20) NOT NULL COMMENT '唯一标识规则，如RULE-001',
  `规则名称` VARCHAR(50) NOT NULL COMMENT '规则描述，如"变压器温度告警"',
  `告警类型` VARCHAR(20) NOT NULL COMMENT '越限告警、通讯故障、设备故障',
  `设备类型` VARCHAR(20) NOT NULL COMMENT '变压器、逆变器、水表、回路等',
  `触发字段` VARCHAR(30) NOT NULL COMMENT '如绕组温度、电压kV、运行状态',
  `比较运算符` VARCHAR(10) NOT NULL COMMENT '>、<、=、>=、<=、≠、包含',
  `触发阈值` VARCHAR(50) NOT NULL COMMENT '阈值数值或状态，如95、正常、离线',
  `告警等级` VARCHAR(10) NOT NULL COMMENT '高、中、低',
  `告警内容模板` VARCHAR(200) NOT NULL COMMENT '告警内容模板，可使用{字段名}占位符',
  `启用状态` TINYINT NOT NULL DEFAULT 1 COMMENT '1-启用，0-禁用',
  `创建人` VARCHAR(20) DEFAULT NULL COMMENT '规则创建人',
  `创建时间` DATETIME DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
  `更新时间` DATETIME DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '更新时间',
  PRIMARY KEY (`规则编号`),
  KEY `idx_设备类型` (`设备类型`),
  KEY `idx_启用状态` (`启用状态`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci COMMENT='告警规则配置表';

-- 插入示例规则数据
INSERT INTO `告警规则配置表` VALUES
('RULE-001', '变压器温度告警', '越限告警', '变压器', '绕组温度', '>', '95', '中', '变压器{设备编号}绕组温度{实际值}℃，超过阈值{阈值}℃', 1, 'admin', NOW(), NOW()),
('RULE-002', '变压器超载告警', '越限告警', '变压器', '负载率', '>', '100', '高', '变压器{设备编号}负载率{实际值}%，已超载运行', 1, 'admin', NOW(), NOW()),
('RULE-003', '回路电压越限', '越限告警', '回路', '电压kV', '>', '37', '中', '回路{设备编号}电压{实际值}kV，超过上限{阈值}kV', 1, 'admin', NOW(), NOW()),
('RULE-004', '光伏设备离线', '通讯故障', '逆变器', '运行状态', '=', '离线', '低', '光伏设备{设备编号}通讯中断，处于离线状态', 1, 'admin', NOW(), NOW()),
('RULE-005', '设备运行故障', '设备故障', '设备', '运行状态', '=', '故障', '中', '设备{设备编号}运行故障，需要检修', 1, 'admin', NOW(), NOW());