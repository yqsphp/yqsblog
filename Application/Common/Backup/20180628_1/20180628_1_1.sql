-- -----------------------------
-- ----Think Mysql Data Transfer 
-- ----Host     : 127.0.0.1
-- ----Port     : 3306
-- ----Database : mengmei
-- ----Part : #
-- ----Date : 2018-06-28 08:52:14
-- ----Vol : 1
-- -----------------------------
SET FOREIGN_KEY_CHECKS = 0;
-- --------Table structure for mengmei_admin--------- -- 
DROP TABLE IF EXISTS `mengmei_admin`;
-- ----------------- -- 
CREATE TABLE `mengmei_admin` (
  `id` int(11) unsigned NOT NULL AUTO_INCREMENT COMMENT '主键自增',
  `name` varchar(255) DEFAULT NULL COMMENT '用户名',
  `pass` varchar(255) DEFAULT NULL COMMENT '用户密码',
  `status` tinyint(1) DEFAULT '1' COMMENT '状态：1.正常，0.禁用',
  `groupid` varchar(100) NOT NULL COMMENT '用户组id',
  `lastip` varchar(15) DEFAULT NULL COMMENT '最后登录ip',
  `lasttime` datetime DEFAULT NULL COMMENT '最后登陆时间',
  PRIMARY KEY (`id`)
) ENGINE=MyISAM AUTO_INCREMENT=3 DEFAULT CHARSET=utf8 COMMENT='管理员表';
-- -------Records of mengmei_admin ----- -- 
INSERT INTO mengmei_admin ( `id`, `name`, `pass`, `status`, `groupid`, `lastip`, `lasttime` ) VALUES ('1','admin','5d8446fee40b639d88772375d6dc86e2','1','1','127.0.0.1','2018-06-28 08:48:49');
-- -------Records of mengmei_admin ----- -- 
INSERT INTO mengmei_admin ( `id`, `name`, `pass`, `status`, `groupid`, `lastip`, `lasttime` ) VALUES ('2','user','87d9bb400c0634691f0e3baaf1e2fd0d','1','2','127.0.0.1','2018-06-14 15:49:32');
-- --------Table structure for mengmei_advert--------- -- 
DROP TABLE IF EXISTS `mengmei_advert`;
-- ----------------- -- 
CREATE TABLE `mengmei_advert` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(255) NOT NULL COMMENT '广告位名称',
  `image` varchar(100) NOT NULL COMMENT '图片',
  `height` double NOT NULL COMMENT '高度',
  `width` double NOT NULL COMMENT '宽度',
  `url` varchar(255) NOT NULL COMMENT '跳转地址',
  `cate` varchar(2) NOT NULL COMMENT '分类：1.轮播图，2.左侧侧边栏，3.右侧侧边栏，4.中间栏，5.底部（二维码等）',
  `isshow` tinyint(1) NOT NULL DEFAULT '1' COMMENT '是否显示：1.是，0.否',
  `isdel` tinyint(1) NOT NULL DEFAULT '0' COMMENT '是否删除：1.是，0.否',
  PRIMARY KEY (`id`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8 COMMENT='广告位表';
-- --------Table structure for mengmei_article--------- -- 
DROP TABLE IF EXISTS `mengmei_article`;
-- ----------------- -- 
CREATE TABLE `mengmei_article` (
  `id` mediumint(8) unsigned NOT NULL AUTO_INCREMENT,
  `catid` smallint(5) unsigned NOT NULL DEFAULT '0' COMMENT '类别表id',
  `name` varchar(160) NOT NULL DEFAULT '' COMMENT '标题',
  `seo` varchar(255) DEFAULT NULL COMMENT 'seo搜索',
  `keywords` varchar(40) NOT NULL DEFAULT '' COMMENT '关键字',
  `description` mediumtext NOT NULL COMMENT '描述',
  `editorid` int(2) DEFAULT NULL COMMENT '编辑人id',
  `editor` varchar(20) NOT NULL DEFAULT '' COMMENT '编辑人',
  `order` tinyint(3) unsigned NOT NULL DEFAULT '0' COMMENT '文章排序',
  `ctime` varchar(30) NOT NULL COMMENT '创建时间',
  `utime` varchar(30) NOT NULL COMMENT '更新时间',
  `ptime` varchar(30) NOT NULL COMMENT '发布时间',
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
) ENGINE=MyISAM AUTO_INCREMENT=2 DEFAULT CHARSET=utf8 COMMENT='文章表';
-- -------Records of mengmei_article ----- -- 
INSERT INTO mengmei_article ( `id`, `catid`, `name`, `seo`, `keywords`, `description`, `editorid`, `editor`, `order`, `ctime`, `utime`, `ptime`, `status`, `hits`, `content`, `image`, `recommend`, `settop`, `weixin`, `pc`, `mobile`, `app`, `wshort`, `isshow`, `isdel`, `copyfrom` ) VALUES ('1','7','舒服舒服舒服舒服','','','','','','0','','','','1','1','','','0','0','1','1','1','1','1','1','0','');
-- --------Table structure for mengmei_attachment--------- -- 
DROP TABLE IF EXISTS `mengmei_attachment`;
-- ----------------- -- 
CREATE TABLE `mengmei_attachment` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(255) NOT NULL COMMENT '附件名称',
  `path` varchar(255) NOT NULL COMMENT '附件路径',
  `path_thumb` varchar(255) NOT NULL COMMENT '缩略图',
  `size` decimal(10,2) NOT NULL COMMENT '大小 （KB）',
  `ext` varchar(10) NOT NULL COMMENT '文件后缀',
  `aid` int(11) NOT NULL COMMENT '文章id',
  `iswx` tinyint(1) NOT NULL DEFAULT '0' COMMENT '是否微信素材:1.是，0.否',
  `ctime` date DEFAULT NULL COMMENT '添加时间',
  `isdel` tinyint(1) NOT NULL DEFAULT '0' COMMENT '是否删除：1.是，0.否',
  PRIMARY KEY (`id`),
  KEY `文章id` (`aid`)
) ENGINE=MyISAM AUTO_INCREMENT=2 DEFAULT CHARSET=utf8 COMMENT='附件表';
-- --------Table structure for mengmei_auth_access--------- -- 
DROP TABLE IF EXISTS `mengmei_auth_access`;
-- ----------------- -- 
CREATE TABLE `mengmei_auth_access` (
  `id` int(11) NOT NULL AUTO_INCREMENT COMMENT '主键自增',
  `uid` int(11) unsigned NOT NULL COMMENT '用户id',
  `group_id` int(11) unsigned NOT NULL COMMENT '用户组id',
  PRIMARY KEY (`id`),
  UNIQUE KEY `uid_group_id` (`uid`,`group_id`),
  KEY `uid` (`uid`),
  KEY `group_id` (`group_id`)
) ENGINE=MyISAM AUTO_INCREMENT=18 DEFAULT CHARSET=utf8 COMMENT='用户组明细表';
-- -------Records of mengmei_auth_access ----- -- 
INSERT INTO mengmei_auth_access ( `id`, `uid`, `group_id` ) VALUES ('1','1','1');
-- -------Records of mengmei_auth_access ----- -- 
INSERT INTO mengmei_auth_access ( `id`, `uid`, `group_id` ) VALUES ('17','2','2');
-- --------Table structure for mengmei_auth_group--------- -- 
DROP TABLE IF EXISTS `mengmei_auth_group`;
-- ----------------- -- 
CREATE TABLE `mengmei_auth_group` (
  `id` int(11) unsigned NOT NULL AUTO_INCREMENT,
  `title` char(100) NOT NULL DEFAULT '' COMMENT '用户组中文名称',
  `status` tinyint(1) NOT NULL DEFAULT '1' COMMENT '状态：1：启用，0：禁用',
  `rules` text COMMENT '规则id 多个规则","隔开',
  PRIMARY KEY (`id`)
) ENGINE=MyISAM AUTO_INCREMENT=10 DEFAULT CHARSET=utf8 COMMENT='用户组表';
-- -------Records of mengmei_auth_group ----- -- 
INSERT INTO mengmei_auth_group ( `id`, `title`, `status`, `rules` ) VALUES ('1','超级管理员','1','1,4,5,52,90,91,92,69,78,79,80,81,2,6,7,8,9,10,11,12,13,14,15,16,17,53,54,55,56,58,59,60,61,62,63,64,68,77,82,83,84,85,86,3,18,19,20,21,22,28,23,24,25,26,27,29,30,31,32,65,75,76,99,33,49,50,87,88,89,37,38,41,42,43,47,93,39,44,45,46,94,95,96,97,98,67,51,72,73,74,66,70,71');
-- -------Records of mengmei_auth_group ----- -- 
INSERT INTO mengmei_auth_group ( `id`, `title`, `status`, `rules` ) VALUES ('2','网站编辑','1','1,5,2,6,7,8,9,10,11,12,13,14,15,16,17,58,59,60,61,37,38,41,42,43,47,93,39,44,45,46,94,95,96,97,98,67,51,72,73,74');
-- --------Table structure for mengmei_auth_rule--------- -- 
DROP TABLE IF EXISTS `mengmei_auth_rule`;
-- ----------------- -- 
CREATE TABLE `mengmei_auth_rule` (
  `id` int(11) unsigned NOT NULL AUTO_INCREMENT,
  `pid` int(11) unsigned NOT NULL DEFAULT '0' COMMENT '父级id',
  `name` char(80) NOT NULL DEFAULT '' COMMENT '规则唯一标识，如：Admin/article/index',
  `title` char(20) NOT NULL DEFAULT '' COMMENT '规则中文名称',
  `status` tinyint(1) NOT NULL DEFAULT '1' COMMENT '状态：1：启用，0：禁用',
  `condition` char(100) NOT NULL DEFAULT '' COMMENT '规则表达式，为空表示存在就验证，不为空表示按照条件验证\r\n自定义三级操作：\r\n1.添加，2.编辑，3.查看，4.还原，5.删除',
  `isdel` tinyint(1) NOT NULL DEFAULT '0' COMMENT '是否删除：1：是，0：否',
  PRIMARY KEY (`id`)
) ENGINE=MyISAM AUTO_INCREMENT=100 DEFAULT CHARSET=utf8 COMMENT='规则表';
-- -------Records of mengmei_auth_rule ----- -- 
INSERT INTO mengmei_auth_rule ( `id`, `pid`, `name`, `title`, `status`, `condition`, `isdel` ) VALUES ('1','0','','基本设置','1','','0');
-- -------Records of mengmei_auth_rule ----- -- 
INSERT INTO mengmei_auth_rule ( `id`, `pid`, `name`, `title`, `status`, `condition`, `isdel` ) VALUES ('2','0','','栏目管理','1','','0');
-- -------Records of mengmei_auth_rule ----- -- 
INSERT INTO mengmei_auth_rule ( `id`, `pid`, `name`, `title`, `status`, `condition`, `isdel` ) VALUES ('3','0','','系统设置','1','','0');
-- -------Records of mengmei_auth_rule ----- -- 
INSERT INTO mengmei_auth_rule ( `id`, `pid`, `name`, `title`, `status`, `condition`, `isdel` ) VALUES ('4','1','index/info','网站设置','1','','0');
-- -------Records of mengmei_auth_rule ----- -- 
INSERT INTO mengmei_auth_rule ( `id`, `pid`, `name`, `title`, `status`, `condition`, `isdel` ) VALUES ('5','1','index/userpass','修改密码','1','','0');
-- -------Records of mengmei_auth_rule ----- -- 
INSERT INTO mengmei_auth_rule ( `id`, `pid`, `name`, `title`, `status`, `condition`, `isdel` ) VALUES ('6','2','article/artlist','内容编辑','1','2','0');
-- -------Records of mengmei_auth_rule ----- -- 
INSERT INTO mengmei_auth_rule ( `id`, `pid`, `name`, `title`, `status`, `condition`, `isdel` ) VALUES ('7','6','article/artedit','添加内容','1','1','0');
-- -------Records of mengmei_auth_rule ----- -- 
INSERT INTO mengmei_auth_rule ( `id`, `pid`, `name`, `title`, `status`, `condition`, `isdel` ) VALUES ('8','6','article/artedit','文章修改','1','2','0');
-- -------Records of mengmei_auth_rule ----- -- 
INSERT INTO mengmei_auth_rule ( `id`, `pid`, `name`, `title`, `status`, `condition`, `isdel` ) VALUES ('9','6','article/artdel','文章删除','1','5','0');
-- -------Records of mengmei_auth_rule ----- -- 
INSERT INTO mengmei_auth_rule ( `id`, `pid`, `name`, `title`, `status`, `condition`, `isdel` ) VALUES ('10','2','article/artpublish','内容发布','1','','0');
-- -------Records of mengmei_auth_rule ----- -- 
INSERT INTO mengmei_auth_rule ( `id`, `pid`, `name`, `title`, `status`, `condition`, `isdel` ) VALUES ('11','10','article/artpublish','文章发布','1','2','0');
-- -------Records of mengmei_auth_rule ----- -- 
INSERT INTO mengmei_auth_rule ( `id`, `pid`, `name`, `title`, `status`, `condition`, `isdel` ) VALUES ('12','10','article/artpublish','文章撤回','1','4','0');
-- -------Records of mengmei_auth_rule ----- -- 
INSERT INTO mengmei_auth_rule ( `id`, `pid`, `name`, `title`, `status`, `condition`, `isdel` ) VALUES ('13','10','article/artpublish','文章取消','1','','0');
-- -------Records of mengmei_auth_rule ----- -- 
INSERT INTO mengmei_auth_rule ( `id`, `pid`, `name`, `title`, `status`, `condition`, `isdel` ) VALUES ('14','2','article/catlist','类别管理','1','','0');
-- -------Records of mengmei_auth_rule ----- -- 
INSERT INTO mengmei_auth_rule ( `id`, `pid`, `name`, `title`, `status`, `condition`, `isdel` ) VALUES ('15','14','article/catedit','添加类别','1','1','0');
-- -------Records of mengmei_auth_rule ----- -- 
INSERT INTO mengmei_auth_rule ( `id`, `pid`, `name`, `title`, `status`, `condition`, `isdel` ) VALUES ('16','14','article/catedit','类别修改','1','2','0');
-- -------Records of mengmei_auth_rule ----- -- 
INSERT INTO mengmei_auth_rule ( `id`, `pid`, `name`, `title`, `status`, `condition`, `isdel` ) VALUES ('17','14','article/catdel','类别删除','1','5','0');
-- -------Records of mengmei_auth_rule ----- -- 
INSERT INTO mengmei_auth_rule ( `id`, `pid`, `name`, `title`, `status`, `condition`, `isdel` ) VALUES ('18','3','rule/grouplist','角色管理','1','','0');
-- -------Records of mengmei_auth_rule ----- -- 
INSERT INTO mengmei_auth_rule ( `id`, `pid`, `name`, `title`, `status`, `condition`, `isdel` ) VALUES ('19','18','rule/groupedit','添加角色','1','1','0');
-- -------Records of mengmei_auth_rule ----- -- 
INSERT INTO mengmei_auth_rule ( `id`, `pid`, `name`, `title`, `status`, `condition`, `isdel` ) VALUES ('20','18','rule/groupedit','角色修改','1','2','0');
-- -------Records of mengmei_auth_rule ----- -- 
INSERT INTO mengmei_auth_rule ( `id`, `pid`, `name`, `title`, `status`, `condition`, `isdel` ) VALUES ('21','18','rule/adminedit','添加成员','1','1','0');
-- -------Records of mengmei_auth_rule ----- -- 
INSERT INTO mengmei_auth_rule ( `id`, `pid`, `name`, `title`, `status`, `condition`, `isdel` ) VALUES ('22','18','rule/groupdel','角色删除','1','5','0');
-- -------Records of mengmei_auth_rule ----- -- 
INSERT INTO mengmei_auth_rule ( `id`, `pid`, `name`, `title`, `status`, `condition`, `isdel` ) VALUES ('23','3','rule/adminlist','用户列表','1','','0');
-- -------Records of mengmei_auth_rule ----- -- 
INSERT INTO mengmei_auth_rule ( `id`, `pid`, `name`, `title`, `status`, `condition`, `isdel` ) VALUES ('24','23','rule/adminedit','添加用户','1','1','0');
-- -------Records of mengmei_auth_rule ----- -- 
INSERT INTO mengmei_auth_rule ( `id`, `pid`, `name`, `title`, `status`, `condition`, `isdel` ) VALUES ('25','23','rule/adminedit','用户修改','1','2','0');
-- -------Records of mengmei_auth_rule ----- -- 
INSERT INTO mengmei_auth_rule ( `id`, `pid`, `name`, `title`, `status`, `condition`, `isdel` ) VALUES ('26','23','rule/admindel','用户删除','1','5','0');
-- -------Records of mengmei_auth_rule ----- -- 
INSERT INTO mengmei_auth_rule ( `id`, `pid`, `name`, `title`, `status`, `condition`, `isdel` ) VALUES ('27','3','rule/rulelist','权限管理','1','','0');
-- -------Records of mengmei_auth_rule ----- -- 
INSERT INTO mengmei_auth_rule ( `id`, `pid`, `name`, `title`, `status`, `condition`, `isdel` ) VALUES ('28','18','rule/rulegroup','权限分配','1','','0');
-- -------Records of mengmei_auth_rule ----- -- 
INSERT INTO mengmei_auth_rule ( `id`, `pid`, `name`, `title`, `status`, `condition`, `isdel` ) VALUES ('29','27','rule/ruleedit','添加权限','1','1','0');
-- -------Records of mengmei_auth_rule ----- -- 
INSERT INTO mengmei_auth_rule ( `id`, `pid`, `name`, `title`, `status`, `condition`, `isdel` ) VALUES ('30','27','rule/ruleedit','添加子菜单','1','1','0');
-- -------Records of mengmei_auth_rule ----- -- 
INSERT INTO mengmei_auth_rule ( `id`, `pid`, `name`, `title`, `status`, `condition`, `isdel` ) VALUES ('31','27','rule/ruleedit','菜单修改','1','2','0');
-- -------Records of mengmei_auth_rule ----- -- 
INSERT INTO mengmei_auth_rule ( `id`, `pid`, `name`, `title`, `status`, `condition`, `isdel` ) VALUES ('32','27','rule/ruledel','菜单删除','1','5','0');
-- -------Records of mengmei_auth_rule ----- -- 
INSERT INTO mengmei_auth_rule ( `id`, `pid`, `name`, `title`, `status`, `condition`, `isdel` ) VALUES ('33','0','','数据库管理','1','','0');
-- -------Records of mengmei_auth_rule ----- -- 
INSERT INTO mengmei_auth_rule ( `id`, `pid`, `name`, `title`, `status`, `condition`, `isdel` ) VALUES ('87','50','backups/del_backups','数据删除','1','5','0');
-- -------Records of mengmei_auth_rule ----- -- 
INSERT INTO mengmei_auth_rule ( `id`, `pid`, `name`, `title`, `status`, `condition`, `isdel` ) VALUES ('88','50','backups/download','数据下载','1','3','0');
-- -------Records of mengmei_auth_rule ----- -- 
INSERT INTO mengmei_auth_rule ( `id`, `pid`, `name`, `title`, `status`, `condition`, `isdel` ) VALUES ('89','50','backups/import','数据还原','1','4','0');
-- -------Records of mengmei_auth_rule ----- -- 
INSERT INTO mengmei_auth_rule ( `id`, `pid`, `name`, `title`, `status`, `condition`, `isdel` ) VALUES ('37','0','','微信管理','1','','0');
-- -------Records of mengmei_auth_rule ----- -- 
INSERT INTO mengmei_auth_rule ( `id`, `pid`, `name`, `title`, `status`, `condition`, `isdel` ) VALUES ('38','37','wechatAccount/index','管理账号','1','','0');
-- -------Records of mengmei_auth_rule ----- -- 
INSERT INTO mengmei_auth_rule ( `id`, `pid`, `name`, `title`, `status`, `condition`, `isdel` ) VALUES ('39','37','wechatReply/index','关键字回复','1','','0');
-- -------Records of mengmei_auth_rule ----- -- 
INSERT INTO mengmei_auth_rule ( `id`, `pid`, `name`, `title`, `status`, `condition`, `isdel` ) VALUES ('94','37','wechatResource/source_list','素材管理','1','','0');
-- -------Records of mengmei_auth_rule ----- -- 
INSERT INTO mengmei_auth_rule ( `id`, `pid`, `name`, `title`, `status`, `condition`, `isdel` ) VALUES ('41','38','wechatAccount/accountedit','添加账号','1','1','0');
-- -------Records of mengmei_auth_rule ----- -- 
INSERT INTO mengmei_auth_rule ( `id`, `pid`, `name`, `title`, `status`, `condition`, `isdel` ) VALUES ('42','38','wechatAccount/accountedit','账号修改','1','2','0');
-- -------Records of mengmei_auth_rule ----- -- 
INSERT INTO mengmei_auth_rule ( `id`, `pid`, `name`, `title`, `status`, `condition`, `isdel` ) VALUES ('43','38','wechatAccount/accountdel','账号删除','1','5','0');
-- -------Records of mengmei_auth_rule ----- -- 
INSERT INTO mengmei_auth_rule ( `id`, `pid`, `name`, `title`, `status`, `condition`, `isdel` ) VALUES ('44','39','wechatReply/keyedit','添加关键字','1','1','0');
-- -------Records of mengmei_auth_rule ----- -- 
INSERT INTO mengmei_auth_rule ( `id`, `pid`, `name`, `title`, `status`, `condition`, `isdel` ) VALUES ('45','39','wechatReply/keyedit','关键字修改','1','2','0');
-- -------Records of mengmei_auth_rule ----- -- 
INSERT INTO mengmei_auth_rule ( `id`, `pid`, `name`, `title`, `status`, `condition`, `isdel` ) VALUES ('46','39','wechatReply/keydel','关键字删除','1','5','0');
-- -------Records of mengmei_auth_rule ----- -- 
INSERT INTO mengmei_auth_rule ( `id`, `pid`, `name`, `title`, `status`, `condition`, `isdel` ) VALUES ('47','38','wechat/reply','账号回复','1','2','0');
-- -------Records of mengmei_auth_rule ----- -- 
INSERT INTO mengmei_auth_rule ( `id`, `pid`, `name`, `title`, `status`, `condition`, `isdel` ) VALUES ('48','2','comments/index','评论管理','1','','1');
-- -------Records of mengmei_auth_rule ----- -- 
INSERT INTO mengmei_auth_rule ( `id`, `pid`, `name`, `title`, `status`, `condition`, `isdel` ) VALUES ('49','33','backups/backups','数据备份','1','','0');
-- -------Records of mengmei_auth_rule ----- -- 
INSERT INTO mengmei_auth_rule ( `id`, `pid`, `name`, `title`, `status`, `condition`, `isdel` ) VALUES ('50','33','backups/index','数据还原','1','','0');
-- -------Records of mengmei_auth_rule ----- -- 
INSERT INTO mengmei_auth_rule ( `id`, `pid`, `name`, `title`, `status`, `condition`, `isdel` ) VALUES ('51','67','message/index','客户留言','1','','0');
-- -------Records of mengmei_auth_rule ----- -- 
INSERT INTO mengmei_auth_rule ( `id`, `pid`, `name`, `title`, `status`, `condition`, `isdel` ) VALUES ('52','1','index/firendsurl','友情链接','1','','0');
-- -------Records of mengmei_auth_rule ----- -- 
INSERT INTO mengmei_auth_rule ( `id`, `pid`, `name`, `title`, `status`, `condition`, `isdel` ) VALUES ('53','2','expert/index','专家管理','1','','0');
-- -------Records of mengmei_auth_rule ----- -- 
INSERT INTO mengmei_auth_rule ( `id`, `pid`, `name`, `title`, `status`, `condition`, `isdel` ) VALUES ('54','53','expert/expert_edit','专家添加','1','1','0');
-- -------Records of mengmei_auth_rule ----- -- 
INSERT INTO mengmei_auth_rule ( `id`, `pid`, `name`, `title`, `status`, `condition`, `isdel` ) VALUES ('55','53','expert/expert_edit','专家修改','1','2','0');
-- -------Records of mengmei_auth_rule ----- -- 
INSERT INTO mengmei_auth_rule ( `id`, `pid`, `name`, `title`, `status`, `condition`, `isdel` ) VALUES ('56','53','expert/expert_del','专家删除','1','5','0');
-- -------Records of mengmei_auth_rule ----- -- 
INSERT INTO mengmei_auth_rule ( `id`, `pid`, `name`, `title`, `status`, `condition`, `isdel` ) VALUES ('58','2','advert/index','广告位管理','1','','0');
-- -------Records of mengmei_auth_rule ----- -- 
INSERT INTO mengmei_auth_rule ( `id`, `pid`, `name`, `title`, `status`, `condition`, `isdel` ) VALUES ('59','58','advert/advert_edit','广告位添加','1','1','0');
-- -------Records of mengmei_auth_rule ----- -- 
INSERT INTO mengmei_auth_rule ( `id`, `pid`, `name`, `title`, `status`, `condition`, `isdel` ) VALUES ('60','58','advert/advert_edit','广告位编辑','1','2','0');
-- -------Records of mengmei_auth_rule ----- -- 
INSERT INTO mengmei_auth_rule ( `id`, `pid`, `name`, `title`, `status`, `condition`, `isdel` ) VALUES ('61','58','advert/advert_del','广告位删除','1','5','0');
-- -------Records of mengmei_auth_rule ----- -- 
INSERT INTO mengmei_auth_rule ( `id`, `pid`, `name`, `title`, `status`, `condition`, `isdel` ) VALUES ('62','2','recover/index','回收站管理','1','','0');
-- -------Records of mengmei_auth_rule ----- -- 
INSERT INTO mengmei_auth_rule ( `id`, `pid`, `name`, `title`, `status`, `condition`, `isdel` ) VALUES ('63','62','recover/restore','数据还原','1','4','0');
-- -------Records of mengmei_auth_rule ----- -- 
INSERT INTO mengmei_auth_rule ( `id`, `pid`, `name`, `title`, `status`, `condition`, `isdel` ) VALUES ('64','62','recover/del','数据删除','1','5','0');
-- -------Records of mengmei_auth_rule ----- -- 
INSERT INTO mengmei_auth_rule ( `id`, `pid`, `name`, `title`, `status`, `condition`, `isdel` ) VALUES ('65','3','log/index','操作日志','1','','0');
-- -------Records of mengmei_auth_rule ----- -- 
INSERT INTO mengmei_auth_rule ( `id`, `pid`, `name`, `title`, `status`, `condition`, `isdel` ) VALUES ('66','67','member/index','会员管理','0','','0');
-- -------Records of mengmei_auth_rule ----- -- 
INSERT INTO mengmei_auth_rule ( `id`, `pid`, `name`, `title`, `status`, `condition`, `isdel` ) VALUES ('67','0','','成员管理','1','','0');
-- -------Records of mengmei_auth_rule ----- -- 
INSERT INTO mengmei_auth_rule ( `id`, `pid`, `name`, `title`, `status`, `condition`, `isdel` ) VALUES ('68','2','attachment/attach','附件管理','1','','0');
-- -------Records of mengmei_auth_rule ----- -- 
INSERT INTO mengmei_auth_rule ( `id`, `pid`, `name`, `title`, `status`, `condition`, `isdel` ) VALUES ('69','1','sitemap/sitelist','网站地图','1','','0');
-- -------Records of mengmei_auth_rule ----- -- 
INSERT INTO mengmei_auth_rule ( `id`, `pid`, `name`, `title`, `status`, `condition`, `isdel` ) VALUES ('70','66','member/membershow','会员查看','0','3','0');
-- -------Records of mengmei_auth_rule ----- -- 
INSERT INTO mengmei_auth_rule ( `id`, `pid`, `name`, `title`, `status`, `condition`, `isdel` ) VALUES ('71','66','member/memberdel','会员删除','0','5','0');
-- -------Records of mengmei_auth_rule ----- -- 
INSERT INTO mengmei_auth_rule ( `id`, `pid`, `name`, `title`, `status`, `condition`, `isdel` ) VALUES ('72','51','message/messshow','留言查看','1','3','0');
-- -------Records of mengmei_auth_rule ----- -- 
INSERT INTO mengmei_auth_rule ( `id`, `pid`, `name`, `title`, `status`, `condition`, `isdel` ) VALUES ('73','51','message/messdel','留言删除','1','5','0');
-- -------Records of mengmei_auth_rule ----- -- 
INSERT INTO mengmei_auth_rule ( `id`, `pid`, `name`, `title`, `status`, `condition`, `isdel` ) VALUES ('74','51','message/messedit','留言编辑','1','2','0');
-- -------Records of mengmei_auth_rule ----- -- 
INSERT INTO mengmei_auth_rule ( `id`, `pid`, `name`, `title`, `status`, `condition`, `isdel` ) VALUES ('75','65','log/logshow','日志查看','1','3','0');
-- -------Records of mengmei_auth_rule ----- -- 
INSERT INTO mengmei_auth_rule ( `id`, `pid`, `name`, `title`, `status`, `condition`, `isdel` ) VALUES ('76','65','log/logdel','日志删除','1','5','0');
-- -------Records of mengmei_auth_rule ----- -- 
INSERT INTO mengmei_auth_rule ( `id`, `pid`, `name`, `title`, `status`, `condition`, `isdel` ) VALUES ('77','68','attachment/attdel','附件删除','1','5','0');
-- -------Records of mengmei_auth_rule ----- -- 
INSERT INTO mengmei_auth_rule ( `id`, `pid`, `name`, `title`, `status`, `condition`, `isdel` ) VALUES ('78','69','sitemap/siteedit','地图编辑','1','2','0');
-- -------Records of mengmei_auth_rule ----- -- 
INSERT INTO mengmei_auth_rule ( `id`, `pid`, `name`, `title`, `status`, `condition`, `isdel` ) VALUES ('79','69','sitemap/index','地图查看','1','3','0');
-- -------Records of mengmei_auth_rule ----- -- 
INSERT INTO mengmei_auth_rule ( `id`, `pid`, `name`, `title`, `status`, `condition`, `isdel` ) VALUES ('80','69','sitemap/sitedel','地图删除','1','5','0');
-- -------Records of mengmei_auth_rule ----- -- 
INSERT INTO mengmei_auth_rule ( `id`, `pid`, `name`, `title`, `status`, `condition`, `isdel` ) VALUES ('81','69','sitemap/siteedit','地图添加','1','1','0');
-- -------Records of mengmei_auth_rule ----- -- 
INSERT INTO mengmei_auth_rule ( `id`, `pid`, `name`, `title`, `status`, `condition`, `isdel` ) VALUES ('82','2','mail/index','邮件管理','1','','0');
-- -------Records of mengmei_auth_rule ----- -- 
INSERT INTO mengmei_auth_rule ( `id`, `pid`, `name`, `title`, `status`, `condition`, `isdel` ) VALUES ('83','82','mail/mailedit','新增邮件','1','1','0');
-- -------Records of mengmei_auth_rule ----- -- 
INSERT INTO mengmei_auth_rule ( `id`, `pid`, `name`, `title`, `status`, `condition`, `isdel` ) VALUES ('84','82','mail/mailedit','编辑邮件','1','2','0');
-- -------Records of mengmei_auth_rule ----- -- 
INSERT INTO mengmei_auth_rule ( `id`, `pid`, `name`, `title`, `status`, `condition`, `isdel` ) VALUES ('85','82','mail/maildel','删除邮件','1','5','0');
-- -------Records of mengmei_auth_rule ----- -- 
INSERT INTO mengmei_auth_rule ( `id`, `pid`, `name`, `title`, `status`, `condition`, `isdel` ) VALUES ('86','82','mail/mailshow','邮件查看','1','3','0');
-- -------Records of mengmei_auth_rule ----- -- 
INSERT INTO mengmei_auth_rule ( `id`, `pid`, `name`, `title`, `status`, `condition`, `isdel` ) VALUES ('90','52','index/firendedit','链接添加','1','1','0');
-- -------Records of mengmei_auth_rule ----- -- 
INSERT INTO mengmei_auth_rule ( `id`, `pid`, `name`, `title`, `status`, `condition`, `isdel` ) VALUES ('91','52','index/firendedit','链接编辑','1','2','0');
-- -------Records of mengmei_auth_rule ----- -- 
INSERT INTO mengmei_auth_rule ( `id`, `pid`, `name`, `title`, `status`, `condition`, `isdel` ) VALUES ('92','52','index/firenddel','链接删除','1','5','0');
-- -------Records of mengmei_auth_rule ----- -- 
INSERT INTO mengmei_auth_rule ( `id`, `pid`, `name`, `title`, `status`, `condition`, `isdel` ) VALUES ('93','38','wechat/index','菜单管理','1','3','0');
-- -------Records of mengmei_auth_rule ----- -- 
INSERT INTO mengmei_auth_rule ( `id`, `pid`, `name`, `title`, `status`, `condition`, `isdel` ) VALUES ('95','94','wechatResource/source_edit','素材添加','1','1','0');
-- -------Records of mengmei_auth_rule ----- -- 
INSERT INTO mengmei_auth_rule ( `id`, `pid`, `name`, `title`, `status`, `condition`, `isdel` ) VALUES ('96','94','wechatResource/source_edit','素材编辑','1','2','0');
-- -------Records of mengmei_auth_rule ----- -- 
INSERT INTO mengmei_auth_rule ( `id`, `pid`, `name`, `title`, `status`, `condition`, `isdel` ) VALUES ('97','94','wechatResource/source_del','素材删除','1','5','0');
-- -------Records of mengmei_auth_rule ----- -- 
INSERT INTO mengmei_auth_rule ( `id`, `pid`, `name`, `title`, `status`, `condition`, `isdel` ) VALUES ('98','94','wechatResource/source_check','素材查看','1','3','0');
-- -------Records of mengmei_auth_rule ----- -- 
INSERT INTO mengmei_auth_rule ( `id`, `pid`, `name`, `title`, `status`, `condition`, `isdel` ) VALUES ('99','3','index/clearCache','清除缓存','1','','0');
-- --------Table structure for mengmei_category--------- -- 
DROP TABLE IF EXISTS `mengmei_category`;
-- ----------------- -- 
CREATE TABLE `mengmei_category` (
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
) ENGINE=MyISAM AUTO_INCREMENT=29 DEFAULT CHARSET=utf8 COMMENT='分类表';
-- -------Records of mengmei_category ----- -- 
INSERT INTO mengmei_category ( `id`, `pid`, `childid`, `name`, `link`, `isdel`, `mobile`, `pc`, `order` ) VALUES ('2','0','0','试管技术','authority','0','1','1','0');
-- -------Records of mengmei_category ----- -- 
INSERT INTO mengmei_category ( `id`, `pid`, `childid`, `name`, `link`, `isdel`, `mobile`, `pc`, `order` ) VALUES ('3','0','0','服务项目','services','0','1','1','0');
-- -------Records of mengmei_category ----- -- 
INSERT INTO mengmei_category ( `id`, `pid`, `childid`, `name`, `link`, `isdel`, `mobile`, `pc`, `order` ) VALUES ('4','0','0','美国专家','expert_list','0','1','1','');
-- -------Records of mengmei_category ----- -- 
INSERT INTO mengmei_category ( `id`, `pid`, `childid`, `name`, `link`, `isdel`, `mobile`, `pc`, `order` ) VALUES ('5','0','0','赴美流程','process','0','1','1','');
-- -------Records of mengmei_category ----- -- 
INSERT INTO mengmei_category ( `id`, `pid`, `childid`, `name`, `link`, `isdel`, `mobile`, `pc`, `order` ) VALUES ('6','0','0','总部医院','hospital_list','0','1','1','');
-- -------Records of mengmei_category ----- -- 
INSERT INTO mengmei_category ( `id`, `pid`, `childid`, `name`, `link`, `isdel`, `mobile`, `pc`, `order` ) VALUES ('7','0','0','新闻中心','','0','1','1','0');
-- -------Records of mengmei_category ----- -- 
INSERT INTO mengmei_category ( `id`, `pid`, `childid`, `name`, `link`, `isdel`, `mobile`, `pc`, `order` ) VALUES ('8','0','0','优选案例','','0','1','1','');
-- -------Records of mengmei_category ----- -- 
INSERT INTO mengmei_category ( `id`, `pid`, `childid`, `name`, `link`, `isdel`, `mobile`, `pc`, `order` ) VALUES ('9','0','0','合作机构','','0','0','1','0');
-- -------Records of mengmei_category ----- -- 
INSERT INTO mengmei_category ( `id`, `pid`, `childid`, `name`, `link`, `isdel`, `mobile`, `pc`, `order` ) VALUES ('10','0','0','常见问题','','0','1','1','');
-- -------Records of mengmei_category ----- -- 
INSERT INTO mengmei_category ( `id`, `pid`, `childid`, `name`, `link`, `isdel`, `mobile`, `pc`, `order` ) VALUES ('11','0','0','联系我们','contact','0','1','1','');
-- -------Records of mengmei_category ----- -- 
INSERT INTO mengmei_category ( `id`, `pid`, `childid`, `name`, `link`, `isdel`, `mobile`, `pc`, `order` ) VALUES ('17','10','0','专家答疑','expert_answer','0','1','1','0');
-- -------Records of mengmei_category ----- -- 
INSERT INTO mengmei_category ( `id`, `pid`, `childid`, `name`, `link`, `isdel`, `mobile`, `pc`, `order` ) VALUES ('15','8','0','客户案例','case_list_1','0','1','1','0');
-- -------Records of mengmei_category ----- -- 
INSERT INTO mengmei_category ( `id`, `pid`, `childid`, `name`, `link`, `isdel`, `mobile`, `pc`, `order` ) VALUES ('16','8','0','赴美动态','case_list_2','0','1','1','0');
-- -------Records of mengmei_category ----- -- 
INSERT INTO mengmei_category ( `id`, `pid`, `childid`, `name`, `link`, `isdel`, `mobile`, `pc`, `order` ) VALUES ('18','7','0','新闻动态','article_list','0','1','1','0');
-- -------Records of mengmei_category ----- -- 
INSERT INTO mengmei_category ( `id`, `pid`, `childid`, `name`, `link`, `isdel`, `mobile`, `pc`, `order` ) VALUES ('19','7','0','热点资讯','article_list','0','1','1','0');
-- -------Records of mengmei_category ----- -- 
INSERT INTO mengmei_category ( `id`, `pid`, `childid`, `name`, `link`, `isdel`, `mobile`, `pc`, `order` ) VALUES ('20','7','0','赴美资讯','article_list','0','1','1','0');
-- -------Records of mengmei_category ----- -- 
INSERT INTO mengmei_category ( `id`, `pid`, `childid`, `name`, `link`, `isdel`, `mobile`, `pc`, `order` ) VALUES ('21','7','0','赴美动态','article_list','0','1','1','0');
-- -------Records of mengmei_category ----- -- 
INSERT INTO mengmei_category ( `id`, `pid`, `childid`, `name`, `link`, `isdel`, `mobile`, `pc`, `order` ) VALUES ('22','10','0','相关攻略','article_list','0','1','1','0');
-- -------Records of mengmei_category ----- -- 
INSERT INTO mengmei_category ( `id`, `pid`, `childid`, `name`, `link`, `isdel`, `mobile`, `pc`, `order` ) VALUES ('23','7','0','赴美攻略','article_list','0','1','1','0');
-- -------Records of mengmei_category ----- -- 
INSERT INTO mengmei_category ( `id`, `pid`, `childid`, `name`, `link`, `isdel`, `mobile`, `pc`, `order` ) VALUES ('24','3','0','试管婴儿','article_list','0','1','1','0');
-- -------Records of mengmei_category ----- -- 
INSERT INTO mengmei_category ( `id`, `pid`, `childid`, `name`, `link`, `isdel`, `mobile`, `pc`, `order` ) VALUES ('25','3','0','专家会诊','expert_list','0','1','1','0');
-- -------Records of mengmei_category ----- -- 
INSERT INTO mengmei_category ( `id`, `pid`, `childid`, `name`, `link`, `isdel`, `mobile`, `pc`, `order` ) VALUES ('26','3','0','协调翻译','article_list','0','1','1','0');
-- -------Records of mengmei_category ----- -- 
INSERT INTO mengmei_category ( `id`, `pid`, `childid`, `name`, `link`, `isdel`, `mobile`, `pc`, `order` ) VALUES ('27','3','0','法律咨询','article_list','0','1','1','0');
-- -------Records of mengmei_category ----- -- 
INSERT INTO mengmei_category ( `id`, `pid`, `childid`, `name`, `link`, `isdel`, `mobile`, `pc`, `order` ) VALUES ('28','3','0','旅游观光','article_list','0','1','1','0');
-- --------Table structure for mengmei_expert--------- -- 
DROP TABLE IF EXISTS `mengmei_expert`;
-- ----------------- -- 
CREATE TABLE `mengmei_expert` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(50) NOT NULL COMMENT '专家名称',
  `sex` smallint(1) NOT NULL DEFAULT '1' COMMENT '专家性别 ：1.男，0.女',
  `age` int(11) NOT NULL COMMENT '年龄',
  `education` varchar(50) NOT NULL COMMENT '学历资质',
  `image` varchar(255) NOT NULL COMMENT '头像',
  `description` text NOT NULL COMMENT '简介',
  `hospital` varchar(100) NOT NULL COMMENT '所在医院',
  `job` varchar(100) NOT NULL COMMENT '职务',
  `content` mediumtext NOT NULL COMMENT '专家事迹',
  `isdel` tinyint(1) NOT NULL DEFAULT '0' COMMENT '是否删除：1.是，0.否',
  `status` tinyint(1) NOT NULL DEFAULT '1' COMMENT '是否显示：1.是，0.否',
  PRIMARY KEY (`id`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8 COMMENT='专家表';
-- --------Table structure for mengmei_invoice--------- -- 
DROP TABLE IF EXISTS `mengmei_invoice`;
-- ----------------- -- 
CREATE TABLE `mengmei_invoice` (
  `id` int(11) NOT NULL AUTO_INCREMENT COMMENT '主键自增',
  `head` varchar(100) NOT NULL COMMENT '发票抬头',
  `type` tinyint(1) NOT NULL DEFAULT '2' COMMENT '发票类型：1.普通发票，2.单位发票，3.增值税发票',
  `tax` varchar(50) NOT NULL COMMENT '税号',
  `province` int(11) NOT NULL COMMENT '省份',
  `city` int(11) NOT NULL COMMENT '城市',
  `town` int(11) NOT NULL COMMENT '镇',
  `address` varchar(100) NOT NULL COMMENT '详细地址',
  `phone` varchar(11) NOT NULL COMMENT '电话',
  `bank` varchar(18) NOT NULL COMMENT '开户行',
  `account` varchar(100) NOT NULL COMMENT '银行账户',
  `aliaccount` varchar(100) NOT NULL COMMENT '支付宝账户',
  `ctime` datetime DEFAULT NULL COMMENT '创建时间',
  `utime` datetime DEFAULT NULL COMMENT '修改时间',
  `isdel` tinyint(1) NOT NULL DEFAULT '0' COMMENT '是否删除：1.是，0.否',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='发票表';
-- --------Table structure for mengmei_invoice_info--------- -- 
DROP TABLE IF EXISTS `mengmei_invoice_info`;
-- ----------------- -- 
CREATE TABLE `mengmei_invoice_info` (
  `id` int(11) NOT NULL COMMENT '主键自增',
  `name` varchar(255) NOT NULL COMMENT '详细名称',
  `content` varchar(255) NOT NULL COMMENT '详细内容',
  `ctime` datetime DEFAULT NULL COMMENT '创建时间',
  `isdel` tinyint(1) NOT NULL COMMENT '是否删除：1.是，0.否',
  `invid` int(11) NOT NULL COMMENT '外键发票表id',
  PRIMARY KEY (`id`),
  KEY `invid` (`invid`),
  CONSTRAINT `mengmei_invoice_info_ibfk_1` FOREIGN KEY (`invid`) REFERENCES `mengmei_invoice` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='发票详细表';
-- --------Table structure for mengmei_link--------- -- 
DROP TABLE IF EXISTS `mengmei_link`;
-- ----------------- -- 
CREATE TABLE `mengmei_link` (
  `id` int(11) NOT NULL AUTO_INCREMENT COMMENT '主键自增',
  `name` varchar(50) NOT NULL,
  `img` varchar(255) NOT NULL COMMENT '图片',
  `url` varchar(255) NOT NULL COMMENT '链接地址',
  `isdel` tinyint(1) NOT NULL DEFAULT '0' COMMENT '是否删除：1是，0.否',
  `isshow` tinyint(1) NOT NULL DEFAULT '1' COMMENT '是否显示：1.是，0.否',
  PRIMARY KEY (`id`)
) ENGINE=MyISAM AUTO_INCREMENT=2 DEFAULT CHARSET=utf8 COMMENT='友情链接表';
-- -------Records of mengmei_link ----- -- 
INSERT INTO mengmei_link ( `id`, `name`, `img`, `url`, `isdel`, `isshow` ) VALUES ('1','随便来点什么','','sfds','0','1');
-- --------Table structure for mengmei_log--------- -- 
DROP TABLE IF EXISTS `mengmei_log`;
-- ----------------- -- 
CREATE TABLE `mengmei_log` (
  `id` int(11) NOT NULL AUTO_INCREMENT COMMENT '主键自增',
  `uid` int(11) NOT NULL COMMENT '操作用户id',
  `uname` varchar(255) NOT NULL COMMENT '操作用户名',
  `ip` varchar(255) NOT NULL COMMENT '操作用户当前ip',
  `tables` varchar(255) NOT NULL COMMENT '操作表名称',
  `tcomment` varchar(255) NOT NULL COMMENT '操作表注释',
  `log` varchar(255) NOT NULL COMMENT '简单的操作日志记录',
  `tid` int(11) NOT NULL COMMENT '操作表中的主键id',
  `type` tinyint(1) NOT NULL COMMENT '操作类型：1.增加，2.编辑，3.删除,4.还原',
  `ctime` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '操作时间',
  PRIMARY KEY (`id`),
  KEY `表名称` (`tables`),
  KEY `日期` (`ctime`)
) ENGINE=InnoDB AUTO_INCREMENT=11 DEFAULT CHARSET=utf8 COMMENT='日志操作表';
-- -------Records of mengmei_log ----- -- 
INSERT INTO mengmei_log ( `id`, `uid`, `uname`, `ip`, `tables`, `tcomment`, `log`, `tid`, `type`, `ctime` ) VALUES ('1','1','admin','127.0.0.1','auth_rule','规则表','管理员【admin】操作表‘auth_rule’新增了一条数据','99','1','2018-06-14 15:26:08');
-- -------Records of mengmei_log ----- -- 
INSERT INTO mengmei_log ( `id`, `uid`, `uname`, `ip`, `tables`, `tcomment`, `log`, `tid`, `type`, `ctime` ) VALUES ('2','1','admin','127.0.0.1','admin','管理员表','管理员【admin】操作表‘admin’新增了一条数据','7','1','2018-06-14 15:44:07');
-- -------Records of mengmei_log ----- -- 
INSERT INTO mengmei_log ( `id`, `uid`, `uname`, `ip`, `tables`, `tcomment`, `log`, `tid`, `type`, `ctime` ) VALUES ('3','1','admin','127.0.0.1','admin','管理员表','管理员【admin】操作表‘admin’修改了一条数据','7','2','2018-06-14 15:46:56');
-- -------Records of mengmei_log ----- -- 
INSERT INTO mengmei_log ( `id`, `uid`, `uname`, `ip`, `tables`, `tcomment`, `log`, `tid`, `type`, `ctime` ) VALUES ('4','1','admin','127.0.0.1','admin','管理员表','管理员【admin】操作表‘admin’修改了一条数据','7','2','2018-06-14 15:46:56');
-- -------Records of mengmei_log ----- -- 
INSERT INTO mengmei_log ( `id`, `uid`, `uname`, `ip`, `tables`, `tcomment`, `log`, `tid`, `type`, `ctime` ) VALUES ('5','1','admin','127.0.0.1','auth_access','用户组明细表','管理员【admin】操作表‘auth_access’删除了一条数据','7','3','2018-06-14 15:48:02');
-- -------Records of mengmei_log ----- -- 
INSERT INTO mengmei_log ( `id`, `uid`, `uname`, `ip`, `tables`, `tcomment`, `log`, `tid`, `type`, `ctime` ) VALUES ('6','1','admin','127.0.0.1','admin','管理员表','管理员【admin】操作表‘admin’删除了一条数据','7','3','2018-06-14 15:48:02');
-- -------Records of mengmei_log ----- -- 
INSERT INTO mengmei_log ( `id`, `uid`, `uname`, `ip`, `tables`, `tcomment`, `log`, `tid`, `type`, `ctime` ) VALUES ('7','1','admin','127.0.0.1','admin','管理员表','管理员【admin】操作表‘admin’新增了一条数据','2','1','2018-06-14 15:48:58');
-- -------Records of mengmei_log ----- -- 
INSERT INTO mengmei_log ( `id`, `uid`, `uname`, `ip`, `tables`, `tcomment`, `log`, `tid`, `type`, `ctime` ) VALUES ('8','1','admin','127.0.0.1','attachment','附件表','管理员【admin】操作表‘attachment’删除了一条数据','39','3','2018-06-14 16:02:44');
-- -------Records of mengmei_log ----- -- 
INSERT INTO mengmei_log ( `id`, `uid`, `uname`, `ip`, `tables`, `tcomment`, `log`, `tid`, `type`, `ctime` ) VALUES ('9','1','admin','127.0.0.1','link','友情链接表','管理员【admin】操作表‘link’新增了一条数据','1','1','2018-06-15 10:11:29');
-- -------Records of mengmei_log ----- -- 
INSERT INTO mengmei_log ( `id`, `uid`, `uname`, `ip`, `tables`, `tcomment`, `log`, `tid`, `type`, `ctime` ) VALUES ('10','1','admin','127.0.0.1','attachment','附件表','管理员【admin】操作表‘attachment’删除了一条数据','1','3','2018-06-19 14:46:20');
-- --------Table structure for mengmei_log_content--------- -- 
DROP TABLE IF EXISTS `mengmei_log_content`;
-- ----------------- -- 
CREATE TABLE `mengmei_log_content` (
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
  CONSTRAINT `mengmei_log_content_ibfk_1` FOREIGN KEY (`logid`) REFERENCES `mengmei_log` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=28 DEFAULT CHARSET=utf8 COMMENT='操作日志从表';
-- -------Records of mengmei_log_content ----- -- 
INSERT INTO mengmei_log_content ( `id`, `tfield`, `toldvalue`, `tnewvalue`, `tcomment`, `logid`, `tid`, `ctime` ) VALUES ('1','id','99','','','1','99','2018-06-14 15:26:08');
-- -------Records of mengmei_log_content ----- -- 
INSERT INTO mengmei_log_content ( `id`, `tfield`, `toldvalue`, `tnewvalue`, `tcomment`, `logid`, `tid`, `ctime` ) VALUES ('2','pid','3','','父级id','1','99','2018-06-14 15:26:08');
-- -------Records of mengmei_log_content ----- -- 
INSERT INTO mengmei_log_content ( `id`, `tfield`, `toldvalue`, `tnewvalue`, `tcomment`, `logid`, `tid`, `ctime` ) VALUES ('3','name','index/clearCache','','规则唯一标识，如：Admin/article/index','1','99','2018-06-14 15:26:08');
-- -------Records of mengmei_log_content ----- -- 
INSERT INTO mengmei_log_content ( `id`, `tfield`, `toldvalue`, `tnewvalue`, `tcomment`, `logid`, `tid`, `ctime` ) VALUES ('4','title','清除缓存','','规则中文名称','1','99','2018-06-14 15:26:08');
-- -------Records of mengmei_log_content ----- -- 
INSERT INTO mengmei_log_content ( `id`, `tfield`, `toldvalue`, `tnewvalue`, `tcomment`, `logid`, `tid`, `ctime` ) VALUES ('5','status','1','','状态：1：启用，0：禁用','1','99','2018-06-14 15:26:08');
-- -------Records of mengmei_log_content ----- -- 
INSERT INTO mengmei_log_content ( `id`, `tfield`, `toldvalue`, `tnewvalue`, `tcomment`, `logid`, `tid`, `ctime` ) VALUES ('6','condition','','','规则表达式，为空表示存在就验证，不为空表示按照条件验证
自定义三级操作：
1.添加，2.编辑，3.查看，4.还原，5.删除','1','99','2018-06-14 15:26:08');
-- -------Records of mengmei_log_content ----- -- 
INSERT INTO mengmei_log_content ( `id`, `tfield`, `toldvalue`, `tnewvalue`, `tcomment`, `logid`, `tid`, `ctime` ) VALUES ('7','isdel','0','','是否删除：1：是，0：否','1','99','2018-06-14 15:26:08');
-- -------Records of mengmei_log_content ----- -- 
INSERT INTO mengmei_log_content ( `id`, `tfield`, `toldvalue`, `tnewvalue`, `tcomment`, `logid`, `tid`, `ctime` ) VALUES ('8','id','7','','','2','7','2018-06-14 15:44:07');
-- -------Records of mengmei_log_content ----- -- 
INSERT INTO mengmei_log_content ( `id`, `tfield`, `toldvalue`, `tnewvalue`, `tcomment`, `logid`, `tid`, `ctime` ) VALUES ('9','name','user','','用户名','2','7','2018-06-14 15:44:07');
-- -------Records of mengmei_log_content ----- -- 
INSERT INTO mengmei_log_content ( `id`, `tfield`, `toldvalue`, `tnewvalue`, `tcomment`, `logid`, `tid`, `ctime` ) VALUES ('10','pass','87d9bb400c0634691f0e3baaf1e2fd0d','','用户密码','2','7','2018-06-14 15:44:07');
-- -------Records of mengmei_log_content ----- -- 
INSERT INTO mengmei_log_content ( `id`, `tfield`, `toldvalue`, `tnewvalue`, `tcomment`, `logid`, `tid`, `ctime` ) VALUES ('11','status','1','','状态：1.正常，0.禁用','2','7','2018-06-14 15:44:07');
-- -------Records of mengmei_log_content ----- -- 
INSERT INTO mengmei_log_content ( `id`, `tfield`, `toldvalue`, `tnewvalue`, `tcomment`, `logid`, `tid`, `ctime` ) VALUES ('12','groupid','2','','用户组id','2','7','2018-06-14 15:44:07');
-- -------Records of mengmei_log_content ----- -- 
INSERT INTO mengmei_log_content ( `id`, `tfield`, `toldvalue`, `tnewvalue`, `tcomment`, `logid`, `tid`, `ctime` ) VALUES ('13','lastip','','','最后登录ip','2','7','2018-06-14 15:44:07');
-- -------Records of mengmei_log_content ----- -- 
INSERT INTO mengmei_log_content ( `id`, `tfield`, `toldvalue`, `tnewvalue`, `tcomment`, `logid`, `tid`, `ctime` ) VALUES ('14','lasttime','','','最后登陆时间','2','7','2018-06-14 15:44:07');
-- -------Records of mengmei_log_content ----- -- 
INSERT INTO mengmei_log_content ( `id`, `tfield`, `toldvalue`, `tnewvalue`, `tcomment`, `logid`, `tid`, `ctime` ) VALUES ('15','id','2','','','7','2','2018-06-14 15:48:58');
-- -------Records of mengmei_log_content ----- -- 
INSERT INTO mengmei_log_content ( `id`, `tfield`, `toldvalue`, `tnewvalue`, `tcomment`, `logid`, `tid`, `ctime` ) VALUES ('16','name','user','','用户名','7','2','2018-06-14 15:48:58');
-- -------Records of mengmei_log_content ----- -- 
INSERT INTO mengmei_log_content ( `id`, `tfield`, `toldvalue`, `tnewvalue`, `tcomment`, `logid`, `tid`, `ctime` ) VALUES ('17','pass','87d9bb400c0634691f0e3baaf1e2fd0d','','用户密码','7','2','2018-06-14 15:48:58');
-- -------Records of mengmei_log_content ----- -- 
INSERT INTO mengmei_log_content ( `id`, `tfield`, `toldvalue`, `tnewvalue`, `tcomment`, `logid`, `tid`, `ctime` ) VALUES ('18','status','1','','状态：1.正常，0.禁用','7','2','2018-06-14 15:48:58');
-- -------Records of mengmei_log_content ----- -- 
INSERT INTO mengmei_log_content ( `id`, `tfield`, `toldvalue`, `tnewvalue`, `tcomment`, `logid`, `tid`, `ctime` ) VALUES ('19','groupid','2','','用户组id','7','2','2018-06-14 15:48:58');
-- -------Records of mengmei_log_content ----- -- 
INSERT INTO mengmei_log_content ( `id`, `tfield`, `toldvalue`, `tnewvalue`, `tcomment`, `logid`, `tid`, `ctime` ) VALUES ('20','lastip','','','最后登录ip','7','2','2018-06-14 15:48:58');
-- -------Records of mengmei_log_content ----- -- 
INSERT INTO mengmei_log_content ( `id`, `tfield`, `toldvalue`, `tnewvalue`, `tcomment`, `logid`, `tid`, `ctime` ) VALUES ('21','lasttime','','','最后登陆时间','7','2','2018-06-14 15:48:58');
-- -------Records of mengmei_log_content ----- -- 
INSERT INTO mengmei_log_content ( `id`, `tfield`, `toldvalue`, `tnewvalue`, `tcomment`, `logid`, `tid`, `ctime` ) VALUES ('22','id','1','','','9','1','2018-06-15 10:11:29');
-- -------Records of mengmei_log_content ----- -- 
INSERT INTO mengmei_log_content ( `id`, `tfield`, `toldvalue`, `tnewvalue`, `tcomment`, `logid`, `tid`, `ctime` ) VALUES ('23','name','随便来点什么','','','9','1','2018-06-15 10:11:29');
-- -------Records of mengmei_log_content ----- -- 
INSERT INTO mengmei_log_content ( `id`, `tfield`, `toldvalue`, `tnewvalue`, `tcomment`, `logid`, `tid`, `ctime` ) VALUES ('24','img','','','图片','9','1','2018-06-15 10:11:29');
-- -------Records of mengmei_log_content ----- -- 
INSERT INTO mengmei_log_content ( `id`, `tfield`, `toldvalue`, `tnewvalue`, `tcomment`, `logid`, `tid`, `ctime` ) VALUES ('25','url','sfds','','链接地址','9','1','2018-06-15 10:11:29');
-- -------Records of mengmei_log_content ----- -- 
INSERT INTO mengmei_log_content ( `id`, `tfield`, `toldvalue`, `tnewvalue`, `tcomment`, `logid`, `tid`, `ctime` ) VALUES ('26','isdel','0','','是否删除：1是，0.否','9','1','2018-06-15 10:11:29');
-- -------Records of mengmei_log_content ----- -- 
INSERT INTO mengmei_log_content ( `id`, `tfield`, `toldvalue`, `tnewvalue`, `tcomment`, `logid`, `tid`, `ctime` ) VALUES ('27','isshow','1','','是否显示：1.是，0.否','9','1','2018-06-15 10:11:29');
-- --------Table structure for mengmei_mail--------- -- 
DROP TABLE IF EXISTS `mengmei_mail`;
-- ----------------- -- 
CREATE TABLE `mengmei_mail` (
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
-- --------Table structure for mengmei_member--------- -- 
DROP TABLE IF EXISTS `mengmei_member`;
-- ----------------- -- 
CREATE TABLE `mengmei_member` (
  `id` int(11) NOT NULL COMMENT '主键自增',
  `user` varchar(20) DEFAULT NULL COMMENT '会员昵称',
  `name` varchar(20) DEFAULT NULL COMMENT '会员真实名',
  `sex` tinyint(1) DEFAULT '1' COMMENT '性别：1.男，0.女',
  `mobile` varchar(11) DEFAULT NULL COMMENT '电话',
  `mail` varchar(50) DEFAULT NULL COMMENT '邮箱',
  `ctime` datetime DEFAULT NULL COMMENT '注册时间',
  `isdel` tinyint(1) DEFAULT NULL COMMENT '是否删除：1.是，0.否',
  `type` tinyint(1) DEFAULT NULL COMMENT '会员等级：1-7星',
  PRIMARY KEY (`id`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8 COMMENT='会员表';
-- --------Table structure for mengmei_message--------- -- 
DROP TABLE IF EXISTS `mengmei_message`;
-- ----------------- -- 
CREATE TABLE `mengmei_message` (
  `id` int(11) NOT NULL AUTO_INCREMENT COMMENT '主键自增',
  `name` varchar(20) NOT NULL COMMENT '留言人名称',
  `sex` tinyint(1) NOT NULL DEFAULT '1' COMMENT '性别：1.男，0.女',
  `age` tinyint(1) NOT NULL COMMENT '年龄范围：1.35一下，2.35-40岁，3.41-45岁，4.45以上',
  `wechat` varchar(100) NOT NULL COMMENT '微信号',
  `mobile` varchar(11) NOT NULL COMMENT '移动电话',
  `mail` varchar(255) NOT NULL COMMENT '邮箱',
  `address` varchar(255) NOT NULL COMMENT '留言地址',
  `message` text NOT NULL COMMENT '客户留言内容',
  `type` tinyint(1) NOT NULL COMMENT '人群类型：1.异性，2.单身，3.同性',
  `ctime` datetime DEFAULT NULL COMMENT '留言时间',
  `status` tinyint(1) NOT NULL COMMENT '生育状态：1.未育，2.一胎，3.二胎',
  `will` tinyint(1) NOT NULL COMMENT '意向：1.冻卵，2.性别选择，3.代孕',
  `isone` tinyint(1) NOT NULL COMMENT '是否安排一对一：1.是，0.否',
  `source` tinyint(1) NOT NULL COMMENT '来源：1.pc，2.移动',
  `back` tinyint(1) NOT NULL DEFAULT '0' COMMENT '反馈状态：1.是，0.否',
  `backtime` datetime DEFAULT NULL COMMENT '反馈时间',
  `info` tinyint(1) NOT NULL DEFAULT '0' COMMENT '留言信息是否完整：1是，0.否',
  `isdel` tinyint(1) NOT NULL DEFAULT '0' COMMENT '删除状态：1.是，0.否',
  PRIMARY KEY (`id`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8 COMMENT='客户留言表';
-- --------Table structure for mengmei_recover--------- -- 
DROP TABLE IF EXISTS `mengmei_recover`;
-- ----------------- -- 
CREATE TABLE `mengmei_recover` (
  `id` int(11) NOT NULL AUTO_INCREMENT COMMENT '主键自增',
  `name` varchar(50) NOT NULL COMMENT '表名称',
  `notes` varchar(50) NOT NULL COMMENT '表注释',
  `reid` int(11) NOT NULL COMMENT '对应表的主键id',
  `time` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '回收时间',
  PRIMARY KEY (`id`)
) ENGINE=MyISAM AUTO_INCREMENT=3 DEFAULT CHARSET=utf8 COMMENT='回收站表';
-- --------Table structure for mengmei_sitemap--------- -- 
DROP TABLE IF EXISTS `mengmei_sitemap`;
-- ----------------- -- 
CREATE TABLE `mengmei_sitemap` (
  `id` int(11) NOT NULL AUTO_INCREMENT COMMENT '主键自增',
  `name` varchar(30) NOT NULL COMMENT '名称',
  `url` varchar(255) NOT NULL COMMENT '跳转地址',
  `ctime` datetime NOT NULL COMMENT '创建时间',
  `sites` tinyint(1) NOT NULL COMMENT '类型：1.网站地图，2.专题',
  `isdel` tinyint(1) NOT NULL COMMENT '是否删除：1.是，0.否',
  PRIMARY KEY (`id`)
) ENGINE=MyISAM AUTO_INCREMENT=13 DEFAULT CHARSET=utf8 COMMENT='网站地图';
-- -------Records of mengmei_sitemap ----- -- 
INSERT INTO mengmei_sitemap ( `id`, `name`, `url`, `ctime`, `sites`, `isdel` ) VALUES ('1','首页','http://www.mengmei.org','2018-05-07 13:02:30','1','0');
-- -------Records of mengmei_sitemap ----- -- 
INSERT INTO mengmei_sitemap ( `id`, `name`, `url`, `ctime`, `sites`, `isdel` ) VALUES ('2','试管技术','http://www.xxx.com','2018-05-07 13:02:34','1','0');
-- -------Records of mengmei_sitemap ----- -- 
INSERT INTO mengmei_sitemap ( `id`, `name`, `url`, `ctime`, `sites`, `isdel` ) VALUES ('3','服务项目','','2018-05-07 13:05:44','1','0');
-- -------Records of mengmei_sitemap ----- -- 
INSERT INTO mengmei_sitemap ( `id`, `name`, `url`, `ctime`, `sites`, `isdel` ) VALUES ('4','美国专家','','2018-05-07 13:05:48','1','0');
-- -------Records of mengmei_sitemap ----- -- 
INSERT INTO mengmei_sitemap ( `id`, `name`, `url`, `ctime`, `sites`, `isdel` ) VALUES ('5','赴美流程','','2018-05-07 13:05:50','1','0');
-- -------Records of mengmei_sitemap ----- -- 
INSERT INTO mengmei_sitemap ( `id`, `name`, `url`, `ctime`, `sites`, `isdel` ) VALUES ('6','总部医院','','2018-05-07 13:05:54','1','0');
-- -------Records of mengmei_sitemap ----- -- 
INSERT INTO mengmei_sitemap ( `id`, `name`, `url`, `ctime`, `sites`, `isdel` ) VALUES ('7','最新资讯','','2018-05-07 13:05:57','1','0');
-- -------Records of mengmei_sitemap ----- -- 
INSERT INTO mengmei_sitemap ( `id`, `name`, `url`, `ctime`, `sites`, `isdel` ) VALUES ('8','优选案例','','2018-05-07 13:05:59','1','0');
-- -------Records of mengmei_sitemap ----- -- 
INSERT INTO mengmei_sitemap ( `id`, `name`, `url`, `ctime`, `sites`, `isdel` ) VALUES ('9','合作机构','','2018-05-07 13:06:01','1','0');
-- -------Records of mengmei_sitemap ----- -- 
INSERT INTO mengmei_sitemap ( `id`, `name`, `url`, `ctime`, `sites`, `isdel` ) VALUES ('10','常见问题','','2018-05-07 13:06:04','1','0');
-- -------Records of mengmei_sitemap ----- -- 
INSERT INTO mengmei_sitemap ( `id`, `name`, `url`, `ctime`, `sites`, `isdel` ) VALUES ('11','联系我们','','2018-05-07 13:06:07','1','0');
-- -------Records of mengmei_sitemap ----- -- 
INSERT INTO mengmei_sitemap ( `id`, `name`, `url`, `ctime`, `sites`, `isdel` ) VALUES ('12','ces ','','2018-05-11 14:51:05','1','1');
-- --------Table structure for mengmei_wechat_account--------- -- 
DROP TABLE IF EXISTS `mengmei_wechat_account`;
-- ----------------- -- 
CREATE TABLE `mengmei_wechat_account` (
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
) ENGINE=MyISAM AUTO_INCREMENT=2 DEFAULT CHARSET=utf8 COMMENT='微信公众号表';
-- -------Records of mengmei_wechat_account ----- -- 
INSERT INTO mengmei_wechat_account ( `id`, `name`, `initid`, `appid`, `appsecret`, `encodingaeskey`, `token`, `type`, `isdel` ) VALUES ('1','可可清清','gh_494e71c88bc1','wx9ba4db6a2438d3c4','26a4e995c4e393b7721117068883aa76','','5ZEhiG0RvUcKru4xMr7V','1','0');
-- --------Table structure for mengmei_wechat_menu--------- -- 
DROP TABLE IF EXISTS `mengmei_wechat_menu`;
-- ----------------- -- 
CREATE TABLE `mengmei_wechat_menu` (
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
-- --------Table structure for mengmei_wechat_reply--------- -- 
DROP TABLE IF EXISTS `mengmei_wechat_reply`;
-- ----------------- -- 
CREATE TABLE `mengmei_wechat_reply` (
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
-- --------Table structure for mengmei_wechat_resource--------- -- 
DROP TABLE IF EXISTS `mengmei_wechat_resource`;
-- ----------------- -- 
CREATE TABLE `mengmei_wechat_resource` (
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
) ENGINE=MyISAM AUTO_INCREMENT=10 DEFAULT CHARSET=utf8 COMMENT='微信素材主表';
-- -------Records of mengmei_wechat_resource ----- -- 
INSERT INTO mengmei_wechat_resource ( `id`, `media_id`, `ctime`, `utime`, `stime`, `sourse_num`, `send_num`, `wechat_id`, `isdel` ) VALUES ('7','VlnuIP8JKdzFH8NZOGn_N7T4htFkAlYPNnnec4RONTg','2018-06-15 11:14:23','2018-06-15 10:52:17','','1','0','1','0');
-- -------Records of mengmei_wechat_resource ----- -- 
INSERT INTO mengmei_wechat_resource ( `id`, `media_id`, `ctime`, `utime`, `stime`, `sourse_num`, `send_num`, `wechat_id`, `isdel` ) VALUES ('8','VlnuIP8JKdzFH8NZOGn_Nzv6qSUTs9mXCwT25eyAaX8','2018-06-15 11:14:23','2018-06-15 10:44:53','','3','0','1','0');
-- -------Records of mengmei_wechat_resource ----- -- 
INSERT INTO mengmei_wechat_resource ( `id`, `media_id`, `ctime`, `utime`, `stime`, `sourse_num`, `send_num`, `wechat_id`, `isdel` ) VALUES ('9','VlnuIP8JKdzFH8NZOGn_N1fcMbGEXsHkZmskJJN1Q2I','2018-06-15 11:14:23','2018-06-14 13:56:46','','4','0','1','0');
-- --------Table structure for mengmei_wechat_resource_list--------- -- 
DROP TABLE IF EXISTS `mengmei_wechat_resource_list`;
-- ----------------- -- 
CREATE TABLE `mengmei_wechat_resource_list` (
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
) ENGINE=MyISAM AUTO_INCREMENT=25 DEFAULT CHARSET=utf8 COMMENT='微信素材从表';
-- -------Records of mengmei_wechat_resource_list ----- -- 
INSERT INTO mengmei_wechat_resource_list ( `id`, `media_id`, `title`, `author`, `digest`, `content`, `content_source_url`, `thumb_media_id`, `show_cover_pic`, `url`, `thumb_url`, `local_image`, `need_open_comment`, `only_fans_can_comment`, `ctime`, `utime`, `up`, `source_id`, `isdel` ) VALUES ('1','VlnuIP8JKdzFH8NZOGn_N7T4htFkAlYPNnnec4RONTg','说的放松的方式','发生的发生的','说的分手的','fggddfg','http://www.baidu.com','VlnuIP8JKdzFH8NZOGn_N6H3Cn52gE_UQV_mkAdx8g0','1','http://mp.weixin.qq.com/s?__biz=MzIwMzQ0MzA1Nw==&mid=100000049&idx=1&sn=960c11e5787fe8e02a65b8e4f482e1a0&chksm=16ce1f2f21b996392395e7e10ac155fcb3d7fff4f48a948e138580143ced0bd5e6e30ece1d56#rd','http://mmbiz.qpic.cn/mmbiz_jpg/nE2Uiamuqzs13mibHPUhxSseMnfL6021nhF16p4jGy6NhztL6wUwetc5TuDFY5OOCLYmqfpzwkGnSu5Qa24geCPQ/0?wx_fmt=jpeg','','1','0','2018-06-15 10:52:17','2018-06-15 10:52:17','1','1','0');
-- -------Records of mengmei_wechat_resource_list ----- -- 
INSERT INTO mengmei_wechat_resource_list ( `id`, `media_id`, `title`, `author`, `digest`, `content`, `content_source_url`, `thumb_media_id`, `show_cover_pic`, `url`, `thumb_url`, `local_image`, `need_open_comment`, `only_fans_can_comment`, `ctime`, `utime`, `up`, `source_id`, `isdel` ) VALUES ('2','VlnuIP8JKdzFH8NZOGn_Nzv6qSUTs9mXCwT25eyAaX8','my father is my son','son','尽瞎鸡巴扯淡','尽瞎鸡巴扯淡尽瞎鸡巴扯淡尽瞎鸡巴扯淡','','VlnuIP8JKdzFH8NZOGn_N5IhJPNh6qSHPin6hi3aeNA','1','http://mp.weixin.qq.com/s?__biz=MzIwMzQ0MzA1Nw==&mid=100000047&idx=1&sn=314615c3c827e3e8fcde7c267a7172ba&chksm=16ce1f3121b99627ae39aa4ece0e262b389155dfbbf18c7179145637a301a2a433bfa33014af#rd','http://mmbiz.qpic.cn/mmbiz_jpg/nE2Uiamuqzs13mibHPUhxSseMnfL6021nhF8vxOILpfUKKkTx4w3bJibxe1ux7KZxbg4tbtJkvhtLpicM2UZbv9Q1A/0?wx_fmt=jpeg','','1','0','2018-06-15 10:44:53','2018-06-15 10:44:53','1','2','0');
-- -------Records of mengmei_wechat_resource_list ----- -- 
INSERT INTO mengmei_wechat_resource_list ( `id`, `media_id`, `title`, `author`, `digest`, `content`, `content_source_url`, `thumb_media_id`, `show_cover_pic`, `url`, `thumb_url`, `local_image`, `need_open_comment`, `only_fans_can_comment`, `ctime`, `utime`, `up`, `source_id`, `isdel` ) VALUES ('3','VlnuIP8JKdzFH8NZOGn_Nzv6qSUTs9mXCwT25eyAaX8','美女的写好','还','受到法律撒','法规规范地方&nbsp;&nbsp;','','VlnuIP8JKdzFH8NZOGn_N_h4et0pY7trN_SUsxsNc3I','1','http://mp.weixin.qq.com/s?__biz=MzIwMzQ0MzA1Nw==&mid=100000047&idx=2&sn=0c5020cb6f105bdb25dd690bb7e41dd6&chksm=16ce1f3121b99627fedb482eb13cf7e84c58c7983491ab82858daf45d66251d1b5ad6ff90117#rd','http://mmbiz.qpic.cn/mmbiz_jpg/nE2Uiamuqzs13mibHPUhxSseMnfL6021nhYujpJJNRIT6PmNQLmYqHlvNlf01pUw8kVyrKcd43YibdlPRRoknjr9A/0?wx_fmt=jpeg','','1','0','2018-06-15 10:44:53','2018-06-15 10:44:53','1','2','0');
-- -------Records of mengmei_wechat_resource_list ----- -- 
INSERT INTO mengmei_wechat_resource_list ( `id`, `media_id`, `title`, `author`, `digest`, `content`, `content_source_url`, `thumb_media_id`, `show_cover_pic`, `url`, `thumb_url`, `local_image`, `need_open_comment`, `only_fans_can_comment`, `ctime`, `utime`, `up`, `source_id`, `isdel` ) VALUES ('4','VlnuIP8JKdzFH8NZOGn_Nzv6qSUTs9mXCwT25eyAaX8','素材删除','妈呀马丁','萨法萨法','上的放松放松啊&nbsp;','','VlnuIP8JKdzFH8NZOGn_NymSRCH1IGzOoe0hB-6_cbM','1','http://mp.weixin.qq.com/s?__biz=MzIwMzQ0MzA1Nw==&mid=100000047&idx=3&sn=b756ecce2ca9e9a45bf21b2749a8fecb&chksm=16ce1f3121b996273771cdf73768b547018193b72c78ccc57fc092f1b76f849de50f36d86b0f#rd','http://mmbiz.qpic.cn/mmbiz_jpg/nE2Uiamuqzs13mibHPUhxSseMnfL6021nhYujpJJNRIT6PmNQLmYqHlvNlf01pUw8kVyrKcd43YibdlPRRoknjr9A/0?wx_fmt=jpeg','','1','0','2018-06-15 10:44:53','2018-06-15 10:44:53','1','2','0');
-- -------Records of mengmei_wechat_resource_list ----- -- 
INSERT INTO mengmei_wechat_resource_list ( `id`, `media_id`, `title`, `author`, `digest`, `content`, `content_source_url`, `thumb_media_id`, `show_cover_pic`, `url`, `thumb_url`, `local_image`, `need_open_comment`, `only_fans_can_comment`, `ctime`, `utime`, `up`, `source_id`, `isdel` ) VALUES ('5','VlnuIP8JKdzFH8NZOGn_N1fcMbGEXsHkZmskJJN1Q2I','北大引来了歌星','哦自己','对了可以看卡','对了可以看卡对了可以看卡对了可以看卡对了可以看卡对了可以看卡对了可以看卡对了可以看卡','','VlnuIP8JKdzFH8NZOGn_N370hf9CVB3Ctfw6eC8Hni0','1','http://mp.weixin.qq.com/s?__biz=MzIwMzQ0MzA1Nw==&mid=100000041&idx=1&sn=9ab86ad96e9699a21327d7234578b955&chksm=16ce1f3721b99621e6304385b2848c68435835d1020e3403d5eae73fecba17f259fe73865d4e#rd','http://mmbiz.qpic.cn/mmbiz_jpg/nE2Uiamuqzs19ynlVK7JOHkpf5cFKgXToicWOeibpa3bZmbBx4oXULdSzer2w3wpPhTfq8Xsef991ianHl90gQibADA/0?wx_fmt=jpeg','','1','0','2018-06-14 13:56:46','2018-06-14 13:56:46','1','3','0');
-- -------Records of mengmei_wechat_resource_list ----- -- 
INSERT INTO mengmei_wechat_resource_list ( `id`, `media_id`, `title`, `author`, `digest`, `content`, `content_source_url`, `thumb_media_id`, `show_cover_pic`, `url`, `thumb_url`, `local_image`, `need_open_comment`, `only_fans_can_comment`, `ctime`, `utime`, `up`, `source_id`, `isdel` ) VALUES ('6','VlnuIP8JKdzFH8NZOGn_N1fcMbGEXsHkZmskJJN1Q2I','真的吗？','来历','第三范式淡然是真的','第三范式淡然是真的第三范式淡然是真的第三范式淡然是真的第三范式淡然是真的','','VlnuIP8JKdzFH8NZOGn_N2i9qP5HIBXhPUqwLS27oS0','1','http://mp.weixin.qq.com/s?__biz=MzIwMzQ0MzA1Nw==&mid=100000041&idx=2&sn=125d7f5d34c44b2065cecc6de65c50a7&chksm=16ce1f3721b99621bc546274533b60610a0d61ada8833ff107825307903d5f5bcf7d32b9447a#rd','http://mmbiz.qpic.cn/mmbiz_jpg/nE2Uiamuqzs19ynlVK7JOHkpf5cFKgXTo8lKtic7JhBwuKUlJjmuhrIaddibldrPYoh0wyjju31oYqn689BQS7VMQ/0?wx_fmt=jpeg','','1','0','2018-06-14 13:56:46','2018-06-14 13:56:46','1','3','0');
-- -------Records of mengmei_wechat_resource_list ----- -- 
INSERT INTO mengmei_wechat_resource_list ( `id`, `media_id`, `title`, `author`, `digest`, `content`, `content_source_url`, `thumb_media_id`, `show_cover_pic`, `url`, `thumb_url`, `local_image`, `need_open_comment`, `only_fans_can_comment`, `ctime`, `utime`, `up`, `source_id`, `isdel` ) VALUES ('7','VlnuIP8JKdzFH8NZOGn_N1fcMbGEXsHkZmskJJN1Q2I','我是不信的','我是不信的','我是不信的','我是不信的我是不信的我是不信的','','VlnuIP8JKdzFH8NZOGn_N8L4Sa_d-7fHuFugetdeDh8','1','http://mp.weixin.qq.com/s?__biz=MzIwMzQ0MzA1Nw==&mid=100000041&idx=3&sn=dcbe69c2090b48f9a6e286ef7c7fabe4&chksm=16ce1f3721b99621e05b006a211dbd13dd1fd5359496a90978350a5fd6cc394f958669ea4fff#rd','http://mmbiz.qpic.cn/mmbiz_jpg/nE2Uiamuqzs19ynlVK7JOHkpf5cFKgXTofLUAwcJ4U7gyBUnpHPzJ0xW8xTW3YHakKXnF9ZatSPxMGPg98K9zNg/0?wx_fmt=jpeg','','1','0','2018-06-14 13:56:46','2018-06-14 13:56:46','1','3','0');
-- -------Records of mengmei_wechat_resource_list ----- -- 
INSERT INTO mengmei_wechat_resource_list ( `id`, `media_id`, `title`, `author`, `digest`, `content`, `content_source_url`, `thumb_media_id`, `show_cover_pic`, `url`, `thumb_url`, `local_image`, `need_open_comment`, `only_fans_can_comment`, `ctime`, `utime`, `up`, `source_id`, `isdel` ) VALUES ('8','VlnuIP8JKdzFH8NZOGn_N1fcMbGEXsHkZmskJJN1Q2I','你爱信不信','切','滚犊子','滚犊子滚犊子滚犊子滚犊子','','VlnuIP8JKdzFH8NZOGn_N_c46CRMI7o6yC3T0G7m5D4','1','http://mp.weixin.qq.com/s?__biz=MzIwMzQ0MzA1Nw==&mid=100000041&idx=4&sn=0076f0266b1bb1eee70067e912b7be1f&chksm=16ce1f3721b99621bf6cf736229b4d68b554333029a47bd555411d027d5ce61f965acff9371c#rd','http://mmbiz.qpic.cn/mmbiz_jpg/nE2Uiamuqzs19ynlVK7JOHkpf5cFKgXToIuia3tj1EvfJAQNCPibruNfriaFCIOUic3JE0qcVm8libxPFGy6F9uZ5Skg/0?wx_fmt=jpeg','','1','0','2018-06-14 13:56:46','2018-06-14 13:56:46','1','3','0');
-- -------Records of mengmei_wechat_resource_list ----- -- 
INSERT INTO mengmei_wechat_resource_list ( `id`, `media_id`, `title`, `author`, `digest`, `content`, `content_source_url`, `thumb_media_id`, `show_cover_pic`, `url`, `thumb_url`, `local_image`, `need_open_comment`, `only_fans_can_comment`, `ctime`, `utime`, `up`, `source_id`, `isdel` ) VALUES ('9','VlnuIP8JKdzFH8NZOGn_N7T4htFkAlYPNnnec4RONTg','说的放松的方式','发生的发生的','说的分手的','fggddfg','http://www.baidu.com','VlnuIP8JKdzFH8NZOGn_N6H3Cn52gE_UQV_mkAdx8g0','1','http://mp.weixin.qq.com/s?__biz=MzIwMzQ0MzA1Nw==&mid=100000049&idx=1&sn=960c11e5787fe8e02a65b8e4f482e1a0&chksm=16ce1f2f21b996392395e7e10ac155fcb3d7fff4f48a948e138580143ced0bd5e6e30ece1d56#rd','http://mmbiz.qpic.cn/mmbiz_jpg/nE2Uiamuqzs13mibHPUhxSseMnfL6021nhF16p4jGy6NhztL6wUwetc5TuDFY5OOCLYmqfpzwkGnSu5Qa24geCPQ/0?wx_fmt=jpeg','','1','0','2018-06-15 10:52:17','2018-06-15 10:52:17','1','4','0');
-- -------Records of mengmei_wechat_resource_list ----- -- 
INSERT INTO mengmei_wechat_resource_list ( `id`, `media_id`, `title`, `author`, `digest`, `content`, `content_source_url`, `thumb_media_id`, `show_cover_pic`, `url`, `thumb_url`, `local_image`, `need_open_comment`, `only_fans_can_comment`, `ctime`, `utime`, `up`, `source_id`, `isdel` ) VALUES ('10','VlnuIP8JKdzFH8NZOGn_Nzv6qSUTs9mXCwT25eyAaX8','my father is my son','son','尽瞎鸡巴扯淡','尽瞎鸡巴扯淡尽瞎鸡巴扯淡尽瞎鸡巴扯淡','','VlnuIP8JKdzFH8NZOGn_N5IhJPNh6qSHPin6hi3aeNA','1','http://mp.weixin.qq.com/s?__biz=MzIwMzQ0MzA1Nw==&mid=100000047&idx=1&sn=314615c3c827e3e8fcde7c267a7172ba&chksm=16ce1f3121b99627ae39aa4ece0e262b389155dfbbf18c7179145637a301a2a433bfa33014af#rd','http://mmbiz.qpic.cn/mmbiz_jpg/nE2Uiamuqzs13mibHPUhxSseMnfL6021nhF8vxOILpfUKKkTx4w3bJibxe1ux7KZxbg4tbtJkvhtLpicM2UZbv9Q1A/0?wx_fmt=jpeg','','1','0','2018-06-15 10:44:53','2018-06-15 10:44:53','1','5','0');
-- -------Records of mengmei_wechat_resource_list ----- -- 
INSERT INTO mengmei_wechat_resource_list ( `id`, `media_id`, `title`, `author`, `digest`, `content`, `content_source_url`, `thumb_media_id`, `show_cover_pic`, `url`, `thumb_url`, `local_image`, `need_open_comment`, `only_fans_can_comment`, `ctime`, `utime`, `up`, `source_id`, `isdel` ) VALUES ('11','VlnuIP8JKdzFH8NZOGn_Nzv6qSUTs9mXCwT25eyAaX8','美女的写好','还','受到法律撒','法规规范地方&nbsp;&nbsp;','','VlnuIP8JKdzFH8NZOGn_N_h4et0pY7trN_SUsxsNc3I','1','http://mp.weixin.qq.com/s?__biz=MzIwMzQ0MzA1Nw==&mid=100000047&idx=2&sn=0c5020cb6f105bdb25dd690bb7e41dd6&chksm=16ce1f3121b99627fedb482eb13cf7e84c58c7983491ab82858daf45d66251d1b5ad6ff90117#rd','http://mmbiz.qpic.cn/mmbiz_jpg/nE2Uiamuqzs13mibHPUhxSseMnfL6021nhYujpJJNRIT6PmNQLmYqHlvNlf01pUw8kVyrKcd43YibdlPRRoknjr9A/0?wx_fmt=jpeg','','1','0','2018-06-15 10:44:53','2018-06-15 10:44:53','1','5','0');
-- -------Records of mengmei_wechat_resource_list ----- -- 
INSERT INTO mengmei_wechat_resource_list ( `id`, `media_id`, `title`, `author`, `digest`, `content`, `content_source_url`, `thumb_media_id`, `show_cover_pic`, `url`, `thumb_url`, `local_image`, `need_open_comment`, `only_fans_can_comment`, `ctime`, `utime`, `up`, `source_id`, `isdel` ) VALUES ('12','VlnuIP8JKdzFH8NZOGn_Nzv6qSUTs9mXCwT25eyAaX8','素材删除','妈呀马丁','萨法萨法','上的放松放松啊&nbsp;','','VlnuIP8JKdzFH8NZOGn_NymSRCH1IGzOoe0hB-6_cbM','1','http://mp.weixin.qq.com/s?__biz=MzIwMzQ0MzA1Nw==&mid=100000047&idx=3&sn=b756ecce2ca9e9a45bf21b2749a8fecb&chksm=16ce1f3121b996273771cdf73768b547018193b72c78ccc57fc092f1b76f849de50f36d86b0f#rd','http://mmbiz.qpic.cn/mmbiz_jpg/nE2Uiamuqzs13mibHPUhxSseMnfL6021nhYujpJJNRIT6PmNQLmYqHlvNlf01pUw8kVyrKcd43YibdlPRRoknjr9A/0?wx_fmt=jpeg','','1','0','2018-06-15 10:44:53','2018-06-15 10:44:53','1','5','0');
-- -------Records of mengmei_wechat_resource_list ----- -- 
INSERT INTO mengmei_wechat_resource_list ( `id`, `media_id`, `title`, `author`, `digest`, `content`, `content_source_url`, `thumb_media_id`, `show_cover_pic`, `url`, `thumb_url`, `local_image`, `need_open_comment`, `only_fans_can_comment`, `ctime`, `utime`, `up`, `source_id`, `isdel` ) VALUES ('13','VlnuIP8JKdzFH8NZOGn_N1fcMbGEXsHkZmskJJN1Q2I','北大引来了歌星','哦自己','对了可以看卡','对了可以看卡对了可以看卡对了可以看卡对了可以看卡对了可以看卡对了可以看卡对了可以看卡','','VlnuIP8JKdzFH8NZOGn_N370hf9CVB3Ctfw6eC8Hni0','1','http://mp.weixin.qq.com/s?__biz=MzIwMzQ0MzA1Nw==&mid=100000041&idx=1&sn=9ab86ad96e9699a21327d7234578b955&chksm=16ce1f3721b99621e6304385b2848c68435835d1020e3403d5eae73fecba17f259fe73865d4e#rd','http://mmbiz.qpic.cn/mmbiz_jpg/nE2Uiamuqzs19ynlVK7JOHkpf5cFKgXToicWOeibpa3bZmbBx4oXULdSzer2w3wpPhTfq8Xsef991ianHl90gQibADA/0?wx_fmt=jpeg','','1','0','2018-06-14 13:56:46','2018-06-14 13:56:46','1','6','0');
-- -------Records of mengmei_wechat_resource_list ----- -- 
INSERT INTO mengmei_wechat_resource_list ( `id`, `media_id`, `title`, `author`, `digest`, `content`, `content_source_url`, `thumb_media_id`, `show_cover_pic`, `url`, `thumb_url`, `local_image`, `need_open_comment`, `only_fans_can_comment`, `ctime`, `utime`, `up`, `source_id`, `isdel` ) VALUES ('14','VlnuIP8JKdzFH8NZOGn_N1fcMbGEXsHkZmskJJN1Q2I','真的吗？','来历','第三范式淡然是真的','第三范式淡然是真的第三范式淡然是真的第三范式淡然是真的第三范式淡然是真的','','VlnuIP8JKdzFH8NZOGn_N2i9qP5HIBXhPUqwLS27oS0','1','http://mp.weixin.qq.com/s?__biz=MzIwMzQ0MzA1Nw==&mid=100000041&idx=2&sn=125d7f5d34c44b2065cecc6de65c50a7&chksm=16ce1f3721b99621bc546274533b60610a0d61ada8833ff107825307903d5f5bcf7d32b9447a#rd','http://mmbiz.qpic.cn/mmbiz_jpg/nE2Uiamuqzs19ynlVK7JOHkpf5cFKgXTo8lKtic7JhBwuKUlJjmuhrIaddibldrPYoh0wyjju31oYqn689BQS7VMQ/0?wx_fmt=jpeg','','1','0','2018-06-14 13:56:46','2018-06-14 13:56:46','1','6','0');
-- -------Records of mengmei_wechat_resource_list ----- -- 
INSERT INTO mengmei_wechat_resource_list ( `id`, `media_id`, `title`, `author`, `digest`, `content`, `content_source_url`, `thumb_media_id`, `show_cover_pic`, `url`, `thumb_url`, `local_image`, `need_open_comment`, `only_fans_can_comment`, `ctime`, `utime`, `up`, `source_id`, `isdel` ) VALUES ('15','VlnuIP8JKdzFH8NZOGn_N1fcMbGEXsHkZmskJJN1Q2I','我是不信的','我是不信的','我是不信的','我是不信的我是不信的我是不信的','','VlnuIP8JKdzFH8NZOGn_N8L4Sa_d-7fHuFugetdeDh8','1','http://mp.weixin.qq.com/s?__biz=MzIwMzQ0MzA1Nw==&mid=100000041&idx=3&sn=dcbe69c2090b48f9a6e286ef7c7fabe4&chksm=16ce1f3721b99621e05b006a211dbd13dd1fd5359496a90978350a5fd6cc394f958669ea4fff#rd','http://mmbiz.qpic.cn/mmbiz_jpg/nE2Uiamuqzs19ynlVK7JOHkpf5cFKgXTofLUAwcJ4U7gyBUnpHPzJ0xW8xTW3YHakKXnF9ZatSPxMGPg98K9zNg/0?wx_fmt=jpeg','','1','0','2018-06-14 13:56:46','2018-06-14 13:56:46','1','6','0');
-- -------Records of mengmei_wechat_resource_list ----- -- 
INSERT INTO mengmei_wechat_resource_list ( `id`, `media_id`, `title`, `author`, `digest`, `content`, `content_source_url`, `thumb_media_id`, `show_cover_pic`, `url`, `thumb_url`, `local_image`, `need_open_comment`, `only_fans_can_comment`, `ctime`, `utime`, `up`, `source_id`, `isdel` ) VALUES ('16','VlnuIP8JKdzFH8NZOGn_N1fcMbGEXsHkZmskJJN1Q2I','你爱信不信','切','滚犊子','滚犊子滚犊子滚犊子滚犊子','','VlnuIP8JKdzFH8NZOGn_N_c46CRMI7o6yC3T0G7m5D4','1','http://mp.weixin.qq.com/s?__biz=MzIwMzQ0MzA1Nw==&mid=100000041&idx=4&sn=0076f0266b1bb1eee70067e912b7be1f&chksm=16ce1f3721b99621bf6cf736229b4d68b554333029a47bd555411d027d5ce61f965acff9371c#rd','http://mmbiz.qpic.cn/mmbiz_jpg/nE2Uiamuqzs19ynlVK7JOHkpf5cFKgXToIuia3tj1EvfJAQNCPibruNfriaFCIOUic3JE0qcVm8libxPFGy6F9uZ5Skg/0?wx_fmt=jpeg','','1','0','2018-06-14 13:56:46','2018-06-14 13:56:46','1','6','0');
-- -------Records of mengmei_wechat_resource_list ----- -- 
INSERT INTO mengmei_wechat_resource_list ( `id`, `media_id`, `title`, `author`, `digest`, `content`, `content_source_url`, `thumb_media_id`, `show_cover_pic`, `url`, `thumb_url`, `local_image`, `need_open_comment`, `only_fans_can_comment`, `ctime`, `utime`, `up`, `source_id`, `isdel` ) VALUES ('17','VlnuIP8JKdzFH8NZOGn_N7T4htFkAlYPNnnec4RONTg','说的放松的方式','发生的发生的','说的分手的','fggddfg','http://www.baidu.com','VlnuIP8JKdzFH8NZOGn_N6H3Cn52gE_UQV_mkAdx8g0','1','http://mp.weixin.qq.com/s?__biz=MzIwMzQ0MzA1Nw==&mid=100000049&idx=1&sn=960c11e5787fe8e02a65b8e4f482e1a0&chksm=16ce1f2f21b996392395e7e10ac155fcb3d7fff4f48a948e138580143ced0bd5e6e30ece1d56#rd','http://mmbiz.qpic.cn/mmbiz_jpg/nE2Uiamuqzs13mibHPUhxSseMnfL6021nhF16p4jGy6NhztL6wUwetc5TuDFY5OOCLYmqfpzwkGnSu5Qa24geCPQ/0?wx_fmt=jpeg','','1','0','2018-06-15 10:52:17','2018-06-15 10:52:17','1','7','0');
-- -------Records of mengmei_wechat_resource_list ----- -- 
INSERT INTO mengmei_wechat_resource_list ( `id`, `media_id`, `title`, `author`, `digest`, `content`, `content_source_url`, `thumb_media_id`, `show_cover_pic`, `url`, `thumb_url`, `local_image`, `need_open_comment`, `only_fans_can_comment`, `ctime`, `utime`, `up`, `source_id`, `isdel` ) VALUES ('18','VlnuIP8JKdzFH8NZOGn_Nzv6qSUTs9mXCwT25eyAaX8','my father is my son','son','尽瞎鸡巴扯淡','尽瞎鸡巴扯淡尽瞎鸡巴扯淡尽瞎鸡巴扯淡','','VlnuIP8JKdzFH8NZOGn_N5IhJPNh6qSHPin6hi3aeNA','1','http://mp.weixin.qq.com/s?__biz=MzIwMzQ0MzA1Nw==&mid=100000047&idx=1&sn=314615c3c827e3e8fcde7c267a7172ba&chksm=16ce1f3121b99627ae39aa4ece0e262b389155dfbbf18c7179145637a301a2a433bfa33014af#rd','http://mmbiz.qpic.cn/mmbiz_jpg/nE2Uiamuqzs13mibHPUhxSseMnfL6021nhF8vxOILpfUKKkTx4w3bJibxe1ux7KZxbg4tbtJkvhtLpicM2UZbv9Q1A/0?wx_fmt=jpeg','','1','0','2018-06-15 10:44:53','2018-06-15 10:44:53','1','8','0');
-- -------Records of mengmei_wechat_resource_list ----- -- 
INSERT INTO mengmei_wechat_resource_list ( `id`, `media_id`, `title`, `author`, `digest`, `content`, `content_source_url`, `thumb_media_id`, `show_cover_pic`, `url`, `thumb_url`, `local_image`, `need_open_comment`, `only_fans_can_comment`, `ctime`, `utime`, `up`, `source_id`, `isdel` ) VALUES ('19','VlnuIP8JKdzFH8NZOGn_Nzv6qSUTs9mXCwT25eyAaX8','美女的写好','还','受到法律撒','法规规范地方&nbsp;&nbsp;','','VlnuIP8JKdzFH8NZOGn_N_h4et0pY7trN_SUsxsNc3I','1','http://mp.weixin.qq.com/s?__biz=MzIwMzQ0MzA1Nw==&mid=100000047&idx=2&sn=0c5020cb6f105bdb25dd690bb7e41dd6&chksm=16ce1f3121b99627fedb482eb13cf7e84c58c7983491ab82858daf45d66251d1b5ad6ff90117#rd','http://mmbiz.qpic.cn/mmbiz_jpg/nE2Uiamuqzs13mibHPUhxSseMnfL6021nhYujpJJNRIT6PmNQLmYqHlvNlf01pUw8kVyrKcd43YibdlPRRoknjr9A/0?wx_fmt=jpeg','','1','0','2018-06-15 10:44:53','2018-06-15 10:44:53','1','8','0');
-- -------Records of mengmei_wechat_resource_list ----- -- 
INSERT INTO mengmei_wechat_resource_list ( `id`, `media_id`, `title`, `author`, `digest`, `content`, `content_source_url`, `thumb_media_id`, `show_cover_pic`, `url`, `thumb_url`, `local_image`, `need_open_comment`, `only_fans_can_comment`, `ctime`, `utime`, `up`, `source_id`, `isdel` ) VALUES ('20','VlnuIP8JKdzFH8NZOGn_Nzv6qSUTs9mXCwT25eyAaX8','素材删除','妈呀马丁','萨法萨法','上的放松放松啊&nbsp;','','VlnuIP8JKdzFH8NZOGn_NymSRCH1IGzOoe0hB-6_cbM','1','http://mp.weixin.qq.com/s?__biz=MzIwMzQ0MzA1Nw==&mid=100000047&idx=3&sn=b756ecce2ca9e9a45bf21b2749a8fecb&chksm=16ce1f3121b996273771cdf73768b547018193b72c78ccc57fc092f1b76f849de50f36d86b0f#rd','http://mmbiz.qpic.cn/mmbiz_jpg/nE2Uiamuqzs13mibHPUhxSseMnfL6021nhYujpJJNRIT6PmNQLmYqHlvNlf01pUw8kVyrKcd43YibdlPRRoknjr9A/0?wx_fmt=jpeg','','1','0','2018-06-15 10:44:53','2018-06-15 10:44:53','1','8','0');
-- -------Records of mengmei_wechat_resource_list ----- -- 
INSERT INTO mengmei_wechat_resource_list ( `id`, `media_id`, `title`, `author`, `digest`, `content`, `content_source_url`, `thumb_media_id`, `show_cover_pic`, `url`, `thumb_url`, `local_image`, `need_open_comment`, `only_fans_can_comment`, `ctime`, `utime`, `up`, `source_id`, `isdel` ) VALUES ('21','VlnuIP8JKdzFH8NZOGn_N1fcMbGEXsHkZmskJJN1Q2I','北大引来了歌星','哦自己','对了可以看卡','对了可以看卡对了可以看卡对了可以看卡对了可以看卡对了可以看卡对了可以看卡对了可以看卡','','VlnuIP8JKdzFH8NZOGn_N370hf9CVB3Ctfw6eC8Hni0','1','http://mp.weixin.qq.com/s?__biz=MzIwMzQ0MzA1Nw==&mid=100000041&idx=1&sn=9ab86ad96e9699a21327d7234578b955&chksm=16ce1f3721b99621e6304385b2848c68435835d1020e3403d5eae73fecba17f259fe73865d4e#rd','http://mmbiz.qpic.cn/mmbiz_jpg/nE2Uiamuqzs19ynlVK7JOHkpf5cFKgXToicWOeibpa3bZmbBx4oXULdSzer2w3wpPhTfq8Xsef991ianHl90gQibADA/0?wx_fmt=jpeg','','1','0','2018-06-14 13:56:46','2018-06-14 13:56:46','1','9','0');
-- -------Records of mengmei_wechat_resource_list ----- -- 
INSERT INTO mengmei_wechat_resource_list ( `id`, `media_id`, `title`, `author`, `digest`, `content`, `content_source_url`, `thumb_media_id`, `show_cover_pic`, `url`, `thumb_url`, `local_image`, `need_open_comment`, `only_fans_can_comment`, `ctime`, `utime`, `up`, `source_id`, `isdel` ) VALUES ('22','VlnuIP8JKdzFH8NZOGn_N1fcMbGEXsHkZmskJJN1Q2I','真的吗？','来历','第三范式淡然是真的','第三范式淡然是真的第三范式淡然是真的第三范式淡然是真的第三范式淡然是真的','','VlnuIP8JKdzFH8NZOGn_N2i9qP5HIBXhPUqwLS27oS0','1','http://mp.weixin.qq.com/s?__biz=MzIwMzQ0MzA1Nw==&mid=100000041&idx=2&sn=125d7f5d34c44b2065cecc6de65c50a7&chksm=16ce1f3721b99621bc546274533b60610a0d61ada8833ff107825307903d5f5bcf7d32b9447a#rd','http://mmbiz.qpic.cn/mmbiz_jpg/nE2Uiamuqzs19ynlVK7JOHkpf5cFKgXTo8lKtic7JhBwuKUlJjmuhrIaddibldrPYoh0wyjju31oYqn689BQS7VMQ/0?wx_fmt=jpeg','','1','0','2018-06-14 13:56:46','2018-06-14 13:56:46','1','9','0');
-- -------Records of mengmei_wechat_resource_list ----- -- 
INSERT INTO mengmei_wechat_resource_list ( `id`, `media_id`, `title`, `author`, `digest`, `content`, `content_source_url`, `thumb_media_id`, `show_cover_pic`, `url`, `thumb_url`, `local_image`, `need_open_comment`, `only_fans_can_comment`, `ctime`, `utime`, `up`, `source_id`, `isdel` ) VALUES ('23','VlnuIP8JKdzFH8NZOGn_N1fcMbGEXsHkZmskJJN1Q2I','我是不信的','我是不信的','我是不信的','我是不信的我是不信的我是不信的','','VlnuIP8JKdzFH8NZOGn_N8L4Sa_d-7fHuFugetdeDh8','1','http://mp.weixin.qq.com/s?__biz=MzIwMzQ0MzA1Nw==&mid=100000041&idx=3&sn=dcbe69c2090b48f9a6e286ef7c7fabe4&chksm=16ce1f3721b99621e05b006a211dbd13dd1fd5359496a90978350a5fd6cc394f958669ea4fff#rd','http://mmbiz.qpic.cn/mmbiz_jpg/nE2Uiamuqzs19ynlVK7JOHkpf5cFKgXTofLUAwcJ4U7gyBUnpHPzJ0xW8xTW3YHakKXnF9ZatSPxMGPg98K9zNg/0?wx_fmt=jpeg','','1','0','2018-06-14 13:56:46','2018-06-14 13:56:46','1','9','0');
-- -------Records of mengmei_wechat_resource_list ----- -- 
INSERT INTO mengmei_wechat_resource_list ( `id`, `media_id`, `title`, `author`, `digest`, `content`, `content_source_url`, `thumb_media_id`, `show_cover_pic`, `url`, `thumb_url`, `local_image`, `need_open_comment`, `only_fans_can_comment`, `ctime`, `utime`, `up`, `source_id`, `isdel` ) VALUES ('24','VlnuIP8JKdzFH8NZOGn_N1fcMbGEXsHkZmskJJN1Q2I','你爱信不信','切','滚犊子','滚犊子滚犊子滚犊子滚犊子','','VlnuIP8JKdzFH8NZOGn_N_c46CRMI7o6yC3T0G7m5D4','1','http://mp.weixin.qq.com/s?__biz=MzIwMzQ0MzA1Nw==&mid=100000041&idx=4&sn=0076f0266b1bb1eee70067e912b7be1f&chksm=16ce1f3721b99621bf6cf736229b4d68b554333029a47bd555411d027d5ce61f965acff9371c#rd','http://mmbiz.qpic.cn/mmbiz_jpg/nE2Uiamuqzs19ynlVK7JOHkpf5cFKgXToIuia3tj1EvfJAQNCPibruNfriaFCIOUic3JE0qcVm8libxPFGy6F9uZ5Skg/0?wx_fmt=jpeg','','1','0','2018-06-14 13:56:46','2018-06-14 13:56:46','1','9','0');
