-- -----------------------------
-- ----Think Mysql Data Transfer 
-- ----Host     : localhost
-- ----Port     : 3306
-- ----Database : mengmei
-- ----Part : #
-- ----Date : 2018-05-07 16:22:40
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
  `groupid` int(3) NOT NULL COMMENT '用户组id',
  `lastip` varchar(15) DEFAULT NULL COMMENT '最后登录ip',
  `lasttime` datetime DEFAULT NULL COMMENT '最后登陆时间',
  PRIMARY KEY (`id`)
) ENGINE=MyISAM AUTO_INCREMENT=4 DEFAULT CHARSET=utf8 COMMENT='管理员表';
-- -------Records of mengmei_admin ----- -- 
INSERT INTO mengmei_admin ( `id`, `name`, `pass`, `status`, `groupid`, `lastip`, `lasttime` ) VALUES ('1','admin','5d8446fee40b639d88772375d6dc86e2','1','1','127.0.0.1','2018-05-07 15:21:38');
-- -------Records of mengmei_admin ----- -- 
INSERT INTO mengmei_admin ( `id`, `name`, `pass`, `status`, `groupid`, `lastip`, `lasttime` ) VALUES ('3','数据库管理员','d41d8cd98f00b204e9800998ecf8427e','1','2','','');
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
  `filepath` varchar(255) NOT NULL COMMENT '伪静态地址',
  `copyfrom` varchar(255) NOT NULL COMMENT '文章来源',
  PRIMARY KEY (`id`),
  KEY `status` (`order`,`id`),
  KEY `listorder` (`catid`,`order`,`id`),
  KEY `catid` (`catid`,`id`),
  KEY `titles` (`name`) USING BTREE
) ENGINE=MyISAM DEFAULT CHARSET=utf8 COMMENT='文章表';
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
  `ctime` date NOT NULL COMMENT '添加时间',
  `isdel` tinyint(1) NOT NULL DEFAULT '0' COMMENT '是否删除：1.是，0.否',
  PRIMARY KEY (`id`),
  KEY `文章id` (`aid`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8 COMMENT='附件表';
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
) ENGINE=MyISAM AUTO_INCREMENT=11 DEFAULT CHARSET=utf8 COMMENT='用户组明细表';
-- -------Records of mengmei_auth_access ----- -- 
INSERT INTO mengmei_auth_access ( `id`, `uid`, `group_id` ) VALUES ('1','1','1');
-- -------Records of mengmei_auth_access ----- -- 
INSERT INTO mengmei_auth_access ( `id`, `uid`, `group_id` ) VALUES ('10','3','8');
-- --------Table structure for mengmei_auth_group--------- -- 
DROP TABLE IF EXISTS `mengmei_auth_group`;
-- ----------------- -- 
CREATE TABLE `mengmei_auth_group` (
  `id` int(11) unsigned NOT NULL AUTO_INCREMENT,
  `title` char(100) NOT NULL DEFAULT '' COMMENT '用户组中文名称',
  `status` tinyint(1) NOT NULL DEFAULT '1' COMMENT '状态：1：启用，0：禁用',
  `rules` text COMMENT '规则id 多个规则","隔开',
  PRIMARY KEY (`id`)
) ENGINE=MyISAM AUTO_INCREMENT=9 DEFAULT CHARSET=utf8 COMMENT='用户组表';
-- -------Records of mengmei_auth_group ----- -- 
INSERT INTO mengmei_auth_group ( `id`, `title`, `status`, `rules` ) VALUES ('1','超级管理员','1','1,4,5,52,69,2,6,7,8,9,10,11,12,13,14,15,16,17,48,53,54,55,56,58,59,60,61,62,63,64,68,3,18,19,20,21,22,28,23,24,25,26,27,29,30,31,32,33,34,35,36,49,50,65,37,38,41,42,43,47,39,44,45,46,40,67,51,66');
-- -------Records of mengmei_auth_group ----- -- 
INSERT INTO mengmei_auth_group ( `id`, `title`, `status`, `rules` ) VALUES ('2','编辑','1','7,8,9,10,11,12,13,14');
-- -------Records of mengmei_auth_group ----- -- 
INSERT INTO mengmei_auth_group ( `id`, `title`, `status`, `rules` ) VALUES ('8','数据库管理员','1','4,34,35,36,37');
-- --------Table structure for mengmei_auth_rule--------- -- 
DROP TABLE IF EXISTS `mengmei_auth_rule`;
-- ----------------- -- 
CREATE TABLE `mengmei_auth_rule` (
  `id` int(11) unsigned NOT NULL AUTO_INCREMENT,
  `pid` int(11) unsigned NOT NULL DEFAULT '0' COMMENT '父级id',
  `name` char(80) NOT NULL DEFAULT '' COMMENT '规则唯一标识，如：Admin/article/index',
  `title` char(20) NOT NULL DEFAULT '' COMMENT '规则中文名称',
  `status` tinyint(1) NOT NULL DEFAULT '1' COMMENT '状态：1：启用，0：禁用',
  `condition` char(100) NOT NULL DEFAULT '' COMMENT '规则表达式，为空表示存在就验证，不为空表示按照条件验证',
  `isdel` tinyint(1) NOT NULL DEFAULT '0' COMMENT '是否删除：1：是，0：否',
  PRIMARY KEY (`id`)
) ENGINE=MyISAM AUTO_INCREMENT=70 DEFAULT CHARSET=utf8 COMMENT='规则表';
-- -------Records of mengmei_auth_rule ----- -- 
INSERT INTO mengmei_auth_rule ( `id`, `pid`, `name`, `title`, `status`, `condition`, `isdel` ) VALUES ('1','0','','基本设置','1','','0');
-- -------Records of mengmei_auth_rule ----- -- 
INSERT INTO mengmei_auth_rule ( `id`, `pid`, `name`, `title`, `status`, `condition`, `isdel` ) VALUES ('2','0','','栏目管理','1','','0');
-- -------Records of mengmei_auth_rule ----- -- 
INSERT INTO mengmei_auth_rule ( `id`, `pid`, `name`, `title`, `status`, `condition`, `isdel` ) VALUES ('3','0','','系统设置','1','','0');
-- -------Records of mengmei_auth_rule ----- -- 
INSERT INTO mengmei_auth_rule ( `id`, `pid`, `name`, `title`, `status`, `condition`, `isdel` ) VALUES ('4','1','admin/index/info','网站设置','1','','0');
-- -------Records of mengmei_auth_rule ----- -- 
INSERT INTO mengmei_auth_rule ( `id`, `pid`, `name`, `title`, `status`, `condition`, `isdel` ) VALUES ('5','1','admin/index/userpass','修改密码','1','','0');
-- -------Records of mengmei_auth_rule ----- -- 
INSERT INTO mengmei_auth_rule ( `id`, `pid`, `name`, `title`, `status`, `condition`, `isdel` ) VALUES ('6','2','admin/article/artlist','内容编辑','1','','0');
-- -------Records of mengmei_auth_rule ----- -- 
INSERT INTO mengmei_auth_rule ( `id`, `pid`, `name`, `title`, `status`, `condition`, `isdel` ) VALUES ('7','6','admin/article/artedit','添加内容','1','','0');
-- -------Records of mengmei_auth_rule ----- -- 
INSERT INTO mengmei_auth_rule ( `id`, `pid`, `name`, `title`, `status`, `condition`, `isdel` ) VALUES ('8','6','admin/article/artedit','文章修改','1','','0');
-- -------Records of mengmei_auth_rule ----- -- 
INSERT INTO mengmei_auth_rule ( `id`, `pid`, `name`, `title`, `status`, `condition`, `isdel` ) VALUES ('9','6','admin/article/artdel','文章删除','1','','0');
-- -------Records of mengmei_auth_rule ----- -- 
INSERT INTO mengmei_auth_rule ( `id`, `pid`, `name`, `title`, `status`, `condition`, `isdel` ) VALUES ('10','2','admin/article/artpublish','内容发布','1','','0');
-- -------Records of mengmei_auth_rule ----- -- 
INSERT INTO mengmei_auth_rule ( `id`, `pid`, `name`, `title`, `status`, `condition`, `isdel` ) VALUES ('11','10','admin/article/artpublish','文章发布','1','','0');
-- -------Records of mengmei_auth_rule ----- -- 
INSERT INTO mengmei_auth_rule ( `id`, `pid`, `name`, `title`, `status`, `condition`, `isdel` ) VALUES ('12','10','admin/article/artpublish','文章撤回','1','','0');
-- -------Records of mengmei_auth_rule ----- -- 
INSERT INTO mengmei_auth_rule ( `id`, `pid`, `name`, `title`, `status`, `condition`, `isdel` ) VALUES ('13','10','admin/article/artpublish','文章取消','1','','0');
-- -------Records of mengmei_auth_rule ----- -- 
INSERT INTO mengmei_auth_rule ( `id`, `pid`, `name`, `title`, `status`, `condition`, `isdel` ) VALUES ('14','2','admin/article/catlist','类别管理','1','','0');
-- -------Records of mengmei_auth_rule ----- -- 
INSERT INTO mengmei_auth_rule ( `id`, `pid`, `name`, `title`, `status`, `condition`, `isdel` ) VALUES ('15','14','admin/article/catedit','添加类别','1','','0');
-- -------Records of mengmei_auth_rule ----- -- 
INSERT INTO mengmei_auth_rule ( `id`, `pid`, `name`, `title`, `status`, `condition`, `isdel` ) VALUES ('16','14','admin/article/catedit','类别修改','1','','0');
-- -------Records of mengmei_auth_rule ----- -- 
INSERT INTO mengmei_auth_rule ( `id`, `pid`, `name`, `title`, `status`, `condition`, `isdel` ) VALUES ('17','14','admin/article/catdel','类别删除','1','','0');
-- -------Records of mengmei_auth_rule ----- -- 
INSERT INTO mengmei_auth_rule ( `id`, `pid`, `name`, `title`, `status`, `condition`, `isdel` ) VALUES ('18','3','admin/rule/grouplist','角色管理','1','','0');
-- -------Records of mengmei_auth_rule ----- -- 
INSERT INTO mengmei_auth_rule ( `id`, `pid`, `name`, `title`, `status`, `condition`, `isdel` ) VALUES ('19','18','admin/rule/groupedit','添加角色','1','','0');
-- -------Records of mengmei_auth_rule ----- -- 
INSERT INTO mengmei_auth_rule ( `id`, `pid`, `name`, `title`, `status`, `condition`, `isdel` ) VALUES ('20','18','admin/rule/groupedit','角色修改','1','','0');
-- -------Records of mengmei_auth_rule ----- -- 
INSERT INTO mengmei_auth_rule ( `id`, `pid`, `name`, `title`, `status`, `condition`, `isdel` ) VALUES ('21','18','admin/rule/adminedit','添加成员','1','','0');
-- -------Records of mengmei_auth_rule ----- -- 
INSERT INTO mengmei_auth_rule ( `id`, `pid`, `name`, `title`, `status`, `condition`, `isdel` ) VALUES ('22','18','admin/rule/groupdel','角色删除','1','','0');
-- -------Records of mengmei_auth_rule ----- -- 
INSERT INTO mengmei_auth_rule ( `id`, `pid`, `name`, `title`, `status`, `condition`, `isdel` ) VALUES ('23','3','admin/rule/adminlist','用户列表','1','','0');
-- -------Records of mengmei_auth_rule ----- -- 
INSERT INTO mengmei_auth_rule ( `id`, `pid`, `name`, `title`, `status`, `condition`, `isdel` ) VALUES ('24','23','admin/rule/adminedit','添加用户','1','','0');
-- -------Records of mengmei_auth_rule ----- -- 
INSERT INTO mengmei_auth_rule ( `id`, `pid`, `name`, `title`, `status`, `condition`, `isdel` ) VALUES ('25','23','admin/rule/adminedit','用户修改','1','','0');
-- -------Records of mengmei_auth_rule ----- -- 
INSERT INTO mengmei_auth_rule ( `id`, `pid`, `name`, `title`, `status`, `condition`, `isdel` ) VALUES ('26','23','admin/rule/admindel','用户删除','1','','0');
-- -------Records of mengmei_auth_rule ----- -- 
INSERT INTO mengmei_auth_rule ( `id`, `pid`, `name`, `title`, `status`, `condition`, `isdel` ) VALUES ('27','3','admin/rule/rulelist','权限管理','1','','0');
-- -------Records of mengmei_auth_rule ----- -- 
INSERT INTO mengmei_auth_rule ( `id`, `pid`, `name`, `title`, `status`, `condition`, `isdel` ) VALUES ('28','18','admin/rule/rulegroup','权限分配','1','','0');
-- -------Records of mengmei_auth_rule ----- -- 
INSERT INTO mengmei_auth_rule ( `id`, `pid`, `name`, `title`, `status`, `condition`, `isdel` ) VALUES ('29','27','admin/rule/ruleedit','添加权限','1','','0');
-- -------Records of mengmei_auth_rule ----- -- 
INSERT INTO mengmei_auth_rule ( `id`, `pid`, `name`, `title`, `status`, `condition`, `isdel` ) VALUES ('30','27','admin/rule/ruleedit','添加子菜单','1','','0');
-- -------Records of mengmei_auth_rule ----- -- 
INSERT INTO mengmei_auth_rule ( `id`, `pid`, `name`, `title`, `status`, `condition`, `isdel` ) VALUES ('31','27','admin/rule/ruleedit','菜单修改','1','','0');
-- -------Records of mengmei_auth_rule ----- -- 
INSERT INTO mengmei_auth_rule ( `id`, `pid`, `name`, `title`, `status`, `condition`, `isdel` ) VALUES ('32','27','admin/rule/ruledel','菜单删除','1','','0');
-- -------Records of mengmei_auth_rule ----- -- 
INSERT INTO mengmei_auth_rule ( `id`, `pid`, `name`, `title`, `status`, `condition`, `isdel` ) VALUES ('33','3','admin/sqlmanager/index','数据库管理','0','','0');
-- -------Records of mengmei_auth_rule ----- -- 
INSERT INTO mengmei_auth_rule ( `id`, `pid`, `name`, `title`, `status`, `condition`, `isdel` ) VALUES ('34','33','admin/sqlmanager/export','数据库备份','0','','0');
-- -------Records of mengmei_auth_rule ----- -- 
INSERT INTO mengmei_auth_rule ( `id`, `pid`, `name`, `title`, `status`, `condition`, `isdel` ) VALUES ('35','33','admin/sqlmanager/import','数据库还原','0','','0');
-- -------Records of mengmei_auth_rule ----- -- 
INSERT INTO mengmei_auth_rule ( `id`, `pid`, `name`, `title`, `status`, `condition`, `isdel` ) VALUES ('36','33','admin/sqlmanager/delsql','数据库删除','0','','0');
-- -------Records of mengmei_auth_rule ----- -- 
INSERT INTO mengmei_auth_rule ( `id`, `pid`, `name`, `title`, `status`, `condition`, `isdel` ) VALUES ('37','0','','微信管理','0','','1');
-- -------Records of mengmei_auth_rule ----- -- 
INSERT INTO mengmei_auth_rule ( `id`, `pid`, `name`, `title`, `status`, `condition`, `isdel` ) VALUES ('38','37','admin/WechatCustomEdit/wechat','管理账号','0','','1');
-- -------Records of mengmei_auth_rule ----- -- 
INSERT INTO mengmei_auth_rule ( `id`, `pid`, `name`, `title`, `status`, `condition`, `isdel` ) VALUES ('39','37','admin/WechatCustomEdit/keywords','关键字回复','0','','1');
-- -------Records of mengmei_auth_rule ----- -- 
INSERT INTO mengmei_auth_rule ( `id`, `pid`, `name`, `title`, `status`, `condition`, `isdel` ) VALUES ('40','37','admin/WechatCustomEdit/index','自定义菜单','0','','1');
-- -------Records of mengmei_auth_rule ----- -- 
INSERT INTO mengmei_auth_rule ( `id`, `pid`, `name`, `title`, `status`, `condition`, `isdel` ) VALUES ('41','38','admin/WechatCustomEdit/wechat_join','添加账号','0','','1');
-- -------Records of mengmei_auth_rule ----- -- 
INSERT INTO mengmei_auth_rule ( `id`, `pid`, `name`, `title`, `status`, `condition`, `isdel` ) VALUES ('42','38','admin/WechatCustomEdit/wechat_join','账号修改','0','','1');
-- -------Records of mengmei_auth_rule ----- -- 
INSERT INTO mengmei_auth_rule ( `id`, `pid`, `name`, `title`, `status`, `condition`, `isdel` ) VALUES ('43','38','admin/WechatCustomEdit/wechat_join_del','账号删除','0','','1');
-- -------Records of mengmei_auth_rule ----- -- 
INSERT INTO mengmei_auth_rule ( `id`, `pid`, `name`, `title`, `status`, `condition`, `isdel` ) VALUES ('44','39','admin/WechatCustomEdit/keywords','添加关键字','0','','1');
-- -------Records of mengmei_auth_rule ----- -- 
INSERT INTO mengmei_auth_rule ( `id`, `pid`, `name`, `title`, `status`, `condition`, `isdel` ) VALUES ('45','39','admin/WechatCustomEdit/keywords','关键字修改','0','','1');
-- -------Records of mengmei_auth_rule ----- -- 
INSERT INTO mengmei_auth_rule ( `id`, `pid`, `name`, `title`, `status`, `condition`, `isdel` ) VALUES ('46','39','admin/WechatCustomEdit/keywordsdel','关键字删除','0','','1');
-- -------Records of mengmei_auth_rule ----- -- 
INSERT INTO mengmei_auth_rule ( `id`, `pid`, `name`, `title`, `status`, `condition`, `isdel` ) VALUES ('47','38','admin/WechatCustomEdit/defaults','默认回复','0','','1');
-- -------Records of mengmei_auth_rule ----- -- 
INSERT INTO mengmei_auth_rule ( `id`, `pid`, `name`, `title`, `status`, `condition`, `isdel` ) VALUES ('48','2','admin/comments/index','评论管理','0','','1');
-- -------Records of mengmei_auth_rule ----- -- 
INSERT INTO mengmei_auth_rule ( `id`, `pid`, `name`, `title`, `status`, `condition`, `isdel` ) VALUES ('49','3','admin/backups/backups','数据备份','1','','0');
-- -------Records of mengmei_auth_rule ----- -- 
INSERT INTO mengmei_auth_rule ( `id`, `pid`, `name`, `title`, `status`, `condition`, `isdel` ) VALUES ('50','3','admin/backups/index','数据还原','1','','0');
-- -------Records of mengmei_auth_rule ----- -- 
INSERT INTO mengmei_auth_rule ( `id`, `pid`, `name`, `title`, `status`, `condition`, `isdel` ) VALUES ('51','67','admin/message/index','客户留言','1','','0');
-- -------Records of mengmei_auth_rule ----- -- 
INSERT INTO mengmei_auth_rule ( `id`, `pid`, `name`, `title`, `status`, `condition`, `isdel` ) VALUES ('52','1','Admin/index/firendsurl','友情链接','1','','0');
-- -------Records of mengmei_auth_rule ----- -- 
INSERT INTO mengmei_auth_rule ( `id`, `pid`, `name`, `title`, `status`, `condition`, `isdel` ) VALUES ('53','2','Admin/expert/index','专家管理','1','','0');
-- -------Records of mengmei_auth_rule ----- -- 
INSERT INTO mengmei_auth_rule ( `id`, `pid`, `name`, `title`, `status`, `condition`, `isdel` ) VALUES ('54','53','Admin/expert/expert_edit','专家添加','1','','0');
-- -------Records of mengmei_auth_rule ----- -- 
INSERT INTO mengmei_auth_rule ( `id`, `pid`, `name`, `title`, `status`, `condition`, `isdel` ) VALUES ('55','53','Admin/expert/expert_edit','专家修改','1','','0');
-- -------Records of mengmei_auth_rule ----- -- 
INSERT INTO mengmei_auth_rule ( `id`, `pid`, `name`, `title`, `status`, `condition`, `isdel` ) VALUES ('56','53','Admin/expert/expert_del','专家删除','1','','0');
-- -------Records of mengmei_auth_rule ----- -- 
INSERT INTO mengmei_auth_rule ( `id`, `pid`, `name`, `title`, `status`, `condition`, `isdel` ) VALUES ('58','2','admin/advert/index','广告位管理','1','','0');
-- -------Records of mengmei_auth_rule ----- -- 
INSERT INTO mengmei_auth_rule ( `id`, `pid`, `name`, `title`, `status`, `condition`, `isdel` ) VALUES ('59','58','admin/advert/advert_edit','广告位添加','1','','0');
-- -------Records of mengmei_auth_rule ----- -- 
INSERT INTO mengmei_auth_rule ( `id`, `pid`, `name`, `title`, `status`, `condition`, `isdel` ) VALUES ('60','58','admin/advert/advert_edit','广告位编辑','1','','0');
-- -------Records of mengmei_auth_rule ----- -- 
INSERT INTO mengmei_auth_rule ( `id`, `pid`, `name`, `title`, `status`, `condition`, `isdel` ) VALUES ('61','58','admin/advert/advert_del','广告位删除','1','','0');
-- -------Records of mengmei_auth_rule ----- -- 
INSERT INTO mengmei_auth_rule ( `id`, `pid`, `name`, `title`, `status`, `condition`, `isdel` ) VALUES ('62','2','admin/recover/index','回收站管理','1','','0');
-- -------Records of mengmei_auth_rule ----- -- 
INSERT INTO mengmei_auth_rule ( `id`, `pid`, `name`, `title`, `status`, `condition`, `isdel` ) VALUES ('63','62','admin/recover/restore','数据还原','1','','0');
-- -------Records of mengmei_auth_rule ----- -- 
INSERT INTO mengmei_auth_rule ( `id`, `pid`, `name`, `title`, `status`, `condition`, `isdel` ) VALUES ('64','62','Admin/recover/del','数据删除','1','','0');
-- -------Records of mengmei_auth_rule ----- -- 
INSERT INTO mengmei_auth_rule ( `id`, `pid`, `name`, `title`, `status`, `condition`, `isdel` ) VALUES ('65','3','admin/log/index','操作日志','1','','0');
-- -------Records of mengmei_auth_rule ----- -- 
INSERT INTO mengmei_auth_rule ( `id`, `pid`, `name`, `title`, `status`, `condition`, `isdel` ) VALUES ('66','67','admin/member/index','会员管理','1','','0');
-- -------Records of mengmei_auth_rule ----- -- 
INSERT INTO mengmei_auth_rule ( `id`, `pid`, `name`, `title`, `status`, `condition`, `isdel` ) VALUES ('67','0','','成员管理','1','','0');
-- -------Records of mengmei_auth_rule ----- -- 
INSERT INTO mengmei_auth_rule ( `id`, `pid`, `name`, `title`, `status`, `condition`, `isdel` ) VALUES ('68','2','admin/attachment/attach','附件管理','1','','0');
-- -------Records of mengmei_auth_rule ----- -- 
INSERT INTO mengmei_auth_rule ( `id`, `pid`, `name`, `title`, `status`, `condition`, `isdel` ) VALUES ('69','1','admin/sitemap/sitelist','网站地图','1','','0');
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
  `isshow` tinyint(1) NOT NULL DEFAULT '1' COMMENT '是否显示：1.是，0.否',
  `order` varchar(100) NOT NULL COMMENT '排序，越小越靠前',
  PRIMARY KEY (`id`)
) ENGINE=MyISAM AUTO_INCREMENT=13 DEFAULT CHARSET=utf8 COMMENT='分类表';
-- -------Records of mengmei_category ----- -- 
INSERT INTO mengmei_category ( `id`, `pid`, `childid`, `name`, `link`, `isdel`, `isshow`, `order` ) VALUES ('1','0','0','首页','','0','0','0');
-- -------Records of mengmei_category ----- -- 
INSERT INTO mengmei_category ( `id`, `pid`, `childid`, `name`, `link`, `isdel`, `isshow`, `order` ) VALUES ('2','0','0','试管技术','','0','1','');
-- -------Records of mengmei_category ----- -- 
INSERT INTO mengmei_category ( `id`, `pid`, `childid`, `name`, `link`, `isdel`, `isshow`, `order` ) VALUES ('3','0','0','服务项目','','0','1','');
-- -------Records of mengmei_category ----- -- 
INSERT INTO mengmei_category ( `id`, `pid`, `childid`, `name`, `link`, `isdel`, `isshow`, `order` ) VALUES ('4','0','0','美国专家','','0','1','');
-- -------Records of mengmei_category ----- -- 
INSERT INTO mengmei_category ( `id`, `pid`, `childid`, `name`, `link`, `isdel`, `isshow`, `order` ) VALUES ('5','0','0','赴美流程','','0','1','');
-- -------Records of mengmei_category ----- -- 
INSERT INTO mengmei_category ( `id`, `pid`, `childid`, `name`, `link`, `isdel`, `isshow`, `order` ) VALUES ('6','0','0','总部医院','','0','1','');
-- -------Records of mengmei_category ----- -- 
INSERT INTO mengmei_category ( `id`, `pid`, `childid`, `name`, `link`, `isdel`, `isshow`, `order` ) VALUES ('7','0','0','最新资讯','','0','1','');
-- -------Records of mengmei_category ----- -- 
INSERT INTO mengmei_category ( `id`, `pid`, `childid`, `name`, `link`, `isdel`, `isshow`, `order` ) VALUES ('8','0','0','优选案例','','0','1','');
-- -------Records of mengmei_category ----- -- 
INSERT INTO mengmei_category ( `id`, `pid`, `childid`, `name`, `link`, `isdel`, `isshow`, `order` ) VALUES ('9','0','0','合作机构','','0','1','');
-- -------Records of mengmei_category ----- -- 
INSERT INTO mengmei_category ( `id`, `pid`, `childid`, `name`, `link`, `isdel`, `isshow`, `order` ) VALUES ('10','0','0','常见问题','','0','1','');
-- -------Records of mengmei_category ----- -- 
INSERT INTO mengmei_category ( `id`, `pid`, `childid`, `name`, `link`, `isdel`, `isshow`, `order` ) VALUES ('11','0','0','联系我们','','0','1','');
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
  `content` mediumtext NOT NULL COMMENT '专家事迹',
  `isdel` tinyint(1) NOT NULL DEFAULT '0' COMMENT '是否删除：1.是，0.否',
  `status` tinyint(1) NOT NULL DEFAULT '2' COMMENT '是否显示：1.是，0.否',
  PRIMARY KEY (`id`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8 COMMENT='专家表';
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
) ENGINE=MyISAM DEFAULT CHARSET=utf8 COMMENT='友情链接表';
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
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='日志操作表';
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
  KEY `日志id` (`logid`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='操作日志从表';
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
  `mobile` varchar(11) NOT NULL COMMENT '移动电话',
  `mail` varchar(255) NOT NULL COMMENT '邮箱',
  `address` varchar(255) NOT NULL COMMENT '留言地址',
  `message` text NOT NULL COMMENT '客户留言内容',
  `type` tinyint(1) NOT NULL COMMENT '类型：0.第一次资讯（非会员）,1.会员',
  `recommend` tinyint(1) NOT NULL COMMENT '是否推荐：1.是 ，0.否',
  `rename` varchar(20) NOT NULL COMMENT '推荐人名称',
  `remobile` varchar(11) NOT NULL COMMENT '推荐人的手机',
  `rereason` varchar(255) NOT NULL COMMENT '推荐原因',
  `ctime` datetime NOT NULL COMMENT '留言时间',
  `status` tinyint(1) NOT NULL COMMENT '客服反馈状态：1.已反馈，0.待反馈',
  `backtime` datetime DEFAULT NULL COMMENT '反馈时间',
  `backid` int(11) NOT NULL COMMENT '操作人id',
  `backuser` varchar(20) NOT NULL COMMENT '操作用户',
  `isdel` tinyint(1) NOT NULL DEFAULT '0' COMMENT '删除状态：1.是，0.否',
  PRIMARY KEY (`id`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8 COMMENT='客户留言表';
-- --------Table structure for mengmei_navigator--------- -- 
DROP TABLE IF EXISTS `mengmei_navigator`;
-- ----------------- -- 
CREATE TABLE `mengmei_navigator` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `pid` int(11) NOT NULL COMMENT '父级id',
  `name` varchar(20) NOT NULL COMMENT '导航名称',
  `url` varchar(100) NOT NULL COMMENT '跳转地址',
  `isshow` tinyint(1) NOT NULL DEFAULT '1' COMMENT '是否显示 1.是 0.否',
  `isdel` tinyint(1) NOT NULL DEFAULT '0' COMMENT '是否删除：1.是，0.否',
  PRIMARY KEY (`id`)
) ENGINE=MyISAM AUTO_INCREMENT=12 DEFAULT CHARSET=utf8 COMMENT='前端导航表';
-- -------Records of mengmei_navigator ----- -- 
INSERT INTO mengmei_navigator ( `id`, `pid`, `name`, `url`, `isshow`, `isdel` ) VALUES ('1','0','首页','','1','0');
-- -------Records of mengmei_navigator ----- -- 
INSERT INTO mengmei_navigator ( `id`, `pid`, `name`, `url`, `isshow`, `isdel` ) VALUES ('2','0','试管技术','','1','0');
-- -------Records of mengmei_navigator ----- -- 
INSERT INTO mengmei_navigator ( `id`, `pid`, `name`, `url`, `isshow`, `isdel` ) VALUES ('3','0','服务项目','','1','0');
-- -------Records of mengmei_navigator ----- -- 
INSERT INTO mengmei_navigator ( `id`, `pid`, `name`, `url`, `isshow`, `isdel` ) VALUES ('4','0','美国专家','','1','0');
-- -------Records of mengmei_navigator ----- -- 
INSERT INTO mengmei_navigator ( `id`, `pid`, `name`, `url`, `isshow`, `isdel` ) VALUES ('5','0','赴美流程','','1','0');
-- -------Records of mengmei_navigator ----- -- 
INSERT INTO mengmei_navigator ( `id`, `pid`, `name`, `url`, `isshow`, `isdel` ) VALUES ('6','0','总部医院','','1','0');
-- -------Records of mengmei_navigator ----- -- 
INSERT INTO mengmei_navigator ( `id`, `pid`, `name`, `url`, `isshow`, `isdel` ) VALUES ('7','0','最新资讯','','1','0');
-- -------Records of mengmei_navigator ----- -- 
INSERT INTO mengmei_navigator ( `id`, `pid`, `name`, `url`, `isshow`, `isdel` ) VALUES ('8','0','优选案例','','1','0');
-- -------Records of mengmei_navigator ----- -- 
INSERT INTO mengmei_navigator ( `id`, `pid`, `name`, `url`, `isshow`, `isdel` ) VALUES ('9','0','合作机构','','1','0');
-- -------Records of mengmei_navigator ----- -- 
INSERT INTO mengmei_navigator ( `id`, `pid`, `name`, `url`, `isshow`, `isdel` ) VALUES ('10','0','常见问题','','1','0');
-- -------Records of mengmei_navigator ----- -- 
INSERT INTO mengmei_navigator ( `id`, `pid`, `name`, `url`, `isshow`, `isdel` ) VALUES ('11','0','联系我们','','1','0');
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
) ENGINE=MyISAM DEFAULT CHARSET=utf8 COMMENT='回收站表';
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
) ENGINE=MyISAM AUTO_INCREMENT=12 DEFAULT CHARSET=utf8 COMMENT='网站地图';
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
