<?php
namespace Admin\Controller;
use Think\Controller;
use Admin\Model\AdminModel as Admin;
use Think\Verify;

class LoginController extends Controller{
    /**
     * 用户登陆
     */
    public function index(){
        if(IS_AJAX){
            $code  = I('request.code'); 		//验证码
            $name  = I('request.name'); 		//用户名
            $pass  = I('request.password');  //密码
            
            $admin = new Admin();
            //$res   = $admin->login1($name,$pass);
            $res   = $admin->login($code,$name,$pass);
            $this->ajaxReturn($res);
        }else{
            $this->display('Index/login');
        }
    }
    /**
     * 退出登陆
     */
    public function logout(){
        session('user_info',null);
        session_destroy();
        $this->redirect('Login/index');
    }
    /**
     * 验证码
     */
    public function verify(){
        $config=[
            'useImgBg'  =>  false,           // 使用背景图片
            'fontSize'  =>  16,              // 验证码字体大小(px)
            'useCurve'  =>  true,            // 是否画混淆曲线
            'useNoise'  =>  false,            // 是否添加杂点
            'imageH'    =>  43,               // 验证码图片高度
            'imageW'    =>  130,               // 验证码图片宽度
            'length'    =>  4,               // 验证码位数
            'fontttf'   =>  '4.ttf'
        ];
        $verify = new Verify($config);
        $verify->entry();
    }
    /**
     * 注册用户
     */
    public function register($pass){
        //if($_POST){
            //$name=I('post.name');
            //$pass=I('post.pass');
            $pass=md5(base64_encode($pass));
            dump($pass);
        //}
    }
}