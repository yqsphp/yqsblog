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
<style>
	.form-group{position: relative;}
	.texts{position: absolute; left: 5px; color: red; }
	#background{width: 100%; height: 100%;}
	.loging{position: relative; z-index: 100;}
</style>
<script src="/Public/js/rainyday.min.js"></script>
<script>
    function run() {
        var image = document.getElementById('background');
        image.onload = function() {
            var engine = new RainyDay({
                image: this,
                gravityThreshold:0,
                gravityAngle:Math.PI / 8,
                gravityAngleVariance:0  //风速
            });
            engine.rain([ [0,2,0.5],[4, 4, 1],[5,6,10]], 50);
        };
        image.crossOrigin = 'anonymous';
        image.src = '/Public/admin/images/bg.jpg'
    }
</script>
<body onload="run()">
<div class="bg">
	<img id="background" src="/Public/admin/images/bg.jpg"/>
</div>
<div class="container loging">
    <div class="line bouncein">
        <div class="xs6 xm4 xs3-move xm4-move">
            <div style="height:100px;"></div>
            <div class="media media-y margin-big-bottom">           
            </div>         
            <form action="<?php echo U('Login/index');?>" method="post">
            <div class="panel loginbox">
                <div class="text-center margin-big padding-big-top"><h1>梦美后台管理中心</h1></div>
                <div class="panel-body" style="padding:30px; padding-bottom:10px; padding-top:10px;">
                    <div class="form-group">
                        <div class="field field-icon-right">
                            <input type="text" class="input input-big" autofocus="autofocus" data="put" name="name" placeholder="登录账号" data-validate="required:请填写账号" />
                            <span class="icon icon-user margin-small"></span>
                        </div>
                        <span class="texts users"></span>
                    </div>
                    <div class="form-group">
                        <div class="field field-icon-right">
                            <input type="password" class="input input-big" data="put" name="password" placeholder="登录密码" data-validate="required:请填写密码" />
                            <span class="icon icon-key margin-small"></span>
                        </div>
                    	<span class="texts passs"></span>
                    </div>
                    <!--<div class="form-group">
                        <div id="captcha"></div>
                        <span class="texts verify"></span>  
                    </div>-->
                    <div class="form-group">
                        <div class="field">
                            <input type="text" class="input input-big" data="put" name="code" placeholder="填写右侧的验证码" data-validate="required:请填写右侧的验证码" />
                           <img src="<?php echo U('Login/verify');?>" alt="" width="130" height="32" class="passcode" style="height:43px;cursor:pointer;" onclick="this.src=this.src+'?'">  
                        </div>
                       <span class="texts verify"></span>                        
                    </div>
                </div>
                <div style="padding:30px;"><input id="btn" type="button" class="button button-block bg-main text-big input-big" value="登录"></div>
            </div>
            </form>          
        </div>
    </div>
</div>
<script src="http://static.geetest.com/static/tools/gt.js"></script>
<script>
$(function(){
	$("body").keyup(function(event){
		if(event.which==13){
			var flag = selects();
			check_verify(flag);
		}
	});
	$("#btn").click(function(){
		var flag = selects();
		check_verify(flag);
	});
});
//input是否填写完
function selects(){
	var flag=1;
	$("input[data='put']").each(function(){
		_this=$(this);
		var val=_this.val();
		if(val==''){
			_this.css('border','1px solid red');
			return false;
		}else{
			_this.css('border','');
			flag++;	
		}
	});
	return flag;
}
function check_verify(flag){
	if(flag == 4){
		$.ajax({
			type:"post",
			url:"<?php echo U('Login/index');?>",
			data:$("form").serialize(),
			beforeSend:function(){
				loading();
			},
			success:function(data){
				console.log(data);
				switch(data){
					case 0:
						errors('密码错误');
						break;
					case 1:
						location.href="<?php echo U('Index/index');?>"
						break;
					case 2:
						errors('验证码错误');
						$(".passcode").click();
						break;
					case 3:
						errors('账号错误');
						break;
					case 4:
						errors('用户已禁用');
						break;
					default:
						break;
				}
			}
		});
	}
}
</script>
</body>
</html>