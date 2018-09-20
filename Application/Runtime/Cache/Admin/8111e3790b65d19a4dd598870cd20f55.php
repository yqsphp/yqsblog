<?php if (!defined('THINK_PATH')) exit();?><!DOCTYPE html>
<html lang="zh-cn">
<head>
    <meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="viewport" content="width=device-width, initial-scale=1.0, maximum-scale=1.0, user-scalable=no" />
    <meta name="renderer" content="webkit">
    <title>后台管理中心</title>  
    <link rel="stylesheet" href="/Public/css/bootstrap.min.css" />
    <link rel="stylesheet" href="/Public/css/bootstrap-switch.css">
    <link rel="stylesheet" href="/Public/admin/css/pintuer.css">
    <link rel="stylesheet" href="/Public/css/page.css">
    <link rel="stylesheet" href="/Public/admin/css/admin.css">
    <!--<script src="/Public/js/jquery-1.8.3.min.js"></script> -->
    <script src="/Public/js/jquery-1.10.2.min.js"></script> 
	<script src="/Public/js/bootstrap.min.js"></script>
	<script src="/Public/js/bootstrap-switch.js"></script>
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

</head>
<!--<link rel="stylesheet" type="text/css" href="/Public/webuploader/webuploader.min.css"/>
<script src="/Public/webuploader/webuploader.js"></script>
<script src="/Public/webuploader/uploadImgPreview.min.js"></script>-->
<link rel="stylesheet" href="/Public/zTreeStyle/zTreeStyle.css">
<style type="text/css">
	.logo-icon {
		float: left;
		width: 60px;
		height: 50px;
		border: 1px solid #ccc;
	}
	
	._filelist li,
	.attachlist li {
		/*这个选择器一定要有宽高，否则图片显示不出来，因为它里面的内容是绝对定位的*/
		width: 180px;
		height: 160px;
	}
	
	#select_attach {
		width: 100px;
		display: block;
		height: 41.5px;
		line-height: 41.5px;
		border-radius: 7px;
	}
	
	.button-uploas>div {
		float: left;
	}
	
	.attach-img {
		position: absolute;
		top: 50%;
		left: 50%;
		margin-top: -50px;
		margin-left: -50px;
	}
	
	.attach-txt {
		width: 100%;
		position: absolute;
		top: 50%;
		left: 0px;
		cursor: default;
		margin-top: -24px;
	}
</style>

<body>
	<div class="panel admin-panel">
		<div class="panel-head" id="add"><strong><span class="icon-pencil-square-o"></span>
  	<?php if($status == 1): ?>增加<?php else: ?>修改<?php endif; ?>内容</strong></div>
		<div class="body-content">
			<form method="post" id="myform" class="form-x" action="<?php echo U('wechatReply/keyedit',['status'=>$status,'id'=>$id]);?>" enctype="multipart/form-data">
				<div class="form-group">
					<div class="label">
						<label>公众号：</label>
					</div>
					<div class="field">
						<select name="token" class="input w50">
							<option value="">请选择公众号</option>
							<?php if(is_array($list)): $i = 0; $__LIST__ = $list;if( count($__LIST__)==0 ) : echo "" ;else: foreach($__LIST__ as $key=>$v): $mod = ($i % 2 );++$i;?><option value="<?php echo ($v["token"]); ?>" <?php if($info['token'] == $v['token']): ?>selected<?php endif; ?>>
									<?php echo ($v["name"]); ?>
								</option><?php endforeach; endif; else: echo "" ;endif; ?>
						</select>
						<div class="tips-thishi">*</div>
					</div>
				</div>
				<div class="form-group">
					<div class="label">
						<label>回复类型：</label>
					</div>
					<div class="field">
						<select name="replytype" class="input w50" id="catse">
							<option value="">请选择分类</option>
							<option value="1" <?php if($info['replytype'] == 1): ?>selected<?php endif; ?>>图文</option>
							<option value="2" <?php if($info['replytype'] == 2): ?>selected<?php endif; ?>>文本</option>
							<!--<option value="3" <?php if($info['catid'] == $vo['id']): ?>selected<?php endif; ?>>图片</option>
	      		<option value="4" <?php if($info['catid'] == $vo['id']): ?>selected<?php endif; ?>>音频</option>
	      		<option value="5" <?php if($info['catid'] == $vo['id']): ?>selected<?php endif; ?>>视频</option>-->
						</select>
						<div class="tips-thishi">*</div>
					</div>
				</div>
				<div class="form-group">
					<div class="label">
						<label>关键字：</label>
					</div>
					<div class="field">
						<input type="text" class="input w50" id="titles" value="<?php echo ($info["keyword"]); ?>" name="keyword" placeholder="请输入关键字" data-validate="required:请输入关键字" />
						<div class="tips"></div>
					</div>
				</div>
				<div class="select-info">
					<div class="form-group" style="display: <?php if( $info[ 'replytype'] == 1 ): ?>block;<?php else: ?>none;<?php endif; ?>">
						<div class="label">
							<label>图文：</label>
						</div>
						<div class="field">
							<ul id="treeDemo" class="ztree select"></ul>
							<div class="tips"></div>
						</div>
					</div>
					<div class="form-group" style="display: <?php if( $info[ 'replytype'] == 2 ): ?>block;<?php else: ?>none;<?php endif; ?>">
						<div class="label">
							<label>文本：</label>
						</div>
						<div class="field padding-large-bottom">
							<textarea class="input w50" id="conts" name="text" style="height:90px;"><?php echo ($info["text"]); ?></textarea>
							<div id="emotion"></div>
							<div class="tips"></div>
						</div>
					</div>
				</div>
				<div class="form-group">
					<div class="label">
						<label>启用：</label>
					</div>
					<div class="field">
						<div class="bootstrap-switch bootstrap-switch-large">
							<?php if($status == 1): ?><input type="checkbox" name="isenable" value="1" checked/>
								<?php else: ?>
								<input type="checkbox" name="isenable" value="<?php echo ($info["isenable"]); ?>" <?php if($info['isenable'] == 1): ?>checked<?php endif; ?>/><?php endif; ?>
						</div>
					</div>
				</div>
				<div class="form-group">
					<div class="label">
						<label></label>
					</div>
					<div class="field">
						<button class="button bg-main icon-check-square-o" type="button" id="btn"> 提交</button>
						<button class="button bg-red icon-mail-reply" type="button" onclick="history.back()"> 撤销</button>
					</div>
				</div>
				<input type="hidden" name="id" value="<?php echo ($info["id"]); ?>" />
				<input type="hidden" name="aid" id="aid" value="<?php echo ($info["aid"]); ?>" />
				<input type="hidden" name="tablename" id="tablename" value="<?php echo ($info["tablename"]); ?>" />
				<input type="hidden" name="type" value="2" />
			</form>
		</div>
	</div>
	<script src="/Public/zTreeStyle/jquery.ztree.core.js"></script>
	<script src="/Public/zTreeStyle/jquery.ztree.excheck.js"></script>
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
	<script>
		$(function() {
			var data = '<?php if(!empty($info)): echo (json_encode($info)); endif; ?>';
			if(data) {
				data = eval("(" + data + ")");
			}
			trees(data);
			$('.radio label').each(function() {
				var e = $(this);
				e.click(function() {
					e.closest('.radio').find("label").removeClass("active");
					e.addClass("active");
				});
			});
			//选择发送类型
			$("#catse").change(function() {
				$(".select-info > div").hide();
				if($(this).val() == 1) {
					$(".select-info > div").eq(0).show();
				} else if($(this).val() == 2) {
					$(".select-info > div").eq(1).show();
				} else {
					$(".select-info > div").hide();
				}
			});
			//checkbox选择状态
			//$("input[type='checkbox']").bootstrapSwitch('toggleState',true)
			$("input[type='checkbox']").bootstrapSwitch({
				onSwitchChange: function(e, state) {
					console.log(this)
					console.log(state);
					state == true ? $(this).val(1) : $(this).val(0);
				}
			});

			$("#btn").click(function() {
				//判断是否是选择了图文
				if($(".select-info>div:first-child").css("display") == "block" && $("#catse").val() == 1) {
					//获取选中的值
					var tree = $.fn.zTree.getZTreeObj("treeDemo");
					var nodes = tree.getCheckedNodes(true);
					var nleng = nodes.length;
					//默认情况是获取第一个节点的id
					var catid = nodes[0].id;
					var table = nodes[0].table;
					if(nodes == 0) {
						errors("至少选择一项");
						return;
					}
					//节点长度大于等于2时，获取最后一个节点id
					if(nleng >= 2) {
						catid = nodes[nleng - 1].id;
						table = nodes[nleng - 1].table;
					}
					$("#aid").val(catid);
					$("#tablename").val(table);
				}
				$("#myform").submit();
			});
		});

		/*树形结构*/
		/*var zNodes =[
				{ id:1, pId:0, name:"父节点1", title:"",children:[
					{id:2,pId:0,name:"zijie"},{id:2,pId:0,name:"zijie"}
					]},
				{ id:12, pId:0, name:"父节点12", title:"", children:[
					{id:2,pId:12,name:"zijie"},{id:2,pId:0,name:"zijie"},
					{id:2,pId:12,name:"zijie"},{id:2,pId:0,name:"zijie"}
				]}
			];
		*/
		//显示树操作
		function trees(info) {
			//节点树操作
			var setting = {
				check: {
					enable: true,
					chkStyle: "radio"
				},
				data: {
					key: {
						title: "name"
					},
					simpleData: {
						enable: true
					}
				},
				callback: {
					onCheck: onCheck
				}
			};
			$.ajax({
				type: "post",
				url: "<?php echo U('wechat/article');?>",
				async: true,
				success: function(data) {
					var znode = "[",
						art = data[0],
						cat = data[1],
						artlen = art.length,
						catlen = cat.length;
					if(info) {
						console.log(info);
						for(var i = 0; i < catlen; i++) {
							if(info.aid == cat[i].id && (info.tablename == cat[i].table || info.tablename == 'article')) {
								znode += "{id:" + cat[i].id + ",pId:" + cat[i].pid + ",name:'" + cat[i].name + "',table:'" + cat[i].table + "',checked:true,open:true,children:[";
							} else {
								znode += "{id:" + cat[i].id + ",pId:" + cat[i].pid + ",name:'" + cat[i].name + "',table:'" + cat[i].table + "',children:[";
							}

							//znode+="{id:"+cat[i].id+",pId:"+cat[i].pid+",name:'"+cat[i].name+"',table:'"+cat[i].table+"',children:[";
							for(var j = 0; j < artlen; j++) {
								if(art[j].catid == cat[i].id) {
									if(info.aid == art[j].id && info.tablename == art[j].table) {
										znode += "{id:" + art[j].id + ",pId:" + art[j].catid + ",name:'" + art[j].name + "',checked:true,open:true,table:'" + art[j].table + "'},";
									} else {
										znode += "{id:" + art[j].id + ",pId:" + art[j].catid + ",name:'" + art[j].name + "',table:'" + art[j].table + "'},";
									}
								}
							}
							znode += "]},";
						}
					} else {
						for(var i = 0; i < catlen; i++) {
							znode += "{id:" + cat[i].id + ",pId:" + cat[i].pid + ",name:'" + cat[i].name + "',table:'" + cat[i].table + "',children:[";
							for(var j = 0; j < artlen; j++) {
								if(art[j].catid == cat[i].id) {
									znode += "{id:" + art[j].id + ",pId:" + art[j].catid + ",name:'" + art[j].name + "',table:'" + art[j].table + "'},";
								}
							}
							znode += "]},";
						}
					}
					znode = znode.substring(0, znode.length - 1);
					znode += "]";
					znode = eval(znode);

					$.fn.zTree.init($("#treeDemo"), setting, znode);
					setTitle();
					count();
				}
			});
		}

		function onCheck(e, treeId, treeNode) {
			count();
		}

		function setTitle(node) {
			var zTree = $.fn.zTree.getZTreeObj("treeDemo");
			var nodes = node ? [node] : zTree.transformToArray(zTree.getNodes());
			for(var i = 0, l = nodes.length; i < l; i++) {
				var n = nodes[i];
				n.title = "[" + n.id + "] isFirstNode = " + n.isFirstNode + ", isLastNode = " + n.isLastNode;
				zTree.updateNode(n);
			}
		}

		function count() {
			function isForceHidden(node) {
				if(!node.parentTId) return false;
				var p = node.getParentNode();
				return !!p.isHidden ? true : isForceHidden(p);
			}
			var zTree = $.fn.zTree.getZTreeObj("treeDemo"),
				checkCount = zTree.getCheckedNodes(true).length,
				nocheckCount = zTree.getCheckedNodes(false).length,
				hiddenNodes = zTree.getNodesByParam("isHidden", true),
				hiddenCount = hiddenNodes.length;

			for(var i = 0, j = hiddenNodes.length; i < j; i++) {
				var n = hiddenNodes[i];
				if(isForceHidden(n)) {
					hiddenCount -= 1;
				} else if(n.isParent) {
					hiddenCount += zTree.transformToArray(n.children).length;
				}
			}
		}
		/*树形结构 end*/
	</script>
</body>

</html>