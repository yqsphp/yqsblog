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
		<strong class="icon-reorder"> 微信账号列表</strong>
	</div>
	<div class="padding border-bottom">
		<ul class="search" style="padding-left:10px;">
			<li><a class="button border-main icon-plus-square-o" href="<?php echo U('wechatAccount/accountedit',['status'=>1]);?>"> 添加账号</a></li>
		</ul>
	</div>
	<table class="table table-hover text-center">
		<tr>
			<th width="5%">序号</th>
			<th>公众号</th>
			<th>原始id</th>
			<th>appid</th>
			<th width="20%">密钥</th>
			<th>类型</th>
			<th width="30%">操作</th>
		</tr>
		<?php if(is_array($info)): $i = 0; $__LIST__ = $info;if( count($__LIST__)==0 ) : echo "" ;else: foreach($__LIST__ as $key=>$v): $mod = ($i % 2 );++$i;?><tr>
			<td><?php echo ($i); ?></td>
			<td width="10%"><?php echo ($v["name"]); ?></td>
			<td width="10%"><?php echo ($v["initid"]); ?></td>
			<td><?php echo ($v["appid"]); ?></td>
			<td><?php echo ($v["token"]); ?></td>
			<td>
		      	<?php if($v['type'] == 1): ?>订阅号
		      	<?php elseif($v['type'] == 2): ?>
		      	服务号
		      	<?php else: ?>
		      	企业号<?php endif; ?>
			</td>
			<td>
				<div class="button-group">
					<?php if($third['auth_edit'] == 1): ?><a class="button border-main edit" href="<?php echo U('wechatAccount/accountedit',['id'=>$v['id'],'status'=>2]);?>">
						<span class="icon-edit"></span> 修改</a><?php endif; ?>	
					<?php if($third['auth_check'] == 1): ?><a class="button border-main defaults" href="<?php echo U('wechat/index',['id'=>$v['id'],'title'=>$v['name'],'token'=>$v['token']]);?>">
						<span class="icon-edit"></span> 菜单</a><?php endif; ?>
					<?php if($third['auth_check'] == 1): ?><a class="button border-main defaults" href="<?php echo U('wechatResource/source_child_list',['wechat_id'=>$v['id']]);?>">
						<span class="icon-edit"></span> 素材</a><?php endif; ?>
					<?php if($third['auth_edit'] == 1): ?><a class="button border-main defaults" href="<?php echo U('wechat/reply',['id'=>$v['id'],'token'=>$v['token']]);?>">
						<span class="icon-edit"></span> 回复</a><?php endif; ?>
					<?php if($third['auth_delete'] == 1): ?><a class="button border-red delete" href="javascript:void(0)" id="<?php echo ($v["id"]); ?>">
						<span class="icon-trash-o"></span> 删除</a><?php endif; ?>
				</div>
			</td>
		</tr><?php endforeach; endif; else: echo "" ;endif; ?>
		<tr>
			<td colspan="7">
				<div class="pagelist-admin">
					<?php echo ($page); ?>
				</div>
			</td>
		</tr>
	</table>
</div>
<script type="text/javascript">
$(function(){
	//删除
	$(".delete").click(function(){
		id=$(this).attr('id');
		function del6(){
			location.href="/WechatAccount/accountdel/id/"+id;
		}
		warning(del6);
	});
});
</script>
</body>
</html>