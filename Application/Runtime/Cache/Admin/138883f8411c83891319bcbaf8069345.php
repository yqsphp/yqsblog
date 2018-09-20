<?php if (!defined('THINK_PATH')) exit();?>﻿<!DOCTYPE html>
<html lang="en">
<head>
<meta charset="utf-8">
<meta http-equiv="X-UA-Compatible" content="IE=edge">
<link rel="stylesheet" href="/Public/admin/css/sweetalert.css">
<!--alert弹窗主题-->
<!--<link rel="stylesheet" href="/Public/admin/css/themes/twitter/twitter.css">-->
<!--<link href="/Public/admin/css/themes/google/google.css" rel="stylesheet"/>-->
<!--<link href="/Public/admin/css/themes/facebook/facebook.css" rel="stylesheet"/>-->
<script src="/Public/admin/js/sweetalert.min.js"></script> 
<script>
function success(title){
	swal({
		title:title,	//标题
		type:'success', 
		timer:2000,
	});
}
function errors(title){
	swal({
		title:title,	//标题
		type:'error', 
		timer:2000,
	});
}
//fun : 函数
function warning(fun,title){
	if(!title) title='确定删除吗?';
	swal({
	  title: title,
	  type: "warning",
	  showCancelButton: true,
	  cancelButtonText:'取消',
	  confirmButtonText: "确定",
	  //closeOnConfirm: true
	},function(isconfirm){
		if(isconfirm){
			fun();
		}
	})
}
//加载弹窗
function loading(){
	swal({
		title: "请稍后...",
		type: "",
		imageUrl:"/Public/admin/images/ajaxload.gif",
		showConfirmButton:false
	})
}
</script>

<meta name="viewport" content="width=device-width, initial-scale=1">
<link rel="stylesheet" href="/Public/css/bootstrap.min.css">
<link rel="stylesheet" href="/Public/zTreeStyle/zTreeStyle.css">
<!-- 自定义样式 -->
<link rel="stylesheet" href="/Public/admin/css/wx-custom.css">
</head>
<div class="panel admin-panel">
	<div class="panel-head">
		<strong class="glyphicon glyphicon-align-justify"> 自定义菜单</strong>
	</div>
	<div class="custom-menu-edit-con">
		<div class="hbox">
			<div class="inner-left">
				<div class="custom-menu-view-con">
					<div class="custom-menu-view">
						<div class="custom-menu-view__title"><?php echo ($get["title"]); ?></div>
						<div class="custom-menu-view__body">
							<div class="weixin-msg-list">
								<ul class="msg-con">
								</ul>
							</div>
						</div>
						<div id="menuMain" class="custom-menu-view__footer">
							<div class="custom-menu-view__footer__left">
							</div>
							<div class="custom-menu-view__footer__right">
								<!--<div class="custom-menu-view__menu f_1" fid="f_1" x="1" y="0">
									<div class="text-ellipsis custom-menu-view_first">
										<i type="1" class="custom-menu-close glyphicon glyphicon-remove" style="display: none;"></i>
										<i class='glyphicon glyphicon-plus text-info iBtn'></i>
										<span id="f_1"></span>
									</div>
									<ul class="custom-menu-view__menu__sub">
										<li class="custom-menu-view__menu__sub__add custom-menu-view_second">
											<div class="text-ellipsis">
												<i class="glyphicon glyphicon-plus text-info"></i>
											</div>
										</li>
									</ul>
								</div>
								<div class="custom-menu-view__menu f_2" fid="f_2" x="2" y="0">
									<div class="text-ellipsis custom-menu-view_first">
										<i type="1" class="custom-menu-close glyphicon glyphicon-remove" style="display: none;"></i>
										<i class="glyphicon glyphicon-plus text-info iBtn"></i>
										<span id="f_2"></span>
									</div>
									<ul class="custom-menu-view__menu__sub">
										<li class="custom-menu-view__menu__sub__add custom-menu-view_second">
											<div class="text-ellipsis">
												<i class="glyphicon glyphicon-plus text-info"></i>
											</div>
										</li>
									</ul>
								</div>
								<div class="custom-menu-view__menu f_3" fid="f_3" x="3" y="0">
									<div class="text-ellipsis custom-menu-view_first">
										<i type="1" class="custom-menu-close glyphicon glyphicon-remove" style="display: none;"></i>
										<i class="glyphicon glyphicon-plus text-info iBtn"></i>
										<span id="f_3"></span>
									</div>
									<ul class="custom-menu-view__menu__sub">
										<li class="custom-menu-view__menu__sub__add custom-menu-view_second">
											<div class="text-ellipsis">
												<i class="glyphicon glyphicon-plus text-info"></i>
											</div>
										</li>
									</ul>
								</div>-->
								<?php if(is_array($pinfo)): $k = 0; $__LIST__ = $pinfo;if( count($__LIST__)==0 ) : echo "" ;else: foreach($__LIST__ as $key=>$v): $mod = ($k % 2 );++$k;?><div class="custom-menu-view__menu f_<?php echo ($k); ?>" fid="f_<?php echo ($k); ?>" x="<?php echo ($k); ?>" y="0">
									<div class="text-ellipsis custom-menu-view_first" id="<?php echo ($v["id"]); ?>">
										<i type="1" class="custom-menu-close glyphicon glyphicon-remove"></i>
										<i class='glyphicon glyphicon-plus text-info iBtn' style="display: none;"></i>
										<span id="f_<?php echo ($k); ?>"><?php echo ($v["name"]); ?></span>
									</div>
									<ul class="custom-menu-view__menu__sub">
										<?php if(is_array($cinfo)): $ko = 0; $__LIST__ = $cinfo;if( count($__LIST__)==0 ) : echo "" ;else: foreach($__LIST__ as $key=>$vo): $mod = ($ko % 2 );++$ko; if($vo['pid'] == $v['id']): ?><li class="custom-menu-view__menu__sub__add custom-second" id="<?php echo ($vo["id"]); ?>" x="<?php echo ($vo["x"]); ?>" y="<?php echo ($vo["y"]); ?>" fid="sub_f_<?php echo ($k); ?>_<?php echo ($vo["y"]); ?>">
												<div id="sub_f_<?php echo ($k); ?>_<?php echo ($vo["y"]); ?>" class="text-ellipsis"><?php echo ($vo["name"]); ?></div>
												<i class="custom-menu-close glyphicon glyphicon-remove"></i>
											</li><?php endif; endforeach; endif; else: echo "" ;endif; ?>
										<li class="custom-menu-view__menu__sub__add custom-menu-view_second">
											<div class="text-ellipsis">
												<i class="glyphicon glyphicon-plus text-info"></i>
											</div>
										</li>
									</ul>
								</div><?php endforeach; endif; else: echo "" ;endif; ?>
								<?php $__FOR_START_30360__=$plength+1;$__FOR_END_30360__=4;for($i=$__FOR_START_30360__;$i < $__FOR_END_30360__;$i+=1){ ?><div class="custom-menu-view__menu f_<?php echo ($i); ?>" fid="f_<?php echo ($i); ?>" x="<?php echo ($i); ?>" y="0">
									<div class="text-ellipsis custom-menu-view_first" id="">
										<i type="1" class="custom-menu-close glyphicon glyphicon-remove" style="display: none;"></i>
										<i class="glyphicon glyphicon-plus text-info iBtn"></i>
										<span id="f_<?php echo ($i); ?>"></span>
									</div>
									<ul class="custom-menu-view__menu__sub">
										<li class="custom-menu-view__menu__sub__add custom-menu-view_second">
											<div class="text-ellipsis">
												<i class="glyphicon glyphicon-plus text-info"></i>
											</div>
										</li>
									</ul>
								</div><?php } ?>
							</div>
						</div>
					</div>
				</div>
			</div>
			<div class="inner-right">
				<div class="cm-edit-before"><h5>点击左侧菜单进行操作</h5></div>
				<div class="cm-edit-after" style="display: none;">
					<form id="custom-submit" class="form-horizontal wrapper-md" name="custom_form">
						<input type="hidden" name="token" id="" value="<?php echo ($get["token"]); ?>" />
						<input type="hidden" name="id" id="id" value="" />
						<input type="hidden" name="pid" id="pid" value="" />
						<input type="hidden" name="x" id="x" value="0" />
						<input type="hidden" name="y" id="y" value="0" />
						<input type="hidden" name="replytype" id="replytype" value="1" />
						<div class="form-group">
							<label class="col-sm-2 control-label">菜单名称:</label>
							<div class="col-sm-5">
								<input name="name" fid="" type="text" class="form-control custom_input_title" value="" placeholder="请输入标题">
							</div>
							<div class="col-sm-5 help-block">
								<div>
									一级菜单字数不超过5个汉字<br />
									二级菜单字数不超过8个汉字
								</div>
							</div>
						</div>
						<div class="form-group" id="radioGroup">
							<label class="col-sm-2 control-label">菜单内容:</label>
							<div class="col-sm-10 LebelRadio">
								<label class="checkbox-inline"><input type="radio" name="sendtype" value="1" checked> 发送消息</label>
								<label class="checkbox-inline"><input type="radio" name="sendtype" value="2"> 跳转网页</label>
							</div>
						</div>
						<div id="editContent">
							<div class="cm-edit-content-con" id="editMsg">
								<div class="editTab">
									<div class="editTab-heading">
										<ul class="msg-panel__tab">
											<li class="msg-tab_item active">
												<span class="glyphicon glyphicon-list-alt" type="1"></span> 图文
											</li>
											<li class="msg-tab_item on">
												<span class="glyphicon glyphicon-edit" type="1"></span> 文本
											</li>
											<!--<li class="msg-tab_item on">
												<span class="glyphicon glyphicon-picture" type="1"></span> 图片
											</li>-->
										</ul>
									</div>
									<input type="hidden" name="type" id="custom-type" value="1"/>
									<input type="hidden" name="aid" id="aid" value=""/>
									<input type="hidden" name="tablename" id="tablename" value=""/>
									<div class="editTab-body">
										<div style="display: block;">
											<ul id="treeDemo" class="ztree select"></ul>
										</div>
										<div>
											<textarea class="textcon" id="conts" name="text" placeholder="请输入文本内容"></textarea>
											<div id="emotion"></div>
										</div>
										<!--<div>这里是图片区</div>-->
									</div>
								</div>
							</div>
							<div class="cm-edit-content-con" id="editPage" style="display: none;">
								<div class="cm-edit-page">
									<div class="row">
										<label class="col-sm-6 control-label">点击该菜单会跳转到以下链接:
										</label>
									</div>
									<div class="row">
										<label class="col-sm-2 control-label">页面地址:
										</label>
										<div class="col-sm-8">
											<input type="text" name="links" class="form-control links" placeholder="输入地址">
											<span class="help-block">如：http://www.xxx.com</span>
										</div>
									</div>
								</div>
							</div>
						</div>
						<div class="cm-edit-footer">
							<button id="saveBtns" type="button" class="btn btn-info"><i class="glyphicon glyphicon-check"></i> 保存</button>
						</div>
					</form>
				</div>
			</div>
		</div>
	</div>
	<div class="custom-publish">
		<button class="btn btn-success" id="publish"><i class="glyphicon glyphicon-send"></i> 发布</button>
		编辑完成后请点击发布按钮
	</div>
</div>
</body>
<script src="/Public/js/jquery-1.10.2.min.js"></script>
<script src="/Public/js/bootstrap.min.js"></script>

<!--树形-->
<script src="/Public/zTreeStyle/jquery.ztree.core.js"></script>
<script src="/Public/zTreeStyle/jquery.ztree.excheck.js"></script>

<script src="/Public/admin/js/wechatmenu.min.js"></script>
<!--表情-->
<link rel="stylesheet" type="text/css" href="/Public/emoji/css/jquery.mCustomScrollbar.min.css"/>
<link rel="stylesheet" type="text/css" href="/Public/emoji/css/jquery.emoji.min.css"/>
<script src="/Public/emoji/js/jquery.mousewheel-3.0.6.min.js"></script>
<script src="/Public/emoji/js/jquery.mCustomScrollbar.min.js"></script>
<script src="/Public/emoji/js/jquery.emoji.min.js"></script>
<script type="text/javascript">
$(function(){
	//表情
	$("#conts").emoji({
		button: "#emotion",
		showTab:false,
		icons:[{
			name:"qq表情",
			path:"/Public/emoji/img/qq/",
			maxNum:91,
			file:".gif",
			placeholder:"/{alias}",
			alias:{
				1: "微笑",2: "撇嘴",3: "色",4: "发呆",5: "得意",6: "流泪",7: "害羞",8: "闭嘴",
				9: "睡",10: "大哭",11: "尴尬",12: "发怒",13: "调皮",14: "呲牙",15: "惊讶",
				16: "难过",17: "酷",18: "冷汗",19: "抓狂",20: "吐",21: "偷笑",22: "愉快",
				23: "白眼",24: "傲慢",25: "饥饿",26: "困",27: "惊恐",28: "流汗",29: "憨笑",
				30: "悠闲",31: "奋斗",32: "咒骂",33: "疑问",34: "嘘",35: "晕",36: "疯了",
				37: "衰",38: "骷髅",39: "敲打",40: "再见",41: "擦汗",42: "抠鼻",43: "鼓掌",44: "糗大了",
				45: "坏笑",46: "左哼哼",47: "右哼哼",48: "哈欠",49: "鄙视",50: "委屈",51: "快哭了",52: "阴险",
				53:"亲亲",54:"吓",55:"可怜",56:"菜刀",57:"啤酒",58:"咖啡",59:"饭",60:"猪头",61:"玫瑰",
				62:"凋谢",63:"嘴唇",64:"爱心",65:"心碎",66:"蛋糕",67:"闪电",68:"炸弹",69:"刀",
				70:"足球",71:"瓢虫",72:"便便",73:"拥抱",74:"强",75:"弱",76:"握手",77:"胜利",
				78:"抱拳",79:"勾引",80:"拳头",81:"差劲",82:"爱你",83:"NO",84:"OK",85:"跳跳",
				86:"发抖",87:"怄火",88:"磕头",89:"回头",90:"激动",91:"乱舞"
			},
			title:{
				1: "微笑",2: "撇嘴",3: "色",4: "发呆",5: "得意",6: "流泪",7: "害羞",8: "闭嘴",
				9: "睡",10: "大哭",11: "尴尬",12: "发怒",13: "调皮",14: "呲牙",15: "惊讶",
				16: "难过",17: "酷",18: "冷汗",19: "抓狂",20: "吐",21: "偷笑",22: "愉快",
				23: "白眼",24: "傲慢",25: "饥饿",26: "困",27: "惊恐",28: "流汗",29: "憨笑",
				30: "悠闲",31: "奋斗",32: "咒骂",33: "疑问",34: "嘘",35: "晕",36: "疯了",
				37: "衰",38: "骷髅",39: "敲打",40: "再见",41: "擦汗",42: "抠鼻",43: "鼓掌",44: "糗大了",
				45: "坏笑",46: "左哼哼",47: "右哼哼",48: "哈欠",49: "鄙视",50: "委屈",51: "快哭了",52: "阴险",
				53:"亲亲",54:"吓",55:"可怜",56:"菜刀",57:"啤酒",58:"咖啡",59:"饭",60:"猪头",61:"玫瑰",
				62:"凋谢",63:"嘴唇",64:"爱心",65:"心碎",66:"蛋糕",67:"闪电",68:"炸弹",69:"刀",
				70:"足球",71:"瓢虫",72:"便便",73:"拥抱",74:"强",75:"弱",76:"握手",77:"胜利",
				78:"抱拳",79:"勾引",80:"拳头",81:"差劲",82:"爱你",83:"NO",84:"OK",85:"跳跳",
				86:"发抖",87:"怄火",88:"磕头",89:"回头",90:"激动",91:"乱舞"
			}
		}]
	});
});
</script>
<script type="text/javascript">
$(function(){
	$("#publish").click(function(){
		$.ajax({
			type:"post",
			url:"<?php echo U('wechatApp/publish');?>",
			data:{"token":"<?php echo ($get["token"]); ?>","id":<?php echo ($get["id"]); ?>},
			beforeSend:loading(),
			success:function(data){
				console.log(data);
				if(data.code == 200){
					success(data.message);
				}else{
					errors(data.code+'<br>'+data.message);
				}
				console.log(data);
			}
		});
	});
});
</script>
</html>