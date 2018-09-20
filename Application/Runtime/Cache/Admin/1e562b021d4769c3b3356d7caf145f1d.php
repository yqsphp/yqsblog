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
		<div class="panel-head"><strong class="icon-reorder"> 内容列表</strong></div>
		<?php if($third['auth_add'] == 1): ?><div class="padding border-bottom">
				<button type="button" class="button border-main" onclick="catedit(1)">
    	<span class="icon-plus-square-o"></span> 添加类别</button>
			</div><?php endif; ?>
		<table class="table table-hover text-center" id="tree_table">
			<tr>
				<th width="10%">序号</th>
				<th width="10%">名称</th>
				<th width="15%">父级ID</th>
				<th width="15%">电脑显示</th>
				<th width="15%">移动显示</th>
				<th width="15%">操作</th>
			</tr>
			<?php if(is_array($catlist)): $i = 0; $__LIST__ = $catlist;if( count($__LIST__)==0 ) : echo "" ;else: foreach($__LIST__ as $key=>$v): $mod = ($i % 2 );++$i;?><tr data-tt-id="<?php echo ($v["id"]); ?>" data-tt-parent-id="<?php echo ($v["pid"]); ?>">
					<td>
						<?php echo ($i); ?>
					</td>
					<td align="left">
						<?php echo ($v["_name"]); ?>
					</td>
					<td>
						<?php echo ($v["pid"]); ?>
					</td>
					<td>
						<select onchange="setUp(1,this.value,<?php echo ($v["id"]); ?>)">
							<option value="1" <?php if(($v['pc']) == "1"): ?>selected<?php endif; ?>>是</option>
							<option value="0" <?php if(($v['pc']) == "0"): ?>selected<?php endif; ?>>否</option>
						</select>
						<!--<font color="#00CC99">
							<?php if($v['pc'] == 1): ?><span class="icon icon-unlock"></span>
								<?php else: ?>
								<span class="icon icon-lock"></span><?php endif; ?>
						</font>-->
					</td>
					<td>
						<select onchange="setUp(2,this.value,<?php echo ($v["id"]); ?>)">
							<option value="1" <?php if(($v['mobile']) == "1"): ?>selected<?php endif; ?>>是</option>
							<option value="0" <?php if(($v['mobile']) == "0"): ?>selected<?php endif; ?>>否</option>
						</select>
						<!--<font color="#00CC99">
							<?php if($v['mobile'] == 1): ?><span class="icon icon-unlock"></span>
								<?php else: ?>
								<span class="icon icon-lock"></span><?php endif; ?>
						</font>-->
					</td>
					<td>
						<div class="button-group">
							<?php if($third['auth_edit'] == 1): ?><a class="button border-main" href="javascript:void(0)" onclick="catedit(2,<?php echo ($v["id"]); ?>)">
									<span class="icon-edit"></span> 修改</a><?php endif; ?>
							<?php if($third['auth_delete'] == 1): ?><a class="button border-red" href="javascript:void(0)" onclick="del(<?php echo ($v["id"]); ?>)">
									<span class="icon-trash-o"></span> 删除</a><?php endif; ?>
						</div>
					</td>
				</tr><?php endforeach; endif; else: echo "" ;endif; ?>
			<!--<tr>
			<td colspan="6">
				<div class="pagelist">
					<?php echo ($page); ?>
				</div>
			</td>
		</tr>-->
		</table>
	</div>
	<link rel="stylesheet" type="text/css" href="/Public/css/jquery.treetable.css" />
	<script src="/Public/js/jquery.treetable.js"></script>
	<script type="text/javascript">
		$(function() {
			$("#tree_table").treetable({
				indent: 20,
				column: 1,
				clickableNodeNames: true,
				expandable: true,
			});
		});

		function del(id) {
			function del1() {
				location.href = "/Article/catdel/id/" + id;
			}
			warning(del1);
		}

		function catedit(status, id) {
			location.href = "/Article/catedit/status/" + status + "/id/" + id;
		}
		/**
		 * 终端显示操作
		 * @param {Object} status 终端标识 1.pc,2.mobile
		 * @param {Object} flag 显示状态
		 */
		function setUp(status,flag,id) {
			if(status == 1) 
				var data = {pc:flag,id:id}
			else 
				var data = {mobile:flag,id:id}
			$.ajax({
				type:"post",
				url:"<?php echo U('setup');?>",
				data:data,
				success:function(res){
					console.log(res);
				}
			});
		}
	</script>
</body>

</html>