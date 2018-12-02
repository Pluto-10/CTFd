/*
 Navicat Premium Data Transfer

 Source Server         : localhost_123456
 Source Server Type    : MySQL
 Source Server Version : 50560
 Source Host           : localhost:3306
 Source Schema         : ctfb

 Target Server Type    : MySQL
 Target Server Version : 50560
 File Encoding         : 65001

 Date: 19/07/2018 10:44:13
*/

SET NAMES utf8mb4;
SET FOREIGN_KEY_CHECKS = 0;

-- ----------------------------
-- Table structure for alembic_version
-- ----------------------------
DROP TABLE IF EXISTS `alembic_version`;
CREATE TABLE `alembic_version`  (
  `version_num` varchar(32) CHARACTER SET utf8mb4 COLLATE utf8mb4_bin NOT NULL,
  PRIMARY KEY (`version_num`) USING BTREE
) ENGINE = InnoDB CHARACTER SET = utf8mb4 COLLATE = utf8mb4_bin ROW_FORMAT = Compact;

-- ----------------------------
-- Table structure for awards
-- ----------------------------
DROP TABLE IF EXISTS `awards`;
CREATE TABLE `awards`  (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `teamid` int(11) NULL DEFAULT NULL,
  `name` varchar(80) CHARACTER SET utf8mb4 COLLATE utf8mb4_bin NULL DEFAULT NULL,
  `description` text CHARACTER SET utf8mb4 COLLATE utf8mb4_bin NULL,
  `date` datetime NULL DEFAULT NULL,
  `value` int(11) NULL DEFAULT NULL,
  `category` varchar(80) CHARACTER SET utf8mb4 COLLATE utf8mb4_bin NULL DEFAULT NULL,
  `icon` text CHARACTER SET utf8mb4 COLLATE utf8mb4_bin NULL,
  PRIMARY KEY (`id`) USING BTREE,
  INDEX `teamid`(`teamid`) USING BTREE,
  CONSTRAINT `awards_ibfk_1` FOREIGN KEY (`teamid`) REFERENCES `teams` (`id`) ON DELETE RESTRICT ON UPDATE RESTRICT
) ENGINE = InnoDB AUTO_INCREMENT = 1 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_bin ROW_FORMAT = Compact;

-- ----------------------------
-- Table structure for challenges
-- ----------------------------
DROP TABLE IF EXISTS `challenges`;
CREATE TABLE `challenges`  (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(80) CHARACTER SET utf8mb4 COLLATE utf8mb4_bin NULL DEFAULT NULL,
  `description` text CHARACTER SET utf8mb4 COLLATE utf8mb4_bin NULL,
  `value` int(11) NULL DEFAULT NULL,
  `category` varchar(80) CHARACTER SET utf8mb4 COLLATE utf8mb4_bin NULL DEFAULT NULL,
  `hidden` tinyint(1) NULL DEFAULT NULL,
  `type` varchar(80) CHARACTER SET utf8mb4 COLLATE utf8mb4_bin NULL DEFAULT NULL,
  `max_attempts` int(11) NULL DEFAULT NULL,
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 4 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_bin ROW_FORMAT = Compact;

-- ----------------------------
-- Table structure for config
-- ----------------------------
DROP TABLE IF EXISTS `config`;
CREATE TABLE `config`  (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `key` text CHARACTER SET utf8mb4 COLLATE utf8mb4_bin NULL,
  `value` text CHARACTER SET utf8mb4 COLLATE utf8mb4_bin NULL,
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 33 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_bin ROW_FORMAT = Compact;

-- ----------------------------
-- Table structure for files
-- ----------------------------
DROP TABLE IF EXISTS `files`;
CREATE TABLE `files`  (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `chal` int(11) NULL DEFAULT NULL,
  `location` text CHARACTER SET utf8mb4 COLLATE utf8mb4_bin NULL,
  PRIMARY KEY (`id`) USING BTREE,
  INDEX `chal`(`chal`) USING BTREE,
  CONSTRAINT `files_ibfk_1` FOREIGN KEY (`chal`) REFERENCES `challenges` (`id`) ON DELETE RESTRICT ON UPDATE RESTRICT
) ENGINE = InnoDB AUTO_INCREMENT = 3 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_bin ROW_FORMAT = Compact;

-- ----------------------------
-- Table structure for hints
-- ----------------------------
DROP TABLE IF EXISTS `hints`;
CREATE TABLE `hints`  (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `type` int(11) NULL DEFAULT NULL,
  `chal` int(11) NULL DEFAULT NULL,
  `hint` text CHARACTER SET utf8mb4 COLLATE utf8mb4_bin NULL,
  `cost` int(11) NULL DEFAULT NULL,
  PRIMARY KEY (`id`) USING BTREE,
  INDEX `chal`(`chal`) USING BTREE,
  CONSTRAINT `hints_ibfk_1` FOREIGN KEY (`chal`) REFERENCES `challenges` (`id`) ON DELETE RESTRICT ON UPDATE RESTRICT
) ENGINE = InnoDB AUTO_INCREMENT = 1 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_bin ROW_FORMAT = Compact;

-- ----------------------------
-- Table structure for keys
-- ----------------------------
DROP TABLE IF EXISTS `keys`;
CREATE TABLE `keys`  (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `chal` int(11) NULL DEFAULT NULL,
  `type` varchar(80) CHARACTER SET utf8mb4 COLLATE utf8mb4_bin NULL DEFAULT NULL,
  `flag` text CHARACTER SET utf8mb4 COLLATE utf8mb4_bin NULL,
  `data` text CHARACTER SET utf8mb4 COLLATE utf8mb4_bin NULL,
  PRIMARY KEY (`id`) USING BTREE,
  INDEX `chal`(`chal`) USING BTREE,
  CONSTRAINT `keys_ibfk_1` FOREIGN KEY (`chal`) REFERENCES `challenges` (`id`) ON DELETE RESTRICT ON UPDATE RESTRICT
) ENGINE = InnoDB AUTO_INCREMENT = 4 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_bin ROW_FORMAT = Compact;

-- ----------------------------
-- Table structure for pages
-- ----------------------------
DROP TABLE IF EXISTS `pages`;
CREATE TABLE `pages`  (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `route` varchar(80) CHARACTER SET utf8mb4 COLLATE utf8mb4_bin NULL DEFAULT NULL,
  `html` text CHARACTER SET utf8mb4 COLLATE utf8mb4_bin NULL,
  `auth_required` tinyint(1) NULL DEFAULT NULL,
  `draft` tinyint(1) NULL DEFAULT NULL,
  `title` varchar(80) CHARACTER SET utf8mb4 COLLATE utf8mb4_bin NULL DEFAULT NULL,
  PRIMARY KEY (`id`) USING BTREE,
  UNIQUE INDEX `route`(`route`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 4 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_bin ROW_FORMAT = Compact;

-- ----------------------------
-- Table structure for solves
-- ----------------------------
DROP TABLE IF EXISTS `solves`;
CREATE TABLE `solves`  (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `chalid` int(11) NULL DEFAULT NULL,
  `teamid` int(11) NULL DEFAULT NULL,
  `ip` varchar(46) CHARACTER SET utf8mb4 COLLATE utf8mb4_bin NULL DEFAULT NULL,
  `flag` text CHARACTER SET utf8mb4 COLLATE utf8mb4_bin NULL,
  `date` datetime NULL DEFAULT NULL,
  PRIMARY KEY (`id`) USING BTREE,
  UNIQUE INDEX `chalid`(`chalid`, `teamid`) USING BTREE,
  INDEX `teamid`(`teamid`) USING BTREE,
  CONSTRAINT `solves_ibfk_1` FOREIGN KEY (`chalid`) REFERENCES `challenges` (`id`) ON DELETE RESTRICT ON UPDATE RESTRICT,
  CONSTRAINT `solves_ibfk_2` FOREIGN KEY (`teamid`) REFERENCES `teams` (`id`) ON DELETE RESTRICT ON UPDATE RESTRICT
) ENGINE = InnoDB AUTO_INCREMENT = 11 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_bin ROW_FORMAT = Compact;

-- ----------------------------
-- Table structure for tags
-- ----------------------------
DROP TABLE IF EXISTS `tags`;
CREATE TABLE `tags`  (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `chal` int(11) NULL DEFAULT NULL,
  `tag` varchar(80) CHARACTER SET utf8mb4 COLLATE utf8mb4_bin NULL DEFAULT NULL,
  PRIMARY KEY (`id`) USING BTREE,
  INDEX `chal`(`chal`) USING BTREE,
  CONSTRAINT `tags_ibfk_1` FOREIGN KEY (`chal`) REFERENCES `challenges` (`id`) ON DELETE RESTRICT ON UPDATE RESTRICT
) ENGINE = InnoDB AUTO_INCREMENT = 1 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_bin ROW_FORMAT = Compact;

-- ----------------------------
-- Table structure for teams
-- ----------------------------
DROP TABLE IF EXISTS `teams`;
CREATE TABLE `teams`  (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(128) CHARACTER SET utf8mb4 COLLATE utf8mb4_bin NULL DEFAULT NULL,
  `email` varchar(128) CHARACTER SET utf8mb4 COLLATE utf8mb4_bin NULL DEFAULT NULL,
  `password` varchar(128) CHARACTER SET utf8mb4 COLLATE utf8mb4_bin NULL DEFAULT NULL,
  `website` varchar(128) CHARACTER SET utf8mb4 COLLATE utf8mb4_bin NULL DEFAULT NULL,
  `affiliation` varchar(128) CHARACTER SET utf8mb4 COLLATE utf8mb4_bin NULL DEFAULT NULL,
  `country` varchar(32) CHARACTER SET utf8mb4 COLLATE utf8mb4_bin NULL DEFAULT NULL,
  `bracket` varchar(32) CHARACTER SET utf8mb4 COLLATE utf8mb4_bin NULL DEFAULT NULL,
  `banned` tinyint(1) NULL DEFAULT NULL,
  `verified` tinyint(1) NULL DEFAULT NULL,
  `admin` tinyint(1) NULL DEFAULT NULL,
  `joined` datetime NULL DEFAULT NULL,
  `solves_count` int(255) NULL DEFAULT 0,
  PRIMARY KEY (`id`) USING BTREE,
  UNIQUE INDEX `email`(`email`) USING BTREE,
  UNIQUE INDEX `name`(`name`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 6 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_bin ROW_FORMAT = Compact;

-- ----------------------------
-- Table structure for tracking
-- ----------------------------
DROP TABLE IF EXISTS `tracking`;
CREATE TABLE `tracking`  (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `ip` varchar(46) CHARACTER SET utf8mb4 COLLATE utf8mb4_bin NULL DEFAULT NULL,
  `team` int(11) NULL DEFAULT NULL,
  `date` datetime NULL DEFAULT NULL,
  PRIMARY KEY (`id`) USING BTREE,
  INDEX `team`(`team`) USING BTREE,
  CONSTRAINT `tracking_ibfk_1` FOREIGN KEY (`team`) REFERENCES `teams` (`id`) ON DELETE RESTRICT ON UPDATE RESTRICT
) ENGINE = InnoDB AUTO_INCREMENT = 6 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_bin ROW_FORMAT = Compact;

-- ----------------------------
-- Table structure for unlocks
-- ----------------------------
DROP TABLE IF EXISTS `unlocks`;
CREATE TABLE `unlocks`  (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `teamid` int(11) NULL DEFAULT NULL,
  `date` datetime NULL DEFAULT NULL,
  `itemid` int(11) NULL DEFAULT NULL,
  `model` varchar(32) CHARACTER SET utf8mb4 COLLATE utf8mb4_bin NULL DEFAULT NULL,
  PRIMARY KEY (`id`) USING BTREE,
  INDEX `teamid`(`teamid`) USING BTREE,
  CONSTRAINT `unlocks_ibfk_1` FOREIGN KEY (`teamid`) REFERENCES `teams` (`id`) ON DELETE RESTRICT ON UPDATE RESTRICT
) ENGINE = InnoDB AUTO_INCREMENT = 1 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_bin ROW_FORMAT = Compact;

-- ----------------------------
-- Table structure for wrong_keys
-- ----------------------------
DROP TABLE IF EXISTS `wrong_keys`;
CREATE TABLE `wrong_keys`  (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `chalid` int(11) NULL DEFAULT NULL,
  `teamid` int(11) NULL DEFAULT NULL,
  `date` datetime NULL DEFAULT NULL,
  `flag` text CHARACTER SET utf8mb4 COLLATE utf8mb4_bin NULL,
  `ip` varchar(46) CHARACTER SET utf8mb4 COLLATE utf8mb4_bin NULL DEFAULT NULL,
  PRIMARY KEY (`id`) USING BTREE,
  INDEX `chalid`(`chalid`) USING BTREE,
  INDEX `teamid`(`teamid`) USING BTREE,
  CONSTRAINT `wrong_keys_ibfk_1` FOREIGN KEY (`chalid`) REFERENCES `challenges` (`id`) ON DELETE RESTRICT ON UPDATE RESTRICT,
  CONSTRAINT `wrong_keys_ibfk_2` FOREIGN KEY (`teamid`) REFERENCES `teams` (`id`) ON DELETE RESTRICT ON UPDATE RESTRICT
) ENGINE = InnoDB AUTO_INCREMENT = 1 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_bin ROW_FORMAT = Compact;

-- ----------------------------
-- Triggers structure for table solves
-- ----------------------------
DROP TRIGGER IF EXISTS `solves_abb1`;
delimiter ;;
CREATE TRIGGER `solves_abb1` AFTER INSERT ON `solves` FOR EACH ROW BEGIN
UPDATE teams SET teams.solves_count=solves_count+1 WHERE teams.id=new.teamid;
END
;;
delimiter ;

SET FOREIGN_KEY_CHECKS = 1;
