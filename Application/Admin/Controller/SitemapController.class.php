<?php
namespace Admin\Controller;
use Admin\Common\AdminBaseController;
use Admin\Common\Sitemap;
use Think\Page;
use Admin\Common\Log;
class SitemapController extends AdminBaseController {
    private static $sitemap;
	public function _initialize(){
        parent::_initialize();
        self::$sitemap = M('sitemap');
    }
    /**
     * 生成网站地图，并在根目录下生成sitemap.xml文件
     */
    public function index(){
        $site = new Sitemap();
        $info = self::$sitemap->where('isdel = 0 and sites = 1')->select();
        foreach($info as $val){
	        $site->AddItem($val['url'], 1);
        }
        $site->SaveToFile('sitemap.xml');
        
        $this->assign('info',$info);
        $this->display();
    }
    /**
     * 网站地图列表
     */
    public function sitelist(){
    	$count = self::$sitemap->where('isdel = 0')->count();
    	$page  = new Page($count,10);
    	$info  = self::$sitemap->where('isdel = 0')->limit(mypage($page))->order('id asc')->select();
    	$this->assign('info',$info);
    	$this->assign('page',$page->show());
    	$this->display();
    }
    /**
     * 地图编辑，添加
     * @param int $status 1.添加，2.编辑
     */
    public function siteedit($status){
    	$id = I('request.id');  //主键id
    	if(IS_POST){
    		$post = I('post.');
    		if($post['type'] == 1){
    			$post['ctime'] = date('Y-m-d H:i:s');
    			if(self::$sitemap->create($post)){
    				$res = self::$sitemap->add();
    				Log::write('sitemap', $res, 1);
    			}
    		}else{
    			$logid = Log::update('sitemap', $post['id'], 2);
    			$res   = self::$sitemap->save($post);
    			Log::write('sitemap', $post['id'], 2, $logid);
    		}
    		self::jump($res, 'sitemap/sitelist');
    	}else{
    		if($status == 2){
    			$info = self::$sitemap->find($id);
    			$this->assign('info',$info);
    		}
    		$this->assign('status',$status);
    		$this->display();
    	}
    }
    /**
     * 地图删除 软删除
     */
    public function sitedel(){
    	$id  = I('request.id');
    	$ids = $id;
    	if(is_array($id)){
    		$id = implode(',', $id);
    	}
    	self::$sitemap->where('id in ('.$id.')')->save(['isdel'=>1]);
    	Log::write('sitemap', $ids, 3);
    	//回收
    	$ret = recover_delete('sitemap', '网站地图', $ids);
    	self::jump($ret, 'sitemap/sitelist');
    }
}