<?php
$url=$_SERVER['DOCUMENT_ROOT'].$_REQUEST['url'];
//2016.11.7  删除图片
if($_REQUEST['action']=='delete'){
	echo delete_file($url);
}else if($_REQUEST['action']=='file_delete'){
	if($_REQUEST['file']==1){
		//删除目录即旗下的所有文件
		echo delete_dir($url);
	}else{
		//删除文件
		echo delete_file($url);
	}
}
//删除目录即旗下的所有文件
function delete_dir($url){
	if($dir=opendir($url)){
		while(($item=readdir($dir)) !== false){
			if($item!='.' && $item!='..'){
				if(is_dir($url.'/'.$item)){
					delete_dir($url);
				}else{
					unlink($url.'/'.$item);
				}
			}
		}
		closedir($dir);
		$res=rmdir($url);
	}
	return $res?1:0;
}
//删除文件非文件夹
function delete_file($url){
	if(file_exists($url)){
		$result=unlink($url);
		if($result){
			$res=1;	
		}else{
			$res=0;
		}
	}else{
		$res=0;
	}
	return $res;
}