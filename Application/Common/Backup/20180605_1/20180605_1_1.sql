-- -----------------------------
-- ----Think Mysql Data Transfer 
-- ----Host     : 127.0.0.1
-- ----Port     : 3306
-- ----Database : mengmei
-- ----Part : #
-- ----Date : 2018-06-05 17:09:28
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
) ENGINE=MyISAM AUTO_INCREMENT=7 DEFAULT CHARSET=utf8 COMMENT='管理员表';
-- -------Records of mengmei_admin ----- -- 
INSERT INTO mengmei_admin ( `id`, `name`, `pass`, `status`, `groupid`, `lastip`, `lasttime` ) VALUES ('1','admin','5d8446fee40b639d88772375d6dc86e2','1','1','127.0.0.1','2018-06-05 16:54:09');
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
) ENGINE=MyISAM AUTO_INCREMENT=59 DEFAULT CHARSET=utf8 COMMENT='文章表';
-- -------Records of mengmei_article ----- -- 
INSERT INTO mengmei_article ( `id`, `catid`, `name`, `seo`, `keywords`, `description`, `editorid`, `editor`, `order`, `ctime`, `utime`, `ptime`, `status`, `hits`, `content`, `image`, `recommend`, `settop`, `weixin`, `pc`, `mobile`, `app`, `wshort`, `isshow`, `isdel`, `copyfrom` ) VALUES ('58','2','数据库管理员','','','的非官方的股份的分割的','1','admin','0','2018-05-29','','2018-05-29','2','34','&nbsp;单发郭德纲','','0','0','1','1','1','1','1','1','0','本站原创');
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
) ENGINE=MyISAM AUTO_INCREMENT=37 DEFAULT CHARSET=utf8 COMMENT='附件表';
-- -------Records of mengmei_attachment ----- -- 
INSERT INTO mengmei_attachment ( `id`, `name`, `path`, `path_thumb`, `size`, `ext`, `aid`, `iswx`, `ctime`, `isdel` ) VALUES ('21','VlnuIP8JKdzFH8NZOGn_NwIxLRPEkqTbKD_Lo4CKOuE','http://mmbiz.qpic.cn/mmbiz_jpg/nE2Uiamuqzs2UPfoGzv8U4b0u9lQs9WleibWiaPpNialyCnWbFic0xXs6VsgXXLicNiaGbyxx0AWibSC2OmFLXg3mGTVWw/0?wx_fmt=jpeg','','0.00','','0','1','2018-06-01','0');
-- -------Records of mengmei_attachment ----- -- 
INSERT INTO mengmei_attachment ( `id`, `name`, `path`, `path_thumb`, `size`, `ext`, `aid`, `iswx`, `ctime`, `isdel` ) VALUES ('22','VlnuIP8JKdzFH8NZOGn_N5NdpCuV-W5vqLQBI_9MhgE','http://mmbiz.qpic.cn/mmbiz_jpg/nE2Uiamuqzs2UPfoGzv8U4b0u9lQs9WleibWiaPpNialyCnWbFic0xXs6VsgXXLicNiaGbyxx0AWibSC2OmFLXg3mGTVWw/0?wx_fmt=jpeg','','0.00','','0','1','2018-06-01','0');
-- -------Records of mengmei_attachment ----- -- 
INSERT INTO mengmei_attachment ( `id`, `name`, `path`, `path_thumb`, `size`, `ext`, `aid`, `iswx`, `ctime`, `isdel` ) VALUES ('23','下载 (2).jpg','upload/20180601/1527840127447.jpg','','30.67','jpg','0','0','2018-06-01','0');
-- -------Records of mengmei_attachment ----- -- 
INSERT INTO mengmei_attachment ( `id`, `name`, `path`, `path_thumb`, `size`, `ext`, `aid`, `iswx`, `ctime`, `isdel` ) VALUES ('24','下载.jpg','upload/20180601/1527840547108.jpg','','21.30','jpg','0','0','2018-06-01','0');
-- -------Records of mengmei_attachment ----- -- 
INSERT INTO mengmei_attachment ( `id`, `name`, `path`, `path_thumb`, `size`, `ext`, `aid`, `iswx`, `ctime`, `isdel` ) VALUES ('25','下载.jpg','upload/20180601/1527841097591.jpg','','21.30','jpg','0','0','2018-06-01','0');
-- -------Records of mengmei_attachment ----- -- 
INSERT INTO mengmei_attachment ( `id`, `name`, `path`, `path_thumb`, `size`, `ext`, `aid`, `iswx`, `ctime`, `isdel` ) VALUES ('26','下载 (2).jpg','upload/20180601/1527841196706.jpg','','30.67','jpg','0','0','2018-06-01','0');
-- -------Records of mengmei_attachment ----- -- 
INSERT INTO mengmei_attachment ( `id`, `name`, `path`, `path_thumb`, `size`, `ext`, `aid`, `iswx`, `ctime`, `isdel` ) VALUES ('27','下载.jpg','upload/20180601/1527841238856.jpg','','21.30','jpg','0','0','2018-06-01','0');
-- -------Records of mengmei_attachment ----- -- 
INSERT INTO mengmei_attachment ( `id`, `name`, `path`, `path_thumb`, `size`, `ext`, `aid`, `iswx`, `ctime`, `isdel` ) VALUES ('28','下载 (2).jpg','upload/20180604/1528083444853.jpg','','30.67','jpg','0','0','2018-06-04','0');
-- -------Records of mengmei_attachment ----- -- 
INSERT INTO mengmei_attachment ( `id`, `name`, `path`, `path_thumb`, `size`, `ext`, `aid`, `iswx`, `ctime`, `isdel` ) VALUES ('29','下载 (1).jpg','upload/20180604/1528083621272.jpg','','22.68','jpg','0','0','2018-06-04','0');
-- -------Records of mengmei_attachment ----- -- 
INSERT INTO mengmei_attachment ( `id`, `name`, `path`, `path_thumb`, `size`, `ext`, `aid`, `iswx`, `ctime`, `isdel` ) VALUES ('30','u=2249893882,1165836821&amp;fm=27&amp;gp=0.jpg','upload/20180604/1528083889662.jpg','','21.56','jpg','0','0','2018-06-04','0');
-- -------Records of mengmei_attachment ----- -- 
INSERT INTO mengmei_attachment ( `id`, `name`, `path`, `path_thumb`, `size`, `ext`, `aid`, `iswx`, `ctime`, `isdel` ) VALUES ('31','0316119018.jpg','upload/20180604/1528090303234.jpg','','94.75','jpg','0','0','2018-06-04','0');
-- -------Records of mengmei_attachment ----- -- 
INSERT INTO mengmei_attachment ( `id`, `name`, `path`, `path_thumb`, `size`, `ext`, `aid`, `iswx`, `ctime`, `isdel` ) VALUES ('32','u=2249893882,1165836821&amp;fm=27&amp;gp=0.jpg','upload/20180604/1528090331740.jpg','','21.56','jpg','0','0','2018-06-04','0');
-- -------Records of mengmei_attachment ----- -- 
INSERT INTO mengmei_attachment ( `id`, `name`, `path`, `path_thumb`, `size`, `ext`, `aid`, `iswx`, `ctime`, `isdel` ) VALUES ('33','u=2249893882,1165836821&amp;fm=27&amp;gp=0.jpg','upload/20180604/1528091632773.jpg','','21.56','jpg','0','0','2018-06-04','0');
-- -------Records of mengmei_attachment ----- -- 
INSERT INTO mengmei_attachment ( `id`, `name`, `path`, `path_thumb`, `size`, `ext`, `aid`, `iswx`, `ctime`, `isdel` ) VALUES ('34','下载 (1).jpg','upload/20180604/1528092688182.jpg','','22.68','jpg','0','0','2018-06-04','0');
-- -------Records of mengmei_attachment ----- -- 
INSERT INTO mengmei_attachment ( `id`, `name`, `path`, `path_thumb`, `size`, `ext`, `aid`, `iswx`, `ctime`, `isdel` ) VALUES ('35','u=2249893882,1165836821&amp;fm=27&amp;gp=0.jpg','upload/20180604/1528092854607.jpg','','21.56','jpg','0','0','2018-06-04','0');
-- -------Records of mengmei_attachment ----- -- 
INSERT INTO mengmei_attachment ( `id`, `name`, `path`, `path_thumb`, `size`, `ext`, `aid`, `iswx`, `ctime`, `isdel` ) VALUES ('36','u=2249893882,1165836821&amp;fm=27&amp;gp=0.jpg','upload/20180604/1528092952546.jpg','','21.56','jpg','0','0','2018-06-04','0');
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
) ENGINE=MyISAM AUTO_INCREMENT=16 DEFAULT CHARSET=utf8 COMMENT='用户组明细表';
-- -------Records of mengmei_auth_access ----- -- 
INSERT INTO mengmei_auth_access ( `id`, `uid`, `group_id` ) VALUES ('1','1','1');
-- -------Records of mengmei_auth_access ----- -- 
INSERT INTO mengmei_auth_access ( `id`, `uid`, `group_id` ) VALUES ('11','1','2');
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
INSERT INTO mengmei_auth_group ( `id`, `title`, `status`, `rules` ) VALUES ('1','超级管理员','1','1,4,5,52,90,91,92,69,78,79,80,81,2,6,7,8,9,10,11,12,13,14,15,16,17,53,54,55,56,58,59,60,61,62,63,64,68,77,82,83,84,85,86,3,18,19,20,21,22,28,23,24,25,26,27,29,30,31,32,65,75,76,33,49,50,87,88,89,37,38,41,42,43,47,93,39,44,45,46,94,95,96,97,98,67,51,72,73,74,66,70,71');
-- -------Records of mengmei_auth_group ----- -- 
INSERT INTO mengmei_auth_group ( `id`, `title`, `status`, `rules` ) VALUES ('2','网站编辑','1','6,7,8,9,10,11,12,13,14,15,16');
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
) ENGINE=MyISAM AUTO_INCREMENT=99 DEFAULT CHARSET=utf8 COMMENT='规则表';
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
) ENGINE=MyISAM AUTO_INCREMENT=15 DEFAULT CHARSET=utf8 COMMENT='分类表';
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
INSERT INTO mengmei_category ( `id`, `pid`, `childid`, `name`, `link`, `isdel`, `isshow`, `order` ) VALUES ('7','0','0','最新资讯','article_list','0','1','0');
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
) ENGINE=MyISAM AUTO_INCREMENT=2 DEFAULT CHARSET=utf8 COMMENT='专家表';
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
) ENGINE=InnoDB AUTO_INCREMENT=193 DEFAULT CHARSET=utf8 COMMENT='日志操作表';
-- -------Records of mengmei_log ----- -- 
INSERT INTO mengmei_log ( `id`, `uid`, `uname`, `ip`, `tables`, `tcomment`, `log`, `tid`, `type`, `ctime` ) VALUES ('166','1','admin','127.0.0.1','auth_rule','规则表','管理员【admin】操作表‘auth_rule’修改了一条数据','40','2','2018-05-25 14:08:13');
-- -------Records of mengmei_log ----- -- 
INSERT INTO mengmei_log ( `id`, `uid`, `uname`, `ip`, `tables`, `tcomment`, `log`, `tid`, `type`, `ctime` ) VALUES ('167','1','admin','127.0.0.1','auth_rule','规则表','管理员【admin】操作表‘auth_rule’修改了一条数据','41','2','2018-05-25 14:08:13');
-- -------Records of mengmei_log ----- -- 
INSERT INTO mengmei_log ( `id`, `uid`, `uname`, `ip`, `tables`, `tcomment`, `log`, `tid`, `type`, `ctime` ) VALUES ('168','1','admin','127.0.0.1','auth_rule','规则表','管理员【admin】操作表‘auth_rule’修改了一条数据','42','2','2018-05-25 14:08:13');
-- -------Records of mengmei_log ----- -- 
INSERT INTO mengmei_log ( `id`, `uid`, `uname`, `ip`, `tables`, `tcomment`, `log`, `tid`, `type`, `ctime` ) VALUES ('169','1','admin','127.0.0.1','auth_rule','规则表','管理员【admin】操作表‘auth_rule’修改了一条数据','43','2','2018-05-25 14:08:13');
-- -------Records of mengmei_log ----- -- 
INSERT INTO mengmei_log ( `id`, `uid`, `uname`, `ip`, `tables`, `tcomment`, `log`, `tid`, `type`, `ctime` ) VALUES ('170','1','admin','127.0.0.1','auth_rule','规则表','管理员【admin】操作表‘auth_rule’修改了一条数据','47','2','2018-05-25 14:08:13');
-- -------Records of mengmei_log ----- -- 
INSERT INTO mengmei_log ( `id`, `uid`, `uname`, `ip`, `tables`, `tcomment`, `log`, `tid`, `type`, `ctime` ) VALUES ('171','1','admin','127.0.0.1','auth_rule','规则表','管理员【admin】操作表‘auth_rule’修改了一条数据','40','2','2018-05-25 14:08:13');
-- -------Records of mengmei_log ----- -- 
INSERT INTO mengmei_log ( `id`, `uid`, `uname`, `ip`, `tables`, `tcomment`, `log`, `tid`, `type`, `ctime` ) VALUES ('172','1','admin','127.0.0.1','auth_rule','规则表','管理员【admin】操作表‘auth_rule’修改了一条数据','41','2','2018-05-25 14:08:13');
-- -------Records of mengmei_log ----- -- 
INSERT INTO mengmei_log ( `id`, `uid`, `uname`, `ip`, `tables`, `tcomment`, `log`, `tid`, `type`, `ctime` ) VALUES ('173','1','admin','127.0.0.1','auth_rule','规则表','管理员【admin】操作表‘auth_rule’修改了一条数据','42','2','2018-05-25 14:08:13');
-- -------Records of mengmei_log ----- -- 
INSERT INTO mengmei_log ( `id`, `uid`, `uname`, `ip`, `tables`, `tcomment`, `log`, `tid`, `type`, `ctime` ) VALUES ('174','1','admin','127.0.0.1','auth_rule','规则表','管理员【admin】操作表‘auth_rule’修改了一条数据','43','2','2018-05-25 14:08:13');
-- -------Records of mengmei_log ----- -- 
INSERT INTO mengmei_log ( `id`, `uid`, `uname`, `ip`, `tables`, `tcomment`, `log`, `tid`, `type`, `ctime` ) VALUES ('175','1','admin','127.0.0.1','auth_rule','规则表','管理员【admin】操作表‘auth_rule’修改了一条数据','47','2','2018-05-25 14:08:13');
-- -------Records of mengmei_log ----- -- 
INSERT INTO mengmei_log ( `id`, `uid`, `uname`, `ip`, `tables`, `tcomment`, `log`, `tid`, `type`, `ctime` ) VALUES ('176','1','admin','127.0.0.1','auth_rule','规则表','管理员【admin】操作表‘auth_rule’修改了一条数据','38','2','2018-05-25 14:08:13');
-- -------Records of mengmei_log ----- -- 
INSERT INTO mengmei_log ( `id`, `uid`, `uname`, `ip`, `tables`, `tcomment`, `log`, `tid`, `type`, `ctime` ) VALUES ('177','1','admin','127.0.0.1','auth_rule','规则表','管理员【admin】操作表‘auth_rule’新增了一条数据','93','1','2018-05-25 14:09:49');
-- -------Records of mengmei_log ----- -- 
INSERT INTO mengmei_log ( `id`, `uid`, `uname`, `ip`, `tables`, `tcomment`, `log`, `tid`, `type`, `ctime` ) VALUES ('178','1','admin','127.0.0.1','auth_rule','规则表','管理员【admin】操作表‘auth_rule’删除了一条数据','40','3','2018-05-25 14:10:19');
-- -------Records of mengmei_log ----- -- 
INSERT INTO mengmei_log ( `id`, `uid`, `uname`, `ip`, `tables`, `tcomment`, `log`, `tid`, `type`, `ctime` ) VALUES ('179','1','admin','127.0.0.1','auth_rule','规则表','管理员【admin】操作表‘auth_rule’修改了一条数据','93','2','2018-05-25 15:33:34');
-- -------Records of mengmei_log ----- -- 
INSERT INTO mengmei_log ( `id`, `uid`, `uname`, `ip`, `tables`, `tcomment`, `log`, `tid`, `type`, `ctime` ) VALUES ('180','1','admin','127.0.0.1','auth_rule','规则表','管理员【admin】操作表‘auth_rule’修改了一条数据','47','2','2018-05-25 15:52:36');
-- -------Records of mengmei_log ----- -- 
INSERT INTO mengmei_log ( `id`, `uid`, `uname`, `ip`, `tables`, `tcomment`, `log`, `tid`, `type`, `ctime` ) VALUES ('181','1','admin','127.0.0.1','wechat_account','微信公众号表','管理员【admin】操作表‘wechat_account’修改了一条数据','4','2','2018-05-29 10:52:52');
-- -------Records of mengmei_log ----- -- 
INSERT INTO mengmei_log ( `id`, `uid`, `uname`, `ip`, `tables`, `tcomment`, `log`, `tid`, `type`, `ctime` ) VALUES ('182','1','admin','127.0.0.1','article','文章表','管理员【admin】操作表‘article’新增了一条数据','58','1','2018-05-29 15:28:04');
-- -------Records of mengmei_log ----- -- 
INSERT INTO mengmei_log ( `id`, `uid`, `uname`, `ip`, `tables`, `tcomment`, `log`, `tid`, `type`, `ctime` ) VALUES ('183','1','admin','127.0.0.1','wechat_reply','关键字回复表','管理员【admin】操作表‘wechat_reply’新增了一条数据','5','1','2018-05-30 08:40:32');
-- -------Records of mengmei_log ----- -- 
INSERT INTO mengmei_log ( `id`, `uid`, `uname`, `ip`, `tables`, `tcomment`, `log`, `tid`, `type`, `ctime` ) VALUES ('184','1','admin','127.0.0.1','wechat_reply','关键字回复表','管理员【admin】操作表‘wechat_reply’修改了一条数据','5','2','2018-05-30 10:18:57');
-- -------Records of mengmei_log ----- -- 
INSERT INTO mengmei_log ( `id`, `uid`, `uname`, `ip`, `tables`, `tcomment`, `log`, `tid`, `type`, `ctime` ) VALUES ('185','1','admin','127.0.0.1','auth_rule','规则表','管理员【admin】操作表‘auth_rule’新增了一条数据','94','1','2018-06-01 10:12:18');
-- -------Records of mengmei_log ----- -- 
INSERT INTO mengmei_log ( `id`, `uid`, `uname`, `ip`, `tables`, `tcomment`, `log`, `tid`, `type`, `ctime` ) VALUES ('186','1','admin','127.0.0.1','auth_rule','规则表','管理员【admin】操作表‘auth_rule’新增了一条数据','95','1','2018-06-01 10:13:15');
-- -------Records of mengmei_log ----- -- 
INSERT INTO mengmei_log ( `id`, `uid`, `uname`, `ip`, `tables`, `tcomment`, `log`, `tid`, `type`, `ctime` ) VALUES ('187','1','admin','127.0.0.1','auth_rule','规则表','管理员【admin】操作表‘auth_rule’新增了一条数据','96','1','2018-06-01 10:13:54');
-- -------Records of mengmei_log ----- -- 
INSERT INTO mengmei_log ( `id`, `uid`, `uname`, `ip`, `tables`, `tcomment`, `log`, `tid`, `type`, `ctime` ) VALUES ('188','1','admin','127.0.0.1','auth_rule','规则表','管理员【admin】操作表‘auth_rule’修改了一条数据','95','2','2018-06-01 10:14:07');
-- -------Records of mengmei_log ----- -- 
INSERT INTO mengmei_log ( `id`, `uid`, `uname`, `ip`, `tables`, `tcomment`, `log`, `tid`, `type`, `ctime` ) VALUES ('189','1','admin','127.0.0.1','auth_rule','规则表','管理员【admin】操作表‘auth_rule’新增了一条数据','97','1','2018-06-01 10:14:26');
-- -------Records of mengmei_log ----- -- 
INSERT INTO mengmei_log ( `id`, `uid`, `uname`, `ip`, `tables`, `tcomment`, `log`, `tid`, `type`, `ctime` ) VALUES ('190','1','admin','127.0.0.1','auth_rule','规则表','管理员【admin】操作表‘auth_rule’修改了一条数据','97','2','2018-06-01 10:14:39');
-- -------Records of mengmei_log ----- -- 
INSERT INTO mengmei_log ( `id`, `uid`, `uname`, `ip`, `tables`, `tcomment`, `log`, `tid`, `type`, `ctime` ) VALUES ('191','1','admin','127.0.0.1','auth_rule','规则表','管理员【admin】操作表‘auth_rule’新增了一条数据','98','1','2018-06-01 10:15:06');
-- -------Records of mengmei_log ----- -- 
INSERT INTO mengmei_log ( `id`, `uid`, `uname`, `ip`, `tables`, `tcomment`, `log`, `tid`, `type`, `ctime` ) VALUES ('192','1','admin','127.0.0.1','category','分类表','管理员【admin】操作表‘category’修改了一条数据','7','2','2018-06-05 15:34:08');
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
) ENGINE=InnoDB AUTO_INCREMENT=758 DEFAULT CHARSET=utf8 COMMENT='操作日志从表';
-- -------Records of mengmei_log_content ----- -- 
INSERT INTO mengmei_log_content ( `id`, `tfield`, `toldvalue`, `tnewvalue`, `tcomment`, `logid`, `tid`, `ctime` ) VALUES ('625','id','40','','','166','40','2018-05-25 14:08:13');
-- -------Records of mengmei_log_content ----- -- 
INSERT INTO mengmei_log_content ( `id`, `tfield`, `toldvalue`, `tnewvalue`, `tcomment`, `logid`, `tid`, `ctime` ) VALUES ('626','pid','38','','父级id','166','40','2018-05-25 14:08:13');
-- -------Records of mengmei_log_content ----- -- 
INSERT INTO mengmei_log_content ( `id`, `tfield`, `toldvalue`, `tnewvalue`, `tcomment`, `logid`, `tid`, `ctime` ) VALUES ('627','name','admin/wechat/menu','','规则唯一标识，如：Admin/article/index','166','40','2018-05-25 14:08:13');
-- -------Records of mengmei_log_content ----- -- 
INSERT INTO mengmei_log_content ( `id`, `tfield`, `toldvalue`, `tnewvalue`, `tcomment`, `logid`, `tid`, `ctime` ) VALUES ('628','title','自定义菜单','','规则中文名称','166','40','2018-05-25 14:08:13');
-- -------Records of mengmei_log_content ----- -- 
INSERT INTO mengmei_log_content ( `id`, `tfield`, `toldvalue`, `tnewvalue`, `tcomment`, `logid`, `tid`, `ctime` ) VALUES ('629','status','1','','状态：1：启用，0：禁用','166','40','2018-05-25 14:08:13');
-- -------Records of mengmei_log_content ----- -- 
INSERT INTO mengmei_log_content ( `id`, `tfield`, `toldvalue`, `tnewvalue`, `tcomment`, `logid`, `tid`, `ctime` ) VALUES ('630','condition','','','规则表达式，为空表示存在就验证，不为空表示按照条件验证
自定义三级操作：
1.添加，2.编辑，3.查看，4.还原，5.删除','166','40','2018-05-25 14:08:13');
-- -------Records of mengmei_log_content ----- -- 
INSERT INTO mengmei_log_content ( `id`, `tfield`, `toldvalue`, `tnewvalue`, `tcomment`, `logid`, `tid`, `ctime` ) VALUES ('631','isdel','0','','是否删除：1：是，0：否','166','40','2018-05-25 14:08:13');
-- -------Records of mengmei_log_content ----- -- 
INSERT INTO mengmei_log_content ( `id`, `tfield`, `toldvalue`, `tnewvalue`, `tcomment`, `logid`, `tid`, `ctime` ) VALUES ('632','id','41','','','167','41','2018-05-25 14:08:13');
-- -------Records of mengmei_log_content ----- -- 
INSERT INTO mengmei_log_content ( `id`, `tfield`, `toldvalue`, `tnewvalue`, `tcomment`, `logid`, `tid`, `ctime` ) VALUES ('633','pid','38','','父级id','167','41','2018-05-25 14:08:13');
-- -------Records of mengmei_log_content ----- -- 
INSERT INTO mengmei_log_content ( `id`, `tfield`, `toldvalue`, `tnewvalue`, `tcomment`, `logid`, `tid`, `ctime` ) VALUES ('634','name','admin/wechat/menuedit','','规则唯一标识，如：Admin/article/index','167','41','2018-05-25 14:08:13');
-- -------Records of mengmei_log_content ----- -- 
INSERT INTO mengmei_log_content ( `id`, `tfield`, `toldvalue`, `tnewvalue`, `tcomment`, `logid`, `tid`, `ctime` ) VALUES ('635','title','添加账号','','规则中文名称','167','41','2018-05-25 14:08:13');
-- -------Records of mengmei_log_content ----- -- 
INSERT INTO mengmei_log_content ( `id`, `tfield`, `toldvalue`, `tnewvalue`, `tcomment`, `logid`, `tid`, `ctime` ) VALUES ('636','status','1','','状态：1：启用，0：禁用','167','41','2018-05-25 14:08:13');
-- -------Records of mengmei_log_content ----- -- 
INSERT INTO mengmei_log_content ( `id`, `tfield`, `toldvalue`, `tnewvalue`, `tcomment`, `logid`, `tid`, `ctime` ) VALUES ('637','condition','1','','规则表达式，为空表示存在就验证，不为空表示按照条件验证
自定义三级操作：
1.添加，2.编辑，3.查看，4.还原，5.删除','167','41','2018-05-25 14:08:13');
-- -------Records of mengmei_log_content ----- -- 
INSERT INTO mengmei_log_content ( `id`, `tfield`, `toldvalue`, `tnewvalue`, `tcomment`, `logid`, `tid`, `ctime` ) VALUES ('638','isdel','0','','是否删除：1：是，0：否','167','41','2018-05-25 14:08:13');
-- -------Records of mengmei_log_content ----- -- 
INSERT INTO mengmei_log_content ( `id`, `tfield`, `toldvalue`, `tnewvalue`, `tcomment`, `logid`, `tid`, `ctime` ) VALUES ('639','id','42','','','168','42','2018-05-25 14:08:13');
-- -------Records of mengmei_log_content ----- -- 
INSERT INTO mengmei_log_content ( `id`, `tfield`, `toldvalue`, `tnewvalue`, `tcomment`, `logid`, `tid`, `ctime` ) VALUES ('640','pid','38','','父级id','168','42','2018-05-25 14:08:13');
-- -------Records of mengmei_log_content ----- -- 
INSERT INTO mengmei_log_content ( `id`, `tfield`, `toldvalue`, `tnewvalue`, `tcomment`, `logid`, `tid`, `ctime` ) VALUES ('641','name','admin/wechat/menuedit','','规则唯一标识，如：Admin/article/index','168','42','2018-05-25 14:08:13');
-- -------Records of mengmei_log_content ----- -- 
INSERT INTO mengmei_log_content ( `id`, `tfield`, `toldvalue`, `tnewvalue`, `tcomment`, `logid`, `tid`, `ctime` ) VALUES ('642','title','账号修改','','规则中文名称','168','42','2018-05-25 14:08:13');
-- -------Records of mengmei_log_content ----- -- 
INSERT INTO mengmei_log_content ( `id`, `tfield`, `toldvalue`, `tnewvalue`, `tcomment`, `logid`, `tid`, `ctime` ) VALUES ('643','status','1','','状态：1：启用，0：禁用','168','42','2018-05-25 14:08:13');
-- -------Records of mengmei_log_content ----- -- 
INSERT INTO mengmei_log_content ( `id`, `tfield`, `toldvalue`, `tnewvalue`, `tcomment`, `logid`, `tid`, `ctime` ) VALUES ('644','condition','2','','规则表达式，为空表示存在就验证，不为空表示按照条件验证
自定义三级操作：
1.添加，2.编辑，3.查看，4.还原，5.删除','168','42','2018-05-25 14:08:13');
-- -------Records of mengmei_log_content ----- -- 
INSERT INTO mengmei_log_content ( `id`, `tfield`, `toldvalue`, `tnewvalue`, `tcomment`, `logid`, `tid`, `ctime` ) VALUES ('645','isdel','0','','是否删除：1：是，0：否','168','42','2018-05-25 14:08:13');
-- -------Records of mengmei_log_content ----- -- 
INSERT INTO mengmei_log_content ( `id`, `tfield`, `toldvalue`, `tnewvalue`, `tcomment`, `logid`, `tid`, `ctime` ) VALUES ('646','id','43','','','169','43','2018-05-25 14:08:13');
-- -------Records of mengmei_log_content ----- -- 
INSERT INTO mengmei_log_content ( `id`, `tfield`, `toldvalue`, `tnewvalue`, `tcomment`, `logid`, `tid`, `ctime` ) VALUES ('647','pid','38','','父级id','169','43','2018-05-25 14:08:13');
-- -------Records of mengmei_log_content ----- -- 
INSERT INTO mengmei_log_content ( `id`, `tfield`, `toldvalue`, `tnewvalue`, `tcomment`, `logid`, `tid`, `ctime` ) VALUES ('648','name','admin/wechat/menudel','','规则唯一标识，如：Admin/article/index','169','43','2018-05-25 14:08:13');
-- -------Records of mengmei_log_content ----- -- 
INSERT INTO mengmei_log_content ( `id`, `tfield`, `toldvalue`, `tnewvalue`, `tcomment`, `logid`, `tid`, `ctime` ) VALUES ('649','title','账号删除','','规则中文名称','169','43','2018-05-25 14:08:13');
-- -------Records of mengmei_log_content ----- -- 
INSERT INTO mengmei_log_content ( `id`, `tfield`, `toldvalue`, `tnewvalue`, `tcomment`, `logid`, `tid`, `ctime` ) VALUES ('650','status','1','','状态：1：启用，0：禁用','169','43','2018-05-25 14:08:13');
-- -------Records of mengmei_log_content ----- -- 
INSERT INTO mengmei_log_content ( `id`, `tfield`, `toldvalue`, `tnewvalue`, `tcomment`, `logid`, `tid`, `ctime` ) VALUES ('651','condition','5','','规则表达式，为空表示存在就验证，不为空表示按照条件验证
自定义三级操作：
1.添加，2.编辑，3.查看，4.还原，5.删除','169','43','2018-05-25 14:08:13');
-- -------Records of mengmei_log_content ----- -- 
INSERT INTO mengmei_log_content ( `id`, `tfield`, `toldvalue`, `tnewvalue`, `tcomment`, `logid`, `tid`, `ctime` ) VALUES ('652','isdel','0','','是否删除：1：是，0：否','169','43','2018-05-25 14:08:13');
-- -------Records of mengmei_log_content ----- -- 
INSERT INTO mengmei_log_content ( `id`, `tfield`, `toldvalue`, `tnewvalue`, `tcomment`, `logid`, `tid`, `ctime` ) VALUES ('653','id','47','','','170','47','2018-05-25 14:08:13');
-- -------Records of mengmei_log_content ----- -- 
INSERT INTO mengmei_log_content ( `id`, `tfield`, `toldvalue`, `tnewvalue`, `tcomment`, `logid`, `tid`, `ctime` ) VALUES ('654','pid','38','','父级id','170','47','2018-05-25 14:08:13');
-- -------Records of mengmei_log_content ----- -- 
INSERT INTO mengmei_log_content ( `id`, `tfield`, `toldvalue`, `tnewvalue`, `tcomment`, `logid`, `tid`, `ctime` ) VALUES ('655','name','admin/WechatCustomEdit/defaults','','规则唯一标识，如：Admin/article/index','170','47','2018-05-25 14:08:13');
-- -------Records of mengmei_log_content ----- -- 
INSERT INTO mengmei_log_content ( `id`, `tfield`, `toldvalue`, `tnewvalue`, `tcomment`, `logid`, `tid`, `ctime` ) VALUES ('656','title','默认回复','','规则中文名称','170','47','2018-05-25 14:08:13');
-- -------Records of mengmei_log_content ----- -- 
INSERT INTO mengmei_log_content ( `id`, `tfield`, `toldvalue`, `tnewvalue`, `tcomment`, `logid`, `tid`, `ctime` ) VALUES ('657','status','1','','状态：1：启用，0：禁用','170','47','2018-05-25 14:08:13');
-- -------Records of mengmei_log_content ----- -- 
INSERT INTO mengmei_log_content ( `id`, `tfield`, `toldvalue`, `tnewvalue`, `tcomment`, `logid`, `tid`, `ctime` ) VALUES ('658','condition','','','规则表达式，为空表示存在就验证，不为空表示按照条件验证
自定义三级操作：
1.添加，2.编辑，3.查看，4.还原，5.删除','170','47','2018-05-25 14:08:13');
-- -------Records of mengmei_log_content ----- -- 
INSERT INTO mengmei_log_content ( `id`, `tfield`, `toldvalue`, `tnewvalue`, `tcomment`, `logid`, `tid`, `ctime` ) VALUES ('659','isdel','0','','是否删除：1：是，0：否','170','47','2018-05-25 14:08:13');
-- -------Records of mengmei_log_content ----- -- 
INSERT INTO mengmei_log_content ( `id`, `tfield`, `toldvalue`, `tnewvalue`, `tcomment`, `logid`, `tid`, `ctime` ) VALUES ('660','id','38','','','176','38','2018-05-25 14:08:13');
-- -------Records of mengmei_log_content ----- -- 
INSERT INTO mengmei_log_content ( `id`, `tfield`, `toldvalue`, `tnewvalue`, `tcomment`, `logid`, `tid`, `ctime` ) VALUES ('661','pid','37','','父级id','176','38','2018-05-25 14:08:13');
-- -------Records of mengmei_log_content ----- -- 
INSERT INTO mengmei_log_content ( `id`, `tfield`, `toldvalue`, `tnewvalue`, `tcomment`, `logid`, `tid`, `ctime` ) VALUES ('662','name','admin/wechat/index','','规则唯一标识，如：Admin/article/index','176','38','2018-05-25 14:08:13');
-- -------Records of mengmei_log_content ----- -- 
INSERT INTO mengmei_log_content ( `id`, `tfield`, `toldvalue`, `tnewvalue`, `tcomment`, `logid`, `tid`, `ctime` ) VALUES ('663','title','管理账号','','规则中文名称','176','38','2018-05-25 14:08:13');
-- -------Records of mengmei_log_content ----- -- 
INSERT INTO mengmei_log_content ( `id`, `tfield`, `toldvalue`, `tnewvalue`, `tcomment`, `logid`, `tid`, `ctime` ) VALUES ('664','status','1','','状态：1：启用，0：禁用','176','38','2018-05-25 14:08:13');
-- -------Records of mengmei_log_content ----- -- 
INSERT INTO mengmei_log_content ( `id`, `tfield`, `toldvalue`, `tnewvalue`, `tcomment`, `logid`, `tid`, `ctime` ) VALUES ('665','condition','','','规则表达式，为空表示存在就验证，不为空表示按照条件验证
自定义三级操作：
1.添加，2.编辑，3.查看，4.还原，5.删除','176','38','2018-05-25 14:08:13');
-- -------Records of mengmei_log_content ----- -- 
INSERT INTO mengmei_log_content ( `id`, `tfield`, `toldvalue`, `tnewvalue`, `tcomment`, `logid`, `tid`, `ctime` ) VALUES ('666','isdel','0','','是否删除：1：是，0：否','176','38','2018-05-25 14:08:13');
-- -------Records of mengmei_log_content ----- -- 
INSERT INTO mengmei_log_content ( `id`, `tfield`, `toldvalue`, `tnewvalue`, `tcomment`, `logid`, `tid`, `ctime` ) VALUES ('667','id','93','','','177','93','2018-05-25 14:09:49');
-- -------Records of mengmei_log_content ----- -- 
INSERT INTO mengmei_log_content ( `id`, `tfield`, `toldvalue`, `tnewvalue`, `tcomment`, `logid`, `tid`, `ctime` ) VALUES ('668','pid','38','','父级id','177','93','2018-05-25 14:09:49');
-- -------Records of mengmei_log_content ----- -- 
INSERT INTO mengmei_log_content ( `id`, `tfield`, `toldvalue`, `tnewvalue`, `tcomment`, `logid`, `tid`, `ctime` ) VALUES ('669','name','admin/wechat/index','','规则唯一标识，如：Admin/article/index','177','93','2018-05-25 14:09:49');
-- -------Records of mengmei_log_content ----- -- 
INSERT INTO mengmei_log_content ( `id`, `tfield`, `toldvalue`, `tnewvalue`, `tcomment`, `logid`, `tid`, `ctime` ) VALUES ('670','title','菜单管理','','规则中文名称','177','93','2018-05-25 14:09:49');
-- -------Records of mengmei_log_content ----- -- 
INSERT INTO mengmei_log_content ( `id`, `tfield`, `toldvalue`, `tnewvalue`, `tcomment`, `logid`, `tid`, `ctime` ) VALUES ('671','status','1','','状态：1：启用，0：禁用','177','93','2018-05-25 14:09:49');
-- -------Records of mengmei_log_content ----- -- 
INSERT INTO mengmei_log_content ( `id`, `tfield`, `toldvalue`, `tnewvalue`, `tcomment`, `logid`, `tid`, `ctime` ) VALUES ('672','condition','','','规则表达式，为空表示存在就验证，不为空表示按照条件验证
自定义三级操作：
1.添加，2.编辑，3.查看，4.还原，5.删除','177','93','2018-05-25 14:09:49');
-- -------Records of mengmei_log_content ----- -- 
INSERT INTO mengmei_log_content ( `id`, `tfield`, `toldvalue`, `tnewvalue`, `tcomment`, `logid`, `tid`, `ctime` ) VALUES ('673','isdel','0','','是否删除：1：是，0：否','177','93','2018-05-25 14:09:49');
-- -------Records of mengmei_log_content ----- -- 
INSERT INTO mengmei_log_content ( `id`, `tfield`, `toldvalue`, `tnewvalue`, `tcomment`, `logid`, `tid`, `ctime` ) VALUES ('674','id','58','','','182','58','2018-05-29 15:28:05');
-- -------Records of mengmei_log_content ----- -- 
INSERT INTO mengmei_log_content ( `id`, `tfield`, `toldvalue`, `tnewvalue`, `tcomment`, `logid`, `tid`, `ctime` ) VALUES ('675','catid','2','','类别表id','182','58','2018-05-29 15:28:05');
-- -------Records of mengmei_log_content ----- -- 
INSERT INTO mengmei_log_content ( `id`, `tfield`, `toldvalue`, `tnewvalue`, `tcomment`, `logid`, `tid`, `ctime` ) VALUES ('676','name','数据库管理员','','标题','182','58','2018-05-29 15:28:05');
-- -------Records of mengmei_log_content ----- -- 
INSERT INTO mengmei_log_content ( `id`, `tfield`, `toldvalue`, `tnewvalue`, `tcomment`, `logid`, `tid`, `ctime` ) VALUES ('677','seo','','','seo搜索','182','58','2018-05-29 15:28:05');
-- -------Records of mengmei_log_content ----- -- 
INSERT INTO mengmei_log_content ( `id`, `tfield`, `toldvalue`, `tnewvalue`, `tcomment`, `logid`, `tid`, `ctime` ) VALUES ('678','keywords','','','关键字','182','58','2018-05-29 15:28:05');
-- -------Records of mengmei_log_content ----- -- 
INSERT INTO mengmei_log_content ( `id`, `tfield`, `toldvalue`, `tnewvalue`, `tcomment`, `logid`, `tid`, `ctime` ) VALUES ('679','description','的非官方的股份的分割的','','描述','182','58','2018-05-29 15:28:05');
-- -------Records of mengmei_log_content ----- -- 
INSERT INTO mengmei_log_content ( `id`, `tfield`, `toldvalue`, `tnewvalue`, `tcomment`, `logid`, `tid`, `ctime` ) VALUES ('680','editorid','1','','编辑人id','182','58','2018-05-29 15:28:05');
-- -------Records of mengmei_log_content ----- -- 
INSERT INTO mengmei_log_content ( `id`, `tfield`, `toldvalue`, `tnewvalue`, `tcomment`, `logid`, `tid`, `ctime` ) VALUES ('681','editor','admin','','编辑人','182','58','2018-05-29 15:28:05');
-- -------Records of mengmei_log_content ----- -- 
INSERT INTO mengmei_log_content ( `id`, `tfield`, `toldvalue`, `tnewvalue`, `tcomment`, `logid`, `tid`, `ctime` ) VALUES ('682','order','0','','文章排序','182','58','2018-05-29 15:28:05');
-- -------Records of mengmei_log_content ----- -- 
INSERT INTO mengmei_log_content ( `id`, `tfield`, `toldvalue`, `tnewvalue`, `tcomment`, `logid`, `tid`, `ctime` ) VALUES ('683','ctime','2018-05-29','','创建时间','182','58','2018-05-29 15:28:05');
-- -------Records of mengmei_log_content ----- -- 
INSERT INTO mengmei_log_content ( `id`, `tfield`, `toldvalue`, `tnewvalue`, `tcomment`, `logid`, `tid`, `ctime` ) VALUES ('684','utime','','','更新时间','182','58','2018-05-29 15:28:05');
-- -------Records of mengmei_log_content ----- -- 
INSERT INTO mengmei_log_content ( `id`, `tfield`, `toldvalue`, `tnewvalue`, `tcomment`, `logid`, `tid`, `ctime` ) VALUES ('685','ptime','2018-05-29','','发布时间','182','58','2018-05-29 15:28:05');
-- -------Records of mengmei_log_content ----- -- 
INSERT INTO mengmei_log_content ( `id`, `tfield`, `toldvalue`, `tnewvalue`, `tcomment`, `logid`, `tid`, `ctime` ) VALUES ('686','status','2','','发布状态: 0未发布, 1 已发布, 2 草稿, 3 撤回','182','58','2018-05-29 15:28:05');
-- -------Records of mengmei_log_content ----- -- 
INSERT INTO mengmei_log_content ( `id`, `tfield`, `toldvalue`, `tnewvalue`, `tcomment`, `logid`, `tid`, `ctime` ) VALUES ('687','hits','34','','点击总数','182','58','2018-05-29 15:28:05');
-- -------Records of mengmei_log_content ----- -- 
INSERT INTO mengmei_log_content ( `id`, `tfield`, `toldvalue`, `tnewvalue`, `tcomment`, `logid`, `tid`, `ctime` ) VALUES ('688','content','&nbsp;单发郭德纲','','内容目录','182','58','2018-05-29 15:28:05');
-- -------Records of mengmei_log_content ----- -- 
INSERT INTO mengmei_log_content ( `id`, `tfield`, `toldvalue`, `tnewvalue`, `tcomment`, `logid`, `tid`, `ctime` ) VALUES ('689','image','','','文章图片','182','58','2018-05-29 15:28:05');
-- -------Records of mengmei_log_content ----- -- 
INSERT INTO mengmei_log_content ( `id`, `tfield`, `toldvalue`, `tnewvalue`, `tcomment`, `logid`, `tid`, `ctime` ) VALUES ('690','recommend','0','','推荐：1.是，0.否','182','58','2018-05-29 15:28:05');
-- -------Records of mengmei_log_content ----- -- 
INSERT INTO mengmei_log_content ( `id`, `tfield`, `toldvalue`, `tnewvalue`, `tcomment`, `logid`, `tid`, `ctime` ) VALUES ('691','settop','0','','置顶：1.是，0.否','182','58','2018-05-29 15:28:05');
-- -------Records of mengmei_log_content ----- -- 
INSERT INTO mengmei_log_content ( `id`, `tfield`, `toldvalue`, `tnewvalue`, `tcomment`, `logid`, `tid`, `ctime` ) VALUES ('692','weixin','1','','微信终端 显示与否 0 否 1是','182','58','2018-05-29 15:28:05');
-- -------Records of mengmei_log_content ----- -- 
INSERT INTO mengmei_log_content ( `id`, `tfield`, `toldvalue`, `tnewvalue`, `tcomment`, `logid`, `tid`, `ctime` ) VALUES ('693','pc','1','','pc显示与否 0否 1是','182','58','2018-05-29 15:28:05');
-- -------Records of mengmei_log_content ----- -- 
INSERT INTO mengmei_log_content ( `id`, `tfield`, `toldvalue`, `tnewvalue`, `tcomment`, `logid`, `tid`, `ctime` ) VALUES ('694','mobile','1','','手机网站 显示与否 0 否 1是','182','58','2018-05-29 15:28:05');
-- -------Records of mengmei_log_content ----- -- 
INSERT INTO mengmei_log_content ( `id`, `tfield`, `toldvalue`, `tnewvalue`, `tcomment`, `logid`, `tid`, `ctime` ) VALUES ('695','app','1','','app终端 显示与否 0 否 1是','182','58','2018-05-29 15:28:05');
-- -------Records of mengmei_log_content ----- -- 
INSERT INTO mengmei_log_content ( `id`, `tfield`, `toldvalue`, `tnewvalue`, `tcomment`, `logid`, `tid`, `ctime` ) VALUES ('696','wshort','1','','小程序终端 显示与否 0 否 1是','182','58','2018-05-29 15:28:05');
-- -------Records of mengmei_log_content ----- -- 
INSERT INTO mengmei_log_content ( `id`, `tfield`, `toldvalue`, `tnewvalue`, `tcomment`, `logid`, `tid`, `ctime` ) VALUES ('697','isshow','1','','是否显示 1是 0否','182','58','2018-05-29 15:28:05');
-- -------Records of mengmei_log_content ----- -- 
INSERT INTO mengmei_log_content ( `id`, `tfield`, `toldvalue`, `tnewvalue`, `tcomment`, `logid`, `tid`, `ctime` ) VALUES ('698','isdel','0','','是否删除 1是 0否','182','58','2018-05-29 15:28:05');
-- -------Records of mengmei_log_content ----- -- 
INSERT INTO mengmei_log_content ( `id`, `tfield`, `toldvalue`, `tnewvalue`, `tcomment`, `logid`, `tid`, `ctime` ) VALUES ('699','copyfrom','本站原创','','文章来源','182','58','2018-05-29 15:28:05');
-- -------Records of mengmei_log_content ----- -- 
INSERT INTO mengmei_log_content ( `id`, `tfield`, `toldvalue`, `tnewvalue`, `tcomment`, `logid`, `tid`, `ctime` ) VALUES ('700','id','5','','','183','5','2018-05-30 08:40:32');
-- -------Records of mengmei_log_content ----- -- 
INSERT INTO mengmei_log_content ( `id`, `tfield`, `toldvalue`, `tnewvalue`, `tcomment`, `logid`, `tid`, `ctime` ) VALUES ('701','keyword','可乐','','关键字','183','5','2018-05-30 08:40:32');
-- -------Records of mengmei_log_content ----- -- 
INSERT INTO mengmei_log_content ( `id`, `tfield`, `toldvalue`, `tnewvalue`, `tcomment`, `logid`, `tid`, `ctime` ) VALUES ('702','type','2','','回复类型 0.关注(默认),1.未知,2.关键字 ','183','5','2018-05-30 08:40:32');
-- -------Records of mengmei_log_content ----- -- 
INSERT INTO mengmei_log_content ( `id`, `tfield`, `toldvalue`, `tnewvalue`, `tcomment`, `logid`, `tid`, `ctime` ) VALUES ('703','replytype','2','','回复类别 1.图文,2.文本,3.图片,4.语音,5.视频','183','5','2018-05-30 08:40:32');
-- -------Records of mengmei_log_content ----- -- 
INSERT INTO mengmei_log_content ( `id`, `tfield`, `toldvalue`, `tnewvalue`, `tcomment`, `logid`, `tid`, `ctime` ) VALUES ('704','ktype','0','','关键词类型 0.完全,1.包含','183','5','2018-05-30 08:40:32');
-- -------Records of mengmei_log_content ----- -- 
INSERT INTO mengmei_log_content ( `id`, `tfield`, `toldvalue`, `tnewvalue`, `tcomment`, `logid`, `tid`, `ctime` ) VALUES ('705','isenable','1','','是否启用 1.是, 0.否','183','5','2018-05-30 08:40:32');
-- -------Records of mengmei_log_content ----- -- 
INSERT INTO mengmei_log_content ( `id`, `tfield`, `toldvalue`, `tnewvalue`, `tcomment`, `logid`, `tid`, `ctime` ) VALUES ('706','hits','0','','点击次数','183','5','2018-05-30 08:40:32');
-- -------Records of mengmei_log_content ----- -- 
INSERT INTO mengmei_log_content ( `id`, `tfield`, `toldvalue`, `tnewvalue`, `tcomment`, `logid`, `tid`, `ctime` ) VALUES ('707','text','lele','','回复文本，回复文本类型有效','183','5','2018-05-30 08:40:32');
-- -------Records of mengmei_log_content ----- -- 
INSERT INTO mengmei_log_content ( `id`, `tfield`, `toldvalue`, `tnewvalue`, `tcomment`, `logid`, `tid`, `ctime` ) VALUES ('708','sorts','0','','排序','183','5','2018-05-30 08:40:32');
-- -------Records of mengmei_log_content ----- -- 
INSERT INTO mengmei_log_content ( `id`, `tfield`, `toldvalue`, `tnewvalue`, `tcomment`, `logid`, `tid`, `ctime` ) VALUES ('709','token','5ZEhiG0RvUcKru4xMr7V','','','183','5','2018-05-30 08:40:32');
-- -------Records of mengmei_log_content ----- -- 
INSERT INTO mengmei_log_content ( `id`, `tfield`, `toldvalue`, `tnewvalue`, `tcomment`, `logid`, `tid`, `ctime` ) VALUES ('710','aid','0','','外键id 根据表名确定','183','5','2018-05-30 08:40:32');
-- -------Records of mengmei_log_content ----- -- 
INSERT INTO mengmei_log_content ( `id`, `tfield`, `toldvalue`, `tnewvalue`, `tcomment`, `logid`, `tid`, `ctime` ) VALUES ('711','tablename','','','表名','183','5','2018-05-30 08:40:32');
-- -------Records of mengmei_log_content ----- -- 
INSERT INTO mengmei_log_content ( `id`, `tfield`, `toldvalue`, `tnewvalue`, `tcomment`, `logid`, `tid`, `ctime` ) VALUES ('712','isdel','0','','是否删除：1.是，0.否','183','5','2018-05-30 08:40:32');
-- -------Records of mengmei_log_content ----- -- 
INSERT INTO mengmei_log_content ( `id`, `tfield`, `toldvalue`, `tnewvalue`, `tcomment`, `logid`, `tid`, `ctime` ) VALUES ('713','id','94','','','185','94','2018-06-01 10:12:18');
-- -------Records of mengmei_log_content ----- -- 
INSERT INTO mengmei_log_content ( `id`, `tfield`, `toldvalue`, `tnewvalue`, `tcomment`, `logid`, `tid`, `ctime` ) VALUES ('714','pid','37','','父级id','185','94','2018-06-01 10:12:18');
-- -------Records of mengmei_log_content ----- -- 
INSERT INTO mengmei_log_content ( `id`, `tfield`, `toldvalue`, `tnewvalue`, `tcomment`, `logid`, `tid`, `ctime` ) VALUES ('715','name','admin/wechatResource/sourse_list','','规则唯一标识，如：Admin/article/index','185','94','2018-06-01 10:12:18');
-- -------Records of mengmei_log_content ----- -- 
INSERT INTO mengmei_log_content ( `id`, `tfield`, `toldvalue`, `tnewvalue`, `tcomment`, `logid`, `tid`, `ctime` ) VALUES ('716','title','素材管理','','规则中文名称','185','94','2018-06-01 10:12:18');
-- -------Records of mengmei_log_content ----- -- 
INSERT INTO mengmei_log_content ( `id`, `tfield`, `toldvalue`, `tnewvalue`, `tcomment`, `logid`, `tid`, `ctime` ) VALUES ('717','status','1','','状态：1：启用，0：禁用','185','94','2018-06-01 10:12:18');
-- -------Records of mengmei_log_content ----- -- 
INSERT INTO mengmei_log_content ( `id`, `tfield`, `toldvalue`, `tnewvalue`, `tcomment`, `logid`, `tid`, `ctime` ) VALUES ('718','condition','','','规则表达式，为空表示存在就验证，不为空表示按照条件验证
自定义三级操作：
1.添加，2.编辑，3.查看，4.还原，5.删除','185','94','2018-06-01 10:12:18');
-- -------Records of mengmei_log_content ----- -- 
INSERT INTO mengmei_log_content ( `id`, `tfield`, `toldvalue`, `tnewvalue`, `tcomment`, `logid`, `tid`, `ctime` ) VALUES ('719','isdel','0','','是否删除：1：是，0：否','185','94','2018-06-01 10:12:18');
-- -------Records of mengmei_log_content ----- -- 
INSERT INTO mengmei_log_content ( `id`, `tfield`, `toldvalue`, `tnewvalue`, `tcomment`, `logid`, `tid`, `ctime` ) VALUES ('720','id','95','','','186','95','2018-06-01 10:13:15');
-- -------Records of mengmei_log_content ----- -- 
INSERT INTO mengmei_log_content ( `id`, `tfield`, `toldvalue`, `tnewvalue`, `tcomment`, `logid`, `tid`, `ctime` ) VALUES ('721','pid','94','','父级id','186','95','2018-06-01 10:13:15');
-- -------Records of mengmei_log_content ----- -- 
INSERT INTO mengmei_log_content ( `id`, `tfield`, `toldvalue`, `tnewvalue`, `tcomment`, `logid`, `tid`, `ctime` ) VALUES ('722','name','admin/wechatResource/sourse_add','','规则唯一标识，如：Admin/article/index','186','95','2018-06-01 10:13:15');
-- -------Records of mengmei_log_content ----- -- 
INSERT INTO mengmei_log_content ( `id`, `tfield`, `toldvalue`, `tnewvalue`, `tcomment`, `logid`, `tid`, `ctime` ) VALUES ('723','title','素材添加','','规则中文名称','186','95','2018-06-01 10:13:15');
-- -------Records of mengmei_log_content ----- -- 
INSERT INTO mengmei_log_content ( `id`, `tfield`, `toldvalue`, `tnewvalue`, `tcomment`, `logid`, `tid`, `ctime` ) VALUES ('724','status','1','','状态：1：启用，0：禁用','186','95','2018-06-01 10:13:15');
-- -------Records of mengmei_log_content ----- -- 
INSERT INTO mengmei_log_content ( `id`, `tfield`, `toldvalue`, `tnewvalue`, `tcomment`, `logid`, `tid`, `ctime` ) VALUES ('725','condition','1','','规则表达式，为空表示存在就验证，不为空表示按照条件验证
自定义三级操作：
1.添加，2.编辑，3.查看，4.还原，5.删除','186','95','2018-06-01 10:13:15');
-- -------Records of mengmei_log_content ----- -- 
INSERT INTO mengmei_log_content ( `id`, `tfield`, `toldvalue`, `tnewvalue`, `tcomment`, `logid`, `tid`, `ctime` ) VALUES ('726','isdel','0','','是否删除：1：是，0：否','186','95','2018-06-01 10:13:15');
-- -------Records of mengmei_log_content ----- -- 
INSERT INTO mengmei_log_content ( `id`, `tfield`, `toldvalue`, `tnewvalue`, `tcomment`, `logid`, `tid`, `ctime` ) VALUES ('727','id','96','','','187','96','2018-06-01 10:13:54');
-- -------Records of mengmei_log_content ----- -- 
INSERT INTO mengmei_log_content ( `id`, `tfield`, `toldvalue`, `tnewvalue`, `tcomment`, `logid`, `tid`, `ctime` ) VALUES ('728','pid','94','','父级id','187','96','2018-06-01 10:13:54');
-- -------Records of mengmei_log_content ----- -- 
INSERT INTO mengmei_log_content ( `id`, `tfield`, `toldvalue`, `tnewvalue`, `tcomment`, `logid`, `tid`, `ctime` ) VALUES ('729','name','admin/wechatResource/sourse_edit','','规则唯一标识，如：Admin/article/index','187','96','2018-06-01 10:13:54');
-- -------Records of mengmei_log_content ----- -- 
INSERT INTO mengmei_log_content ( `id`, `tfield`, `toldvalue`, `tnewvalue`, `tcomment`, `logid`, `tid`, `ctime` ) VALUES ('730','title','素材编辑','','规则中文名称','187','96','2018-06-01 10:13:54');
-- -------Records of mengmei_log_content ----- -- 
INSERT INTO mengmei_log_content ( `id`, `tfield`, `toldvalue`, `tnewvalue`, `tcomment`, `logid`, `tid`, `ctime` ) VALUES ('731','status','1','','状态：1：启用，0：禁用','187','96','2018-06-01 10:13:54');
-- -------Records of mengmei_log_content ----- -- 
INSERT INTO mengmei_log_content ( `id`, `tfield`, `toldvalue`, `tnewvalue`, `tcomment`, `logid`, `tid`, `ctime` ) VALUES ('732','condition','2','','规则表达式，为空表示存在就验证，不为空表示按照条件验证
自定义三级操作：
1.添加，2.编辑，3.查看，4.还原，5.删除','187','96','2018-06-01 10:13:54');
-- -------Records of mengmei_log_content ----- -- 
INSERT INTO mengmei_log_content ( `id`, `tfield`, `toldvalue`, `tnewvalue`, `tcomment`, `logid`, `tid`, `ctime` ) VALUES ('733','isdel','0','','是否删除：1：是，0：否','187','96','2018-06-01 10:13:54');
-- -------Records of mengmei_log_content ----- -- 
INSERT INTO mengmei_log_content ( `id`, `tfield`, `toldvalue`, `tnewvalue`, `tcomment`, `logid`, `tid`, `ctime` ) VALUES ('734','id','97','','','189','97','2018-06-01 10:14:26');
-- -------Records of mengmei_log_content ----- -- 
INSERT INTO mengmei_log_content ( `id`, `tfield`, `toldvalue`, `tnewvalue`, `tcomment`, `logid`, `tid`, `ctime` ) VALUES ('735','pid','94','','父级id','189','97','2018-06-01 10:14:26');
-- -------Records of mengmei_log_content ----- -- 
INSERT INTO mengmei_log_content ( `id`, `tfield`, `toldvalue`, `tnewvalue`, `tcomment`, `logid`, `tid`, `ctime` ) VALUES ('736','name','admin/wechatResource/sourse_得了、','','规则唯一标识，如：Admin/article/index','189','97','2018-06-01 10:14:26');
-- -------Records of mengmei_log_content ----- -- 
INSERT INTO mengmei_log_content ( `id`, `tfield`, `toldvalue`, `tnewvalue`, `tcomment`, `logid`, `tid`, `ctime` ) VALUES ('737','title','素材删除','','规则中文名称','189','97','2018-06-01 10:14:26');
-- -------Records of mengmei_log_content ----- -- 
INSERT INTO mengmei_log_content ( `id`, `tfield`, `toldvalue`, `tnewvalue`, `tcomment`, `logid`, `tid`, `ctime` ) VALUES ('738','status','1','','状态：1：启用，0：禁用','189','97','2018-06-01 10:14:26');
-- -------Records of mengmei_log_content ----- -- 
INSERT INTO mengmei_log_content ( `id`, `tfield`, `toldvalue`, `tnewvalue`, `tcomment`, `logid`, `tid`, `ctime` ) VALUES ('739','condition','','','规则表达式，为空表示存在就验证，不为空表示按照条件验证
自定义三级操作：
1.添加，2.编辑，3.查看，4.还原，5.删除','189','97','2018-06-01 10:14:26');
-- -------Records of mengmei_log_content ----- -- 
INSERT INTO mengmei_log_content ( `id`, `tfield`, `toldvalue`, `tnewvalue`, `tcomment`, `logid`, `tid`, `ctime` ) VALUES ('740','isdel','0','','是否删除：1：是，0：否','189','97','2018-06-01 10:14:26');
-- -------Records of mengmei_log_content ----- -- 
INSERT INTO mengmei_log_content ( `id`, `tfield`, `toldvalue`, `tnewvalue`, `tcomment`, `logid`, `tid`, `ctime` ) VALUES ('741','id','98','','','191','98','2018-06-01 10:15:06');
-- -------Records of mengmei_log_content ----- -- 
INSERT INTO mengmei_log_content ( `id`, `tfield`, `toldvalue`, `tnewvalue`, `tcomment`, `logid`, `tid`, `ctime` ) VALUES ('742','pid','94','','父级id','191','98','2018-06-01 10:15:06');
-- -------Records of mengmei_log_content ----- -- 
INSERT INTO mengmei_log_content ( `id`, `tfield`, `toldvalue`, `tnewvalue`, `tcomment`, `logid`, `tid`, `ctime` ) VALUES ('743','name','admin/wechatResource/sourse_check','','规则唯一标识，如：Admin/article/index','191','98','2018-06-01 10:15:06');
-- -------Records of mengmei_log_content ----- -- 
INSERT INTO mengmei_log_content ( `id`, `tfield`, `toldvalue`, `tnewvalue`, `tcomment`, `logid`, `tid`, `ctime` ) VALUES ('744','title','素材查看','','规则中文名称','191','98','2018-06-01 10:15:06');
-- -------Records of mengmei_log_content ----- -- 
INSERT INTO mengmei_log_content ( `id`, `tfield`, `toldvalue`, `tnewvalue`, `tcomment`, `logid`, `tid`, `ctime` ) VALUES ('745','status','1','','状态：1：启用，0：禁用','191','98','2018-06-01 10:15:06');
-- -------Records of mengmei_log_content ----- -- 
INSERT INTO mengmei_log_content ( `id`, `tfield`, `toldvalue`, `tnewvalue`, `tcomment`, `logid`, `tid`, `ctime` ) VALUES ('746','condition','3','','规则表达式，为空表示存在就验证，不为空表示按照条件验证
自定义三级操作：
1.添加，2.编辑，3.查看，4.还原，5.删除','191','98','2018-06-01 10:15:06');
-- -------Records of mengmei_log_content ----- -- 
INSERT INTO mengmei_log_content ( `id`, `tfield`, `toldvalue`, `tnewvalue`, `tcomment`, `logid`, `tid`, `ctime` ) VALUES ('747','isdel','0','','是否删除：1：是，0：否','191','98','2018-06-01 10:15:06');
-- -------Records of mengmei_log_content ----- -- 
INSERT INTO mengmei_log_content ( `id`, `tfield`, `toldvalue`, `tnewvalue`, `tcomment`, `logid`, `tid`, `ctime` ) VALUES ('748','id','7','','','192','7','2018-06-05 15:34:08');
-- -------Records of mengmei_log_content ----- -- 
INSERT INTO mengmei_log_content ( `id`, `tfield`, `toldvalue`, `tnewvalue`, `tcomment`, `logid`, `tid`, `ctime` ) VALUES ('749','pid','0','','父级id','192','7','2018-06-05 15:34:08');
-- -------Records of mengmei_log_content ----- -- 
INSERT INTO mengmei_log_content ( `id`, `tfield`, `toldvalue`, `tnewvalue`, `tcomment`, `logid`, `tid`, `ctime` ) VALUES ('750','childid','0','','是否为子集 0 否 1是','192','7','2018-06-05 15:34:08');
-- -------Records of mengmei_log_content ----- -- 
INSERT INTO mengmei_log_content ( `id`, `tfield`, `toldvalue`, `tnewvalue`, `tcomment`, `logid`, `tid`, `ctime` ) VALUES ('751','name','最新资讯','','类别名称','192','7','2018-06-05 15:34:08');
-- -------Records of mengmei_log_content ----- -- 
INSERT INTO mengmei_log_content ( `id`, `tfield`, `toldvalue`, `tnewvalue`, `tcomment`, `logid`, `tid`, `ctime` ) VALUES ('752','link','','','','192','7','2018-06-05 15:34:08');
-- -------Records of mengmei_log_content ----- -- 
INSERT INTO mengmei_log_content ( `id`, `tfield`, `toldvalue`, `tnewvalue`, `tcomment`, `logid`, `tid`, `ctime` ) VALUES ('753','isdel','0','','是否删除：1.是，0.否','192','7','2018-06-05 15:34:08');
-- -------Records of mengmei_log_content ----- -- 
INSERT INTO mengmei_log_content ( `id`, `tfield`, `toldvalue`, `tnewvalue`, `tcomment`, `logid`, `tid`, `ctime` ) VALUES ('754','isshow','1','','是否显示：1.是，0.否','192','7','2018-06-05 15:34:08');
-- -------Records of mengmei_log_content ----- -- 
INSERT INTO mengmei_log_content ( `id`, `tfield`, `toldvalue`, `tnewvalue`, `tcomment`, `logid`, `tid`, `ctime` ) VALUES ('755','order','','','排序，越小越靠前','192','7','2018-06-05 15:34:08');
-- -------Records of mengmei_log_content ----- -- 
INSERT INTO mengmei_log_content ( `id`, `tfield`, `toldvalue`, `tnewvalue`, `tcomment`, `logid`, `tid`, `ctime` ) VALUES ('756','order','','0','排序，越小越靠前','192','7','2018-06-05 15:34:08');
-- -------Records of mengmei_log_content ----- -- 
INSERT INTO mengmei_log_content ( `id`, `tfield`, `toldvalue`, `tnewvalue`, `tcomment`, `logid`, `tid`, `ctime` ) VALUES ('757','link','','article_list','','192','7','2018-06-05 15:34:08');
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
) ENGINE=MyISAM AUTO_INCREMENT=22 DEFAULT CHARSET=utf8 COMMENT='邮件表';
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
  `isdel` tinyint(1) NOT NULL DEFAULT '0' COMMENT '删除状态：1.是，0.否',
  PRIMARY KEY (`id`)
) ENGINE=MyISAM AUTO_INCREMENT=11 DEFAULT CHARSET=utf8 COMMENT='客户留言表';
-- -------Records of mengmei_message ----- -- 
INSERT INTO mengmei_message ( `id`, `name`, `sex`, `age`, `wechat`, `mobile`, `mail`, `address`, `message`, `type`, `ctime`, `status`, `will`, `isone`, `source`, `isdel` ) VALUES ('1','姚麒山','1','0','wechtswe','18888888888','','','','0','0000-00-00 00:00:00','0','0','0','0','0');
-- -------Records of mengmei_message ----- -- 
INSERT INTO mengmei_message ( `id`, `name`, `sex`, `age`, `wechat`, `mobile`, `mail`, `address`, `message`, `type`, `ctime`, `status`, `will`, `isone`, `source`, `isdel` ) VALUES ('2','姚麒山','1','0','wechtswe','18888888888','','','','0','0000-00-00 00:00:00','0','0','0','0','0');
-- -------Records of mengmei_message ----- -- 
INSERT INTO mengmei_message ( `id`, `name`, `sex`, `age`, `wechat`, `mobile`, `mail`, `address`, `message`, `type`, `ctime`, `status`, `will`, `isone`, `source`, `isdel` ) VALUES ('3','姚麒山','1','0','wechtswe','18888888888','','','','0','0000-00-00 00:00:00','0','0','0','0','0');
-- -------Records of mengmei_message ----- -- 
INSERT INTO mengmei_message ( `id`, `name`, `sex`, `age`, `wechat`, `mobile`, `mail`, `address`, `message`, `type`, `ctime`, `status`, `will`, `isone`, `source`, `isdel` ) VALUES ('4','姚麒山','1','0','wechtswe','18888888888','','','','0','0000-00-00 00:00:00','0','0','0','0','0');
-- -------Records of mengmei_message ----- -- 
INSERT INTO mengmei_message ( `id`, `name`, `sex`, `age`, `wechat`, `mobile`, `mail`, `address`, `message`, `type`, `ctime`, `status`, `will`, `isone`, `source`, `isdel` ) VALUES ('5','姚麒山','1','0','wechtswe','18888888888','','','','0','0000-00-00 00:00:00','0','0','0','0','0');
-- -------Records of mengmei_message ----- -- 
INSERT INTO mengmei_message ( `id`, `name`, `sex`, `age`, `wechat`, `mobile`, `mail`, `address`, `message`, `type`, `ctime`, `status`, `will`, `isone`, `source`, `isdel` ) VALUES ('6','姚麒山','1','0','wechtswe','18888888888','','','','0','0000-00-00 00:00:00','0','0','0','0','0');
-- -------Records of mengmei_message ----- -- 
INSERT INTO mengmei_message ( `id`, `name`, `sex`, `age`, `wechat`, `mobile`, `mail`, `address`, `message`, `type`, `ctime`, `status`, `will`, `isone`, `source`, `isdel` ) VALUES ('7','姚麒山','1','0','wechtswe','18888888888','','','','0','0000-00-00 00:00:00','0','0','0','0','0');
-- -------Records of mengmei_message ----- -- 
INSERT INTO mengmei_message ( `id`, `name`, `sex`, `age`, `wechat`, `mobile`, `mail`, `address`, `message`, `type`, `ctime`, `status`, `will`, `isone`, `source`, `isdel` ) VALUES ('8','姚山','1','0','4145w','18825252525','','','','0','0000-00-00 00:00:00','0','0','0','0','0');
-- -------Records of mengmei_message ----- -- 
INSERT INTO mengmei_message ( `id`, `name`, `sex`, `age`, `wechat`, `mobile`, `mail`, `address`, `message`, `type`, `ctime`, `status`, `will`, `isone`, `source`, `isdel` ) VALUES ('9','姚山','1','0','4145w','18825252525','','','','0','0000-00-00 00:00:00','0','0','0','0','0');
-- -------Records of mengmei_message ----- -- 
INSERT INTO mengmei_message ( `id`, `name`, `sex`, `age`, `wechat`, `mobile`, `mail`, `address`, `message`, `type`, `ctime`, `status`, `will`, `isone`, `source`, `isdel` ) VALUES ('10','网络','1','0','国家经济','18452536544','','','','0','0000-00-00 00:00:00','0','0','0','0','0');
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
) ENGINE=MyISAM AUTO_INCREMENT=44 DEFAULT CHARSET=utf8 COMMENT='回收站表';
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
) ENGINE=MyISAM AUTO_INCREMENT=33 DEFAULT CHARSET=utf8 COMMENT='自定义菜单表';
-- -------Records of mengmei_wechat_menu ----- -- 
INSERT INTO mengmei_wechat_menu ( `id`, `name`, `pid`, `order`, `links`, `sendtype`, `type`, `x`, `y`, `token`, `isshow`, `replytype`, `text`, `aid`, `tablename`, `isdel` ) VALUES ('29','红米','26','0','http://www.mi.com','2','1','1','1','5ZEhiG0RvUcKru4xMr7V','1','0','','0','','0');
-- -------Records of mengmei_wechat_menu ----- -- 
INSERT INTO mengmei_wechat_menu ( `id`, `name`, `pid`, `order`, `links`, `sendtype`, `type`, `x`, `y`, `token`, `isshow`, `replytype`, `text`, `aid`, `tablename`, `isdel` ) VALUES ('26','小米','0','0','','1','2','1','0','5ZEhiG0RvUcKru4xMr7V','1','2','小米科技','0','','0');
-- -------Records of mengmei_wechat_menu ----- -- 
INSERT INTO mengmei_wechat_menu ( `id`, `name`, `pid`, `order`, `links`, `sendtype`, `type`, `x`, `y`, `token`, `isshow`, `replytype`, `text`, `aid`, `tablename`, `isdel` ) VALUES ('27','华为','0','0','','1','2','2','0','5ZEhiG0RvUcKru4xMr7V','1','2','华为科技','0','','0');
-- -------Records of mengmei_wechat_menu ----- -- 
INSERT INTO mengmei_wechat_menu ( `id`, `name`, `pid`, `order`, `links`, `sendtype`, `type`, `x`, `y`, `token`, `isshow`, `replytype`, `text`, `aid`, `tablename`, `isdel` ) VALUES ('28','锤子','0','0','','1','2','3','0','5ZEhiG0RvUcKru4xMr7V','1','2','锤子科技','0','','0');
-- -------Records of mengmei_wechat_menu ----- -- 
INSERT INTO mengmei_wechat_menu ( `id`, `name`, `pid`, `order`, `links`, `sendtype`, `type`, `x`, `y`, `token`, `isshow`, `replytype`, `text`, `aid`, `tablename`, `isdel` ) VALUES ('30','小米note','26','0','','1','1','1','2','5ZEhiG0RvUcKru4xMr7V','1','1','','2','category','0');
-- -------Records of mengmei_wechat_menu ----- -- 
INSERT INTO mengmei_wechat_menu ( `id`, `name`, `pid`, `order`, `links`, `sendtype`, `type`, `x`, `y`, `token`, `isshow`, `replytype`, `text`, `aid`, `tablename`, `isdel` ) VALUES ('31','一锤子买卖','28','0','','1','1','3','1','5ZEhiG0RvUcKru4xMr7V','1','2','滚犊子/发怒','0','','0');
-- -------Records of mengmei_wechat_menu ----- -- 
INSERT INTO mengmei_wechat_menu ( `id`, `name`, `pid`, `order`, `links`, `sendtype`, `type`, `x`, `y`, `token`, `isshow`, `replytype`, `text`, `aid`, `tablename`, `isdel` ) VALUES ('32','华为平板','27','0','http://www.huawei.com','2','2','2','1','5ZEhiG0RvUcKru4xMr7V','1','0','','2','category','0');
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
) ENGINE=MyISAM AUTO_INCREMENT=6 DEFAULT CHARSET=utf8 COMMENT='关键字回复表';
-- -------Records of mengmei_wechat_reply ----- -- 
INSERT INTO mengmei_wechat_reply ( `id`, `keyword`, `type`, `replytype`, `ktype`, `isenable`, `hits`, `text`, `sorts`, `token`, `aid`, `tablename`, `isdel` ) VALUES ('4','妖精的尾巴','2','1','0','1','0','','0','5ZEhiG0RvUcKru4xMr7V','2','category','0');
-- -------Records of mengmei_wechat_reply ----- -- 
INSERT INTO mengmei_wechat_reply ( `id`, `keyword`, `type`, `replytype`, `ktype`, `isenable`, `hits`, `text`, `sorts`, `token`, `aid`, `tablename`, `isdel` ) VALUES ('3','','0','1','0','1','0','','0','5ZEhiG0RvUcKru4xMr7V','2','category','0');
-- -------Records of mengmei_wechat_reply ----- -- 
INSERT INTO mengmei_wechat_reply ( `id`, `keyword`, `type`, `replytype`, `ktype`, `isenable`, `hits`, `text`, `sorts`, `token`, `aid`, `tablename`, `isdel` ) VALUES ('5','可乐','2','2','0','1','0','lele','0','5ZEhiG0RvUcKru4xMr7V','0','','0');
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
) ENGINE=MyISAM AUTO_INCREMENT=49 DEFAULT CHARSET=utf8 COMMENT='微信素材主表';
-- -------Records of mengmei_wechat_resource ----- -- 
INSERT INTO mengmei_wechat_resource ( `id`, `media_id`, `ctime`, `utime`, `stime`, `sourse_num`, `send_num`, `wechat_id`, `isdel` ) VALUES ('46','VlnuIP8JKdzFH8NZOGn_Nwgf6okKYqq_FVpd6OWAtDM','2018-06-04 14:07:46','2018-06-01 14:59:57','2018-06-04 23:59:58','2','0','1','0');
-- -------Records of mengmei_wechat_resource ----- -- 
INSERT INTO mengmei_wechat_resource ( `id`, `media_id`, `ctime`, `utime`, `stime`, `sourse_num`, `send_num`, `wechat_id`, `isdel` ) VALUES ('47','VlnuIP8JKdzFH8NZOGn_NyH7m5wwQlOCuCf12B06UbA','2018-06-04 14:07:46','2018-05-31 13:54:11','','2','0','1','0');
-- -------Records of mengmei_wechat_resource ----- -- 
INSERT INTO mengmei_wechat_resource ( `id`, `media_id`, `ctime`, `utime`, `stime`, `sourse_num`, `send_num`, `wechat_id`, `isdel` ) VALUES ('45','VlnuIP8JKdzFH8NZOGn_N2j73cDqZlZXCH7pQxgnU3Q','2018-06-04 14:07:46','2018-06-04 13:56:16','','1','0','1','0');
-- -------Records of mengmei_wechat_resource ----- -- 
INSERT INTO mengmei_wechat_resource ( `id`, `media_id`, `ctime`, `utime`, `stime`, `sourse_num`, `send_num`, `wechat_id`, `isdel` ) VALUES ('48','VlnuIP8JKdzFH8NZOGn_NyHGN5wVmuHmZJymSNliP-g','2018-06-04 14:12:14','2018-06-04 14:12:14','','1','0','1','0');
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
) ENGINE=MyISAM AUTO_INCREMENT=171 DEFAULT CHARSET=utf8 COMMENT='微信素材从表';
-- -------Records of mengmei_wechat_resource_list ----- -- 
INSERT INTO mengmei_wechat_resource_list ( `id`, `media_id`, `title`, `author`, `digest`, `content`, `content_source_url`, `thumb_media_id`, `show_cover_pic`, `url`, `thumb_url`, `local_image`, `need_open_comment`, `only_fans_can_comment`, `ctime`, `utime`, `up`, `source_id`, `isdel` ) VALUES ('154','VlnuIP8JKdzFH8NZOGn_N2j73cDqZlZXCH7pQxgnU3Q','测试1','我','测试1测试1测试1测试1','','','VlnuIP8JKdzFH8NZOGn_N8FslYR0nbveHMPRvGwnFlk','1','http://mp.weixin.qq.com/s?__biz=MzIwMzQ0MzA1Nw==&mid=100000034&idx=1&sn=e6c9fa75979b6abee8cef8aa143bbfdf&chksm=16ce1f3c21b9962ace6dcc7d6aeb06ef185df5964d0d209f61a9ee01e668d7ba37a8f2e064ec#rd','http://mmbiz.qpic.cn/mmbiz_jpg/nE2Uiamuqzs1BA0LHiaCRwpOjRCAfTyLgyAVj7FdJpzl26CJ1ic2upgwYiac6ONS9flZiaVUs5kg1q7ibgicJEGtvibfug/0?wx_fmt=jpeg','','1','0','2018-06-04 13:56:16','2018-06-04 13:56:16','1','39','0');
-- -------Records of mengmei_wechat_resource_list ----- -- 
INSERT INTO mengmei_wechat_resource_list ( `id`, `media_id`, `title`, `author`, `digest`, `content`, `content_source_url`, `thumb_media_id`, `show_cover_pic`, `url`, `thumb_url`, `local_image`, `need_open_comment`, `only_fans_can_comment`, `ctime`, `utime`, `up`, `source_id`, `isdel` ) VALUES ('155','VlnuIP8JKdzFH8NZOGn_Nwgf6okKYqq_FVpd6OWAtDM','最后一组测试——3','测试编辑1','这是测试的摘要1','<h1>这是一个测试文章1</h1><br  /><br  /><div>测试下图文素材的效果</div><br  /><div>测试下图文素材的效果</div>','http://www.地址','VlnuIP8JKdzFH8NZOGn_NzX_qam9kJblGVVRDEHyiHM','1','http://mp.weixin.qq.com/s?__biz=MzIwMzQ0MzA1Nw==&mid=100000016&idx=1&sn=58fcc28756a7602ec352b626995e5f24&chksm=16ce1f0e21b99618a1a213b735910e1f9e1b4515b09800494bd9806480cf390ae56fb6a15872#rd','http://mmbiz.qpic.cn/mmbiz_jpg/nE2Uiamuqzs1ebsgjppsZTV555S5944Nxiax4GEjeqeP8wpn6e37alnr6iaI1aPB2xyLQ7rJDdmKRw83Wx6uicoIew/0?wx_fmt=jpeg','','0','0','2018-05-31 13:59:56','2018-06-01 14:59:57','1','40','0');
-- -------Records of mengmei_wechat_resource_list ----- -- 
INSERT INTO mengmei_wechat_resource_list ( `id`, `media_id`, `title`, `author`, `digest`, `content`, `content_source_url`, `thumb_media_id`, `show_cover_pic`, `url`, `thumb_url`, `local_image`, `need_open_comment`, `only_fans_can_comment`, `ctime`, `utime`, `up`, `source_id`, `isdel` ) VALUES ('156','VlnuIP8JKdzFH8NZOGn_Nwgf6okKYqq_FVpd6OWAtDM','最后一组测试——4','测试编辑2','这是测试的摘要2','<h1>这是一个测试文章2</h1><br  /><br  /><div>测试下图文素材的效果</div><br  /><div>测试下图文素材的效果</div>','http://www.地址','VlnuIP8JKdzFH8NZOGn_NzX_qam9kJblGVVRDEHyiHM','1','http://mp.weixin.qq.com/s?__biz=MzIwMzQ0MzA1Nw==&mid=100000016&idx=2&sn=9857cb9791f0a4a9bfdeaa7696f504e5&chksm=16ce1f0e21b99618da67a7b8b06daafb2ec29faf1ed7581eec65c6dc73c955b149743f2233e5#rd','http://mmbiz.qpic.cn/mmbiz_jpg/nE2Uiamuqzs1ebsgjppsZTV555S5944Nxiax4GEjeqeP8wpn6e37alnr6iaI1aPB2xyLQ7rJDdmKRw83Wx6uicoIew/0?wx_fmt=jpeg','','0','0','2018-05-31 13:59:56','2018-06-01 14:59:57','1','40','0');
-- -------Records of mengmei_wechat_resource_list ----- -- 
INSERT INTO mengmei_wechat_resource_list ( `id`, `media_id`, `title`, `author`, `digest`, `content`, `content_source_url`, `thumb_media_id`, `show_cover_pic`, `url`, `thumb_url`, `local_image`, `need_open_comment`, `only_fans_can_comment`, `ctime`, `utime`, `up`, `source_id`, `isdel` ) VALUES ('157','VlnuIP8JKdzFH8NZOGn_NyH7m5wwQlOCuCf12B06UbA','最后一组测试——3','测试编辑1','这是测试的摘要1','<h1>这是一个测试文章1</h1><br  /><br  /><div>测试下图文素材的效果</div><br  /><div>测试下图文素材的效果</div>','http://www.地址','VlnuIP8JKdzFH8NZOGn_NzX_qam9kJblGVVRDEHyiHM','1','http://mp.weixin.qq.com/s?__biz=MzIwMzQ0MzA1Nw==&mid=100000015&idx=1&sn=a3bd540f6249c177d322bac40595e871&chksm=16ce1f1121b996079ba4c13bb743b73273920a047dc8800f7378d82b05ed925b159083f63c8d#rd','http://mmbiz.qpic.cn/mmbiz_jpg/nE2Uiamuqzs1ebsgjppsZTV555S5944Nxiax4GEjeqeP8wpn6e37alnr6iaI1aPB2xyLQ7rJDdmKRw83Wx6uicoIew/0?wx_fmt=jpeg','','0','0','2018-05-31 13:54:11','2018-05-31 13:54:11','1','41','0');
-- -------Records of mengmei_wechat_resource_list ----- -- 
INSERT INTO mengmei_wechat_resource_list ( `id`, `media_id`, `title`, `author`, `digest`, `content`, `content_source_url`, `thumb_media_id`, `show_cover_pic`, `url`, `thumb_url`, `local_image`, `need_open_comment`, `only_fans_can_comment`, `ctime`, `utime`, `up`, `source_id`, `isdel` ) VALUES ('158','VlnuIP8JKdzFH8NZOGn_NyH7m5wwQlOCuCf12B06UbA','最后一组测试——4','测试编辑2','这是测试的摘要2','<h1>这是一个测试文章2</h1><br  /><br  /><div>测试下图文素材的效果</div><br  /><div>测试下图文素材的效果</div>','http://www.地址','VlnuIP8JKdzFH8NZOGn_NzX_qam9kJblGVVRDEHyiHM','1','http://mp.weixin.qq.com/s?__biz=MzIwMzQ0MzA1Nw==&mid=100000015&idx=2&sn=39228ba3920c1c4ad9aca27c2e177b76&chksm=16ce1f1121b99607fa1fc2c9eb0c3472b6d42eea76ea6b28f45e344be5b5e72bb7569af5f66a#rd','http://mmbiz.qpic.cn/mmbiz_jpg/nE2Uiamuqzs1ebsgjppsZTV555S5944Nxiax4GEjeqeP8wpn6e37alnr6iaI1aPB2xyLQ7rJDdmKRw83Wx6uicoIew/0?wx_fmt=jpeg','','0','0','2018-05-31 13:54:11','2018-05-31 13:54:11','1','41','0');
-- -------Records of mengmei_wechat_resource_list ----- -- 
INSERT INTO mengmei_wechat_resource_list ( `id`, `media_id`, `title`, `author`, `digest`, `content`, `content_source_url`, `thumb_media_id`, `show_cover_pic`, `url`, `thumb_url`, `local_image`, `need_open_comment`, `only_fans_can_comment`, `ctime`, `utime`, `up`, `source_id`, `isdel` ) VALUES ('159','VlnuIP8JKdzFH8NZOGn_N2j73cDqZlZXCH7pQxgnU3Q','测试1','我','测试1测试1测试1测试1','','','VlnuIP8JKdzFH8NZOGn_N8FslYR0nbveHMPRvGwnFlk','1','http://mp.weixin.qq.com/s?__biz=MzIwMzQ0MzA1Nw==&mid=100000034&idx=1&sn=e6c9fa75979b6abee8cef8aa143bbfdf&chksm=16ce1f3c21b9962ace6dcc7d6aeb06ef185df5964d0d209f61a9ee01e668d7ba37a8f2e064ec#rd','http://mmbiz.qpic.cn/mmbiz_jpg/nE2Uiamuqzs1BA0LHiaCRwpOjRCAfTyLgyAVj7FdJpzl26CJ1ic2upgwYiac6ONS9flZiaVUs5kg1q7ibgicJEGtvibfug/0?wx_fmt=jpeg','','1','0','2018-06-04 13:56:16','2018-06-04 13:56:16','1','42','0');
-- -------Records of mengmei_wechat_resource_list ----- -- 
INSERT INTO mengmei_wechat_resource_list ( `id`, `media_id`, `title`, `author`, `digest`, `content`, `content_source_url`, `thumb_media_id`, `show_cover_pic`, `url`, `thumb_url`, `local_image`, `need_open_comment`, `only_fans_can_comment`, `ctime`, `utime`, `up`, `source_id`, `isdel` ) VALUES ('160','VlnuIP8JKdzFH8NZOGn_Nwgf6okKYqq_FVpd6OWAtDM','最后一组测试——3','测试编辑1','这是测试的摘要1','<h1>这是一个测试文章1</h1><br  /><br  /><div>测试下图文素材的效果</div><br  /><div>测试下图文素材的效果</div>','http://www.地址','VlnuIP8JKdzFH8NZOGn_NzX_qam9kJblGVVRDEHyiHM','1','http://mp.weixin.qq.com/s?__biz=MzIwMzQ0MzA1Nw==&mid=100000016&idx=1&sn=58fcc28756a7602ec352b626995e5f24&chksm=16ce1f0e21b99618a1a213b735910e1f9e1b4515b09800494bd9806480cf390ae56fb6a15872#rd','http://mmbiz.qpic.cn/mmbiz_jpg/nE2Uiamuqzs1ebsgjppsZTV555S5944Nxiax4GEjeqeP8wpn6e37alnr6iaI1aPB2xyLQ7rJDdmKRw83Wx6uicoIew/0?wx_fmt=jpeg','','0','0','2018-05-31 13:59:56','2018-06-01 14:59:57','1','43','0');
-- -------Records of mengmei_wechat_resource_list ----- -- 
INSERT INTO mengmei_wechat_resource_list ( `id`, `media_id`, `title`, `author`, `digest`, `content`, `content_source_url`, `thumb_media_id`, `show_cover_pic`, `url`, `thumb_url`, `local_image`, `need_open_comment`, `only_fans_can_comment`, `ctime`, `utime`, `up`, `source_id`, `isdel` ) VALUES ('161','VlnuIP8JKdzFH8NZOGn_Nwgf6okKYqq_FVpd6OWAtDM','最后一组测试——4','测试编辑2','这是测试的摘要2','<h1>这是一个测试文章2</h1><br  /><br  /><div>测试下图文素材的效果</div><br  /><div>测试下图文素材的效果</div>','http://www.地址','VlnuIP8JKdzFH8NZOGn_NzX_qam9kJblGVVRDEHyiHM','1','http://mp.weixin.qq.com/s?__biz=MzIwMzQ0MzA1Nw==&mid=100000016&idx=2&sn=9857cb9791f0a4a9bfdeaa7696f504e5&chksm=16ce1f0e21b99618da67a7b8b06daafb2ec29faf1ed7581eec65c6dc73c955b149743f2233e5#rd','http://mmbiz.qpic.cn/mmbiz_jpg/nE2Uiamuqzs1ebsgjppsZTV555S5944Nxiax4GEjeqeP8wpn6e37alnr6iaI1aPB2xyLQ7rJDdmKRw83Wx6uicoIew/0?wx_fmt=jpeg','','0','0','2018-05-31 13:59:56','2018-06-01 14:59:57','1','43','0');
-- -------Records of mengmei_wechat_resource_list ----- -- 
INSERT INTO mengmei_wechat_resource_list ( `id`, `media_id`, `title`, `author`, `digest`, `content`, `content_source_url`, `thumb_media_id`, `show_cover_pic`, `url`, `thumb_url`, `local_image`, `need_open_comment`, `only_fans_can_comment`, `ctime`, `utime`, `up`, `source_id`, `isdel` ) VALUES ('162','VlnuIP8JKdzFH8NZOGn_NyH7m5wwQlOCuCf12B06UbA','最后一组测试——3','测试编辑1','这是测试的摘要1','<h1>这是一个测试文章1</h1><br  /><br  /><div>测试下图文素材的效果</div><br  /><div>测试下图文素材的效果</div>','http://www.地址','VlnuIP8JKdzFH8NZOGn_NzX_qam9kJblGVVRDEHyiHM','1','http://mp.weixin.qq.com/s?__biz=MzIwMzQ0MzA1Nw==&mid=100000015&idx=1&sn=a3bd540f6249c177d322bac40595e871&chksm=16ce1f1121b996079ba4c13bb743b73273920a047dc8800f7378d82b05ed925b159083f63c8d#rd','http://mmbiz.qpic.cn/mmbiz_jpg/nE2Uiamuqzs1ebsgjppsZTV555S5944Nxiax4GEjeqeP8wpn6e37alnr6iaI1aPB2xyLQ7rJDdmKRw83Wx6uicoIew/0?wx_fmt=jpeg','','0','0','2018-05-31 13:54:11','2018-05-31 13:54:11','1','44','0');
-- -------Records of mengmei_wechat_resource_list ----- -- 
INSERT INTO mengmei_wechat_resource_list ( `id`, `media_id`, `title`, `author`, `digest`, `content`, `content_source_url`, `thumb_media_id`, `show_cover_pic`, `url`, `thumb_url`, `local_image`, `need_open_comment`, `only_fans_can_comment`, `ctime`, `utime`, `up`, `source_id`, `isdel` ) VALUES ('153','VlnuIP8JKdzFH8NZOGn_N2j73cDqZlZXCH7pQxgnU3Q','测试1','我','测试1测试1测试1测试1','<img src=\"/Public/kindupload/image/20180523/20180523162158_80447.png\" alt=\"\" />','','VlnuIP8JKdzFH8NZOGn_N8FslYR0nbveHMPRvGwnFlk','1','','http://mmbiz.qpic.cn/mmbiz_jpg/nE2Uiamuqzs1BA0LHiaCRwpOjRCAfTyLgyAVj7FdJpzl26CJ1ic2upgwYiac6ONS9flZiaVUs5kg1q7ibgicJEGtvibfug/0?wx_fmt=jpeg','upload/20180604/1528091632773.jpg','1','0','2018-06-04 13:54:18','2018-06-04 13:57:19','1','38','0');
-- -------Records of mengmei_wechat_resource_list ----- -- 
INSERT INTO mengmei_wechat_resource_list ( `id`, `media_id`, `title`, `author`, `digest`, `content`, `content_source_url`, `thumb_media_id`, `show_cover_pic`, `url`, `thumb_url`, `local_image`, `need_open_comment`, `only_fans_can_comment`, `ctime`, `utime`, `up`, `source_id`, `isdel` ) VALUES ('163','VlnuIP8JKdzFH8NZOGn_NyH7m5wwQlOCuCf12B06UbA','最后一组测试——4','测试编辑2','这是测试的摘要2','<h1>这是一个测试文章2</h1><br  /><br  /><div>测试下图文素材的效果</div><br  /><div>测试下图文素材的效果</div>','http://www.地址','VlnuIP8JKdzFH8NZOGn_NzX_qam9kJblGVVRDEHyiHM','1','http://mp.weixin.qq.com/s?__biz=MzIwMzQ0MzA1Nw==&mid=100000015&idx=2&sn=39228ba3920c1c4ad9aca27c2e177b76&chksm=16ce1f1121b99607fa1fc2c9eb0c3472b6d42eea76ea6b28f45e344be5b5e72bb7569af5f66a#rd','http://mmbiz.qpic.cn/mmbiz_jpg/nE2Uiamuqzs1ebsgjppsZTV555S5944Nxiax4GEjeqeP8wpn6e37alnr6iaI1aPB2xyLQ7rJDdmKRw83Wx6uicoIew/0?wx_fmt=jpeg','','0','0','2018-05-31 13:54:11','2018-05-31 13:54:11','1','44','0');
-- -------Records of mengmei_wechat_resource_list ----- -- 
INSERT INTO mengmei_wechat_resource_list ( `id`, `media_id`, `title`, `author`, `digest`, `content`, `content_source_url`, `thumb_media_id`, `show_cover_pic`, `url`, `thumb_url`, `local_image`, `need_open_comment`, `only_fans_can_comment`, `ctime`, `utime`, `up`, `source_id`, `isdel` ) VALUES ('164','VlnuIP8JKdzFH8NZOGn_N2j73cDqZlZXCH7pQxgnU3Q','测试1','我','测试1测试1测试1测试1','','','VlnuIP8JKdzFH8NZOGn_N8FslYR0nbveHMPRvGwnFlk','1','http://mp.weixin.qq.com/s?__biz=MzIwMzQ0MzA1Nw==&mid=100000034&idx=1&sn=e6c9fa75979b6abee8cef8aa143bbfdf&chksm=16ce1f3c21b9962ace6dcc7d6aeb06ef185df5964d0d209f61a9ee01e668d7ba37a8f2e064ec#rd','http://mmbiz.qpic.cn/mmbiz_jpg/nE2Uiamuqzs1BA0LHiaCRwpOjRCAfTyLgyAVj7FdJpzl26CJ1ic2upgwYiac6ONS9flZiaVUs5kg1q7ibgicJEGtvibfug/0?wx_fmt=jpeg','','1','0','2018-06-04 13:56:16','2018-06-04 13:56:16','1','45','0');
-- -------Records of mengmei_wechat_resource_list ----- -- 
INSERT INTO mengmei_wechat_resource_list ( `id`, `media_id`, `title`, `author`, `digest`, `content`, `content_source_url`, `thumb_media_id`, `show_cover_pic`, `url`, `thumb_url`, `local_image`, `need_open_comment`, `only_fans_can_comment`, `ctime`, `utime`, `up`, `source_id`, `isdel` ) VALUES ('165','VlnuIP8JKdzFH8NZOGn_Nwgf6okKYqq_FVpd6OWAtDM','最后一组测试——3','测试编辑1','这是测试的摘要1','<h1>这是一个测试文章1</h1><br  /><br  /><div>测试下图文素材的效果</div><br  /><div>测试下图文素材的效果</div>','http://www.地址','VlnuIP8JKdzFH8NZOGn_NzX_qam9kJblGVVRDEHyiHM','1','http://mp.weixin.qq.com/s?__biz=MzIwMzQ0MzA1Nw==&mid=100000016&idx=1&sn=58fcc28756a7602ec352b626995e5f24&chksm=16ce1f0e21b99618a1a213b735910e1f9e1b4515b09800494bd9806480cf390ae56fb6a15872#rd','http://mmbiz.qpic.cn/mmbiz_jpg/nE2Uiamuqzs1ebsgjppsZTV555S5944Nxiax4GEjeqeP8wpn6e37alnr6iaI1aPB2xyLQ7rJDdmKRw83Wx6uicoIew/0?wx_fmt=jpeg','','0','0','2018-05-31 13:59:56','2018-06-01 14:59:57','1','46','0');
-- -------Records of mengmei_wechat_resource_list ----- -- 
INSERT INTO mengmei_wechat_resource_list ( `id`, `media_id`, `title`, `author`, `digest`, `content`, `content_source_url`, `thumb_media_id`, `show_cover_pic`, `url`, `thumb_url`, `local_image`, `need_open_comment`, `only_fans_can_comment`, `ctime`, `utime`, `up`, `source_id`, `isdel` ) VALUES ('166','VlnuIP8JKdzFH8NZOGn_Nwgf6okKYqq_FVpd6OWAtDM','最后一组测试——4','测试编辑2','这是测试的摘要2','<h1>这是一个测试文章2</h1><br  /><br  /><div>测试下图文素材的效果</div><br  /><div>测试下图文素材的效果</div>','http://www.地址','VlnuIP8JKdzFH8NZOGn_NzX_qam9kJblGVVRDEHyiHM','1','http://mp.weixin.qq.com/s?__biz=MzIwMzQ0MzA1Nw==&mid=100000016&idx=2&sn=9857cb9791f0a4a9bfdeaa7696f504e5&chksm=16ce1f0e21b99618da67a7b8b06daafb2ec29faf1ed7581eec65c6dc73c955b149743f2233e5#rd','http://mmbiz.qpic.cn/mmbiz_jpg/nE2Uiamuqzs1ebsgjppsZTV555S5944Nxiax4GEjeqeP8wpn6e37alnr6iaI1aPB2xyLQ7rJDdmKRw83Wx6uicoIew/0?wx_fmt=jpeg','','0','0','2018-05-31 13:59:56','2018-06-01 14:59:57','1','46','0');
-- -------Records of mengmei_wechat_resource_list ----- -- 
INSERT INTO mengmei_wechat_resource_list ( `id`, `media_id`, `title`, `author`, `digest`, `content`, `content_source_url`, `thumb_media_id`, `show_cover_pic`, `url`, `thumb_url`, `local_image`, `need_open_comment`, `only_fans_can_comment`, `ctime`, `utime`, `up`, `source_id`, `isdel` ) VALUES ('167','VlnuIP8JKdzFH8NZOGn_NyH7m5wwQlOCuCf12B06UbA','最后一组测试——3','测试编辑1','这是测试的摘要1','<h1>这是一个测试文章1</h1><br  /><br  /><div>测试下图文素材的效果</div><br  /><div>测试下图文素材的效果</div>','http://www.地址','VlnuIP8JKdzFH8NZOGn_NzX_qam9kJblGVVRDEHyiHM','1','http://mp.weixin.qq.com/s?__biz=MzIwMzQ0MzA1Nw==&mid=100000015&idx=1&sn=a3bd540f6249c177d322bac40595e871&chksm=16ce1f1121b996079ba4c13bb743b73273920a047dc8800f7378d82b05ed925b159083f63c8d#rd','http://mmbiz.qpic.cn/mmbiz_jpg/nE2Uiamuqzs1ebsgjppsZTV555S5944Nxiax4GEjeqeP8wpn6e37alnr6iaI1aPB2xyLQ7rJDdmKRw83Wx6uicoIew/0?wx_fmt=jpeg','','0','0','2018-05-31 13:54:11','2018-05-31 13:54:11','1','47','0');
-- -------Records of mengmei_wechat_resource_list ----- -- 
INSERT INTO mengmei_wechat_resource_list ( `id`, `media_id`, `title`, `author`, `digest`, `content`, `content_source_url`, `thumb_media_id`, `show_cover_pic`, `url`, `thumb_url`, `local_image`, `need_open_comment`, `only_fans_can_comment`, `ctime`, `utime`, `up`, `source_id`, `isdel` ) VALUES ('168','VlnuIP8JKdzFH8NZOGn_NyH7m5wwQlOCuCf12B06UbA','最后一组测试——4','测试编辑2','这是测试的摘要2','<h1>这是一个测试文章2</h1><br  /><br  /><div>测试下图文素材的效果</div><br  /><div>测试下图文素材的效果</div>','http://www.地址','VlnuIP8JKdzFH8NZOGn_NzX_qam9kJblGVVRDEHyiHM','1','http://mp.weixin.qq.com/s?__biz=MzIwMzQ0MzA1Nw==&mid=100000015&idx=2&sn=39228ba3920c1c4ad9aca27c2e177b76&chksm=16ce1f1121b99607fa1fc2c9eb0c3472b6d42eea76ea6b28f45e344be5b5e72bb7569af5f66a#rd','http://mmbiz.qpic.cn/mmbiz_jpg/nE2Uiamuqzs1ebsgjppsZTV555S5944Nxiax4GEjeqeP8wpn6e37alnr6iaI1aPB2xyLQ7rJDdmKRw83Wx6uicoIew/0?wx_fmt=jpeg','','0','0','2018-05-31 13:54:11','2018-05-31 13:54:11','1','47','0');
-- -------Records of mengmei_wechat_resource_list ----- -- 
INSERT INTO mengmei_wechat_resource_list ( `id`, `media_id`, `title`, `author`, `digest`, `content`, `content_source_url`, `thumb_media_id`, `show_cover_pic`, `url`, `thumb_url`, `local_image`, `need_open_comment`, `only_fans_can_comment`, `ctime`, `utime`, `up`, `source_id`, `isdel` ) VALUES ('169','VlnuIP8JKdzFH8NZOGn_NyHGN5wVmuHmZJymSNliP-g','素材添加','sfsf','士大夫士大夫','水电费十分的舒服的事','','VlnuIP8JKdzFH8NZOGn_N0R01NfpKu5QmGdp-VKM1hI','1','','http://mmbiz.qpic.cn/mmbiz_jpg/nE2Uiamuqzs1BA0LHiaCRwpOjRCAfTyLgyT0Gwt3VOrVYzCmP9ibZuNN26Licg7lXsfgiaMavCGlmC8TjIrGD0uWyRQ/0?wx_fmt=jpeg','upload/20180604/1528092688182.jpg','1','0','2018-06-04 14:11:42','2018-06-04 14:12:14','1','48','0');
-- -------Records of mengmei_wechat_resource_list ----- -- 
INSERT INTO mengmei_wechat_resource_list ( `id`, `media_id`, `title`, `author`, `digest`, `content`, `content_source_url`, `thumb_media_id`, `show_cover_pic`, `url`, `thumb_url`, `local_image`, `need_open_comment`, `only_fans_can_comment`, `ctime`, `utime`, `up`, `source_id`, `isdel` ) VALUES ('170','','素材删除','ssfd','fdsfdsf','sdfsdfdsfds','','','1','','','upload/20180604/1528092952546.jpg','1','0','2018-06-04 14:15:56','','0','0','0');
