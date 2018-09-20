<?php
namespace Admin\Controller;
use Admin\Model\ArticleModel;
use Admin\Common\AdminBaseController;
use Admin\Common\Tree;
class ArticleController extends AdminBaseController{
	private static $art;
	private static $cat;
    public function _initialize(){
        parent::_initialize();
        self::$art = new ArticleModel();
        self::$cat = D('Category');
    }
    /**
     * 文章显示列表
     */
    public function artlist(){
    	$get = self::$get;
        //文章查询
    	$get = self::get_fillter($get);
        if(empty($get)){
            $info = self::$art->info(2);
	        }else{
            $info = self::$art->info(2,$get);
            $this->assign('get',$get); //查询条件
        }
        $cat = Tree::tree($info['cat'],'name');
        $this->assign('list',$info['info']);
        $this->assign('page',$info['page']);
        $this->assign('cat',$cat);
        $this->display();
    }
    /**
     * 添加文章信息
     */
    public function artedit(){
        $status = I('request.status');
        $id		= I('request.id');
        $post   = I('post.');
        if(IS_POST){
            if($status == 1){//添加文章
                $res = self::$art->artedit('',$post,$_FILES['image']);
            }else{//编辑文章
                $res = self::$art->artedit($id,$post,$_FILES['image']);
            }
            self::jump($res, 'Article/artlist');
        }else{
            if($status == 1){//添加文章
                $this->assign('status',1);
            }else{//编辑文章
                $info = self::$art->artedit($id);
                $this->assign('status',2);
                $this->assign('id',$id);
                $this->assign('info',$info);
            }
            $catinfo = self::$art->catedit(2);
            //分类列表
            $this->assign('parent',$catinfo['parent']);
            $this->assign('child',$catinfo['child']);
            $this->display();
        }
    }
    /**
     * 文章发布
     */
    public function artpublish(){
    	$get = self::$get;
        $id  = I('request.id');
        if(!empty($id)){
            if(IS_POST) $id	= I('post.id'); //是否是post提交
            $status = I('request.status');
            $edit   = I('request.edit'); //编辑之后提交的数据
            $res    = self::$art->artpublish($status,$id);
            //判断是否是编辑之后提交的数据
            if(empty($edit)){
            	self::jump($res, 'Article/artpublish');
            }else{
            	self::jump($res, 'Article/artlist');
            }
        }else{
        	$get = self::get_fillter($get);
            if(empty($get)){
                $info = self::$art->info();
            }else{
                $info = self::$art->info($get['status'],$get);
                $this->assign('get',$get); //查询条件
            }
            $cat = Tree::tree($info['cat'],'name');
            $this->assign('list',$info['info']);
            $this->assign('page',$info['page']);
            $this->assign('cat',$cat);
            $this->display();
        }
    }
    /**
     * 设置文章置顶，推荐
     */
    public function settop(){
    	if(IS_AJAX){
    		$post = I('post.');
    		$res  = self::$art->save($post);
    		//$res = self::$art->_sql();
    		$this->ajaxReturn($res);
    	}
    }
    /**
     * 删除文章
     */
    public function artdel(){
        $id = I('request.id');
        if(IS_POST){
            $id = $_POST['id'];
        }
        $res = self::$art->artdel($id);
        self::jump($res, 'Article/artlist');
    }
    /**
     * 文章排序操作
     */
    public function artsort(){
    	$sort = I('post.sort');
    	$id   = I('post.id');
    	$res  = self::$art->where('id = '.$id)->save(['order'=>$sort]);
    	echo $res;
    }
    /*---------------------------------------类别列表--------------------------------------------------*/
    /**
     * 类别显示列表
     */
    public function catlist(){
        $catinfo = self::$art->cate();
        //使用树形结构
        $info	 = Tree::tree($catinfo,'name');
        $this->assign('catlist',$info);
        //未使用
        /* $this->assign('catlist',$catinfo['info']);
        $this->assign('page',$catinfo['page']); */
        $this->display();
    }
    /**
     * 类别管理：添加，修改
     * 状态 $status 1.添加，2.修改
     * 类别id $id
     */
    public function catedit($status,$id) {
        if(IS_POST){
           if($status == 1){
               $res = self::$art->catedit($status,$_POST);
           }else{
               $res = self::$art->catedit($status,$_POST,$id);
           }
           self::jump($res, 'Article/catlist');
        }else{
            if($status == 1){//添加
                //数据显示
                $catinfo = self::$art->catedit($status);
                $this->assign('status',1);
            }else{//编辑
                $catinfo = self::$art->catedit($status,'',$id);
                $this->assign('status',2);
                $this->assign('id',$id);
            }
            $this->assign('parent',$catinfo['parent']);
            $this->assign('info',$catinfo['info']);
            $this->display();
        }
    }
    /**
     * 类别删除
     */
    public function catdel(){
        $id  = I('request.id');
        $res = self::$art->catdel($id);
        self::jump($res, 'Article/catlist');
    }
    /**
     * 类别终端显示操作（ajax）
     */
    public function setup(){
    	if(IS_AJAX){
    		$post = I('post.');
    		$res  = self::$cat->save($post);
    		$this->ajaxReturn($res);
    	}
    }
}