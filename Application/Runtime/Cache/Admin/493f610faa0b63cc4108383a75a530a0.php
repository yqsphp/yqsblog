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
<body>
<div class="panel admin-panel">
	<div class="panel-head">
		<strong class="icon-reorder"> 关键字列表</strong><a href="" style="float:right; display:none;">添加字段</a>
	</div>
	<form action="" method="get" id="serachs">
		<div class="padding border-bottom">
			<ul class="search" style="padding-left:10px;">
				<?php if($third['auth_add'] == 1): ?><li><a class="button border-main icon-plus-square-o" href="<?php echo U('wechatReply/keyedit',array('status'=>1));?>"> 添加内容</a></li><?php endif; ?>
				<li>搜索：</li>
				<li>
				<select name="replytype" class="input" style="line-height:17px;">
					<option value="">回复类别</option>
					<option value="1" <?php if(($get['replytype']) == "1"): ?>selected<?php endif; ?>>图文</option>
					<option value="2" <?php if(($get['replytype']) == "2"): ?>selected<?php endif; ?>>文本</option>
					<!--<option value="3" <?php if(($get['replytype']) == "3"): ?>selected<?php endif; ?>>图片</option>
					<option value="4" <?php if(($get['replytype']) == "4"): ?>selected<?php endif; ?>>语音</option>
					<option value="5" <?php if(($get['replytype']) == "5"): ?>selected<?php endif; ?>>视频</option>-->
					</volist>
				</select>
				</li>
				<li>
				<select name="isenable" class="input" style="line-height:17px;">
					<option value="">是否启用</option>
					<option value="1" <?php if(($get['isenable']) == "1"): ?>selected<?php endif; ?>>是</option>
					<option value="0" <?php if(($get['isenable']) == "0"): ?>selected<?php endif; ?>>否</option>
					</volist>
				</select>
				</li>
				<li>
				<input type="text" placeholder="请输入搜索关键字" name="keyword" class="input" 
					style="width:250px; line-height:17px;display:inline-block" value="<?php if(!empty($get['keyword'])): echo ($get['keyword']); endif; ?>"/>
				<a href="javascript:void(0)" class="button border-main icon-search" onclick="changesearch()"> 搜索</a>
				</li>
				<li><input type="reset" id="resets" class="button border-main icon-search"  value="重置"/></li>
			</ul>
		</div>
	</form>
	<form method="post" action="<?php echo U('keydel');?>" id="listform">
		<table class="table table-hover text-center">
		<tr>
			<th width="1%"></th>
			<th>序号</th>
			<th>关键字</th>
			<th>回复类别</th>
			<th>启用状态</th>
			<th>密钥</th>
			<th width="30%">操作</th>
		</tr>
		<?php if(is_array($info)): $i = 0; $__LIST__ = $info;if( count($__LIST__)==0 ) : echo "" ;else: foreach($__LIST__ as $key=>$v): $mod = ($i % 2 );++$i;?><tr>
			<td><input type="checkbox" name="id[]" value="<?php echo ($v["id"]); ?>"/></td>
			<td><?php echo ($i); ?></td>
			<td><?php echo ($v["keyword"]); ?></td>
			<td>
				<?php if($v['replytype'] == 1): ?>图文
				<?php elseif($v['replytype'] == 2): ?>
				文本<?php endif; ?>
			<td><?php if($v['isenable'] == 1): ?>是<?php else: ?>否<?php endif; ?></td>
			<td><?php echo ($v["token"]); ?></td>
			<td>
				<div class="button-group">
					<?php if($third['auth_edit'] == 1): ?><a class="button border-main edit" href="<?php echo U('keyedit',['status'=>2,id=>$v['id']]);?>">
						<span class="icon-edit"></span> 修改</a><?php endif; ?>
					<?php if($third['auth_delete'] == 1): ?><a class="button border-red delete" href="javascript:void(0)" id="<?php echo ($v["id"]); ?>">
						<span class="icon-trash-o"></span> 删除</a><?php endif; ?>
				</div>
			</td>
		</tr><?php endforeach; endif; else: echo "" ;endif; ?>
		<tr>
	        <td>
	        	<input type="checkbox" class="checkall"/>
            </td>
	        <td colspan="8" style="text-align:left;padding-left:20px;">
				<div class="button-group">
					<?php if($third['auth_delete'] == 1): ?><a class="button border-red icon-trash-o" href="javascript:void(0)" 
					onclick="artSelect(0)"> 删除</a><?php endif; ?>
				</div>
			</td>
		</tr>
		<tr>
			<td colspan="8">
				<div class="pagelist-admin">
					<?php echo ($page); ?>
				</div>
			</td>
		</tr>
		</table>
	</form>
</div>
<script type="text/javascript">
//搜索
function changesearch(){	
	$('#serachs').submit();
}
$(function(){
	//全选
	$(".checkall").click(function(){ 
	  $("input[name='id[]']").each(function(){
		  if (this.checked) {
			  this.checked = false;
		  }
		  else {
			  this.checked = true;
		  }
	  });
	});
	//删除
	$(".delete").click(function(){
		id=$(this).attr('id');
		function jumps(){
			location.href="/WechatReply/artdel/id/"+id;
		}
		warning(jumps);
		/*if(confirm("确定删除吗？")){
			id=$(this).attr('id');
			location.href="/WechatReply/artdel/id/"+id;
		}*/
	});
	//排序设置
	$("input[name='sort']").blur(function(){
		var sort = $(this).val();
		var id   = $(this).attr("id");
		$.ajax({
			type:"post",
			url:"<?php echo U('article/artsort');?>",
			data:{"id":id,"sort":sort},
			success:function(res){
				console.log(res);
			}
		});
	});
	//重置
	$("#resets").click(function(){
		$(".input").val("");
		$(".input").removeAttr("value");
		$(".input").find("option").removeAttr("selected");
	});
});
//批量删除或提交 0：删除，1：提交
function artSelect(status){
	var Checkbox=false;
	 $("input[name='id[]']").each(function(){
	  if (this.checked==true) {		
		Checkbox=true;	
	  }
	});
	if (Checkbox){
		var url="";
		if(status==0){
			function sumit(){
				url='artdel/status/'+status;
				$("#listform").attr('action','/WechatReply/'+url);
				$("#listform").submit();
			}
			warning(sumit);
		}else{
			url='artpublish/edit/1/status/0';
			$("#listform").attr('action','/WechatReply/'+url);
			$("#listform").submit();
		}
				
	}
	else{
		errors("请选择内容!");
		return false;
	}
}
</script>
</body>
</html>