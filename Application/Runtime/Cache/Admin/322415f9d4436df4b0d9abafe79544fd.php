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
<link href="/Public/fcup/css/style.css" rel="stylesheet" /> 
<script src="/Public/fcup/js/jquery.fcup.js"></script>
<body>
	<div class="panel admin-panel">
		<div class="panel-head" id="add"><strong><span class="icon-pencil-square-o"></span>
  		<?php if($status == 1): ?>增加<?php else: ?>修改<?php endif; ?>内容</strong></div>
		<div class="body-content">
			<form method="post" id="myform" class="form-x" action="<?php echo U('attach_upload_video',['status'=>$status,'id'=>$id]);?>" enctype="multipart/form-data">
				<div class="form-group">
					<div class="label">
						<label>视频名称：</label>
					</div>
					<div class="field">
						<input type="text" class="input w50" id="titles" value="<?php echo ($info["name"]); ?>" name="name" placeholder="请输入标题" data-validate="required:请输入标题" />
						<div class="tips">添加视频附件</div>
					</div>
				</div>
				<div class="form-group">
					<div class="label">
						<label>视频缩略图：</label>
					</div>
					<div class="field">
						<div class="logo-icon">
							<img class="float-left" src="<?php if( $info[ 'image'] != '' ): ?>/Public/<?php echo ($info["image"]); ?>
        			<?php else: echo C('DEFAULT_IMG'); endif; ?>" width="60" height="50" />
						</div>
						<input type="file" name="image" id="file" accept="image/*" style="display:none" />
						<input type="button" class="button bg-blue margin-left" id="image1" value="+ 浏览上传">
					</div>
					<div class="clear"></div>
				</div>
				<div class="form-group">
					<div class="label">
						<input type="hidden" name="image" id="image" value="1" />
						<label>视频上传：</label>
					</div>
					<div class="field">
						<div id="fcup" class="margin"></div>
						<input type="hidden" name="isvideo" value="1" />
					</div>
				</div>
				<div class="form-group">
					<div class="label">
						<label></label>
					</div>
					<div class="field">
						<button class="button bg-main icon-check-square-o" type="button" id="btn" disabled> 提交</button>
						<button class="button bg-red icon-mail-reply" type="button" onclick="history.back()"> 撤销</button>
					</div>
				</div>
				<input type="hidden" name="size" value="" />
				<input type="hidden" name="path" value="" />
				<input type="hidden" name="file_name" value="" />
			</form>
		</div>
	</div>
	<script>
		$(function() {
			$.fcup({
			    updom: "#fcup",//上传控件的位置dom		
				//upid: 'upid',//上传的文件表单id，有默认
				shardsize: "5",//切片大小,(单次上传最大值)单位M，默认2M
				upmaxsize : "1024",//上传文件大小,单位M，不设置不限制
				upstr: "上传文件",//按钮文字
				uploading: "上传中...",//上传中的提示文字
			    upfinished: "上传完成",//上传完成后的提示文字
				upurl: "<?php echo U('attach_upload_video');?>",//文件上传接口 node接口:http://127.0.0.1:8888/upload
				uptype: "mp4,flv",//上传类型检测,用,号分割
			    errmaxup: "上传文件过大",//检测文件是否超出设置上传大小
				errtype: '请上传mp4文件',//不支持类型的提示文字
				//接口返回结果回调
				upcallback : function(res){
					res = eval("("+res+")");
				    console.log(res);
				    if(res.file_name) $("input[name='file_name']").val(res.file_name);
				    if(res.file_size) $("input[name='size']").val(res.file_size);
				    if(res.path){
				    	$("input[name='path']").val(res.path);
				    	$("#btn").removeAttr("disabled");
				    }
				}
			});
			$("#image1").click(function() {
				$("#file").click();
			});
			//文件上传预览
			$("#file").change(function() {
				//在重新点击上传附件移除所有img的元素
				$(".logo-icon").children('img').remove();
				// 得到一个参考文件列表
				var files = !!this.files ? this.files : [];
				// 如果没有选择任何文件,或者没有FileReader支持,返回
				if(!files.length || !window.FileReader) return;
				// 只有选择的文件是一个image才显示
				//if (/^image/.test( files[i].type)){}
				$.each(files, function(i) {
					// 创建一个新的FileReader的实例
					var reader = new FileReader();
					reader.readAsDataURL(files[i]);
					// 当加载时,图像数据
					reader.onloadend = function() {
						img = "<img class='float-left' src='" + this.result + "' width=60 height=50/> &nbsp;";
						$(".logo-icon").append(img);
					}
				});
			});
			$('.radio label').each(function() {
				var e = $(this);
				e.click(function() {
					e.closest('.radio').find("label").removeClass("active");
					e.addClass("active");
				});
			});
			$("#btn").click(function() {
				var file = $("#file").val();
				var title = $("#titles").val();
				if(file == '' || title == '') {
					errors("名称或缩略图不能为空");
					return false;
				} else {
					$("#myform").submit();
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
		});
	</script>
</body>

</html>