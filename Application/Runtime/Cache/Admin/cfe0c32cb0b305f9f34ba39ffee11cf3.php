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
<link rel="stylesheet" type="text/css" href="/Public/webuploader/webuploader.min.css" />
<script src="/Public/webuploader/webuploader.min.js"></script>
<script src="/Public/webuploader/uploadImgPreview.min.js"></script>
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
			<form method="post" id="myform" class="form-x" action="/Article/artedit/status/<?php echo ($status); if(isset($id)): ?>/id/<?php echo ($id); endif; ?>" enctype="multipart/form-data">
				<input type="hidden" name="editorid" value="<?php echo ($_SESSION['user_info']['user_id']); ?>" />
				<input type="hidden" name="editor" value="<?php echo ($_SESSION['user_info']['user_name']); ?>" />
				<div class="form-group">
					<div class="label">
						<label>上级分类：</label>
					</div>
					<div class="field">
						<select name="catid" class="input w50" id="catse">
							<option value="">请选择分类</option>
							<?php if(is_array($parent)): $i = 0; $__LIST__ = $parent;if( count($__LIST__)==0 ) : echo "" ;else: foreach($__LIST__ as $key=>$vo): $mod = ($i % 2 );++$i;?><option value="<?php echo ($vo["id"]); ?>" <?php if($info['catid'] == $vo['id']): ?>selected<?php endif; ?>>
									<?php echo ($vo["name"]); ?>
								</option>
								<?php if(is_array($child)): $i = 0; $__LIST__ = $child;if( count($__LIST__)==0 ) : echo "" ;else: foreach($__LIST__ as $key=>$v): $mod = ($i % 2 );++$i; if($v['pid'] == $vo['id']): ?><option value="<?php echo ($v['id']); ?>" <?php if($info['catid'] == $v['id']): ?>selected<?php endif; ?>>&nbsp;└─
									<?php echo ($v["name"]); ?>
										</option><?php endif; endforeach; endif; else: echo "" ;endif; endforeach; endif; else: echo "" ;endif; ?>
						</select>
						<div class="tips-thishi">*</div>
					</div>
				</div>
				<div class="form-group">
					<div class="label">
						<label>标题：</label>
					</div>
					<div class="field">
						<input type="text" class="input w50" id="titles" value="<?php echo ($info["name"]); ?>" name="name" placeholder="请输入标题" data-validate="required:请输入标题" />
						<div class="tips"></div>
					</div>
				</div>
				<div class="form-group">
					<div class="label">
						<label>栏目图片：</label>
					</div>
					<div class="field">
						<div class="logo-icon">
							<img src="<?php if( $info[ 'image'] != '' ): ?>/Public/<?php echo ($info["image"]); ?>
        			<?php else: echo C('DEFAULT_IMG'); endif; ?>" width="60" height="50" />
						</div>
						<input type="file" name="image" id="file" style="display:none" />
						<input type="button" class="button bg-blue margin-left" id="image1" value="+ 浏览上传">
					</div>
				</div>

				<div class="form-group">
					<div class="label">
						<label>来源：</label>
					</div>
					<div class="field">
						<input type="text" class="input" name="copyfrom" value="<?php echo ($info["copyfrom"]); ?>" />
						<div class="tips"></div>
					</div>
				</div>
				<div class="form-group">
					<div class="label">
						<label>描述：</label>
					</div>
					<div class="field">
						<textarea class="input" name="description" style="height:90px;"><?php echo ($info["description"]); ?></textarea>
						<div class="tips"></div>
					</div>
				</div>
				<div class="form-group">
					<div class="label">
						<label>内容：</label>
					</div>
					<div class="field">
						<font color="red">注意：如果内容在移动端显示，则视频必须上传【MP4】格式，否则无法播放</font>
						<textarea id="kindeditor" name="content" class="input" style="height:450px; border:1px solid #ddd;"><?php echo ($info["content"]); ?></textarea>
						<script src="/Public/kindeditor/kindeditor.js"></script>
						<script>
							KindEditor.ready(function(K) {
								window.editor = K.create("#kindeditor", {
									allowFileManager: true,
									afterBlur: function() { //失去焦点获取textareea的值
										this.sync();
									}
								});
							});
						</script>
						<div class="tips"></div>
					</div>
				</div>
				<div class="clear"></div>
				<div class="form-group">
					<div class="label">
						<label>附件集：</label>
					</div>
					<div class="field">
						<div class="button-uploas">
							<div>
								<a type="button" class="btn bg-blue margin-left" id="select_attach" style="padding: 0;">+ 浏览上传</a>
							</div>
							<div><button type="button" class="button bg-blue margin-left" id="upload_now">开始上传</button></div>
							<div class="padding">单个文件上传大小，默认2M</div>
						</div>
						<div class="clear"></div>
						<div class="margin">
							<ul class="attachlist">
								<?php if(!empty($info['attach'])): if(is_array($info['attach'])): $i = 0; $__LIST__ = $info['attach'];if( count($__LIST__)==0 ) : echo "" ;else: foreach($__LIST__ as $key=>$v): $mod = ($i % 2 );++$i;?><li>
											<p class="title">
												<?php echo ($v["name"]); ?>
											</p>
											<p class="imgWrap">
												<?php if(in_array($v['ext'],['jpg','png','gif','jpeg','bmp'])): ?><img class="attach-img" src="/Public/<?php echo ($v["path"]); ?>" />
													<?php else: ?>
													<div class="attach-txt">
														您上传的<b> <?php echo ($v["name"]); ?> </b>文件不支持预览！
													</div><?php endif; ?>
											</p>
											<p class="progress"></p>
											<span class="success"></span>
											<div class="file-panel">
												<span class="cancel attach-cancel" id="<?php echo ($v["id"]); ?>">删除</span>
											</div>
										</li><?php endforeach; endif; else: echo "" ;endif; endif; ?>
							</ul>
						</div>
						<div id="uploader" class="margin padding-top"></div>
						<input type="hidden" name="attachid" id="attachid" value="" />
					</div>
					<script>
						$(function() {
							var uploader = uploadImage({
								wrap: jQuery("#uploader"), //包裹整个上传控件的元素，必须。可以传递dom元素、选择器、jQuery对象
								/*预览图片的宽度，可以不传，如果宽高都不传则为包裹预览图的元素宽度，高度自动计算*/
								//width: "160px", 
								height: 100, //预览图片的高度
								auto: false, //是否自动上传
								method: "POST", //上传方式，可以有POST、GET
								sendAsBlob: false, //是否以二进制流的形式发送
								viewImgHorizontal: true, //预览图是否水平垂直居中
								fileVal: "file", // [默认值：'file'] 设置文件上传域的name。
								btns: { //必须
									uploadBtn: $("#upload_now"), //开始上传按钮，必须。可以传递dom元素、选择器、jQuery对象
									retryBtn: $("#upload_now"), //用户自定义"重新上传"按钮
									chooseBtn: '#select_attach', //"选折图片"按钮，必须。可以传递dom元素、选择器、jQuery对象
									chooseBtnText: "选择文件" //选择文件按钮显示的文字
								},
								pictureOnly: false, //只能上传图片
								datas: {
									//"uuid": new Date().getTime()
								}, //上传的参数,如果有参数则必须是一个对象
								// 不压缩image, 默认如果是jpeg，文件上传前会压缩一把再上传！false为不压缩
								resize: false,
								//是否可以重复上传，即上传一张图片后还可以再次上传。默认是不可以的，false为不可以，true为可以
								duplicate: false,
								multiple: true, //是否支持多选能力
								swf: "/Public/webuploader/Uploader.swf", //swf文件路径，必须
								url: "<?php echo U('attachment/attach_upload');?>", //图片上传的路径，必须
								maxFileNum: 20, //最大上传文件个数
								maxFileTotalSize: 838860800, //最大上传文件大小，100M
								maxFileSize: 838860800, //单个文件最大大小，100M
								showToolBtn: true, //当鼠标放在图片上时是否显示工具按钮,
								//当有图片进来后所处理函数
								onFileAdd: function() {},
								onDelete: null, //当预览图销毁时所处理函数
								/*当单个文件上传失败时执行的函数，会传入当前显示图片的包裹元素，以便用户操作这个元素*/
								uploadFailTip: null,
								//上传出错时执行的函数
								onError: null,
								notSupport: null, //当浏览器不支持该插件时所执行的函数
								/*当上传成功（此处的上传成功指的是上传图片请求成功，并非图片真正上传到服务器）后所执行的函数，会传入当前状态及上一个状态*/
								onSuccess: null,
								callback: function(e, res) {
									console.log(uploader.getStats());
									console.log(res);
									var attach = $("#attachid").val();
									if(res != false) {
										$("#attachid").val(attach + ',' + res);
									}

								}
							});
							/*如果按钮开始是隐藏的，经过触发后才显示，则可以用这个方法重新渲染下*/
							//uploader.refresh();//该方法可以重新渲染选择文件按钮
							//uploader.upload();//调用该方法可以直接上传图片
							//uploader.retry();//调用该方法可以重新上传图片
							$(".attachlist li").hover(
								function() {
									$(this).children("div.file-panel").animate({
										"height": "30px"
									}, 300);
								},
								function() {
									$(this).children("div.file-panel").animate({
										"height": "0"
									}, 300);
								}
							);
							//删除已上传的附件
							$(".attach-cancel").click(function() {
								var that = $(this);
								var id = that.attr("id"); //附件id
								$.ajax({
									type: "post",
									url: "<?php echo U('attachment/attach_delete');?>",
									data: {
										"id": id
									},
									success: function(res) {
										if(res == 1) {
											that.parent().parent().remove();
										}
										console.log(res);
									}
								});
							});
						});
					</script>
				</div>
				<div class="form-group">
					<div class="label">
						<label>SEO关键字：</label>
					</div>
					<div class="field">
						<input type="text" class="input" name="keywords" value="<?php echo ($info["keywords"]); ?>" placeholder="多个关键字以，分隔" />
					</div>
				</div>
				<div class="form-group">
					<div class="label">
						<label>SEO描述：</label>
					</div>
					<div class="field">
						<textarea class="input" name="seo" style="height:90px;"><?php echo ($info["seo"]); ?></textarea>
						<div class="tips"></div>
					</div>
				</div>
				<div class="form-group">
					<div class="label">
						<label>排序：</label>
					</div>
					<div class="field">
						<input type="number" class="input w50" name="order" value="<?php echo ($info["order"]); ?>" data-validate="number:排序必须为数字" />
						<div class="tips"></div>
					</div>
				</div>
				<div class="form-group">
					<div class="label">
						<label>发布时间：</label>
					</div>
					<div class="field">
						<script src="/Public/Js/laydate/laydate.js"></script>
						<input type="text" class="input w50" style="" id="demo" name="ptime" value="<?php echo ($info["ptime"]); ?>" placeholder="请输入日期" onclick="laydate" id="demo" readonly=""/>
						<script>
							;
							! function() {
								laydate.skin('blue')
								laydate({
									elem: '#demo',
									istoday: true
								})
							}();
						</script>
						<div class="tips"></div>
					</div>
				</div>
				<div class="form-group">
					<div class="label">
						<label>点击次数：</label>
					</div>
					<div class="field">
						<input type="number" class="input w50" name="hits" value="<?php echo ($info["hits"]); ?>" data-validate="member:只能为数字" />
						<div class="tips"></div>
					</div>
				</div>
				<div class="form-group">
					<div class="label">
						<label>推荐：</label>
					</div>
					<div class="field">
						<div class="bootstrap-switch bootstrap-switch-large">
							<?php if($status == 1): ?><input type="checkbox" name="recommend" value="0" />
								<?php else: ?>
								<input type="checkbox" name="recommend" value="<?php echo ($info["recommend"]); ?>" <?php if($info['recommend'] == 1): ?>checked<?php endif; ?>/><?php endif; ?>
						</div>
					</div>
				</div>
				<div class="form-group">
					<div class="label">
						<label>置顶：</label>
					</div>
					<div class="field">
						<div class="bootstrap-switch bootstrap-switch-large">
							<?php if($status == 1): ?><input type="checkbox" name="settop" value="0" />
								<?php else: ?>
								<input type="checkbox" name="settop" value="<?php echo ($info["settop"]); ?>" <?php if($info['settop'] == 1): ?>checked<?php endif; ?>/><?php endif; ?>
						</div>
					</div>
				</div>
				<div class="form-group">
					<div class="label">
						<label>显示端：</label>
					</div>
					<div class="field">
						<div class="col-sm-2">
							<div class="label" style="width: 55px;">
								<label>电脑端：</label>
							</div>
							<div class="bootstrap-switch bootstrap-switch-large">
								<?php if($status == 1): ?><input type="checkbox" name="pc" value="1" checked/>
									<?php else: ?>
									<input type="checkbox" name="pc" value="<?php echo ($info["pc"]); ?>" <?php if($info['pc'] == 1): ?>checked<?php endif; ?>/><?php endif; ?>
							</div>
						</div>
						<div class="col-sm-2">
							<div class="label" style="width: 55px;">
								<label>移动端：</label>
							</div>
							<div class="bootstrap-switch bootstrap-switch-large">
								<?php if($status == 1): ?><input type="checkbox" name="mobile" value="1" checked/>
									<?php else: ?>
									<input type="checkbox" name="mobile" value="<?php echo ($info["mobile"]); ?>" <?php if($info['mobile'] == 1): ?>checked<?php endif; ?>/><?php endif; ?>
							</div>
						</div>
						<div class="col-sm-2">
							<div class="label" style="width: 55px;">
								<label>微信端：</label>
							</div>
							<div class="bootstrap-switch bootstrap-switch-large">
								<?php if($status == 1): ?><input type="checkbox" name="weixin" value="1" checked/>
									<?php else: ?>
									<input type="checkbox" name="weixin" value="<?php echo ($info["weixin"]); ?>" <?php if($info['weixin'] == 1): ?>checked<?php endif; ?>/><?php endif; ?>
							</div>
						</div>
						<div class="col-sm-2">
							<div class="label" style="width: 55px;">
								<label>APP端：</label>
							</div>
							<div class="bootstrap-switch bootstrap-switch-large">
								<?php if($status == 1): ?><input type="checkbox" name="app" value="1" checked/>
									<?php else: ?>
									<input type="checkbox" name="app" value="<?php echo ($info["app"]); ?>" <?php if($info['app'] == 1): ?>checked<?php endif; ?>/><?php endif; ?>
							</div>
						</div>
						<div class="col-sm-2">
							<div class="label" style="width: 55px;">
								<label>小程序：</label>
							</div>
							<div class="bootstrap-switch bootstrap-switch-large">
								<?php if($status == 1): ?><input type="checkbox" name="wshort" value="1" checked/>
									<?php else: ?>
									<input type="checkbox" name="wshort" value="<?php echo ($info["wshort"]); ?>" <?php if($info['wshort'] == 1): ?>checked<?php endif; ?>/><?php endif; ?>
							</div>
						</div>
						<div class="tips"></div>
					</div>
				</div>
				<div class="form-group">
					<div class="label">
						<label>显示：</label>
					</div>
					<div class="field">
						<div class="bootstrap-switch bootstrap-switch-large">
							<?php if($status == 1): ?><input type="checkbox" name="isshow" value="1" checked/>
								<?php else: ?>
								<input type="checkbox" name="isshow" value="<?php echo ($info["isshow"]); ?>" <?php if($info['isshow'] == 1): ?>checked<?php endif; ?>/><?php endif; ?>
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
			</form>
		</div>
	</div>
	<script>
		$(function() {
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
						img = "<img src='" + this.result + "' width=60 height=50/> &nbsp;";
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
				var catse = $("#catse").val();
				var title = $("#titles").val();
				if(catse == '' || title == '') {
					errors("分类或标题不能为空");
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