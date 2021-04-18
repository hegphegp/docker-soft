/*
 Navicat Premium Data Transfer

 Source Server         : localhost-3306
 Source Server Type    : MySQL
 Source Server Version : 80016
 Source Host           : localhost:3306
 Source Schema         : cat

 Target Server Type    : MySQL
 Target Server Version : 80016
 File Encoding         : 65001

 Date: 17/04/2021 16:44:36
*/

SET NAMES utf8mb4;
SET FOREIGN_KEY_CHECKS = 0;

-- ----------------------------
-- Table structure for alert
-- ----------------------------
DROP TABLE IF EXISTS `alert`;
CREATE TABLE `alert`  (
  `id` int(11) NOT NULL AUTO_INCREMENT COMMENT '自增长ID',
  `domain` varchar(128) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL COMMENT '告警项目',
  `alert_time` datetime(0) NOT NULL COMMENT '告警时间',
  `category` varchar(64) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL COMMENT '告警分类:network/business/system/exception -alert',
  `type` varchar(64) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL COMMENT '告警类型:error/warning',
  `content` longtext CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL COMMENT '告警内容',
  `metric` varchar(128) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL COMMENT '告警指标',
  `creation_date` datetime(0) NOT NULL COMMENT '数据插入时间',
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB CHARACTER SET = utf8 COLLATE = utf8_general_ci COMMENT = '存储告警信息' ROW_FORMAT = Dynamic;

-- ----------------------------
-- Table structure for alert_summary
-- ----------------------------
DROP TABLE IF EXISTS `alert_summary`;
CREATE TABLE `alert_summary`  (
  `id` int(11) NOT NULL AUTO_INCREMENT COMMENT '自增长ID',
  `domain` varchar(128) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL COMMENT '告警项目',
  `alert_time` datetime(0) NOT NULL COMMENT '告警时间',
  `content` longtext CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL COMMENT '统一告警内容',
  `creation_date` datetime(0) NOT NULL COMMENT '数据插入时间',
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB CHARACTER SET = utf8 COLLATE = utf8_general_ci COMMENT = '统一告警信息' ROW_FORMAT = Dynamic;

-- ----------------------------
-- Table structure for alteration
-- ----------------------------
DROP TABLE IF EXISTS `alteration`;
CREATE TABLE `alteration`  (
  `id` int(11) NOT NULL AUTO_INCREMENT COMMENT '自增长ID',
  `type` varchar(64) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL COMMENT '分类',
  `title` varchar(128) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL COMMENT '变更标题',
  `domain` varchar(128) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL COMMENT '变更项目',
  `hostname` varchar(128) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL COMMENT '变更机器名',
  `ip` varchar(128) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '变更机器IP',
  `date` datetime(0) NOT NULL COMMENT '变更时间',
  `user` varchar(45) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL COMMENT '变更用户',
  `alt_group` varchar(45) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '变更组别',
  `content` longtext CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL COMMENT '变更内容',
  `url` varchar(200) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '变更链接',
  `status` tinyint(4) NULL DEFAULT 0 COMMENT '变更状态',
  `creation_date` datetime(0) NOT NULL COMMENT '数据库创建时间',
  PRIMARY KEY (`id`) USING BTREE,
  INDEX `ind_date_domain_host`(`date`, `domain`, `hostname`) USING BTREE
) ENGINE = InnoDB CHARACTER SET = utf8 COLLATE = utf8_general_ci COMMENT = '变更表' ROW_FORMAT = Dynamic;

-- ----------------------------
-- Table structure for baseline
-- ----------------------------
DROP TABLE IF EXISTS `baseline`;
CREATE TABLE `baseline`  (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `report_name` varchar(100) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL,
  `index_key` varchar(100) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL,
  `report_period` datetime(0) NULL DEFAULT NULL,
  `data` blob NULL,
  `creation_date` datetime(0) NULL DEFAULT NULL,
  PRIMARY KEY (`id`) USING BTREE,
  INDEX `period_name_key`(`report_period`, `report_name`, `index_key`) USING BTREE
) ENGINE = InnoDB CHARACTER SET = utf8 COLLATE = utf8_general_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Table structure for businessReport
-- ----------------------------
DROP TABLE IF EXISTS `businessReport`;
CREATE TABLE `businessReport`  (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `type` tinyint(4) NOT NULL COMMENT '报表类型 报表数据格式, 1/Binary, 2/xml , 3/json',
  `name` varchar(20) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL COMMENT '报表名称',
  `ip` varchar(50) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL COMMENT '报表来自于哪台机器',
  `productLine` varchar(50) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL COMMENT '指标来源于哪个产品组',
  `period` datetime(0) NOT NULL COMMENT '报表时间段',
  `content` longblob NULL COMMENT '用于存放报表的具体内容',
  `creation_date` datetime(0) NOT NULL COMMENT '报表创建时间',
  PRIMARY KEY (`id`) USING BTREE,
  INDEX `IX_Period_productLine_name`(`period`, `productLine`, `name`) USING BTREE
) ENGINE = InnoDB CHARACTER SET = utf8 COLLATE = utf8_general_ci COMMENT = '用于存放业务监控实时报表信息，处理之后的结果' ROW_FORMAT = Compressed;

-- ----------------------------
-- Table structure for business_config
-- ----------------------------
DROP TABLE IF EXISTS `business_config`;
CREATE TABLE `business_config`  (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(20) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL DEFAULT '' COMMENT '配置名称',
  `domain` varchar(50) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL DEFAULT '' COMMENT '项目',
  `content` longtext CHARACTER SET utf8 COLLATE utf8_general_ci NULL COMMENT '配置内容',
  `updatetime` datetime(0) NOT NULL,
  PRIMARY KEY (`id`) USING BTREE,
  INDEX `updatetime`(`updatetime`) USING BTREE,
  INDEX `name_domain`(`name`, `domain`) USING BTREE
) ENGINE = InnoDB CHARACTER SET = utf8 COLLATE = utf8_general_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Table structure for config
-- ----------------------------
DROP TABLE IF EXISTS `config`;
CREATE TABLE `config`  (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(50) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL COMMENT '配置名称',
  `content` longtext CHARACTER SET utf8 COLLATE utf8_general_ci NULL COMMENT '配置的具体内容',
  `creation_date` datetime(0) NOT NULL COMMENT '配置创建时间',
  `modify_date` datetime(0) NOT NULL COMMENT '配置修改时间',
  PRIMARY KEY (`id`) USING BTREE,
  UNIQUE INDEX `name`(`name`) USING BTREE
) ENGINE = InnoDB CHARACTER SET = utf8 COLLATE = utf8_general_ci COMMENT = '用于存储系统的全局配置信息' ROW_FORMAT = Dynamic;

-- ----------------------------
-- Table structure for config_modification
-- ----------------------------
DROP TABLE IF EXISTS `config_modification`;
CREATE TABLE `config_modification`  (
  `id` int(11) NOT NULL AUTO_INCREMENT COMMENT '自增长ID',
  `user_name` varchar(64) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL COMMENT '用户名',
  `account_name` varchar(64) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL COMMENT '账户名',
  `action_name` varchar(64) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL COMMENT 'action名',
  `argument` longtext CHARACTER SET utf8 COLLATE utf8_general_ci NULL COMMENT '参数内容',
  `date` datetime(0) NOT NULL COMMENT '修改时间',
  `creation_date` datetime(0) NOT NULL COMMENT '创建时间',
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB CHARACTER SET = utf8 COLLATE = utf8_general_ci COMMENT = '配置修改记录表' ROW_FORMAT = Dynamic;

-- ----------------------------
-- Table structure for daily_report_content
-- ----------------------------
DROP TABLE IF EXISTS `daily_report_content`;
CREATE TABLE `daily_report_content`  (
  `report_id` int(11) NOT NULL COMMENT '报表ID',
  `content` longblob NOT NULL COMMENT '二进制报表内容',
  `period` datetime(0) NULL DEFAULT NULL COMMENT '报表时间段',
  `creation_date` datetime(0) NOT NULL COMMENT '创建时间',
  PRIMARY KEY (`report_id`) USING BTREE,
  INDEX `IX_Period`(`period`) USING BTREE
) ENGINE = InnoDB CHARACTER SET = utf8 COLLATE = utf8_general_ci COMMENT = '天报表二进制内容' ROW_FORMAT = Compressed;

-- ----------------------------
-- Table structure for dailyreport
-- ----------------------------
DROP TABLE IF EXISTS `dailyreport`;
CREATE TABLE `dailyreport`  (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(20) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL COMMENT '报表名称, transaction, problem...',
  `ip` varchar(50) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL COMMENT '报表来自于哪台cat-consumer机器',
  `domain` varchar(50) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL COMMENT '报表处理的Domain信息',
  `period` datetime(0) NOT NULL COMMENT '报表时间段',
  `type` tinyint(4) NOT NULL COMMENT '报表数据格式, 1/xml, 2/json, 默认1',
  `creation_date` datetime(0) NOT NULL COMMENT '报表创建时间',
  PRIMARY KEY (`id`) USING BTREE,
  UNIQUE INDEX `period`(`period`, `domain`, `name`) USING BTREE
) ENGINE = InnoDB CHARACTER SET = utf8 COLLATE = utf8_general_ci COMMENT = '天报表' ROW_FORMAT = Dynamic;

-- ----------------------------
-- Table structure for hostinfo
-- ----------------------------
DROP TABLE IF EXISTS `hostinfo`;
CREATE TABLE `hostinfo`  (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `ip` varchar(50) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL COMMENT '部署机器IP',
  `domain` varchar(200) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL COMMENT '部署机器对应的项目名',
  `hostname` varchar(200) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '机器域名',
  `creation_date` datetime(0) NOT NULL,
  `last_modified_date` datetime(0) NOT NULL,
  PRIMARY KEY (`id`) USING BTREE,
  UNIQUE INDEX `ip_index`(`ip`) USING BTREE
) ENGINE = InnoDB CHARACTER SET = utf8 COLLATE = utf8_general_ci COMMENT = 'IP和项目名的对应关系' ROW_FORMAT = Dynamic;

-- ----------------------------
-- Table structure for hourly_report_content
-- ----------------------------
DROP TABLE IF EXISTS `hourly_report_content`;
CREATE TABLE `hourly_report_content`  (
  `report_id` int(11) NOT NULL COMMENT '报表ID',
  `content` longblob NOT NULL COMMENT '二进制报表内容',
  `period` datetime(0) NOT NULL COMMENT '报表时间段',
  `creation_date` datetime(0) NOT NULL COMMENT '创建时间',
  PRIMARY KEY (`report_id`) USING BTREE,
  INDEX `IX_Period`(`period`) USING BTREE
) ENGINE = InnoDB CHARACTER SET = utf8 COLLATE = utf8_general_ci COMMENT = '小时报表二进制内容' ROW_FORMAT = Compressed;

-- ----------------------------
-- Table structure for hourlyreport
-- ----------------------------
DROP TABLE IF EXISTS `hourlyreport`;
CREATE TABLE `hourlyreport`  (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `type` tinyint(4) NOT NULL COMMENT '报表类型, 1/xml, 9/binary 默认1',
  `name` varchar(20) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL COMMENT '报表名称',
  `ip` varchar(50) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '报表来自于哪台机器',
  `domain` varchar(50) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL COMMENT '报表项目',
  `period` datetime(0) NOT NULL COMMENT '报表时间段',
  `creation_date` datetime(0) NOT NULL COMMENT '报表创建时间',
  PRIMARY KEY (`id`) USING BTREE,
  INDEX `IX_Domain_Name_Period`(`domain`, `name`, `period`) USING BTREE,
  INDEX `IX_Name_Period`(`name`, `period`) USING BTREE,
  INDEX `IX_Period`(`period`) USING BTREE
) ENGINE = InnoDB CHARACTER SET = utf8 COLLATE = utf8_general_ci COMMENT = '用于存放实时报表信息，处理之后的结果' ROW_FORMAT = Compressed;

-- ----------------------------
-- Table structure for metric_graph
-- ----------------------------
DROP TABLE IF EXISTS `metric_graph`;
CREATE TABLE `metric_graph`  (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `graph_id` int(11) NOT NULL COMMENT '大盘ID',
  `name` varchar(50) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL COMMENT '配置ID',
  `content` longtext CHARACTER SET utf8 COLLATE utf8_general_ci NULL COMMENT '配置的具体内容',
  `creation_date` datetime(0) NOT NULL COMMENT '配置创建时间',
  `updatetime` datetime(0) NOT NULL COMMENT '配置修改时间',
  PRIMARY KEY (`id`) USING BTREE,
  UNIQUE INDEX `name`(`name`) USING BTREE
) ENGINE = InnoDB CHARACTER SET = utf8 COLLATE = utf8_general_ci COMMENT = '系统监控的graph配置' ROW_FORMAT = Dynamic;

-- ----------------------------
-- Table structure for metric_screen
-- ----------------------------
DROP TABLE IF EXISTS `metric_screen`;
CREATE TABLE `metric_screen`  (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(50) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL COMMENT '配置名称',
  `graph_name` varchar(50) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL DEFAULT '' COMMENT 'Graph名称',
  `view` varchar(50) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL DEFAULT '' COMMENT '视角',
  `endPoints` longtext CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL,
  `measurements` longtext CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL COMMENT '配置的指标',
  `content` longtext CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL COMMENT '配置的具体内容',
  `creation_date` datetime(0) NOT NULL COMMENT '配置创建时间',
  `updatetime` datetime(0) NOT NULL COMMENT '配置修改时间',
  PRIMARY KEY (`id`) USING BTREE,
  UNIQUE INDEX `name_graph`(`name`, `graph_name`) USING BTREE
) ENGINE = InnoDB CHARACTER SET = utf8 COLLATE = utf8_general_ci COMMENT = '系统监控的screen配置' ROW_FORMAT = Dynamic;

-- ----------------------------
-- Table structure for monthly_report_content
-- ----------------------------
DROP TABLE IF EXISTS `monthly_report_content`;
CREATE TABLE `monthly_report_content`  (
  `report_id` int(11) NOT NULL COMMENT '报表ID',
  `content` longblob NOT NULL COMMENT '二进制报表内容',
  `period` datetime(0) NULL DEFAULT NULL COMMENT '报表时间段',
  `creation_date` datetime(0) NOT NULL COMMENT '创建时间',
  PRIMARY KEY (`report_id`) USING BTREE,
  INDEX `IX_Period`(`period`) USING BTREE
) ENGINE = InnoDB CHARACTER SET = utf8 COLLATE = utf8_general_ci COMMENT = '月报表二进制内容' ROW_FORMAT = Compressed;

-- ----------------------------
-- Table structure for monthreport
-- ----------------------------
DROP TABLE IF EXISTS `monthreport`;
CREATE TABLE `monthreport`  (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(20) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL COMMENT '报表名称, transaction, problem...',
  `ip` varchar(50) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL COMMENT '报表来自于哪台cat-consumer机器',
  `domain` varchar(50) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL COMMENT '报表处理的Domain信息',
  `period` datetime(0) NOT NULL COMMENT '报表时间段',
  `type` tinyint(4) NOT NULL COMMENT '报表数据格式, 1/xml, 2/json, 默认1',
  `creation_date` datetime(0) NOT NULL COMMENT '报表创建时间',
  PRIMARY KEY (`id`) USING BTREE,
  UNIQUE INDEX `period`(`period`, `domain`, `name`) USING BTREE
) ENGINE = InnoDB CHARACTER SET = utf8 COLLATE = utf8_general_ci COMMENT = '月报表' ROW_FORMAT = Dynamic;

-- ----------------------------
-- Table structure for operation
-- ----------------------------
DROP TABLE IF EXISTS `operation`;
CREATE TABLE `operation`  (
  `id` int(11) NOT NULL AUTO_INCREMENT COMMENT '自增长ID',
  `user` varchar(128) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL COMMENT '用户名',
  `module` varchar(128) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL COMMENT '模块',
  `operation` varchar(128) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL COMMENT '操作',
  `time` datetime(0) NOT NULL COMMENT '修改时间',
  `content` longtext CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL COMMENT '修改内容',
  `creation_date` datetime(0) NOT NULL COMMENT '数据插入时间',
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB CHARACTER SET = utf8 COLLATE = utf8_general_ci COMMENT = '用户操作日志' ROW_FORMAT = Dynamic;

-- ----------------------------
-- Table structure for overload
-- ----------------------------
DROP TABLE IF EXISTS `overload`;
CREATE TABLE `overload`  (
  `id` int(11) NOT NULL AUTO_INCREMENT COMMENT '自增长ID',
  `report_id` int(11) NOT NULL COMMENT '报告id',
  `report_type` tinyint(4) NOT NULL COMMENT '报告类型 1:hourly 2:daily 3:weekly 4:monthly',
  `report_size` double NOT NULL COMMENT '报告大小 单位MB',
  `period` datetime(0) NOT NULL COMMENT '报表时间',
  `creation_date` datetime(0) NOT NULL COMMENT '创建时间',
  PRIMARY KEY (`id`) USING BTREE,
  INDEX `period`(`period`) USING BTREE
) ENGINE = InnoDB CHARACTER SET = utf8 COLLATE = utf8_general_ci COMMENT = '过大容量表' ROW_FORMAT = Dynamic;

-- ----------------------------
-- Table structure for project
-- ----------------------------
DROP TABLE IF EXISTS `project`;
CREATE TABLE `project`  (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `domain` varchar(200) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL COMMENT '项目名称',
  `cmdb_domain` varchar(200) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT 'cmdb项目名称',
  `level` int(5) NULL DEFAULT NULL COMMENT '项目级别',
  `bu` varchar(50) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT 'CMDB事业部',
  `cmdb_productline` varchar(50) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT 'CMDB产品线',
  `owner` varchar(50) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '项目负责人',
  `email` longtext CHARACTER SET utf8 COLLATE utf8_general_ci NULL COMMENT '项目组邮件',
  `phone` longtext CHARACTER SET utf8 COLLATE utf8_general_ci NULL COMMENT '联系电话',
  `creation_date` datetime(0) NULL DEFAULT NULL COMMENT '创建时间',
  `modify_date` datetime(0) NULL DEFAULT NULL COMMENT '修改时间',
  PRIMARY KEY (`id`) USING BTREE,
  UNIQUE INDEX `domain`(`domain`) USING BTREE
) ENGINE = InnoDB CHARACTER SET = utf8 COLLATE = utf8_general_ci COMMENT = '项目基本信息' ROW_FORMAT = Dynamic;

-- ----------------------------
-- Table structure for server_alarm_rule
-- ----------------------------
DROP TABLE IF EXISTS `server_alarm_rule`;
CREATE TABLE `server_alarm_rule`  (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `category` varchar(50) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL COMMENT '监控分类',
  `endPoint` varchar(200) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL COMMENT '监控对象ID',
  `measurement` varchar(200) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL COMMENT '监控指标',
  `tags` varchar(200) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL DEFAULT '' COMMENT '监控指标标签',
  `content` longtext CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL COMMENT '配置的具体内容',
  `type` varchar(20) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL DEFAULT '' COMMENT '数据聚合方式',
  `creator` varchar(100) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT '' COMMENT '创建人',
  `creation_date` datetime(0) NOT NULL COMMENT '配置创建时间',
  `updatetime` datetime(0) NOT NULL COMMENT '配置修改时间',
  PRIMARY KEY (`id`) USING BTREE,
  INDEX `updatetime`(`updatetime`) USING BTREE
) ENGINE = InnoDB CHARACTER SET = utf8 COLLATE = utf8_general_ci COMMENT = '系统告警的配置' ROW_FORMAT = Dynamic;

-- ----------------------------
-- Table structure for task
-- ----------------------------
DROP TABLE IF EXISTS `task`;
CREATE TABLE `task`  (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `producer` varchar(20) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL COMMENT '任务创建者ip',
  `consumer` varchar(20) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '任务执行者ip',
  `failure_count` tinyint(4) NOT NULL COMMENT '任务失败次数',
  `report_name` varchar(20) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL COMMENT '报表名称, transaction, problem...',
  `report_domain` varchar(50) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL COMMENT '报表处理的Domain信息',
  `report_period` datetime(0) NOT NULL COMMENT '报表时间',
  `status` tinyint(4) NOT NULL COMMENT '执行状态: 1/todo, 2/doing, 3/done 4/failed',
  `task_type` tinyint(4) NOT NULL DEFAULT 1 COMMENT '0表示小时任务，1表示天任务',
  `creation_date` datetime(0) NOT NULL COMMENT '任务创建时间',
  `start_date` datetime(0) NULL DEFAULT NULL COMMENT '开始时间, 这次执行开始时间',
  `end_date` datetime(0) NULL DEFAULT NULL COMMENT '结束时间, 这次执行结束时间',
  PRIMARY KEY (`id`) USING BTREE,
  UNIQUE INDEX `task_period_domain_name_type`(`report_period`, `report_domain`, `report_name`, `task_type`) USING BTREE
) ENGINE = InnoDB CHARACTER SET = utf8 COLLATE = utf8_general_ci COMMENT = '后台任务' ROW_FORMAT = Dynamic;

-- ----------------------------
-- Table structure for topologyGraph
-- ----------------------------
DROP TABLE IF EXISTS `topologyGraph`;
CREATE TABLE `topologyGraph`  (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `ip` varchar(50) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL COMMENT '报表来自于哪台cat-client机器ip',
  `period` datetime(0) NOT NULL COMMENT '报表时间段,精确到分钟',
  `type` tinyint(4) NOT NULL COMMENT '报表数据格式, 1/xml, 2/json, 3/binary',
  `content` longblob NULL COMMENT '用于存放报表的具体内容',
  `creation_date` datetime(0) NOT NULL COMMENT '报表创建时间',
  PRIMARY KEY (`id`) USING BTREE,
  INDEX `period`(`period`) USING BTREE
) ENGINE = InnoDB CHARACTER SET = utf8 COLLATE = utf8_general_ci COMMENT = '用于存储历史的拓扑图曲线' ROW_FORMAT = Dynamic;

-- ----------------------------
-- Table structure for user_define_rule
-- ----------------------------
DROP TABLE IF EXISTS `user_define_rule`;
CREATE TABLE `user_define_rule`  (
  `id` int(11) NOT NULL AUTO_INCREMENT COMMENT '自增长ID',
  `content` text CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL COMMENT '用户定义规则',
  `creation_date` datetime(0) NOT NULL COMMENT '创建时间',
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB CHARACTER SET = utf8 COLLATE = utf8_general_ci COMMENT = '用户定义规则表' ROW_FORMAT = Dynamic;

-- ----------------------------
-- Table structure for weekly_report_content
-- ----------------------------
DROP TABLE IF EXISTS `weekly_report_content`;
CREATE TABLE `weekly_report_content`  (
  `report_id` int(11) NOT NULL COMMENT '报表ID',
  `content` longblob NOT NULL COMMENT '二进制报表内容',
  `period` datetime(0) NULL DEFAULT NULL COMMENT '报表时间段',
  `creation_date` datetime(0) NOT NULL COMMENT '创建时间',
  PRIMARY KEY (`report_id`) USING BTREE,
  INDEX `IX_Period`(`period`) USING BTREE
) ENGINE = InnoDB CHARACTER SET = utf8 COLLATE = utf8_general_ci COMMENT = '周报表二进制内容' ROW_FORMAT = Compressed;

-- ----------------------------
-- Table structure for weeklyreport
-- ----------------------------
DROP TABLE IF EXISTS `weeklyreport`;
CREATE TABLE `weeklyreport`  (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(20) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL COMMENT '报表名称, transaction, problem...',
  `ip` varchar(50) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL COMMENT '报表来自于哪台cat-consumer机器',
  `domain` varchar(50) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL COMMENT '报表处理的Domain信息',
  `period` datetime(0) NOT NULL COMMENT '报表时间段',
  `type` tinyint(4) NOT NULL COMMENT '报表数据格式, 1/xml, 2/json, 默认1',
  `creation_date` datetime(0) NOT NULL COMMENT '报表创建时间',
  PRIMARY KEY (`id`) USING BTREE,
  UNIQUE INDEX `period`(`period`, `domain`, `name`) USING BTREE
) ENGINE = InnoDB CHARACTER SET = utf8 COLLATE = utf8_general_ci COMMENT = '周报表' ROW_FORMAT = Dynamic;

SET FOREIGN_KEY_CHECKS = 1;
