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
		<strong class="icon-reorder"> 内容列表</strong><a href="" style="float:right; display:none;">添加字段</a>
	</div>
	<!--搜索-->
	<form action="" method="get" id="serachs">
		<div class="padding border-bottom">
			<ul class="search" style="padding-left:10px;">
				<li>搜索：</li>
				<li>
					<select name="catid" class="input" style="line-height:17px;">
						<option value="">请选择分类</option>
						<?php if(is_array($cat)): $i = 0; $__LIST__ = $cat;if( count($__LIST__)==0 ) : echo "" ;else: foreach($__LIST__ as $key=>$vo): $mod = ($i % 2 );++$i;?><option value="<?php echo ($vo["id"]); ?>"<?php if(($get['catid']) == $vo["id"]): ?>selected<?php endif; ?>><?php echo ($vo["_name"]); ?></option><?php endforeach; endif; else: echo "" ;endif; ?>
					</select>
				</li>
				<li>
					<select name="portshow" class="input" style="line-height:17px;">
						<option value="">显示终端</option>
						<option value="电脑端" <?php if(($get['portshow']) == "电脑端"): ?>selected<?php endif; ?>>电脑端</option>
						<option value="移动端" <?php if(($get['portshow']) == "移动端"): ?>selected<?php endif; ?>>移动端</option>
						<option value="微信端" <?php if(($get['portshow']) == "微信端"): ?>selected<?php endif; ?>>微信端</option>
						<option value="APP端" <?php if(($get['portshow']) == "APP端"): ?>selected<?php endif; ?>>APP端</option>
						<option value="小程序端" <?php if(($get['portshow']) == "小程序端"): ?>selected<?php endif; ?>>小程序端</option>
						</volist>
					</select>
				</li>
				<li>
					<select name="porttype" class="input" style="line-height:17px;">
						<option value="">显示方式</option>
						<option value="置顶" <?php if(($get['porttype']) == "置顶"): ?>selected<?php endif; ?>>置顶</option>
						<option value="推荐" <?php if(($get['porttype']) == "推荐"): ?>selected<?php endif; ?>>推荐</option>
						</volist>
					</select>
				</li>
				<li>
					<select name="status" class="input" style="line-height:17px;">
						<option value="">状态</option>
						<option value="1" <?php if(($get['status']) == "1"): ?>selected<?php endif; ?>>已发布</option>
						<option value="0" <?php if(($get['status']) == "0"): ?>selected<?php endif; ?>>未发布</option>
						</volist>
					</select>
				</li>
				<li>
					<input type="text" placeholder="请输入搜索关键字" name="name" class="input" 
					style="width:250px; line-height:17px;display:inline-block" 
					value="<?php if(($get['name']) != ""): echo ($get['name']); endif; ?>"/>
					<button href="javascript:void(0)" type="submit" class="button border-main icon-search"> 搜索</button>
					<button href="javascript:void(0)" type="reset" id="resets" class="button border-main icon-search"> 重置</button>
				</li>
			</ul>
		</div>
	</form>
	<form method="post" action="" id="listform">
		<table class="table table-hover text-center">
		<tr>
			<th width="1%"></th>
			<th width="3%">序号</th>
			<th width="3%">排序</th>
			<th width="13%">缩略图</th>
			<th width="10%">标题</th>
			<th>分类</th>
			<th width="10%">发布时间</th>
			<th>置顶</th>
			<th>推荐</th>
			<th>终端显示</th>
			<th>状态</th>
			<th width="8%">编辑人</th>
			<th width="15%">操作</th>
		</tr>
		<?php if(is_array($list)): $i = 0; $__LIST__ = $list;if( count($__LIST__)==0 ) : echo "" ;else: foreach($__LIST__ as $key=>$v): $mod = ($i % 2 );++$i;?><tr>
			<td width="1%"><input type="checkbox" name="id[]" value="<?php echo ($v["id"]); ?>"/></td>
			<td><?php echo ($i); ?></td>
			<td>
				<input type="text" name="sort[1]" value="<?php echo ($v["order"]); ?>" onblur="setTop(5,<?php echo ($v["id"]); ?>,this.value)" style="width:50px; text-align:center; border:1px solid #ddd; padding:7px 0;"/>
			</td>
			<td width="10%">
				<img src="<?php if($v['image'] != ''): ?>/Public/<?php echo ($v["image"]); else: echo C('DEFAULT_IMG'); endif; ?>" alt="" width="70" height="50"/>
			</td>
			<td>
				<a title="<?php echo ($v["name"]); ?>">
					<?php if(strlen($v['name']) > 50): echo (mb_substr($v["name"],0,15,'utf-8')); ?>...
					<?php else: ?>
					<?php echo ($v["name"]); endif; ?>
				</a>
			</td>
			<td><?php echo ($v["cname"]); ?></td>
			<td><?php echo ($v["ptime"]); ?></td>
			<td>
				<select onchange="setTop(1,<?php echo ($v["id"]); ?>,this.value)">
					<option value="1" <?php if(($v['settop']) == "1"): ?>selected<?php endif; ?>>是</option>
					<option value="0" <?php if(($v['settop']) == "0"): ?>selected<?php endif; ?>>否</option>
				</select>
			</td>
			<td>
				<select onchange="setTop(2,<?php echo ($v["id"]); ?>,this.value)">
					<option value="1" <?php if(($v['recommend']) == "1"): ?>selected<?php endif; ?>>是</option>
					<option value="0" <?php if(($v['recommend']) == "0"): ?>selected<?php endif; ?>>否</option>
				</select>
			</td>
			<td>
				电脑：<select onchange="setTop(3,<?php echo ($v["id"]); ?>,this.value)">
						<option value="1" <?php if(($v['pc']) == "1"): ?>selected<?php endif; ?>>是</option>
						<option value="0" <?php if(($v['pc']) == "0"): ?>selected<?php endif; ?>>否</option>
					</select>
				&emsp;
				移动：<select onchange="setTop(4,<?php echo ($v["id"]); ?>,this.value)">
						<option value="1" <?php if(($v['mobile']) == "1"): ?>selected<?php endif; ?>>是</option>
						<option value="0" <?php if(($v['mobile']) == "0"): ?>selected<?php endif; ?>>否</option>
					</select>
				<!--<br />
				微信：<?php echo ($v['weixin'] == 1 ? '是':'否'); ?>&emsp;|&emsp;
				APP：<?php echo ($v['app'] == 1 ? '是':'否'); ?>&emsp; -->
				<!--&emsp;<br />
				小程序：<?php echo ($v['wshort'] == 1 ? '是':'否'); ?>-->
			</td>
			<td>
				<?php if($v['status'] == 1): ?><font color="#00CC99">已发布</font>
				<?php else: ?>
					<font color="red">未发布</font><?php endif; ?>
			</td>
			<td><?php echo ($v["editor"]); ?></td>
			<td>
				<div class="button-group">
					<?php if($v['status'] == 1): ?><a class="button border-main publish" href="javascript:void(0)" id="<?php echo ($v["id"]); ?>">
						<span class="icon-check"></span> 已发布
					</a>
					<?php else: ?>
						<a class="button border-red publish" href="javascript:void(0)" id="<?php echo ($v["id"]); ?>">
						<span class="icon-meh-o"></span> 未发布
						</a><?php endif; ?>
					<a class="button border-red reply" href="javascript:void(0)" id="<?php echo ($v["id"]); ?>">
						<span class="icon-mail-reply"></span> 撤回</a>
				</div>
			</td>
		</tr><?php endforeach; endif; else: echo "" ;endif; ?>
		<tr>
	        <td>
	        	<input type="checkbox" class="checkall"/>
            </td>
	        <td colspan="12" style="text-align:left;padding-left:20px;">
				<div class="button-group">
					<?php if($third['auth_edit'] == 1): ?><a class="button border-main icon-check" href="javascript:void(0)" 
						onclick="artSelect(1)"> 发布</a><?php endif; ?>
					<?php if($third['auth_recover'] == 1): ?><a class="button border-red icon-mail-reply" href="javascript:void(0)" 
					onclick="artSelect(3)"> 撤回</a><?php endif; ?>
					<?php if($third['auth_edit'] == 1): ?><a class="button border-red icon-times" href="javascript:void(0)" 
					onclick="artSelect(0)"> 取消</a><?php endif; ?>
				</div>
			</td>
        </tr>
		<tr>
			<td colspan="13">
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
	//撤回
	$(".reply").click(function(){
		id=$(this).attr('id');
		location.href="/Article/artpublish/status/3/id/"+id;
	});
	//发布
	$(".publish").click(function(){
		id=$(this).attr('id');
		location.href="/Article/artpublish/status/1/id/"+id;
	});
	//重置
	$("#resets").click(function(){
		$(".input").val("");
		$(".input").find("option").removeAttr("selected");
	});
});
//批量发布或撤回编辑或取消发布0：未发布，1：发布，2：草稿 3：撤回
function artSelect(status){
	var Checkbox=false;
	 $("input[name='id[]']").each(function(){
	  if (this.checked==true) {		
		Checkbox=true;	
	  }
	});
	if (Checkbox){
		$("#listform").attr('action','/Article/artpublish/status/'+status);
		$("#listform").submit();		
	}
	else{
		errors("请选择的内容!");
		return false;
	}
}
/**
 * 多种状态操作
 * @param {Object} flag 1.置顶，2.推荐 ,3.pc显示,4.移动显示,5.排序 
 * @param {Object} id  主键id
 * @param {Object} status 显示状态
 */
function setTop(flag,id,status){
	//console.log(status);return;
	var data = {id:id};
	if(flag == 1)		data.settop 	= status;
	else if(flag == 2)	data.recommend 	= status;
	else if(flag == 3)	data.pc			= status;
	else if(flag == 4)	data.mobile 	= status;
	else if(flag == 5)	data.order 		= status;
	$.ajax({
		type:"post",
		url:"<?php echo U('settop');?>",
		data:data,
		success:function(res){
			console.log(res);
		}
	});
}
</script>
</body>
</html>