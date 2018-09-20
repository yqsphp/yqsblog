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
		<strong class="icon-reorder"> 素材列表</strong><a href="" style="float:right; display:none;">添加字段</a>
	</div>
	<!--搜索-->
	<form action="" method="get" id="serachs">
	<div class="padding border-bottom">
		<ul class="search" style="padding-left:10px;">
			<li>搜索：</li>
			<li>
				<select name="wechat_id" class="input">
					<option value="">微信号</option>
					<?php if(is_array($user)): $i = 0; $__LIST__ = $user;if( count($__LIST__)==0 ) : echo "" ;else: foreach($__LIST__ as $key=>$v): $mod = ($i % 2 );++$i;?><option value="<?php echo ($v["id"]); ?>" <?php if(($get['wechat_id']) == $v['id']): ?>selected<?php endif; ?>><?php echo ($v["name"]); ?></option><?php endforeach; endif; else: echo "" ;endif; ?>
				</select>
			</li>
			<li>
				<button type="submit" class="button border-main icon-search"> 搜索</button>
				<button type="reset" id="resets" class="button border-main icon-search"> 重置</button>
			</li>
			<li>
				<button type="button" class="refresh button border-main icon-refresh"> 刷新</button>
				<font color="red" size="3">注意：刷新是从微信公众号获取数据同步本系统，请求限制为5次，当日剩余<b class="number"><?php echo ($number); ?></b>次</font>
			</li>
		</ul>
	</div>
	</form>
	<form method="post" action="" id="listform">
		<table class="table table-hover text-center">
		<tr>
			<th width="1%"></th>
			<th width="3%">序号</th>
			<th width="5%">素材媒体</th>
			<th width="5%">素材个数</th>
			<th width="5%">推送次数</th>
			<th width="5%">微信号</th>
			<th width="8%">创建时间</th>
			<th width="8%">更新时间</th>
			<th width="15%">操作</th>
		</tr>
		<?php if(is_array($info)): $i = 0; $__LIST__ = $info;if( count($__LIST__)==0 ) : echo "" ;else: foreach($__LIST__ as $key=>$v): $mod = ($i % 2 );++$i;?><tr>
			<td width="1%"><input type="checkbox" name="id[]" value="<?php echo ($v["id"]); ?>"/></td>
			<td><?php echo ($i); ?></td>
			<td><?php echo ($v["media_id"]); ?></td>
			<td><?php echo ($v["sourse_num"]); ?></td>
			<td><?php echo ($v["send_num"]); ?></td>
			<td><?php echo ($v["wechat_name"]); ?></td>
			<td><?php echo ($v["ctime"]); ?></td>
			<td><?php echo ($v["utime"]); ?></td>
			<td>
				<div class="button-group">
					<a class="button border-main icon-edit" onclick="loading()" href="<?php echo U('source_send',['id'=>$v['id'],'wechat_id'=>$v['wechat_id'],'media_id'=>$v['media_id']]);?>"> 推送</a>
					<?php if($third['auth_check'] == 1): ?><a class="button border-main icon-edit" href="<?php echo U('source_check',['wechat_id'=>$v['wechat_id'],'source_id'=>$v['id']]);?>"> 查看</a><?php endif; ?>
					<?php if($third['auth_delete'] == 1): ?><a class="button border-red icon-trash-o" onclick="sourceDel('<?php echo U('source_del',['wechat_id'=>$v['wechat_id'],'id'=>$v['id'],'media_id'=>$v['media_id']]);?>')"> 删除</a><?php endif; ?>
				</div>
			</td>
		</tr><?php endforeach; endif; else: echo "" ;endif; ?>
		<?php if($third['auth_delete'] == 1): ?><tr>
	        <td>
	        	<input type="checkbox" class="checkall"/>
            </td>
	        <td colspan="15" style="text-align:left;padding-left:20px;">
				<div class="button-group">
					<!-- <a class="button border-main icon-edit" href="javascript:void(0)" 
						onclick="artSelect(1)"> 查看</a> -->
					<a class="button border-red icon-trash-o" href="javascript:void(0)" 
					onclick="message()"> 删除</a>
				</div>
				<font color="red" size="3">由于公众号限制，一天只能推送列表素材中的一个，请慎重</font>
			</td>
        </tr><?php endif; ?>
		<tr>
			<td colspan="15">
				<div class="pagelist-admin">
					<?php echo ($page); ?>
				</div>
			</td>
		</tr>
		</table>
	</form>
</div>
<script type="text/javascript">
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
	//重置
	$("#resets").click(function(){
		$(".input").val("");
		$(".input").find("option").removeAttr("selected");
	});
	//刷新
	$(".refresh").click(function(){
		var wechat_id = [<?php echo ($wechat_id); ?>];
		$.ajax({
			type:"post",
			url:"<?php echo U('get_source');?>",
			data:{'wechat_id':wechat_id},
			sendBefore:loading(),
			success:function(res){
				if(res.code == 200){
					$(".number").html(res.number);
					success(res.message);
					setTimeout(location.reload(),1000);
				}else{
					errors(res.message);
				}
				console.log(res);
			}
		});
	});
});
//批量删除
function message(){
	var Checkbox=false;
	 $("input[name='id[]']").each(function(){
	  if (this.checked==true) {		
		Checkbox=true;	
	  }
	});
	if (Checkbox){
		$("#listform").attr('action','/WechatResource/attdel');
		$("#listform").submit();		
	}
	else{
		errors("请选择的内容!");
		return false;
	}
}
//删除
function sourceDel(url){
	function jump(){
		location.href = url;
	}
	warning(jump,"删除时公众号素材将同时被删除,请慎重！");
}
</script>
</body>
</html>