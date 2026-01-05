-- 创建系统日志表（如果不存在）
CREATE TABLE IF NOT EXISTS `系统日志表` (
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

-- 创建系统日志表（如果不存在）
CREATE TABLE IF NOT EXISTS `系统日志表` (
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