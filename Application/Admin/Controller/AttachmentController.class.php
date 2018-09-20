<?php
namespace Admin\Controller;
use Admin\Common\AdminBaseController;
use Think\Page;
use Admin\Common\Log;
/**
 * 附件上传处理类
 * @author yqs
 */
class AttachmentController extends AdminBaseController{
	private static $attach;
    public function _initialize(){
        parent::_initialize();
        self::$attach = D('attachment');
    }
    /**
     * 附件列表显示
     */
    public function attach(){
    	$get      	= self::$get;
    	$pre      	= C('DB_PREFIX');
    	$where 		= $pre.'attachment.isdel = 0';
    	$parameter 	= $get;
    	$get 		= self::get_fillter($get);
    	if(!empty($get)){
    		foreach ($get as $key => $val){
    			$where .= ' and '.$pre.'attachment.'.$key.' = "'.$val.'"';
    		}
    		$this->assign('get',$get);
    	}
    	$count = self::$attach->where($where)->count();
    	$page  = new Page($count,10,$parameter);
    	$info  = self::$attach->field($pre.'attachment.*,art.name as title')
    			->join($pre.'article as art on art.id = '.$pre.'attachment.aid','left')
    			->where($where)
    			->order('ctime desc')
    			->limit(mypage($page))
    			->select();
    	//判断附件后缀是否图片格式
    	$ext = ['jpg','png','gif','jpeg','bmp'];
    	foreach($info as &$val){
    		if(in_array($val['ext'],$ext)){
    			$val['show'] = 1;
    		}else{
    			$val['show'] = 0;
    		}
    	}
    	//查询是图片格式的数据
    	if(isset($get['ext']) && $get['ext'] == 1){
    	foreach($info as &$val){
    		if(!in_array($val['ext'],$ext)){
    			unset($val);
    		}
    	}
    	}
    	$this->assign('info',$info);
    	$this->assign('page',$page->show());
    	$this->display();
    }
    /**
     * 附件上传
     */
    public function attach_upload(){
    	$path 		   = fileuploadOne($_FILES['file']);
    	if(empty($path)) $this->ajaxReturn(false);
    	$post 		   = I('post.');
    	$post['path']  = $path ? $path : '';
    	$post['size']  = $post['size'] / 1024;
    	$post['ctime'] = date('Y-m-d');
    	$post['ext']   = substr($post['name'],strrpos($post['name'],'.')+1,strlen($post['name']));
    	if(self::$attach->create($post)){
    		$result = self::$attach->add();
    		$this->ajaxReturn($result);
    	}else{
    		$this->ajaxReturn(false);
    	}
    }
    /**
     * 视频附件上传
     */
    public function attach_upload_video(){
    	$post 		   = I('post.');
    	if($post['image'] == 1){
    		$path 	   			= fileuploadOne($_FILES['file']); //上传封面图
    		$post['path_thumb'] = $path;
    		$post['ctime'] 		= date('Y-m-d');
    		$post['ext']   		= substr($post['file_name'],strrpos($post['file_name'],'.')+1,strlen($post['file_name']));;
    		if(self::$attach->create($post)){
    			$result = self::$attach->add();
    			self::jump($result, 'attach');
    		}else{
    			self::jump(false, 'attach');
    		}
    	}else{
    		//视频文件太大，分片上传后在合并视频 这里限定只能上传MP4格式
    		$v_path  = fileuploadOne($_FILES['file_data']);
    		//上传根目录
    		$public	 = './Public/';
    		$av_path = $public.'upload/'.date('Ymd').'/'.date('Ymd');
    		//文件路径(上传成功后分片文件路径名多了个“.”)
    		$path 	 = $public.substr($v_path,0,strlen($v_path)-1);
    		//循环获取分片中的内容并追加到新的文件里,同时删除临时文件
    		$con   	 = file_get_contents($path);
    		$res     = file_put_contents($av_path, $con,FILE_APPEND);
    		if($res) unlink($path);
    		
    		$total   = isset($post['file_total']) ? $post['file_total'] : 0; //总片数
    		$index   = isset($post['file_index']) ? $post['file_index'] : 0; //当前片数
    		//当前片数等于总片时改名文件上传完成
    		if($index == $total){
    			//上传子目录文件名
    			$child   = 'upload/'.date('Ymd').'/'.time() . mt_rand(100, 999);
    			//文件后缀
    			$ext = substr($post['file_name'],strrpos($post['file_name'],'.'),strlen($post['file_name'])); 
    			rename($av_path, $public.$child.$ext); //文件改名
    			$post['path']  = $child.$ext;
    			$this->ajaxReturn($post);
    		}else{
    			$this->ajaxReturn($index);
    		}
    		//视频上传完返回
    	}
    }
    /**
     * 附件编辑
     * $status 1.添加，2.编辑
     */
    public function attedit($status){
    	$id = self::$get['id'];
    	if(IS_POST){
			$post = I('post.');
			if(empty($post['id']))
				self::jump(false, 'attachment/attedit',['status'=>$status],'请上传附件');
			
			$path = fileuploadOne($_FILES['image']);
			$post['path_thumb'] = $path ? $path : ''; 
			
			$res = self::$attach->save($post);
			self::jump($res, 'attachment/attach');
    	}else{
    		if($status == 2){
    			self::$attach->find($id);
    		}
    		$this->assign('status',$status);
    		$this->display();
    	}
    }
    /**
     * 附件删除
     */
    public function attdel(){
    	$id  = I('request.id');
    	$ids = $id;
    	if(is_array($id)){
    		$id = implode(',', $id);
    	}
    	$res = self::$attach->where('id in ('.$id.')')->save(['isdel'=>1]);
    	Log::write('attachment', $ids, 3);
    	//放入回收站
    	$ret = recover_delete('attachment', '附件表', $ids);
    	self::jump($ret, 'attachment/attach');
    }
    /**
     * 附件删除(AJAX)
     */
    public function attach_delete(){
    	$id  = I('post.id');
    	if(empty($id)) $this->ajaxReturn(false);
    	$res = self::$attach->where('id = '.$id)->delete();
    	$this->ajaxReturn($res);
    }
}