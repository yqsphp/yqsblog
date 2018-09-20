<?php
namespace Admin\Controller;
use Admin\Common\AdminBaseController;
use Think\Page;
use Admin\Common\Log;
/**
 * 邮件管理操作
 * @author yqs
 *
 */
class MailController extends AdminBaseController{
	private static $mail;
    public function _initialize(){
        parent::_initialize();
        self::$mail = D('mail');
    }
    /**
     * 邮件列表
     */
    public function index(){
    	$get 	   = self::$get;
    	$where 	   = 'isdel = 0 ';
    	$parameter = $get;
    	$get	   = self::get_fillter($get);
    	if(!empty($get)){
    		foreach($get as $key => $val){
    			if($key == 'sendto' || $key == 'sendcopy' || $key == 'sendbcc'){
    				$where .= ' and '.$key.' like "%'.$val.'%"';
    			}elseif($key == 'start'){
					$where .= ' and date_format(stime,"%Y%m%d") >= "'.str_replace('-','',$val).'"';
    			}elseif($key == 'end'){
					$where .= ' and date_format(stime,"%Y%m%d") <= "'.str_replace('-','',$val).'"';
    			}else{
    				$where .= ' and '.$key.' = "'.$val.'"';
    			}
    		}
    		$this->assign('get',$get); //查询数据回显
    	}
    	
    	$count = self::$mail->where($where)->count();
    	$page  = new Page($count,10,$parameter);
    	$info  = self::$mail->where($where)->order('ctime desc')->limit(mypage($page))->select();
    	$this->assign('info',$info);
    	$this->assign('page',$page->show());
    	$this->display();
    }
    /**
     * 邮箱编辑
     */
    public function mailedit($status){
    	$id   = I('request.id');
    	$post = I('post.');
    	if(IS_POST){
    		if($post['type'] == 1){//添加
    			$post['attachid'] = trim($post['attachid'],',');
    			$post['content']  = html_entity_decode($post['content']);
    			$post['ctime']	  = date('Y-m-d H:i:s');
    			$post['issend'] == 1 ? $post['stime'] = date('Y-m-d H:i:s') : false;
				if(self::$mail->create($post)){
					$res = self::$mail->add();
					Log::write('mail', $res, 1);
					
					if($post['issend'] == 1){
						$send_to = explode(',',$post['sendto']);
						if($post['attachid']){
							$attachment = M('attachment')->field('name,path')->where('id in ('.trim($post['attachid'],',').')')->select();
							foreach($attachment as &$val){
								$val['path'] = './public/'.$val['path'];
							}
						}
						$post['content'] = str_replace('/Public/kindupload/', SITE_NAME.'/Public/kindupload/', $post['content']);
						$result = send_mail($send_to, $post['sendfrom'], $post['subject'], $post['content'],$attachment);
						
						$result['code'] == 200 ? self::jump(true, 'mail/index','',$result['message']) : self::jump(false, 'mail/index','','发送失败');
					}
				}
			}else{//编辑
				$logid = Log::update('mail', $post['id'], 2);
				$res   = self::$mail->save($post);
				Log::write('mail', $post['id'], 2, $logid);
			}
			self::jump($res, 'mail/index');
    	}else{
    		if($status == 2){
    			$info = self::$mail->find($id);
    			if($info['attachid']){
    				$info['attach'] = M('attachment')->where('id in ('.$info['attachid'].')')->select();
    			}
    			$this->assign('info',$info);
    		}
    		$this->assign('status',$status);
    		$this->display();
    	}
    }
    /**
     * 邮件查看，发送之后可查看
     */
    public function mailshow(){
    	$id   = I('request.id');
    	$info = self::$mail->find($id);
    	if($info['attachid']){
    		$info['attach'] = M('attachment')->where('id in ('.$info['attachid'].')')->select();
    	}
    	$this->assign('info',$info);
    	$this->display();
    }
    /**
     * 邮箱删除，软删
     */
    public function maildel(){
    	$id  = I('request.id');
    	$ids = $id;
    	if(is_array($id)){
    		$id  = implode(',', $id);
    	}
    	$res = self::$mail->where('id in ('.$id.')')->save(['isdel'=>1]);
    	
    	//将回收的数据对应表名，主键id，添加到回收表中
    	Log::write('mail', $ids, 3);
    	$rest = recover_delete('mail', '邮件表', $ids);
    	self::jump($rest, 'mail/index');
    }
    /**
     * 发送邮箱(ajax)
     */
    public function mailsend(){
    	$id  = I('request.id');
    	$ids = $id;
    	if(is_array($id)){
    		$id  = implode(',', $id);
    	}
    	
    	$info = self::$mail->where('id in ('.$id.')')->select();
    	$atth = M('attachment');
    	$send = [];
    	foreach($info as $val){
    		if($val['attachid']){
    			$val['attachment'] = $atth->field('name,path')->where('id in ('.$val['attachid'].')')->select();
    		}
    		$val['sendto'] 	 = explode(',',$val['sendto']);
    		$val['sendcopy'] = explode(',',$val['sendcopy']);
    		$val['sendbcc']  = explode(',',$val['sendbcc']);
    		$result 		 = send_mail($val['sendto'], $val['sendfrom'], $val['subject'], $val['content'],$val['attachment'],$val['sendcopy'],$val['sendbcc']);
    	}
    	if($result['code'] == 200){
	    	self::$mail->where('id in ('.$id.')')->save(['issend'=>1,'stime'=>date('Y-m-d H:i:s')]);
    		$this->ajaxReturn(1); 
    	}else{
    		$this->ajaxReturn(0);
    	}
    }
}