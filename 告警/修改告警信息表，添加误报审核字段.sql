-- 为告警信息表添加误报审核相关字段
ALTER TABLE `告警信息表`
ADD COLUMN `是否误报` TINYINT DEFAULT 0 COMMENT '0-真实告警，1-误报',
ADD COLUMN `误报审核人` VARCHAR(20) DEFAULT NULL COMMENT '误报审核人员ID',
ADD COLUMN `误报审核时间` DATETIME DEFAULT NULL COMMENT '误报审核时间',
ADD COLUMN `误报原因` VARCHAR(200) DEFAULT NULL COMMENT '误报原因说明',
ADD COLUMN `自动派单状态` TINYINT DEFAULT 0 COMMENT '0-未派单，1-已派单，2-派单失败',
ADD COLUMN `派单尝试次数` INT DEFAULT 0 COMMENT '自动派单尝试次数',
ADD COLUMN `最后派单时间` DATETIME DEFAULT NULL COMMENT '最后尝试派单时间';

-- 添加索引
ALTER TABLE `告警信息表`
ADD INDEX `idx_是否误报` (`是否误报`),
ADD INDEX `idx_自动派单状态` (`自动派单状态`);