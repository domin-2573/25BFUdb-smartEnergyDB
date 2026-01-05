-- 创建通知记录表
DROP TABLE IF EXISTS `告警通知记录表`;
CREATE TABLE `告警通知记录表` (
  `通知编号` VARCHAR(20) NOT NULL COMMENT '唯一标识通知',
  `告警编号` VARCHAR(20) NOT NULL COMMENT '关联的告警',
  `通知方式` VARCHAR(10) NOT NULL COMMENT '短信、APP推送、邮件、系统消息',
  `通知内容` VARCHAR(500) NOT NULL COMMENT '通知内容',
  `接收人ID` VARCHAR(20) NOT NULL COMMENT '接收人ID',
  `发送状态` VARCHAR(10) NOT NULL COMMENT '待发送、发送中、发送成功、发送失败',
  `发送时间` DATETIME DEFAULT NULL COMMENT '实际发送时间',
  `创建时间` DATETIME DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
  `备注` VARCHAR(200) DEFAULT NULL COMMENT '发送失败原因等备注',
  PRIMARY KEY (`通知编号`),
  KEY `idx_告警编号` (`告警编号`),
  KEY `idx_发送状态` (`发送状态`),
  KEY `idx_接收人ID` (`接收人ID`),
  CONSTRAINT `fk_通知_告警` FOREIGN KEY (`告警编号`) REFERENCES `告警信息表` (`告警编号`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci COMMENT='告警通知记录表';