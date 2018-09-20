<?php
namespace Admin\Controller;
use Think\Controller;
use Admin\Common\Geetest;
class GettestController extends Controller{
	/**
     * geetest生成验证码
     */
    public function geetest_show_verify(){
        $geetest_id	 		 = C('GEETEST_ID');
    	$geetest_key 		 = C('GEETEST_KEY');
        $geetest			 = new Geetest($geetest_id,$geetest_key);
        $user_id 			 = "test";
        $status 			 = $geetest->pre_process($user_id);
        $_SESSION['geetest'] = ['gtserver' => $status,'user_id' => $user_id];
        echo $geetest->get_response_str();
    }
 
    /**
     * geetest submit 提交验证
     */
    public function geetest_submit_check(){
        $data = I('post.');
        $veri = geetest_chcek_verify($data);
        if ($veri) {
            echo '验证成功';
        }else{
            echo '验证失败';
        }
    }
 
    /**
     * geetest ajax 验证
     */
    public function geetest_ajax_check(){
        $data = I('post.');
        echo intval(geetest_chcek_verify($data));
    }
}