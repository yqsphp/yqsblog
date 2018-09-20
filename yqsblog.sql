/*
Navicat MySQL Data Transfer

Source Server         : localhost[127.0.0.1]
Source Server Version : 50553
Source Host           : localhost:3306
Source Database       : yqsblog

Target Server Type    : MYSQL
Target Server Version : 50553
File Encoding         : 65001

Date: 2018-09-20 16:38:09
*/

SET FOREIGN_KEY_CHECKS=0;

-- ----------------------------
-- Table structure for myblog_admin
-- ----------------------------
DROP TABLE IF EXISTS `myblog_admin`;
CREATE TABLE `myblog_admin` (
  `id` int(11) unsigned NOT NULL AUTO_INCREMENT COMMENT '主键自增',
  `truename` varchar(100) NOT NULL COMMENT '真实姓名',
  `sex` tinyint(1) DEFAULT NULL COMMENT '性别 1.男，0.女',
  `name` varchar(255) NOT NULL COMMENT '用户名昵称',
  `pass` varchar(255) NOT NULL COMMENT '用户密码',
  `mail` varchar(255) NOT NULL COMMENT '邮箱',
  `status` tinyint(1) NOT NULL DEFAULT '1' COMMENT '状态：1.正常，0.禁用',
  `groupid` varchar(100) NOT NULL COMMENT '用户组id',
  `lastip` varchar(15) NOT NULL COMMENT '最后登录ip',
  `lasttime` datetime DEFAULT NULL COMMENT '最后登陆时间',
  PRIMARY KEY (`id`)
) ENGINE=MyISAM AUTO_INCREMENT=12 DEFAULT CHARSET=utf8 COMMENT='管理员表';

-- ----------------------------
-- Records of myblog_admin
-- ----------------------------
INSERT INTO `myblog_admin` VALUES ('1', '超级管理员', '0', 'admin', '5d8446fee40b639d88772375d6dc86e2', '', '1', '1', '127.0.0.1', '2018-09-20 08:51:10');
INSERT INTO `myblog_admin` VALUES ('6', '何', '0', 'hjx', '87d9bb400c0634691f0e3baaf1e2fd0d', '', '1', '2', '127.0.0.1', '2018-08-17 09:11:21');
INSERT INTO `myblog_admin` VALUES ('11', '郭学良', '1', 'gxl', '87d9bb400c0634691f0e3baaf1e2fd0d', '', '1', '11', '127.0.0.1', '2018-09-11 13:28:18');

-- ----------------------------
-- Table structure for myblog_advert
-- ----------------------------
DROP TABLE IF EXISTS `myblog_advert`;
CREATE TABLE `myblog_advert` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(255) NOT NULL COMMENT '广告位名称',
  `image` varchar(100) NOT NULL COMMENT '图片',
  `height` double NOT NULL COMMENT '高度',
  `width` double NOT NULL COMMENT '宽度',
  `url` varchar(255) NOT NULL COMMENT '跳转地址',
  `ctime` timestamp NULL DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
  `cate` varchar(2) NOT NULL COMMENT '分类：1.轮播图，2.左侧侧边栏，3.右侧侧边栏，4.中间栏，5.底部（二维码等）',
  `isshow` tinyint(1) NOT NULL DEFAULT '1' COMMENT '是否显示：1.是，0.否',
  `isdel` tinyint(1) NOT NULL DEFAULT '0' COMMENT '是否删除：1.是，0.否',
  PRIMARY KEY (`id`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8 COMMENT='广告位表';

-- ----------------------------
-- Records of myblog_advert
-- ----------------------------

-- ----------------------------
-- Table structure for myblog_article
-- ----------------------------
DROP TABLE IF EXISTS `myblog_article`;
CREATE TABLE `myblog_article` (
  `id` mediumint(8) unsigned NOT NULL AUTO_INCREMENT,
  `catid` smallint(5) unsigned NOT NULL DEFAULT '0' COMMENT '类别表id',
  `name` varchar(160) NOT NULL DEFAULT '' COMMENT '标题',
  `seo` varchar(255) DEFAULT NULL COMMENT 'seo搜索',
  `keywords` varchar(40) NOT NULL DEFAULT '' COMMENT '关键字',
  `description` mediumtext NOT NULL COMMENT '描述',
  `editorid` int(2) DEFAULT NULL COMMENT '编辑人id',
  `editor` varchar(20) NOT NULL DEFAULT '' COMMENT '编辑人',
  `order` tinyint(3) unsigned NOT NULL DEFAULT '0' COMMENT '文章排序',
  `ctime` varchar(11) NOT NULL COMMENT '创建时间',
  `utime` varchar(11) NOT NULL COMMENT '更新时间',
  `ptime` varchar(11) NOT NULL COMMENT '发布时间',
  `status` tinyint(1) NOT NULL DEFAULT '2' COMMENT '发布状态: 0未发布, 1 已发布, 2 草稿, 3 撤回',
  `hits` int(11) NOT NULL DEFAULT '0' COMMENT '点击总数',
  `content` mediumtext NOT NULL COMMENT '内容目录',
  `image` varchar(255) NOT NULL COMMENT '文章图片',
  `recommend` tinyint(1) NOT NULL DEFAULT '0' COMMENT '推荐：1.是，0.否',
  `settop` tinyint(4) NOT NULL DEFAULT '0' COMMENT '置顶：1.是，0.否',
  `weixin` tinyint(1) NOT NULL DEFAULT '1' COMMENT '微信终端 显示与否 0 否 1是',
  `pc` tinyint(1) NOT NULL DEFAULT '1' COMMENT 'pc显示与否 0否 1是',
  `mobile` tinyint(1) NOT NULL DEFAULT '1' COMMENT '手机网站 显示与否 0 否 1是',
  `app` tinyint(1) NOT NULL DEFAULT '1' COMMENT 'app终端 显示与否 0 否 1是',
  `wshort` tinyint(1) unsigned NOT NULL DEFAULT '1' COMMENT '小程序终端 显示与否 0 否 1是',
  `isshow` tinyint(1) NOT NULL DEFAULT '1' COMMENT '是否显示 1是 0否',
  `isdel` tinyint(1) NOT NULL DEFAULT '0' COMMENT '是否删除 1是 0否',
  `copyfrom` varchar(255) NOT NULL COMMENT '文章来源',
  PRIMARY KEY (`id`),
  KEY `status` (`order`,`id`),
  KEY `listorder` (`catid`,`order`,`id`),
  KEY `catid` (`catid`,`id`),
  KEY `titles` (`name`) USING BTREE
) ENGINE=MyISAM DEFAULT CHARSET=utf8 COMMENT='文章表';

-- ----------------------------
-- Records of myblog_article
-- ----------------------------

-- ----------------------------
-- Table structure for myblog_attachment
-- ----------------------------
DROP TABLE IF EXISTS `myblog_attachment`;
CREATE TABLE `myblog_attachment` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(255) NOT NULL COMMENT '附件名称',
  `path` varchar(255) NOT NULL COMMENT '附件路径',
  `path_thumb` varchar(255) NOT NULL COMMENT '缩略图',
  `size` decimal(20,2) NOT NULL COMMENT '大小 （KB）',
  `ext` varchar(10) NOT NULL COMMENT '文件后缀',
  `isvideo` tinyint(1) NOT NULL DEFAULT '0' COMMENT '是否视频文件：1.是，0.否',
  `aid` int(11) NOT NULL COMMENT '外键对应表id',
  `atable` varchar(255) NOT NULL COMMENT '外键表名',
  `iswx` tinyint(1) NOT NULL DEFAULT '0' COMMENT '是否微信素材:1.是，0.否',
  `ctime` date DEFAULT NULL COMMENT '添加时间',
  `isdel` tinyint(1) NOT NULL DEFAULT '0' COMMENT '是否删除：1.是，0.否',
  PRIMARY KEY (`id`),
  KEY `文章id` (`aid`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8 COMMENT='附件表';

-- ----------------------------
-- Records of myblog_attachment
-- ----------------------------

-- ----------------------------
-- Table structure for myblog_auth_access
-- ----------------------------
DROP TABLE IF EXISTS `myblog_auth_access`;
CREATE TABLE `myblog_auth_access` (
  `id` int(11) NOT NULL AUTO_INCREMENT COMMENT '主键自增',
  `uid` int(11) unsigned NOT NULL COMMENT '用户id',
  `group_id` int(11) unsigned NOT NULL COMMENT '用户组id',
  PRIMARY KEY (`id`),
  UNIQUE KEY `uid_group_id` (`uid`,`group_id`),
  KEY `uid` (`uid`),
  KEY `group_id` (`group_id`)
) ENGINE=MyISAM AUTO_INCREMENT=21 DEFAULT CHARSET=utf8 COMMENT='用户组明细表';

-- ----------------------------
-- Records of myblog_auth_access
-- ----------------------------
INSERT INTO `myblog_auth_access` VALUES ('1', '1', '1');
INSERT INTO `myblog_auth_access` VALUES ('2', '6', '2');
INSERT INTO `myblog_auth_access` VALUES ('20', '11', '11');

-- ----------------------------
-- Table structure for myblog_auth_group
-- ----------------------------
DROP TABLE IF EXISTS `myblog_auth_group`;
CREATE TABLE `myblog_auth_group` (
  `id` int(11) unsigned NOT NULL AUTO_INCREMENT,
  `title` char(100) NOT NULL DEFAULT '' COMMENT '用户组中文名称',
  `status` tinyint(1) NOT NULL DEFAULT '1' COMMENT '状态：1：启用，0：禁用',
  `rules` text COMMENT '规则id 多个规则","隔开',
  PRIMARY KEY (`id`)
) ENGINE=MyISAM AUTO_INCREMENT=12 DEFAULT CHARSET=utf8 COMMENT='用户组表';

-- ----------------------------
-- Records of myblog_auth_group
-- ----------------------------
INSERT INTO `myblog_auth_group` VALUES ('1', '超级管理员', '1', '1,4,5,52,90,91,92,69,78,79,80,81,2,6,7,8,9,10,11,12,13,14,15,16,17,53,54,55,56,58,59,60,61,62,63,64,68,77,100,101,82,83,84,85,86,3,18,19,20,21,22,28,23,24,25,26,27,29,30,31,32,65,75,76,99,33,49,50,87,88,89,37,38,41,42,43,47,93,39,44,45,46,94,95,96,97,98,67,51,72,73,74,66,70,71');
INSERT INTO `myblog_auth_group` VALUES ('2', '网站编辑', '1', '1,4,5,52,90,91,69,78,79,81,2,6,7,8,10,11,12,13,14,15,16,58,59,60,68,100,101');
INSERT INTO `myblog_auth_group` VALUES ('10', '文案', '1', null);
INSERT INTO `myblog_auth_group` VALUES ('11', '留言管理员', '1', '67,51,72,73,74,66,70,71');

-- ----------------------------
-- Table structure for myblog_auth_rule
-- ----------------------------
DROP TABLE IF EXISTS `myblog_auth_rule`;
CREATE TABLE `myblog_auth_rule` (
  `id` int(11) unsigned NOT NULL AUTO_INCREMENT,
  `pid` int(11) unsigned NOT NULL DEFAULT '0' COMMENT '父级id',
  `name` char(80) NOT NULL DEFAULT '' COMMENT '规则唯一标识，如：Admin/article/index',
  `title` char(20) NOT NULL DEFAULT '' COMMENT '规则中文名称',
  `type` tinyint(1) NOT NULL DEFAULT '1',
  `status` tinyint(1) NOT NULL DEFAULT '1' COMMENT '状态：1：启用，0：禁用',
  `condition` char(100) NOT NULL DEFAULT '' COMMENT '规则表达式，为空表示存在就验证，不为空表示按照条件验证\r\n自定义三级操作：\r\n1.添加，2.编辑，3.查看，4.还原，5.删除',
  `isdel` tinyint(1) NOT NULL DEFAULT '0' COMMENT '是否删除：1：是，0：否',
  PRIMARY KEY (`id`)
) ENGINE=MyISAM AUTO_INCREMENT=102 DEFAULT CHARSET=utf8 COMMENT='规则表';

-- ----------------------------
-- Records of myblog_auth_rule
-- ----------------------------
INSERT INTO `myblog_auth_rule` VALUES ('1', '0', '', '基本设置', '1', '1', '', '0');
INSERT INTO `myblog_auth_rule` VALUES ('2', '0', '', '栏目管理', '1', '1', '', '0');
INSERT INTO `myblog_auth_rule` VALUES ('3', '0', '', '系统设置', '1', '1', '', '0');
INSERT INTO `myblog_auth_rule` VALUES ('4', '1', 'index/info', '网站设置', '1', '1', '', '0');
INSERT INTO `myblog_auth_rule` VALUES ('5', '1', 'index/userpass', '修改密码', '1', '1', '', '0');
INSERT INTO `myblog_auth_rule` VALUES ('6', '2', 'article/artlist', '内容编辑', '1', '1', '2', '0');
INSERT INTO `myblog_auth_rule` VALUES ('7', '6', 'article/artedit', '添加内容', '1', '1', '1', '0');
INSERT INTO `myblog_auth_rule` VALUES ('8', '6', 'article/artedit', '文章修改', '1', '1', '2', '0');
INSERT INTO `myblog_auth_rule` VALUES ('9', '6', 'article/artdel', '文章删除', '1', '1', '5', '0');
INSERT INTO `myblog_auth_rule` VALUES ('10', '2', 'article/artpublish', '内容发布', '1', '1', '', '0');
INSERT INTO `myblog_auth_rule` VALUES ('11', '10', 'article/artpublish', '文章发布', '1', '1', '2', '0');
INSERT INTO `myblog_auth_rule` VALUES ('12', '10', 'article/artpublish', '文章撤回', '1', '1', '4', '0');
INSERT INTO `myblog_auth_rule` VALUES ('13', '10', 'article/artpublish', '文章取消', '1', '1', '', '0');
INSERT INTO `myblog_auth_rule` VALUES ('14', '2', 'article/catlist', '类别管理', '1', '1', '', '0');
INSERT INTO `myblog_auth_rule` VALUES ('15', '14', 'article/catedit', '添加类别', '1', '1', '1', '0');
INSERT INTO `myblog_auth_rule` VALUES ('16', '14', 'article/catedit', '类别修改', '1', '1', '2', '0');
INSERT INTO `myblog_auth_rule` VALUES ('17', '14', 'article/catdel', '类别删除', '1', '1', '5', '0');
INSERT INTO `myblog_auth_rule` VALUES ('18', '3', 'rule/grouplist', '角色管理', '1', '1', '', '0');
INSERT INTO `myblog_auth_rule` VALUES ('19', '18', 'rule/groupedit', '添加角色', '1', '1', '1', '0');
INSERT INTO `myblog_auth_rule` VALUES ('20', '18', 'rule/groupedit', '角色修改', '1', '1', '2', '0');
INSERT INTO `myblog_auth_rule` VALUES ('21', '18', 'rule/adminedit', '添加成员', '1', '1', '1', '0');
INSERT INTO `myblog_auth_rule` VALUES ('22', '18', 'rule/groupdel', '角色删除', '1', '1', '5', '0');
INSERT INTO `myblog_auth_rule` VALUES ('23', '3', 'rule/adminlist', '用户列表', '1', '1', '', '0');
INSERT INTO `myblog_auth_rule` VALUES ('24', '23', 'rule/adminedit', '添加用户', '1', '1', '1', '0');
INSERT INTO `myblog_auth_rule` VALUES ('25', '23', 'rule/adminedit', '用户修改', '1', '1', '2', '0');
INSERT INTO `myblog_auth_rule` VALUES ('26', '23', 'rule/admindel', '用户删除', '1', '1', '5', '0');
INSERT INTO `myblog_auth_rule` VALUES ('27', '3', 'rule/rulelist', '权限管理', '1', '1', '', '0');
INSERT INTO `myblog_auth_rule` VALUES ('28', '18', 'rule/rulegroup', '权限分配', '1', '1', '', '0');
INSERT INTO `myblog_auth_rule` VALUES ('29', '27', 'rule/ruleedit', '添加权限', '1', '1', '1', '0');
INSERT INTO `myblog_auth_rule` VALUES ('30', '27', 'rule/ruleedit', '添加子菜单', '1', '1', '1', '0');
INSERT INTO `myblog_auth_rule` VALUES ('31', '27', 'rule/ruleedit', '菜单修改', '1', '1', '2', '0');
INSERT INTO `myblog_auth_rule` VALUES ('32', '27', 'rule/ruledel', '菜单删除', '1', '1', '5', '0');
INSERT INTO `myblog_auth_rule` VALUES ('33', '0', '', '数据库管理', '1', '1', '', '0');
INSERT INTO `myblog_auth_rule` VALUES ('87', '50', 'backups/del_backups', '数据删除', '1', '1', '5', '0');
INSERT INTO `myblog_auth_rule` VALUES ('88', '50', 'backups/download', '数据下载', '1', '1', '3', '0');
INSERT INTO `myblog_auth_rule` VALUES ('89', '50', 'backups/import', '数据还原', '1', '1', '4', '0');
INSERT INTO `myblog_auth_rule` VALUES ('37', '0', '', '微信管理', '1', '1', '', '0');
INSERT INTO `myblog_auth_rule` VALUES ('38', '37', 'wechatAccount/index', '管理账号', '1', '1', '', '0');
INSERT INTO `myblog_auth_rule` VALUES ('39', '37', 'wechatReply/index', '关键字回复', '1', '1', '', '0');
INSERT INTO `myblog_auth_rule` VALUES ('94', '37', 'wechatResource/source_list', '素材管理', '1', '1', '', '0');
INSERT INTO `myblog_auth_rule` VALUES ('41', '38', 'wechatAccount/accountedit', '添加账号', '1', '1', '1', '0');
INSERT INTO `myblog_auth_rule` VALUES ('42', '38', 'wechatAccount/accountedit', '账号修改', '1', '1', '2', '0');
INSERT INTO `myblog_auth_rule` VALUES ('43', '38', 'wechatAccount/accountdel', '账号删除', '1', '1', '5', '0');
INSERT INTO `myblog_auth_rule` VALUES ('44', '39', 'wechatReply/keyedit', '添加关键字', '1', '1', '1', '0');
INSERT INTO `myblog_auth_rule` VALUES ('45', '39', 'wechatReply/keyedit', '关键字修改', '1', '1', '2', '0');
INSERT INTO `myblog_auth_rule` VALUES ('46', '39', 'wechatReply/keydel', '关键字删除', '1', '1', '5', '0');
INSERT INTO `myblog_auth_rule` VALUES ('47', '38', 'wechat/reply', '账号回复', '1', '1', '2', '0');
INSERT INTO `myblog_auth_rule` VALUES ('48', '2', 'comments/index', '评论管理', '1', '1', '', '1');
INSERT INTO `myblog_auth_rule` VALUES ('49', '33', 'backups/backups', '数据备份', '1', '1', '', '0');
INSERT INTO `myblog_auth_rule` VALUES ('50', '33', 'backups/index', '数据还原', '1', '1', '', '0');
INSERT INTO `myblog_auth_rule` VALUES ('51', '67', 'message/index', '用户留言', '1', '1', '', '0');
INSERT INTO `myblog_auth_rule` VALUES ('52', '1', 'index/firendsurl', '友情链接', '1', '1', '', '0');
INSERT INTO `myblog_auth_rule` VALUES ('54', '53', 'expert/expert_edit', '专家添加', '1', '1', '1', '0');
INSERT INTO `myblog_auth_rule` VALUES ('55', '53', 'expert/expert_edit', '专家修改', '1', '1', '2', '0');
INSERT INTO `myblog_auth_rule` VALUES ('56', '53', 'expert/expert_del', '专家删除', '1', '1', '5', '0');
INSERT INTO `myblog_auth_rule` VALUES ('58', '2', 'advert/index', '广告位管理', '1', '1', '', '0');
INSERT INTO `myblog_auth_rule` VALUES ('59', '58', 'advert/advert_edit', '广告位添加', '1', '1', '1', '0');
INSERT INTO `myblog_auth_rule` VALUES ('60', '58', 'advert/advert_edit', '广告位编辑', '1', '1', '2', '0');
INSERT INTO `myblog_auth_rule` VALUES ('61', '58', 'advert/advert_del', '广告位删除', '1', '1', '5', '0');
INSERT INTO `myblog_auth_rule` VALUES ('62', '3', 'recover/index', '回收站', '1', '1', '', '0');
INSERT INTO `myblog_auth_rule` VALUES ('63', '62', 'recover/restore', '数据还原', '1', '1', '4', '0');
INSERT INTO `myblog_auth_rule` VALUES ('64', '62', 'recover/del', '数据删除', '1', '1', '5', '0');
INSERT INTO `myblog_auth_rule` VALUES ('65', '3', 'log/index', '操作日志', '1', '1', '', '0');
INSERT INTO `myblog_auth_rule` VALUES ('67', '0', '', '留言管理', '1', '1', '', '0');
INSERT INTO `myblog_auth_rule` VALUES ('68', '2', 'attachment/attach', '附件管理', '1', '1', '', '0');
INSERT INTO `myblog_auth_rule` VALUES ('69', '1', 'sitemap/sitelist', '网站地图', '1', '1', '', '0');
INSERT INTO `myblog_auth_rule` VALUES ('70', '66', 'member/membershow', '会员查看', '1', '0', '3', '0');
INSERT INTO `myblog_auth_rule` VALUES ('71', '66', 'member/memberdel', '会员删除', '1', '0', '5', '0');
INSERT INTO `myblog_auth_rule` VALUES ('72', '51', 'message/messshow', '留言查看', '1', '1', '3', '0');
INSERT INTO `myblog_auth_rule` VALUES ('73', '51', 'message/messdel', '留言删除', '1', '1', '5', '0');
INSERT INTO `myblog_auth_rule` VALUES ('74', '51', 'message/messedit', '留言编辑', '1', '1', '2', '0');
INSERT INTO `myblog_auth_rule` VALUES ('75', '65', 'log/logshow', '日志查看', '1', '1', '3', '0');
INSERT INTO `myblog_auth_rule` VALUES ('76', '65', 'log/logdel', '日志删除', '1', '1', '5', '0');
INSERT INTO `myblog_auth_rule` VALUES ('77', '68', 'attachment/attdel', '附件删除', '1', '1', '5', '0');
INSERT INTO `myblog_auth_rule` VALUES ('78', '69', 'sitemap/siteedit', '地图编辑', '1', '1', '2', '0');
INSERT INTO `myblog_auth_rule` VALUES ('79', '69', 'sitemap/index', '地图查看', '1', '1', '3', '0');
INSERT INTO `myblog_auth_rule` VALUES ('80', '69', 'sitemap/sitedel', '地图删除', '1', '1', '5', '0');
INSERT INTO `myblog_auth_rule` VALUES ('81', '69', 'sitemap/siteedit', '地图添加', '1', '1', '1', '0');
INSERT INTO `myblog_auth_rule` VALUES ('82', '2', 'mail/index', '邮件管理', '1', '1', '', '0');
INSERT INTO `myblog_auth_rule` VALUES ('83', '82', 'mail/mailedit', '新增邮件', '1', '1', '1', '0');
INSERT INTO `myblog_auth_rule` VALUES ('84', '82', 'mail/mailedit', '编辑邮件', '1', '1', '2', '0');
INSERT INTO `myblog_auth_rule` VALUES ('85', '82', 'mail/maildel', '删除邮件', '1', '1', '5', '0');
INSERT INTO `myblog_auth_rule` VALUES ('86', '82', 'mail/mailshow', '邮件查看', '1', '1', '3', '0');
INSERT INTO `myblog_auth_rule` VALUES ('90', '52', 'index/firendedit', '链接添加', '1', '1', '1', '0');
INSERT INTO `myblog_auth_rule` VALUES ('91', '52', 'index/firendedit', '链接编辑', '1', '1', '2', '0');
INSERT INTO `myblog_auth_rule` VALUES ('92', '52', 'index/firenddel', '链接删除', '1', '1', '5', '0');
INSERT INTO `myblog_auth_rule` VALUES ('93', '38', 'wechat/index', '菜单管理', '1', '1', '3', '0');
INSERT INTO `myblog_auth_rule` VALUES ('95', '94', 'wechatResource/source_edit', '素材添加', '1', '1', '1', '0');
INSERT INTO `myblog_auth_rule` VALUES ('96', '94', 'wechatResource/source_edit', '素材编辑', '1', '1', '2', '0');
INSERT INTO `myblog_auth_rule` VALUES ('97', '94', 'wechatResource/source_del', '素材删除', '1', '1', '5', '0');
INSERT INTO `myblog_auth_rule` VALUES ('98', '94', 'wechatResource/source_check', '素材查看', '1', '1', '3', '0');
INSERT INTO `myblog_auth_rule` VALUES ('99', '3', 'index/clearCache', '清除缓存', '1', '1', '', '0');
INSERT INTO `myblog_auth_rule` VALUES ('100', '68', 'attachment/attedit', '附件添加', '1', '1', '1', '0');
INSERT INTO `myblog_auth_rule` VALUES ('101', '68', 'attachment/attedit', '附件编辑', '1', '1', '2', '0');

-- ----------------------------
-- Table structure for myblog_category
-- ----------------------------
DROP TABLE IF EXISTS `myblog_category`;
CREATE TABLE `myblog_category` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `pid` int(11) NOT NULL COMMENT '父级id',
  `childid` tinyint(1) NOT NULL DEFAULT '0' COMMENT '是否为子集 0 否 1是',
  `name` varchar(255) NOT NULL COMMENT '类别名称',
  `link` varchar(100) NOT NULL,
  `isdel` tinyint(1) NOT NULL DEFAULT '0' COMMENT '是否删除：1.是，0.否',
  `mobile` tinyint(1) NOT NULL DEFAULT '1' COMMENT '移动端显示：1.是，0.否',
  `pc` tinyint(1) NOT NULL DEFAULT '1' COMMENT 'pc端显示：1.是，0.否',
  `order` varchar(100) NOT NULL COMMENT '排序，越小越靠前',
  PRIMARY KEY (`id`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8 COMMENT='分类表';

-- ----------------------------
-- Records of myblog_category
-- ----------------------------

-- ----------------------------
-- Table structure for myblog_city
-- ----------------------------
DROP TABLE IF EXISTS `myblog_city`;
CREATE TABLE `myblog_city` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(255) DEFAULT NULL COMMENT '城市名',
  PRIMARY KEY (`id`),
  KEY `pname` (`name`) USING BTREE
) ENGINE=MyISAM AUTO_INCREMENT=393 DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of myblog_city
-- ----------------------------
INSERT INTO `myblog_city` VALUES ('1', '七台河市');
INSERT INTO `myblog_city` VALUES ('2', '万宁市');
INSERT INTO `myblog_city` VALUES ('3', '三亚市');
INSERT INTO `myblog_city` VALUES ('4', '三明市');
INSERT INTO `myblog_city` VALUES ('5', '三门峡市');
INSERT INTO `myblog_city` VALUES ('6', '上海市');
INSERT INTO `myblog_city` VALUES ('7', '上饶市');
INSERT INTO `myblog_city` VALUES ('8', '东方市');
INSERT INTO `myblog_city` VALUES ('9', '东莞市');
INSERT INTO `myblog_city` VALUES ('10', '东营市');
INSERT INTO `myblog_city` VALUES ('11', '中卫市');
INSERT INTO `myblog_city` VALUES ('12', '中山市');
INSERT INTO `myblog_city` VALUES ('13', '临夏回族自治州');
INSERT INTO `myblog_city` VALUES ('14', '临汾市');
INSERT INTO `myblog_city` VALUES ('15', '临沂市');
INSERT INTO `myblog_city` VALUES ('16', '临沧市');
INSERT INTO `myblog_city` VALUES ('17', '临高县');
INSERT INTO `myblog_city` VALUES ('18', '丹东市');
INSERT INTO `myblog_city` VALUES ('19', '丽水市');
INSERT INTO `myblog_city` VALUES ('20', '丽江市');
INSERT INTO `myblog_city` VALUES ('21', '乌兰察布市');
INSERT INTO `myblog_city` VALUES ('22', '乌海市');
INSERT INTO `myblog_city` VALUES ('23', '乌苏市');
INSERT INTO `myblog_city` VALUES ('24', '乌鲁木齐市');
INSERT INTO `myblog_city` VALUES ('25', '乐东黎族自治县');
INSERT INTO `myblog_city` VALUES ('26', '乐山市');
INSERT INTO `myblog_city` VALUES ('27', '九江市');
INSERT INTO `myblog_city` VALUES ('28', '云林县');
INSERT INTO `myblog_city` VALUES ('29', '云浮市');
INSERT INTO `myblog_city` VALUES ('30', '五家渠市');
INSERT INTO `myblog_city` VALUES ('31', '五指山市');
INSERT INTO `myblog_city` VALUES ('32', '亳州市');
INSERT INTO `myblog_city` VALUES ('33', '仙桃市');
INSERT INTO `myblog_city` VALUES ('34', '伊 春 市');
INSERT INTO `myblog_city` VALUES ('35', '伊宁市');
INSERT INTO `myblog_city` VALUES ('36', '佛山市');
INSERT INTO `myblog_city` VALUES ('37', '佳木斯市');
INSERT INTO `myblog_city` VALUES ('38', '保亭黎族苗族自治县');
INSERT INTO `myblog_city` VALUES ('39', '保定市');
INSERT INTO `myblog_city` VALUES ('40', '保山市');
INSERT INTO `myblog_city` VALUES ('41', '信阳市');
INSERT INTO `myblog_city` VALUES ('42', '儋州市');
INSERT INTO `myblog_city` VALUES ('43', '克拉玛依市');
INSERT INTO `myblog_city` VALUES ('44', '六安市');
INSERT INTO `myblog_city` VALUES ('45', '六盘水市');
INSERT INTO `myblog_city` VALUES ('46', '兰州市');
INSERT INTO `myblog_city` VALUES ('47', '兴安盟');
INSERT INTO `myblog_city` VALUES ('48', '内江市');
INSERT INTO `myblog_city` VALUES ('49', '凉山彝族自治州');
INSERT INTO `myblog_city` VALUES ('50', '包头市');
INSERT INTO `myblog_city` VALUES ('51', '北京市');
INSERT INTO `myblog_city` VALUES ('52', '北海市');
INSERT INTO `myblog_city` VALUES ('53', '十堰市');
INSERT INTO `myblog_city` VALUES ('54', '南京市');
INSERT INTO `myblog_city` VALUES ('55', '南充市');
INSERT INTO `myblog_city` VALUES ('56', '南宁市');
INSERT INTO `myblog_city` VALUES ('57', '南平市');
INSERT INTO `myblog_city` VALUES ('58', '南投县');
INSERT INTO `myblog_city` VALUES ('59', '南昌市');
INSERT INTO `myblog_city` VALUES ('60', '南通市');
INSERT INTO `myblog_city` VALUES ('61', '南阳市');
INSERT INTO `myblog_city` VALUES ('62', '博乐市');
INSERT INTO `myblog_city` VALUES ('63', '厦门市');
INSERT INTO `myblog_city` VALUES ('64', '双鸭山市');
INSERT INTO `myblog_city` VALUES ('65', '台东县');
INSERT INTO `myblog_city` VALUES ('66', '台中县');
INSERT INTO `myblog_city` VALUES ('67', '台中市');
INSERT INTO `myblog_city` VALUES ('68', '台北县');
INSERT INTO `myblog_city` VALUES ('69', '台北市');
INSERT INTO `myblog_city` VALUES ('70', '台南县');
INSERT INTO `myblog_city` VALUES ('71', '台南市');
INSERT INTO `myblog_city` VALUES ('72', '台州市');
INSERT INTO `myblog_city` VALUES ('73', '合肥市');
INSERT INTO `myblog_city` VALUES ('74', '吉安市');
INSERT INTO `myblog_city` VALUES ('75', '吉林市');
INSERT INTO `myblog_city` VALUES ('76', '吐鲁番市');
INSERT INTO `myblog_city` VALUES ('77', '吕梁市');
INSERT INTO `myblog_city` VALUES ('78', '吴忠市');
INSERT INTO `myblog_city` VALUES ('79', '周口市');
INSERT INTO `myblog_city` VALUES ('80', '呼伦贝尔市');
INSERT INTO `myblog_city` VALUES ('81', '呼和浩特市');
INSERT INTO `myblog_city` VALUES ('82', '和田市');
INSERT INTO `myblog_city` VALUES ('83', '咸宁市');
INSERT INTO `myblog_city` VALUES ('84', '咸阳市');
INSERT INTO `myblog_city` VALUES ('85', '哈密市');
INSERT INTO `myblog_city` VALUES ('86', '哈尔滨市');
INSERT INTO `myblog_city` VALUES ('87', '唐山市');
INSERT INTO `myblog_city` VALUES ('88', '商丘市');
INSERT INTO `myblog_city` VALUES ('89', '商洛市');
INSERT INTO `myblog_city` VALUES ('90', '喀什市');
INSERT INTO `myblog_city` VALUES ('91', '嘉义县');
INSERT INTO `myblog_city` VALUES ('92', '嘉义市');
INSERT INTO `myblog_city` VALUES ('93', '嘉兴市');
INSERT INTO `myblog_city` VALUES ('94', '嘉峪关市');
INSERT INTO `myblog_city` VALUES ('95', '四平市');
INSERT INTO `myblog_city` VALUES ('96', '固原市');
INSERT INTO `myblog_city` VALUES ('97', '图木舒克市');
INSERT INTO `myblog_city` VALUES ('98', '基隆市');
INSERT INTO `myblog_city` VALUES ('99', '塔城市');
INSERT INTO `myblog_city` VALUES ('100', '大 庆 市');
INSERT INTO `myblog_city` VALUES ('101', '大兴安岭地区');
INSERT INTO `myblog_city` VALUES ('102', '大同市');
INSERT INTO `myblog_city` VALUES ('103', '大理白族自治州');
INSERT INTO `myblog_city` VALUES ('104', '大连市');
INSERT INTO `myblog_city` VALUES ('105', '天水市');
INSERT INTO `myblog_city` VALUES ('106', '天津市');
INSERT INTO `myblog_city` VALUES ('107', '天门市');
INSERT INTO `myblog_city` VALUES ('108', '太原市');
INSERT INTO `myblog_city` VALUES ('109', '奎屯市');
INSERT INTO `myblog_city` VALUES ('110', '威海市');
INSERT INTO `myblog_city` VALUES ('111', '娄底市');
INSERT INTO `myblog_city` VALUES ('112', '孝感市');
INSERT INTO `myblog_city` VALUES ('113', '宁德市');
INSERT INTO `myblog_city` VALUES ('114', '宁波市');
INSERT INTO `myblog_city` VALUES ('115', '安庆市');
INSERT INTO `myblog_city` VALUES ('116', '安康市');
INSERT INTO `myblog_city` VALUES ('117', '安阳市');
INSERT INTO `myblog_city` VALUES ('118', '安顺市');
INSERT INTO `myblog_city` VALUES ('119', '定安县');
INSERT INTO `myblog_city` VALUES ('120', '定西市');
INSERT INTO `myblog_city` VALUES ('121', '宜兰县');
INSERT INTO `myblog_city` VALUES ('122', '宜宾市');
INSERT INTO `myblog_city` VALUES ('123', '宜昌市');
INSERT INTO `myblog_city` VALUES ('124', '宜春市');
INSERT INTO `myblog_city` VALUES ('125', '宝鸡市');
INSERT INTO `myblog_city` VALUES ('126', '宣城市');
INSERT INTO `myblog_city` VALUES ('127', '宿州市');
INSERT INTO `myblog_city` VALUES ('128', '宿迁市');
INSERT INTO `myblog_city` VALUES ('129', '屏东县');
INSERT INTO `myblog_city` VALUES ('130', '屯昌县');
INSERT INTO `myblog_city` VALUES ('131', '山南地区');
INSERT INTO `myblog_city` VALUES ('132', '岳阳市');
INSERT INTO `myblog_city` VALUES ('133', '崇左市');
INSERT INTO `myblog_city` VALUES ('134', '巢湖市');
INSERT INTO `myblog_city` VALUES ('135', '巴中市');
INSERT INTO `myblog_city` VALUES ('136', '巴彦淖尔市');
INSERT INTO `myblog_city` VALUES ('137', '常州市');
INSERT INTO `myblog_city` VALUES ('138', '常德市');
INSERT INTO `myblog_city` VALUES ('139', '平凉市');
INSERT INTO `myblog_city` VALUES ('140', '平顶山市');
INSERT INTO `myblog_city` VALUES ('141', '广元市');
INSERT INTO `myblog_city` VALUES ('142', '广安市');
INSERT INTO `myblog_city` VALUES ('143', '广州市');
INSERT INTO `myblog_city` VALUES ('144', '庆阳市');
INSERT INTO `myblog_city` VALUES ('145', '库尔勒市');
INSERT INTO `myblog_city` VALUES ('146', '廊坊市');
INSERT INTO `myblog_city` VALUES ('147', '延安市');
INSERT INTO `myblog_city` VALUES ('148', '延边朝鲜族自治州');
INSERT INTO `myblog_city` VALUES ('149', '开封市');
INSERT INTO `myblog_city` VALUES ('150', '张家口市');
INSERT INTO `myblog_city` VALUES ('151', '张家界市');
INSERT INTO `myblog_city` VALUES ('152', '张掖市');
INSERT INTO `myblog_city` VALUES ('153', '彰化县');
INSERT INTO `myblog_city` VALUES ('154', '徐州市');
INSERT INTO `myblog_city` VALUES ('155', '德宏傣族景颇族自治州');
INSERT INTO `myblog_city` VALUES ('156', '德州市');
INSERT INTO `myblog_city` VALUES ('157', '德阳市');
INSERT INTO `myblog_city` VALUES ('158', '忻州市');
INSERT INTO `myblog_city` VALUES ('159', '怀化市');
INSERT INTO `myblog_city` VALUES ('160', '怒江傈傈族自治州');
INSERT INTO `myblog_city` VALUES ('161', '思茅市');
INSERT INTO `myblog_city` VALUES ('162', '恩施土家族苗族自治州');
INSERT INTO `myblog_city` VALUES ('163', '惠州市');
INSERT INTO `myblog_city` VALUES ('164', '成都市');
INSERT INTO `myblog_city` VALUES ('165', '扬州市');
INSERT INTO `myblog_city` VALUES ('166', '承德市');
INSERT INTO `myblog_city` VALUES ('167', '抚州市');
INSERT INTO `myblog_city` VALUES ('168', '抚顺市');
INSERT INTO `myblog_city` VALUES ('169', '拉萨市');
INSERT INTO `myblog_city` VALUES ('170', '揭阳市');
INSERT INTO `myblog_city` VALUES ('171', '攀枝花市');
INSERT INTO `myblog_city` VALUES ('172', '文山壮族苗族自治州');
INSERT INTO `myblog_city` VALUES ('173', '文昌市');
INSERT INTO `myblog_city` VALUES ('174', '新乡市');
INSERT INTO `myblog_city` VALUES ('175', '新余市');
INSERT INTO `myblog_city` VALUES ('176', '新竹县');
INSERT INTO `myblog_city` VALUES ('177', '新竹市');
INSERT INTO `myblog_city` VALUES ('178', '无锡市');
INSERT INTO `myblog_city` VALUES ('179', '日喀则地区');
INSERT INTO `myblog_city` VALUES ('180', '日照市');
INSERT INTO `myblog_city` VALUES ('181', '昆明市');
INSERT INTO `myblog_city` VALUES ('182', '昌吉市　');
INSERT INTO `myblog_city` VALUES ('183', '昌江黎族自治县');
INSERT INTO `myblog_city` VALUES ('184', '昌都地区');
INSERT INTO `myblog_city` VALUES ('185', '昭通市');
INSERT INTO `myblog_city` VALUES ('186', '晋中市');
INSERT INTO `myblog_city` VALUES ('187', '晋城市');
INSERT INTO `myblog_city` VALUES ('188', '景德镇市');
INSERT INTO `myblog_city` VALUES ('189', '曲靖市');
INSERT INTO `myblog_city` VALUES ('190', '朔州市');
INSERT INTO `myblog_city` VALUES ('191', '朝阳市');
INSERT INTO `myblog_city` VALUES ('192', '本溪市');
INSERT INTO `myblog_city` VALUES ('193', '来宾市');
INSERT INTO `myblog_city` VALUES ('194', '杭州市');
INSERT INTO `myblog_city` VALUES ('195', '松原市');
INSERT INTO `myblog_city` VALUES ('196', '林芝地区');
INSERT INTO `myblog_city` VALUES ('197', '果洛藏族自治州');
INSERT INTO `myblog_city` VALUES ('198', '枣庄市');
INSERT INTO `myblog_city` VALUES ('199', '柳州市');
INSERT INTO `myblog_city` VALUES ('200', '株洲市');
INSERT INTO `myblog_city` VALUES ('201', '桂林市');
INSERT INTO `myblog_city` VALUES ('202', '桃园县');
INSERT INTO `myblog_city` VALUES ('203', '梅州市');
INSERT INTO `myblog_city` VALUES ('204', '梧州市');
INSERT INTO `myblog_city` VALUES ('205', '楚雄彝族自治州');
INSERT INTO `myblog_city` VALUES ('206', '榆林市');
INSERT INTO `myblog_city` VALUES ('207', '武威市');
INSERT INTO `myblog_city` VALUES ('208', '武汉市');
INSERT INTO `myblog_city` VALUES ('209', '毕节地区');
INSERT INTO `myblog_city` VALUES ('210', '永州市');
INSERT INTO `myblog_city` VALUES ('211', '汉中市');
INSERT INTO `myblog_city` VALUES ('212', '汕头市');
INSERT INTO `myblog_city` VALUES ('213', '汕尾市');
INSERT INTO `myblog_city` VALUES ('214', '江门市');
INSERT INTO `myblog_city` VALUES ('215', '池州市');
INSERT INTO `myblog_city` VALUES ('216', '沈阳市');
INSERT INTO `myblog_city` VALUES ('217', '沧州市');
INSERT INTO `myblog_city` VALUES ('218', '河池市');
INSERT INTO `myblog_city` VALUES ('219', '河源市');
INSERT INTO `myblog_city` VALUES ('220', '泉州市');
INSERT INTO `myblog_city` VALUES ('221', '泰安市');
INSERT INTO `myblog_city` VALUES ('222', '泰州市');
INSERT INTO `myblog_city` VALUES ('223', '泸州市');
INSERT INTO `myblog_city` VALUES ('224', '洛阳市');
INSERT INTO `myblog_city` VALUES ('225', '济南市');
INSERT INTO `myblog_city` VALUES ('226', '济宁市');
INSERT INTO `myblog_city` VALUES ('227', '济源市');
INSERT INTO `myblog_city` VALUES ('228', '海东地区');
INSERT INTO `myblog_city` VALUES ('229', '海北藏族自治州');
INSERT INTO `myblog_city` VALUES ('230', '海南藏族自治州');
INSERT INTO `myblog_city` VALUES ('231', '海口市');
INSERT INTO `myblog_city` VALUES ('232', '海西蒙古族藏族自治州');
INSERT INTO `myblog_city` VALUES ('233', '淄博市');
INSERT INTO `myblog_city` VALUES ('234', '淮北市');
INSERT INTO `myblog_city` VALUES ('235', '淮南市');
INSERT INTO `myblog_city` VALUES ('236', '淮安市');
INSERT INTO `myblog_city` VALUES ('237', '深圳市');
INSERT INTO `myblog_city` VALUES ('238', '清远市');
INSERT INTO `myblog_city` VALUES ('239', '温州市');
INSERT INTO `myblog_city` VALUES ('240', '渭南市');
INSERT INTO `myblog_city` VALUES ('241', '湖州市');
INSERT INTO `myblog_city` VALUES ('242', '湘潭市');
INSERT INTO `myblog_city` VALUES ('243', '湘西土家族苗族自治州');
INSERT INTO `myblog_city` VALUES ('244', '湛江市');
INSERT INTO `myblog_city` VALUES ('245', '滁州市');
INSERT INTO `myblog_city` VALUES ('246', '滨州市');
INSERT INTO `myblog_city` VALUES ('247', '漯河市');
INSERT INTO `myblog_city` VALUES ('248', '漳州市');
INSERT INTO `myblog_city` VALUES ('249', '潍坊市');
INSERT INTO `myblog_city` VALUES ('250', '潜江市');
INSERT INTO `myblog_city` VALUES ('251', '潮州市');
INSERT INTO `myblog_city` VALUES ('252', '澄迈县');
INSERT INTO `myblog_city` VALUES ('253', '澎湖县');
INSERT INTO `myblog_city` VALUES ('254', '澳门特别行政区');
INSERT INTO `myblog_city` VALUES ('255', '濮阳市');
INSERT INTO `myblog_city` VALUES ('256', '烟台市');
INSERT INTO `myblog_city` VALUES ('257', '焦作市');
INSERT INTO `myblog_city` VALUES ('258', '牡丹江市');
INSERT INTO `myblog_city` VALUES ('259', '玉林市');
INSERT INTO `myblog_city` VALUES ('260', '玉树藏族自治州');
INSERT INTO `myblog_city` VALUES ('261', '玉溪市');
INSERT INTO `myblog_city` VALUES ('262', '珠海市');
INSERT INTO `myblog_city` VALUES ('263', '琼中黎族苗族自治县');
INSERT INTO `myblog_city` VALUES ('264', '琼海市');
INSERT INTO `myblog_city` VALUES ('265', '甘南藏族自治州');
INSERT INTO `myblog_city` VALUES ('266', '甘孜藏族自治州');
INSERT INTO `myblog_city` VALUES ('267', '白城市');
INSERT INTO `myblog_city` VALUES ('268', '白山市');
INSERT INTO `myblog_city` VALUES ('269', '白沙黎族自治县');
INSERT INTO `myblog_city` VALUES ('270', '白银市');
INSERT INTO `myblog_city` VALUES ('271', '百色市');
INSERT INTO `myblog_city` VALUES ('272', '益阳市');
INSERT INTO `myblog_city` VALUES ('273', '盐城市');
INSERT INTO `myblog_city` VALUES ('274', '盘锦市');
INSERT INTO `myblog_city` VALUES ('275', '眉山市');
INSERT INTO `myblog_city` VALUES ('276', '石嘴山市');
INSERT INTO `myblog_city` VALUES ('277', '石家庄市');
INSERT INTO `myblog_city` VALUES ('278', '石河子市　');
INSERT INTO `myblog_city` VALUES ('279', '神农架林区');
INSERT INTO `myblog_city` VALUES ('280', '福州市');
INSERT INTO `myblog_city` VALUES ('281', '秦皇岛市');
INSERT INTO `myblog_city` VALUES ('282', '米泉市');
INSERT INTO `myblog_city` VALUES ('283', '红河哈尼族彝族自治州');
INSERT INTO `myblog_city` VALUES ('284', '绍兴市');
INSERT INTO `myblog_city` VALUES ('285', '绥 化 市');
INSERT INTO `myblog_city` VALUES ('286', '绵阳市');
INSERT INTO `myblog_city` VALUES ('287', '聊城市');
INSERT INTO `myblog_city` VALUES ('288', '肇庆市');
INSERT INTO `myblog_city` VALUES ('289', '自贡市');
INSERT INTO `myblog_city` VALUES ('290', '舟山市');
INSERT INTO `myblog_city` VALUES ('291', '芜湖市');
INSERT INTO `myblog_city` VALUES ('292', '花莲县');
INSERT INTO `myblog_city` VALUES ('293', '苏州市');
INSERT INTO `myblog_city` VALUES ('294', '苗栗县');
INSERT INTO `myblog_city` VALUES ('295', '茂名市');
INSERT INTO `myblog_city` VALUES ('296', '荆州市');
INSERT INTO `myblog_city` VALUES ('297', '荆门市');
INSERT INTO `myblog_city` VALUES ('298', '莆田市');
INSERT INTO `myblog_city` VALUES ('299', '莱芜市');
INSERT INTO `myblog_city` VALUES ('300', '菏泽市');
INSERT INTO `myblog_city` VALUES ('301', '萍乡市');
INSERT INTO `myblog_city` VALUES ('302', '营口市');
INSERT INTO `myblog_city` VALUES ('303', '葫芦岛市');
INSERT INTO `myblog_city` VALUES ('304', '蚌埠市');
INSERT INTO `myblog_city` VALUES ('305', '衡水市');
INSERT INTO `myblog_city` VALUES ('306', '衡阳市');
INSERT INTO `myblog_city` VALUES ('307', '衢州市');
INSERT INTO `myblog_city` VALUES ('308', '襄樊市');
INSERT INTO `myblog_city` VALUES ('309', '西双版纳傣族自治州');
INSERT INTO `myblog_city` VALUES ('310', '西宁市');
INSERT INTO `myblog_city` VALUES ('311', '西安市');
INSERT INTO `myblog_city` VALUES ('312', '许昌市');
INSERT INTO `myblog_city` VALUES ('313', '贵港市');
INSERT INTO `myblog_city` VALUES ('314', '贵阳市');
INSERT INTO `myblog_city` VALUES ('315', '贺州市');
INSERT INTO `myblog_city` VALUES ('316', '资阳市');
INSERT INTO `myblog_city` VALUES ('317', '赣州市');
INSERT INTO `myblog_city` VALUES ('318', '赤峰市');
INSERT INTO `myblog_city` VALUES ('319', '辽源市');
INSERT INTO `myblog_city` VALUES ('320', '辽阳市');
INSERT INTO `myblog_city` VALUES ('321', '达州市');
INSERT INTO `myblog_city` VALUES ('322', '运城市');
INSERT INTO `myblog_city` VALUES ('323', '连云港市');
INSERT INTO `myblog_city` VALUES ('324', '迪庆藏族自治州');
INSERT INTO `myblog_city` VALUES ('325', '通化市');
INSERT INTO `myblog_city` VALUES ('326', '通辽市');
INSERT INTO `myblog_city` VALUES ('327', '遂宁市');
INSERT INTO `myblog_city` VALUES ('328', '遵义市');
INSERT INTO `myblog_city` VALUES ('329', '邢台市');
INSERT INTO `myblog_city` VALUES ('330', '那曲地区');
INSERT INTO `myblog_city` VALUES ('331', '邯郸市');
INSERT INTO `myblog_city` VALUES ('332', '邵阳市');
INSERT INTO `myblog_city` VALUES ('333', '郑州市');
INSERT INTO `myblog_city` VALUES ('334', '郴州市');
INSERT INTO `myblog_city` VALUES ('335', '鄂尔多斯市');
INSERT INTO `myblog_city` VALUES ('336', '鄂州市');
INSERT INTO `myblog_city` VALUES ('337', '酒泉市');
INSERT INTO `myblog_city` VALUES ('338', '重庆市');
INSERT INTO `myblog_city` VALUES ('339', '金华市');
INSERT INTO `myblog_city` VALUES ('340', '金昌市');
INSERT INTO `myblog_city` VALUES ('341', '钦州市');
INSERT INTO `myblog_city` VALUES ('342', '铁岭市');
INSERT INTO `myblog_city` VALUES ('343', '铜仁地区');
INSERT INTO `myblog_city` VALUES ('344', '铜川市');
INSERT INTO `myblog_city` VALUES ('345', '铜陵市');
INSERT INTO `myblog_city` VALUES ('346', '银川市');
INSERT INTO `myblog_city` VALUES ('347', '锡林郭勒盟');
INSERT INTO `myblog_city` VALUES ('348', '锦州市');
INSERT INTO `myblog_city` VALUES ('349', '镇江市');
INSERT INTO `myblog_city` VALUES ('350', '长春市');
INSERT INTO `myblog_city` VALUES ('351', '长沙市');
INSERT INTO `myblog_city` VALUES ('352', '长治市');
INSERT INTO `myblog_city` VALUES ('353', '阜康市');
INSERT INTO `myblog_city` VALUES ('354', '阜新市');
INSERT INTO `myblog_city` VALUES ('355', '阜阳市');
INSERT INTO `myblog_city` VALUES ('356', '防城港市');
INSERT INTO `myblog_city` VALUES ('357', '阳江市');
INSERT INTO `myblog_city` VALUES ('358', '阳泉市');
INSERT INTO `myblog_city` VALUES ('359', '阿克苏市');
INSERT INTO `myblog_city` VALUES ('360', '阿勒泰市');
INSERT INTO `myblog_city` VALUES ('361', '阿图什市');
INSERT INTO `myblog_city` VALUES ('362', '阿坝藏族羌族自治州');
INSERT INTO `myblog_city` VALUES ('363', '阿拉善盟');
INSERT INTO `myblog_city` VALUES ('364', '阿拉尔市');
INSERT INTO `myblog_city` VALUES ('365', '阿里地区');
INSERT INTO `myblog_city` VALUES ('366', '陇南市');
INSERT INTO `myblog_city` VALUES ('367', '陵水黎族自治县');
INSERT INTO `myblog_city` VALUES ('368', '随州市');
INSERT INTO `myblog_city` VALUES ('369', '雅安市');
INSERT INTO `myblog_city` VALUES ('370', '青岛市');
INSERT INTO `myblog_city` VALUES ('371', '鞍山市');
INSERT INTO `myblog_city` VALUES ('372', '韶关市');
INSERT INTO `myblog_city` VALUES ('373', '香港特别行政区');
INSERT INTO `myblog_city` VALUES ('374', '马鞍山市');
INSERT INTO `myblog_city` VALUES ('375', '驻马店市');
INSERT INTO `myblog_city` VALUES ('376', '高雄县');
INSERT INTO `myblog_city` VALUES ('377', '高雄市');
INSERT INTO `myblog_city` VALUES ('378', '鸡 西 市');
INSERT INTO `myblog_city` VALUES ('379', '鹤 岗 市');
INSERT INTO `myblog_city` VALUES ('380', '鹤壁市');
INSERT INTO `myblog_city` VALUES ('381', '鹰潭市');
INSERT INTO `myblog_city` VALUES ('382', '黄冈市');
INSERT INTO `myblog_city` VALUES ('383', '黄南藏族自治州');
INSERT INTO `myblog_city` VALUES ('384', '黄山市');
INSERT INTO `myblog_city` VALUES ('385', '黄石市');
INSERT INTO `myblog_city` VALUES ('386', '黑河市');
INSERT INTO `myblog_city` VALUES ('387', '黔东南苗族侗族自治州');
INSERT INTO `myblog_city` VALUES ('388', '黔南布依族苗族自治州');
INSERT INTO `myblog_city` VALUES ('389', '黔西南布依族苗族自治州');
INSERT INTO `myblog_city` VALUES ('390', '齐齐哈尔市');
INSERT INTO `myblog_city` VALUES ('391', '龙岩市');

-- ----------------------------
-- Table structure for myblog_link
-- ----------------------------
DROP TABLE IF EXISTS `myblog_link`;
CREATE TABLE `myblog_link` (
  `id` int(11) NOT NULL AUTO_INCREMENT COMMENT '主键自增',
  `name` varchar(50) NOT NULL,
  `img` varchar(255) NOT NULL COMMENT '图片',
  `url` varchar(255) NOT NULL COMMENT '链接地址',
  `isdel` tinyint(1) NOT NULL DEFAULT '0' COMMENT '是否删除：1是，0.否',
  `isshow` tinyint(1) NOT NULL DEFAULT '1' COMMENT '是否显示：1.是，0.否',
  PRIMARY KEY (`id`)
) ENGINE=MyISAM AUTO_INCREMENT=2 DEFAULT CHARSET=utf8 COMMENT='友情链接表';

-- ----------------------------
-- Records of myblog_link
-- ----------------------------

-- ----------------------------
-- Table structure for myblog_log
-- ----------------------------
DROP TABLE IF EXISTS `myblog_log`;
CREATE TABLE `myblog_log` (
  `id` int(11) NOT NULL AUTO_INCREMENT COMMENT '主键自增',
  `uid` int(11) NOT NULL COMMENT '操作用户id',
  `uname` varchar(255) NOT NULL COMMENT '操作用户名',
  `ip` varchar(255) NOT NULL COMMENT '操作用户当前ip',
  `tables` varchar(255) NOT NULL COMMENT '操作表名称',
  `tcomment` varchar(255) NOT NULL COMMENT '操作表注释',
  `log` varchar(255) NOT NULL COMMENT '简单的操作日志记录',
  `tid` int(11) NOT NULL COMMENT '操作表中的主键id',
  `type` tinyint(1) NOT NULL DEFAULT '0' COMMENT '操作类型：1.增加，2.编辑，3.删除,4.还原',
  `ctime` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '操作时间',
  PRIMARY KEY (`id`),
  KEY `表名称` (`tables`),
  KEY `日期` (`ctime`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='日志操作表';

-- ----------------------------
-- Records of myblog_log
-- ----------------------------

-- ----------------------------
-- Table structure for myblog_log_content
-- ----------------------------
DROP TABLE IF EXISTS `myblog_log_content`;
CREATE TABLE `myblog_log_content` (
  `id` int(11) NOT NULL AUTO_INCREMENT COMMENT '主键自增',
  `tfield` varchar(255) NOT NULL COMMENT '字段名称',
  `toldvalue` longtext NOT NULL COMMENT '对应字段插入数据的信息',
  `tnewvalue` longtext NOT NULL COMMENT '对应字段更新后的信息',
  `tcomment` varchar(100) NOT NULL COMMENT '当前对应表名注释',
  `logid` int(11) NOT NULL COMMENT '日志表id',
  `tid` int(11) NOT NULL COMMENT '对应表主键id',
  `ctime` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`),
  KEY `日志id` (`logid`),
  CONSTRAINT `myblog_log_content_ibfk_1` FOREIGN KEY (`logid`) REFERENCES `myblog_log` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='操作日志从表';

-- ----------------------------
-- Records of myblog_log_content
-- ----------------------------

-- ----------------------------
-- Table structure for myblog_mail
-- ----------------------------
DROP TABLE IF EXISTS `myblog_mail`;
CREATE TABLE `myblog_mail` (
  `id` int(11) NOT NULL AUTO_INCREMENT COMMENT '主键自增',
  `sendfrom` varchar(255) NOT NULL COMMENT '发件人',
  `sendto` text NOT NULL COMMENT '收件人 多个以‘，’分割',
  `sendcopy` varchar(255) NOT NULL COMMENT '抄送 多个以‘，’分割',
  `sendbcc` varchar(255) NOT NULL COMMENT '密送人',
  `subject` varchar(255) NOT NULL COMMENT '主题：邮件标题',
  `content` longtext NOT NULL COMMENT '邮件内容',
  `attachid` varchar(255) NOT NULL COMMENT '附件id,（附件表）',
  `ctime` datetime DEFAULT NULL COMMENT '创建时间',
  `stime` datetime DEFAULT NULL COMMENT '发送时间',
  `issend` tinyint(1) NOT NULL COMMENT '是否发送：1是，0.否',
  `isdel` tinyint(1) NOT NULL DEFAULT '0' COMMENT '是否删除：1是，0.否',
  PRIMARY KEY (`id`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8 COMMENT='邮件表';

-- ----------------------------
-- Records of myblog_mail
-- ----------------------------

-- ----------------------------
-- Table structure for myblog_message
-- ----------------------------
DROP TABLE IF EXISTS `myblog_message`;
CREATE TABLE `myblog_message` (
  `id` int(11) NOT NULL AUTO_INCREMENT COMMENT '主键自增',
  `name` varchar(20) NOT NULL COMMENT '留言人名称',
  `sex` tinyint(1) NOT NULL DEFAULT '2' COMMENT '性别：1.男，0.女',
  `age` tinyint(1) NOT NULL COMMENT '年龄范围：1.35一下，2.35-40岁，3.41-45岁，4.45以上',
  `wechat` varchar(100) NOT NULL COMMENT '微信号',
  `mobile` varchar(11) NOT NULL COMMENT '移动电话',
  `mail` varchar(255) NOT NULL COMMENT '邮箱',
  `address` varchar(255) NOT NULL COMMENT '留言地址',
  `question` varchar(255) NOT NULL COMMENT '留言问题',
  `message` text NOT NULL COMMENT '客户留言内容',
  `type` tinyint(1) NOT NULL COMMENT '人群类型：1.异性，2.单身，3.同性',
  `ctime` datetime DEFAULT NULL COMMENT '留言时间',
  `status` tinyint(1) NOT NULL COMMENT '生育状态：1.未育，2.一胎，3.二胎',
  `will` tinyint(1) NOT NULL COMMENT '意向：1.冻卵，2.性别选择，3.代孕',
  `isone` tinyint(1) NOT NULL COMMENT '是否安排一对一：1.是，0.否',
  `source` int(3) NOT NULL DEFAULT '2' COMMENT '来源：1.pc，2.移动，3.答疑会（临时添加），4. 头条，5.UC头条，6.腾讯，7.美柚，8.新浪，9.凤凰，10.网易，11.一点资讯，12.手机百度，13.微信，14.，15.公益宣传9.1-12-1',
  `back` tinyint(1) NOT NULL DEFAULT '0' COMMENT '反馈状态：1.是，0.否',
  `backtime` datetime DEFAULT NULL COMMENT '反馈时间',
  `info` tinyint(1) NOT NULL DEFAULT '0' COMMENT '留言信息是否完整：1是，0.否',
  `isdel` tinyint(1) NOT NULL DEFAULT '0' COMMENT '删除状态：1.是，0.否',
  PRIMARY KEY (`id`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8 COMMENT='客户留言表';

-- ----------------------------
-- Records of myblog_message
-- ----------------------------

-- ----------------------------
-- Table structure for myblog_recover
-- ----------------------------
DROP TABLE IF EXISTS `myblog_recover`;
CREATE TABLE `myblog_recover` (
  `id` int(11) NOT NULL AUTO_INCREMENT COMMENT '主键自增',
  `name` varchar(50) NOT NULL COMMENT '表名称',
  `notes` varchar(50) NOT NULL COMMENT '表注释',
  `reid` int(11) NOT NULL COMMENT '对应表的主键id',
  `time` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '回收时间',
  PRIMARY KEY (`id`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8 COMMENT='回收站表';

-- ----------------------------
-- Records of myblog_recover
-- ----------------------------

-- ----------------------------
-- Table structure for myblog_sitemap
-- ----------------------------
DROP TABLE IF EXISTS `myblog_sitemap`;
CREATE TABLE `myblog_sitemap` (
  `id` int(11) NOT NULL AUTO_INCREMENT COMMENT '主键自增',
  `name` varchar(30) NOT NULL COMMENT '名称',
  `url` varchar(255) NOT NULL COMMENT '跳转地址',
  `ctime` datetime NOT NULL COMMENT '创建时间',
  `sites` tinyint(1) NOT NULL COMMENT '类型：1.网站地图，2.专题',
  `isdel` tinyint(1) NOT NULL COMMENT '是否删除：1.是，0.否',
  PRIMARY KEY (`id`)
) ENGINE=MyISAM AUTO_INCREMENT=13 DEFAULT CHARSET=utf8 COMMENT='网站地图';

-- ----------------------------
-- Records of myblog_sitemap
-- ----------------------------
INSERT INTO `myblog_sitemap` VALUES ('1', '首页', 'http://www.mengmei.org', '2018-05-07 13:02:30', '1', '0');
INSERT INTO `myblog_sitemap` VALUES ('2', '试管技术', 'http://www.xxx.com', '2018-05-07 13:02:34', '1', '0');
INSERT INTO `myblog_sitemap` VALUES ('3', '服务项目', '', '2018-05-07 13:05:44', '1', '0');
INSERT INTO `myblog_sitemap` VALUES ('4', '美国专家', '', '2018-05-07 13:05:48', '1', '0');
INSERT INTO `myblog_sitemap` VALUES ('5', '赴美流程', '', '2018-05-07 13:05:50', '1', '0');
INSERT INTO `myblog_sitemap` VALUES ('6', '总部医院', '', '2018-05-07 13:05:54', '1', '0');
INSERT INTO `myblog_sitemap` VALUES ('7', '最新资讯', '', '2018-05-07 13:05:57', '1', '0');
INSERT INTO `myblog_sitemap` VALUES ('8', '优选案例', '', '2018-05-07 13:05:59', '1', '0');
INSERT INTO `myblog_sitemap` VALUES ('9', '合作机构', '', '2018-05-07 13:06:01', '1', '0');
INSERT INTO `myblog_sitemap` VALUES ('10', '常见问题', '', '2018-05-07 13:06:04', '1', '0');
INSERT INTO `myblog_sitemap` VALUES ('11', '联系我们', '', '2018-05-07 13:06:07', '1', '0');
INSERT INTO `myblog_sitemap` VALUES ('12', 'ces ', '', '2018-05-11 14:51:05', '1', '1');

-- ----------------------------
-- Table structure for myblog_tree
-- ----------------------------
DROP TABLE IF EXISTS `myblog_tree`;
CREATE TABLE `myblog_tree` (
  `id` int(11) unsigned NOT NULL AUTO_INCREMENT,
  `name` varchar(255) DEFAULT NULL,
  `pid` varchar(255) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=MyISAM AUTO_INCREMENT=26 DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of myblog_tree
-- ----------------------------
INSERT INTO `myblog_tree` VALUES ('1', '爷爷奶奶', '0');
INSERT INTO `myblog_tree` VALUES ('2', '外公外婆', '0');
INSERT INTO `myblog_tree` VALUES ('6', '爸爸', '1');
INSERT INTO `myblog_tree` VALUES ('3', '妈妈', '2');
INSERT INTO `myblog_tree` VALUES ('4', '舅舅', '2');
INSERT INTO `myblog_tree` VALUES ('5', '舅妈', '2');
INSERT INTO `myblog_tree` VALUES ('7', '女儿', '6');
INSERT INTO `myblog_tree` VALUES ('8', '儿子', '3');
INSERT INTO `myblog_tree` VALUES ('11', '舅伯', '2');
INSERT INTO `myblog_tree` VALUES ('9', '叔叔', '1');
INSERT INTO `myblog_tree` VALUES ('10', '婶婶', '1');
INSERT INTO `myblog_tree` VALUES ('14', '表哥', '4');
INSERT INTO `myblog_tree` VALUES ('15', '表弟', '4');
INSERT INTO `myblog_tree` VALUES ('16', '表妹', '5');
INSERT INTO `myblog_tree` VALUES ('17', '表姐', '11');
INSERT INTO `myblog_tree` VALUES ('18', '堂哥', '9');
INSERT INTO `myblog_tree` VALUES ('19', '堂弟', '10');
INSERT INTO `myblog_tree` VALUES ('20', '堂姐', '9');
INSERT INTO `myblog_tree` VALUES ('21', '堂妹', '10');
INSERT INTO `myblog_tree` VALUES ('22', '孙子', '7');
INSERT INTO `myblog_tree` VALUES ('23', '孙女', '8');
INSERT INTO `myblog_tree` VALUES ('24', '外甥', '14');
INSERT INTO `myblog_tree` VALUES ('25', '外甥女', '5');

-- ----------------------------
-- Table structure for myblog_wechat_account
-- ----------------------------
DROP TABLE IF EXISTS `myblog_wechat_account`;
CREATE TABLE `myblog_wechat_account` (
  `id` int(11) NOT NULL AUTO_INCREMENT COMMENT '主键自增',
  `name` varchar(255) NOT NULL COMMENT '公众号名称',
  `initid` varchar(255) NOT NULL COMMENT '原始id',
  `appid` varchar(100) NOT NULL COMMENT '公众号appid',
  `appsecret` varchar(255) NOT NULL COMMENT '功能的密钥',
  `encodingaeskey` varchar(255) NOT NULL COMMENT '密用的EncodingAESKey 明文时可不填',
  `token` varchar(255) NOT NULL COMMENT 'token值',
  `type` tinyint(1) NOT NULL DEFAULT '1' COMMENT '公众号类型：1.订阅号，2.服务号，3.企业号',
  `isdel` tinyint(1) NOT NULL DEFAULT '0' COMMENT '是否删除：1.是，0.否',
  PRIMARY KEY (`id`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8 COMMENT='微信公众号表';

-- ----------------------------
-- Records of myblog_wechat_account
-- ----------------------------

-- ----------------------------
-- Table structure for myblog_wechat_menu
-- ----------------------------
DROP TABLE IF EXISTS `myblog_wechat_menu`;
CREATE TABLE `myblog_wechat_menu` (
  `id` smallint(4) unsigned NOT NULL AUTO_INCREMENT COMMENT '主键',
  `name` varchar(50) NOT NULL COMMENT '菜单名称',
  `pid` smallint(4) NOT NULL COMMENT '父级id',
  `order` tinyint(1) NOT NULL COMMENT '排序，在公众号显示的位置',
  `links` varchar(1000) NOT NULL COMMENT '链接',
  `sendtype` tinyint(1) NOT NULL COMMENT '发送类型：1.文本，2.链接',
  `type` tinyint(1) NOT NULL COMMENT '事件类型：1.text,2.view',
  `x` tinyint(1) NOT NULL COMMENT '存储自定义菜单在手机中的x轴的位置 最多3个，从左到右顺排（1-3）',
  `y` tinyint(1) NOT NULL COMMENT '存储菜单在手机中的y轴的位置，每列最多5个，从上到下顺排（1-5）',
  `token` varchar(255) NOT NULL,
  `isshow` tinyint(1) NOT NULL DEFAULT '1' COMMENT '是否显示:1.是，0.否',
  `replytype` tinyint(1) NOT NULL COMMENT '回复类型1.图文、2.文本、3.图片',
  `text` varchar(255) NOT NULL COMMENT '文本内容',
  `aid` int(11) NOT NULL COMMENT '图文外键表id',
  `tablename` varchar(255) NOT NULL COMMENT '外键表名称',
  `isdel` tinyint(1) NOT NULL DEFAULT '0' COMMENT '是否删除：1.是，0.否',
  PRIMARY KEY (`id`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8 COMMENT='自定义菜单表';

-- ----------------------------
-- Records of myblog_wechat_menu
-- ----------------------------

-- ----------------------------
-- Table structure for myblog_wechat_reply
-- ----------------------------
DROP TABLE IF EXISTS `myblog_wechat_reply`;
CREATE TABLE `myblog_wechat_reply` (
  `id` int(20) unsigned NOT NULL AUTO_INCREMENT COMMENT '主键',
  `keyword` varchar(500) NOT NULL COMMENT '关键字',
  `type` tinyint(1) NOT NULL COMMENT '回复类型 0.关注(默认),1.未知,2.关键字 ',
  `replytype` tinyint(1) NOT NULL COMMENT '回复类别 1.图文,2.文本,3.图片,4.语音,5.视频',
  `ktype` tinyint(1) NOT NULL COMMENT '关键词类型 0.完全,1.包含',
  `isenable` tinyint(1) NOT NULL DEFAULT '1' COMMENT '是否启用 1.是, 0.否',
  `hits` int(11) NOT NULL COMMENT '点击次数',
  `text` varchar(1000) NOT NULL COMMENT '回复文本，回复文本类型有效',
  `sorts` int(11) NOT NULL COMMENT '排序',
  `token` char(255) NOT NULL,
  `aid` int(11) NOT NULL COMMENT '外键id 根据表名确定',
  `tablename` varchar(255) NOT NULL COMMENT '表名',
  `isdel` tinyint(1) NOT NULL DEFAULT '0' COMMENT '是否删除：1.是，0.否',
  PRIMARY KEY (`id`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8 COMMENT='关键字回复表';

-- ----------------------------
-- Records of myblog_wechat_reply
-- ----------------------------

-- ----------------------------
-- Table structure for myblog_wechat_resource
-- ----------------------------
DROP TABLE IF EXISTS `myblog_wechat_resource`;
CREATE TABLE `myblog_wechat_resource` (
  `id` int(11) NOT NULL AUTO_INCREMENT COMMENT '主键自增',
  `media_id` varchar(255) NOT NULL COMMENT '新增的永久素材的media_id',
  `ctime` datetime NOT NULL COMMENT '创建时间',
  `utime` datetime NOT NULL COMMENT '更新时间',
  `stime` datetime DEFAULT NULL COMMENT '推送时间',
  `sourse_num` int(11) NOT NULL COMMENT '当前素材下子集个数',
  `send_num` int(11) NOT NULL COMMENT '推送次数',
  `wechat_id` int(11) NOT NULL COMMENT '微信账户关联id',
  `isdel` tinyint(1) NOT NULL DEFAULT '0' COMMENT '是否删除：1是，0.否',
  PRIMARY KEY (`id`),
  UNIQUE KEY `mediaid` (`media_id`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8 COMMENT='微信素材主表';

-- ----------------------------
-- Records of myblog_wechat_resource
-- ----------------------------

-- ----------------------------
-- Table structure for myblog_wechat_resource_list
-- ----------------------------
DROP TABLE IF EXISTS `myblog_wechat_resource_list`;
CREATE TABLE `myblog_wechat_resource_list` (
  `id` int(11) NOT NULL AUTO_INCREMENT COMMENT '主键自增',
  `media_id` varchar(255) NOT NULL COMMENT '素材主表media_id',
  `title` varchar(255) NOT NULL COMMENT '标题',
  `author` varchar(255) NOT NULL COMMENT '作者',
  `digest` varchar(255) NOT NULL COMMENT '图文消息的摘要',
  `content` varchar(255) NOT NULL COMMENT '图文消息的具体内容，支持HTML标签，必须少于2万字符，小于1M，且此处会去除JS',
  `content_source_url` varchar(255) NOT NULL COMMENT '图文消息的原文地址',
  `thumb_media_id` varchar(255) NOT NULL COMMENT '图文消息的封面图片素材id（必须是永久mediaID）',
  `show_cover_pic` tinyint(1) NOT NULL DEFAULT '1' COMMENT '是否显示封面：1是，0.否',
  `url` varchar(255) NOT NULL COMMENT '图文地址',
  `thumb_url` varchar(255) NOT NULL COMMENT '缩略图地址',
  `local_image` varchar(255) NOT NULL COMMENT '本地图片地址',
  `need_open_comment` tinyint(1) NOT NULL COMMENT '是否开启评论：1是，0.否',
  `only_fans_can_comment` tinyint(1) NOT NULL COMMENT '是否只有粉丝可以评论：1.是，0.否',
  `ctime` datetime DEFAULT NULL COMMENT '创建时间',
  `utime` datetime DEFAULT NULL COMMENT '更新时间',
  `up` tinyint(4) NOT NULL DEFAULT '0' COMMENT '是否上传到微信服务器：1是，0.否',
  `source_id` int(11) NOT NULL COMMENT '素材表id',
  `isdel` tinyint(1) NOT NULL DEFAULT '0' COMMENT '是否删除：1是，0.否',
  PRIMARY KEY (`id`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8 COMMENT='微信素材从表';

-- ----------------------------
-- Records of myblog_wechat_resource_list
-- ----------------------------
