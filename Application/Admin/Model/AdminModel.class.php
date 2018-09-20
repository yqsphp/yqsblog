<?php
namespace Admin\Model;
use Think\Model;
use Think\Verify;
use Admin\Common\Tree;
class AdminModel extends Model{
    /**
     * 登陆检测
     * @param 验证码 $code
     * @param 用户名 $pass
     * @param 密码 $pass
     * @return string
     */
    public  function login($code,$name,$pass){
        //0.密码错误 1.验证通过 2.验证码错误 3.账号错误 4.用户已禁用
        $verify = new Verify();
        if($verify->check($code)){
            $info = $this->getByName($name);
            if($info != null){
                if($info['status'] == 0) return 4;
                //session_set_cookie_params(3600); //设置session生命周期
            	session('user_info',['user_name'=>$name,'user_pass'=>$pass,'user_id'=>$info['id']]);
                //session_regenerate_id(true); //设置session生命周期后，时间过去在清空session
                
                //保存登录ip和时间
                $ups=['id'=>$info['id'],'lastip'=>get_client_ip(),'lasttime'=>date('Y-m-d H:i:s')];
                $this->save($ups);
                return $info['pass'] == md5(base64_encode($pass)) ? 1 : 0;
                
                
            }else{
                return 3;
            }
        }else{
            return 2;
        }
    }
    /**
     * 不用验证验证码的登陆
     * @param string $name
     * @param string $pass
     * @return number
     */
    public function login1($name,$pass){
        $info = $this->getByName($name);
        if($info != null){
            if($info['status'] == 0) return 4;
            session_set_cookie_params(3600); //设置session生命周期
            session('user_info',['user_name'=>$name,'user_pass'=>$pass,'user_id'=>$info['id']]);
          	session_regenerate_id(true); //设置session生命周期后，时间过去在清空session
            //保存登录ip和时间
            $ups=['id'=>$info['id'],'lastip'=>get_client_ip(),'lasttime'=>date('Y-m-d H:i:s',time())];
            $this->save($ups);
            return $info['pass'] == md5(base64_encode($pass)) ? 1 : 0;
        }else{
            return 3;
        }
    }
    /**
     * 菜单权限
     * @param array $group 登陆用户所在组的信息
     * $group=array('uid'=>'用户','group_id'=>'用户组id','title'=>'用户组名','rules'=>'用户组权限(1,2,3,...)');
     * @return array|boolean
     */
    public function nav($group){
        if(empty($group)) return false;
        $data	= D('AuthRule')->select();
        $data	= Tree::tree($data);
        //获取用户所在组
        //将权限转换成数组
        $ids	= explode(',', $group['rules']);
        $nav	= array(); //一级菜单
        $second	= array(); //二级菜单
        $third	= array(); //三级菜单
        foreach($data as $val){
            if(in_array($val['id'], $ids) && $val['status'] == 1){
                if($val['_level'] == 1){
                    $nav[]    = $val;
                }elseif($val['_level'] == 2){
                    $second[] = $val;
                }else{
                    $third[]  = $val;
                }
            }

        }
        return array('nav'=>$nav,'second'=>$second,'third'=>$third);
    }
}