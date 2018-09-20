<?php
use Org\Nx\Sms;
/**
 * 分页定制
 *
 * @param object $page
 *        	分页对象
 */
function mypage($page){
	/*
	 * $page->setConfig('header', '<li class="rows">共<b>%TOTAL_ROW%</b>条记录&nbsp;第<b>%NOW_PAGE%</b>页/共<b>%TOTAL_PAGE%</b>页</li>');
	 * $page->setConfig('prev', '上一页');
	 * $page->setConfig('next', '下一页');
	 * $page->setConfig('last', '末页');
	 * $page->setConfig('first', '首页');
	 * $page->setConfig('theme', '%FIRST%%UP_PAGE%%LINK_PAGE%%DOWN_PAGE%%END%%HEADER%');
	 */
	$page->setConfig('prev', '上一页');
	$page->setConfig('next', '下一页');
	$page->setConfig('first', '首页');
	$page->setConfig('last', '尾页');
	$page->setConfig('theme', '%FIRST%%UP_PAGE%%LINK_PAGE%%DOWN_PAGE%%END%%HEADER%');
	return $page->firstRow . "," . $page->listRows;
}
/**
 * 带跳转指定页分页
 *
 * @param object $page        	
 * @return string
 */
function mypageone($page){
	/*
	 * $page->setConfig('header', '<li class="rows">共<b>%TOTAL_ROW%</b>条记录&nbsp;第<b>%NOW_PAGE%</b>页/共<b>%TOTAL_PAGE%</b>页</li>');
	 * $page->setConfig('prev', '上一页');
	 * $page->setConfig('next', '下一页');
	 * $page->setConfig('last', '末页');
	 * $page->setConfig('first', '首页');
	 * $page->setConfig('theme', '%FIRST%%UP_PAGE%%LINK_PAGE%%DOWN_PAGE%%END%%HEADER%');
	 */
	//判断终端
	$parme	= $_SERVER['HTTP_USER_AGENT'];
	$pex	= "/NetFront|iPhone|MIDP-2.0|UCWEB|Android|Opera Mini|Windows CE|SymbianOS|iPad/i";
	//移动端使用简单的分页
	if(preg_match($pex, $parme)){
		$page->setConfig('prev', '上页');
		$page->setConfig('next', '下页');
		// $page->setConfig('first', '首页');
		// $page->setConfig('last', '尾页');
		$page->setConfig('theme', '%UP_PAGE%%LINK_PAGE%%DOWN_PAGE%');
		return $page->firstRow . "," . $page->listRows;
	}
	
	$url	= $_SERVER['REQUEST_URI'];
	if(strpos($url, 'p/') !== false){
		$url = substr($url, 0, strpos($url, 'p/')+2);
	}else{
		$url = substr($url, 0, strrpos($url, '.')).'/p/';
	}
	$script = <<<eof
		<span class="rows">
			<input id="pageVal" />
			<button id="pageGo">GO</button>
		</span>
		<span class="count">
			共<b>%TOTAL_ROW%</b>条记录&nbsp;第<b>%NOW_PAGE%</b>页/共<b>%TOTAL_PAGE%</b>页
		</span>
		<script>
		document.getElementById("pageGo").onclick=function(){
			var val = document.getElementById("pageVal").value;
			location.href="{$url}"+val+".html";
		}
		</script>
eof;
	//$page->setConfig('header', '<span class="rows"><input id="pageVal" /><button id="pageGo">GO</button></span><span class="count">共<b>%TOTAL_ROW%</b>条记录&nbsp;第<b>%NOW_PAGE%</b>页/共<b>%TOTAL_PAGE%</b>页</span>');
	$page->setConfig('header', $script);
	$page->setConfig('prev', '上一页');
	$page->setConfig('next', '下一页');
	$page->setConfig('first', '首页');
	$page->setConfig('last', '尾页');
	$page->setConfig('theme', '%FIRST%%UP_PAGE%%LINK_PAGE%%DOWN_PAGE%%END%%HEADER%');
	return $page->firstRow . "," . $page->listRows;
}

/**
 * 移动端分页定制
 * * @param object $page
 * 分页对象
 */
function mypageMobile($page){
	$page->setConfig('prev', '上页');
	$page->setConfig('next', '下页');
	// $page->setConfig('first', '首页');
	// $page->setConfig('last', '尾页');
	$page->setConfig('theme', '%UP_PAGE%%LINK_PAGE%%DOWN_PAGE%');
	return $page->firstRow . "," . $page->listRows;
}
/**
 * 文件下载方法
 * 文件路径 $filePath
 */
function download($filePath){
	// $filePath=iconv('UTF-8','GB2312//IGNORE',$filePath);
	// 获取文件路径
	// echo $filePath;
	// 判断文件是否存在file_exists
	if(! file_exists($filePath)){
		echo '文件不存在';
		exit();
	}
	$filePath = str_replace('\\', '/', $filePath);
	// echo $filePath;
	// 文件后缀名
	$pofix = strrchr($filePath, '.');
	if(in_array($pofix, ['.jpg','.png','.gif','.jpeg' ])){
		$fileName = time() . mt_rand(1, 1000) . $pofix;
	}else{
		$fileName = str_replace('/', '', strrchr($filePath, '/'));
	}
	
	// echo $fileName;
	// exit();
	
	// 打开文件
	ob_clean(); // 清除缓存
	$fp = fopen($filePath, 'r');
	// 获取文件大小
	$fileSize = filesize($filePath);
	// 可以定义文件超过指定大小不提供下载
	/*
	 * if($fileSize>16*1024*1024){
	 * echo '<script>alert('文件过大，不提供下载');</script>';
	 * return;
	 * }
	 */
	// 返回二进制流的文件
	header('Content-type:application/octet-stream');
	// 返回文件大小
	header('Accpet-Length:' . $fileSize);
	// 客户端弹出下载对话框，对应文件下载名
	header('Content-Disposition:attachment; filename=' . $fileName);
	// 向客户端回送数据
	$buffer = 1024; // 每次回送1024个字节
	                // 为了下载安全，我们最好做一个文件字节读取器 建议加上
	$fileCount = 0;
	// 判断文件是否结束 feof( end of file 文件结束大小)
	while(! feof($fp) && ($fileSize - $fileCount > 0)){
		$fileRead = fread($fp, $buffer);
		// 统计读了多少个字节
		$fileCount += $buffer;
		echo $fileRead;
	}
	// 关闭文件
	fclose($fp);
}

/**
 * 单文件文件上传
 *
 * @param string $file
 *        	$_FILES
 * @return array
 */
function fileuploadOne($file = []){
	$conf = array(
	'rootPath' => C('ROOTPATH'),
	'savePath' => C('SAVEPATH'),
	'saveName' => C('SAVENAME'),
	'subName' => C('SUBNAME') 
	);
	if(empty($file)){
		foreach($_FILES as $val){
			$file = $val;
			continue;
		}
	}
	
	$upload = new Think\Upload($conf);
	$res = $upload->uploadOne($file);
	return $res ? $res['savepath'] . $res['savename'] : '';
}

/**
 * 多文件上传
 *
 * @return array
 */
function fileupload(){
	$conf = array(
	'rootPath' => C('ROOTPATH'),
	'savePath' => C('SAVEPATH'),
        /* 'saveName' =>  C('SAVENAME'), *///这样设置后多文件上传有bug，成功上传的文件只是第一个
        'subName' => C('SUBNAME') 
	);
	$upload = new Think\Upload($conf);
	return $upload->upload();
}

/**
 * 格式化字节大小
 *
 * @param number $size
 *        	字节数
 * @param string $delimiter
 *        	数字和单位分隔符
 * @return string 格式化后的带单位的大小
 */
function format_bytes($size, $delimiter = ''){
	$units = array(
	'B',
	'KB',
	'MB',
	'GB',
	'TB',
	'PB' 
	);
	for($i = 0; $size >= 1024 && $i < 5; $i ++)
		$size /= 1024;
	return round($size, 2) . $delimiter . $units[$i];
}

/**
 * 图片处理 缩略图
 *
 * @param unknown $filepath        	
 * @param unknown $imgname        	
 */
function imageHandle($filepath, $imgname){
	$img = new Think\Image();
	$img->open($filepath);
	$img->thumb(450, 450)->save('thumb_' . $imgname);
}

/**
 * 文件打包
 *
 * @param string $path
 *        	文件路径
 * @param string $ext
 *        	压缩文件后缀名
 * @return string 打包后的路径
 */
function zipActive($path, $ext = '.zip'){
	$zip = new ZipArchive();
	if($zip->open($path . $ext, ZIPARCHIVE::CREATE) === true){
		echo 'true';
		zipHandle($path, $zip);
	}else{
		echo 'false';
	}
	$zip->close();
	
	/*
	 * //判断文件是否存在
	 * if(file_exists($path.$ext)){
	 * if ($zip->open($path . $ext, ZIPARCHIVE::OVERWRITE) == true) {
	 * //echo true;
	 * zipHandle($path, $zip);
	 * } else {
	 * echo false;
	 * }
	 * $zip->close();
	 * }else{
	 * //看看是windows还是linux系统
	 * if(strpos($_SERVER['SYSTEMROOT'], 'Windows') !== false){
	 * $path = iconv("UTF-8", "GBK//IGNORE", $path);
	 * }
	 *
	 * if($zip->open($path . $ext, ZIPARCHIVE::CREATE) === true){
	 * zipActive($path ,$ext);
	 * }
	 * }
	 */
	return $path . $ext;
}

/**
 * 文件夹目录下文件打包zip操作
 *
 * @param string $directory
 *        	文件夹路径
 * @param object $zip
 *        	ZipArchive对象
 */
function zipHandle($directory, ZipArchive $zip){
	$op = opendir($directory);
	while(($file = readdir($op)) !== false){
		if($file != '.' && $file != '..'){
			$fullpath = $directory . '/' . $file;
			if(is_dir($fullpath)){
				zipHandle($fullpath);
			}else{
				$zip->addFile($fullpath, $file); // 将文件加入到zip对象
			}
		}
	}
	closedir($op);
}

/**
 * 清除数据缓存
 *
 * @param $dir 缓存路径(清空runtime)        	
 */
function clear($dir){
	$op = opendir($dir);
	while(($file = readdir($op)) !== false){
		if($file != '.' && $file != '..'){
			$fullpath = $dir . '/' . $file;
			if(is_dir($fullpath)){
				clear($fullpath);
			}else{
				unlink($fullpath);
			}
		}
	}
	closedir($op);
	return rmdir($dir) ? true : false;
}

/**
 * 数据库备份文件信息
 *
 * @param string $dir
 *        	文件路径
 * @return multitype:string 备份文件名称
 */
function sqlinfo($dir){
	$op = opendir($dir);
	$fileinfo = array();
	$i = 0;
	while(($file = readdir($op)) !== false){
		if($file != '.' && $file != '..'){
			$fileinfo[$i]['name'] = $file;
			$fileinfo[$i]['size'] = ceil(filesize($dir . '/' . $file) / 1024);
			$fileinfo[$i]['time'] = date('Y-m-d H:i:s', filemtime($dir . '/' . $file));
		}
		++ $i;
	}
	return $fileinfo;
}

/**
 * 随机字符串
 *
 * @param int $len
 *        	长度
 * @return string
 */
function subchar($len, $key = ''){
	if($key == ''){
		$char = 'ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz0123456789';
	}else{
		$char = '0123456789';
	}
	for($i = 0; $i < $len; ++ $i){
		$rand .= $char[rand(0, strlen($char) - 1)];
	}
	return $rand;
}

/**
 * 滑动验证码检测
 * geetest检测验证码
 */
function geetest_chcek_verify($data){
	$geetest_id = C('GEETEST_ID');
	$geetest_key = C('GEETEST_KEY');
	$geetest = new Admin\Common\Geetest($geetest_id, $geetest_key);
	$user_id = session('user_id');
	if($_SESSION['geetest']['gtserver'] == 1){
		$result = $geetest->success_validate($data['geetest_challenge'], $data['geetest_validate'], $data['geetest_seccode'], $user_id);
		if($result){
			return true;
		}else{
			return false;
		}
	}else{
		if($geetest->fail_validate($data['geetest_challenge'], $data['geetest_validate'], $data['geetest_seccode'])){
			return true;
		}else{
			return false;
		}
	}
}

// 日志
function traceHttp($trace){
	file_put_contents("log.txt", date('Y-m-d H:i:s') . '-' . $trace . PHP_EOL, FILE_APPEND);
}

/**
 * 生成二维码
 *
 * @param string $url
 *        	url连接
 * @param integer $size
 *        	尺寸 纯数字
 */
function qrcode($url, $size = 4){
	vendor('Phpqrcode.phpqrcode');
	QRcode::png($url, false, QR_ECLEVEL_L, $size, 2, false, 0xFFFFFF, 0x000000);
}

/**
 * 生成pdf
 *
 * @param string $html
 *        	需要生成的内容
 */
function pdf($html = ''){
	vendor('Tcpdf.tcpdf');
	$pdf = new \TCPDF(PDF_PAGE_ORIENTATION, PDF_UNIT, PDF_PAGE_FORMAT, true, 'UTF-8', false);
	// 设置打印模式
	$pdf->SetCreator(PDF_CREATOR);
	$pdf->SetAuthor('Nicola Asuni');
	$pdf->SetTitle('TCPDF Example 001');
	$pdf->SetSubject('TCPDF Tutorial');
	$pdf->SetKeywords('TCPDF, PDF, example, test, guide');
	// 是否显示页眉
	$pdf->setPrintHeader(false);
	// 设置页眉显示的内容
	$pdf->SetHeaderData('logo.png', 60, 'xxx.com', 'xxxblog', array(
	0,
	64,
	255 
	), array(
	0,
	64,
	128 
	));
	// 设置页眉字体
	$pdf->setHeaderFont(Array(
	'dejavusans',
	'',
	'12' 
	));
	// 页眉距离顶部的距离
	$pdf->SetHeaderMargin('5');
	// 是否显示页脚
	$pdf->setPrintFooter(true);
	// 设置页脚显示的内容
	$pdf->setFooterData(array(
	0,
	64,
	0 
	), array(
	0,
	64,
	128 
	));
	// 设置页脚的字体
	$pdf->setFooterFont(Array(
	'dejavusans',
	'',
	'10' 
	));
	// 设置页脚距离底部的距离
	$pdf->SetFooterMargin('10');
	// 设置默认等宽字体
	$pdf->SetDefaultMonospacedFont(PDF_FONT_MONOSPACED);
	// 设置行高
	$pdf->setCellHeightRatio(1);
	// 设置左、上、右的间距
	$pdf->SetMargins('10', '10', '10');
	// 设置是否自动分页 距离底部多少距离时分页
	$pdf->SetAutoPageBreak(TRUE, '15');
	// 设置图像比例因子
	$pdf->setImageScale(PDF_IMAGE_SCALE_RATIO);
	$l = dirname(__FILE__) . '/lang/eng.php';
	if(@file_exists($l)){
		require_once $l;
		$pdf->setLanguageArray($l);
	}
	$pdf->setFontSubsetting(true);
	$pdf->AddPage();
	// 设置字体
	$pdf->SetFont('stsongstdlight', '', 14, '', true);
	$pdf->writeHTMLCell(0, 0, '', '', $html, 0, 1, 0, true, '', true);
	$pdf->Output('example_001.pdf', 'I');
}

/**
 * 发送短信
 *
 * @param string $to
 *        	接收短信号码
 * @param array $data
 *        	发送类容 ['title','content']
 */
function sendsms($to, $data){
	import('Org\Nx');
	$send = new Sms(C('sms_require'), C('sms_port'), C('sms_version'));
	$send->setAccount(C('sms_account'), C('sms_token'));
	$send->setAppId(C('sms_appid'));
	$result = $send->sendTemplateSMS($to, $data, C('sms_tempid'));
	if($result == null){
		$code = [
		'code' => 500,
		'message' => '发送失败' 
		];
	}
	if($result->statusCode != 0){
		$code = [
		'code' => $result->statusCode,
		'message' => $result->statusMsg 
		];
	}else{
		$code = [
		'code' => 200,
		'message' => '发送成功' 
		];
	}
	return $code;
}

/**
 * excel文件导出
 *
 * @param array $data
 *        	需要生成excel文件的数组
 * @param string $filename
 *        	生成的excel文件名
 *        	示例数据：
 *        	$data = array(
 *        	array(NULL, 2010, 2011, 2012),
 *        	array('Q1', 12, 15, 21),
 *        	array('Q2', 56, 73, 86),
 *        	array('Q3', 52, 61, 69),
 *        	array('Q4', 30, 32, 0),
 *        	);
 */
function export_excel($data, $title = '', $filename = '*.xls'){
	set_time_limit(0);
	Vendor('PHPExcel.PHPExcel');
	$filename = $filename . '.xls';
	$phpexcel = new PHPExcel();
	$phpexcel->getProperties()->setCreator("Maarten Balliauw")->setLastModifiedBy("Maarten Balliauw")->setTitle("Office 2007 XLSX Test Document")->setSubject("Office 2007 XLSX Test Document")->setDescription("Test document for Office 2007 XLSX, generated using PHP classes.")->setKeywords("office 2007 openxml php")->setCategory("Test result file");
	// 标题设置
	if(! empty($title)){
		$cellKey = [
		'A',
		'B',
		'C',
		'D',
		'E',
		'F',
		'G',
		'H',
		'I',
		'J',
		'K',
		'L',
		'M',
		'N',
		'O',
		'P',
		'Q',
		'R',
		'S',
		'T',
		'U',
		'V',
		'W',
		'X',
		'Y',
		'Z',
		'AA',
		'AB',
		'AC',
		'AD',
		'AE',
		'AF',
		'AG',
		'AH',
		'AI',
		'AJ',
		'AK',
		'AL',
		'AM',
		'AN',
		'AO',
		'AP',
		'AQ',
		'AR',
		'AS',
		'AT',
		'AU',
		'AV',
		'AW',
		'AX',
		'AY',
		'AZ' 
		];
		$phpexcel->getActiveSheet()->mergeCells('A1:' . $cellKey[count($data[0]) - 1] . '1')-> // 合并指定列
getStyle('A1')->getFont()->setBold(true)->setSize(20);
		$phpexcel->getActiveSheet()->freezePane('A3'); // 冻结窗口
		$phpexcel->setActiveSheetIndex(0)->setCellValue('A1', $title); // 设置标题
		$phpexcel->getActiveSheet()->getRowDimension(1)->setRowHeight(50); // 设置标题行高
		$phpexcel->getActiveSheet()->getStyle('A1')->getAlignment()->setHorizontal(PHPExcel_Style_Alignment::HORIZONTAL_CENTER)-> // 水平居中
setVertical(PHPExcel_Style_Alignment::VERTICAL_CENTER); // 垂直居中
		
		$phpexcel->getActiveSheet()->getRowDimension(2)->setRowHeight(30); // 设置表头行高
		$phpexcel->getActiveSheet()->getStyle('2')->getFont()->setBold(true)->setSize(15);
		$phpexcel->getActiveSheet()->getStyle('2')->getAlignment()->setHorizontal(PHPExcel_Style_Alignment::HORIZONTAL_CENTER)-> // 水平居中
setVertical(PHPExcel_Style_Alignment::VERTICAL_CENTER); // 垂直居中
		$phpexcel->getActiveSheet()->fromArray($data, null, 'A2'); // formArray(填充的数据,列值为空默认填充空,从第几行开始)
	}else{
		$phpexcel->getActiveSheet()->fromArray($data);
	}
	//
	
	$phpexcel->getActiveSheet()->setTitle('Sheet1');
	// 默认表格样式居中
	$phpexcel->getActiveSheet()->getDefaultStyle()->getAlignment()->setHorizontal(PHPExcel_Style_Alignment::HORIZONTAL_CENTER);
	
	$len = [];
	foreach($data[0] as $val){
		array_push($len, strlen($val) + 8);
	}
	for($i = 0; $i < count($data[0]); $i ++){
		$phpexcel->getActiveSheet()->getColumnDimension($cellKey[$i])->
		// ->setAutoSize(true); //设置列宽自适应
		setWidth($len[$i]);
	}
	// $phpexcel->getActiveSheet()->getColumnDimensions()->setAutoSize(true); //md 还报错，getColumnDimensions
	// dump($a);die;
	// 合并指定列
	// $phpexcel->getActiveSheet()->mergeCells('A1:R1');
	// $phpexcel->setActiveSheetIndex(0);
	header('Content-Type: application/vnd.ms-excel');
	header('Content-Disposition: attachment;filename=' . $filename);
	header('Cache-Control: max-age=0');
	header('Cache-Control: max-age=1');
	header('Expires: Mon, 26 Jul 1997 05:00:00 GMT'); // Date in the past
	header('Last-Modified: ' . gmdate('D, d M Y H:i:s') . ' GMT'); // always modified
	header('Cache-Control: cache, must-revalidate'); // HTTP/1.1
	header('Pragma: public'); // HTTP/1.0
	$objwriter = PHPExcel_IOFactory::createWriter($phpexcel, 'Excel5');
	$objwriter->save('php://output');
	exit();
}
/**
 * 发送邮件
 *
 * @param mixed $send_to
 *        	收件人邮箱 数组，或字符串
 * @param string $send_form
 *        	发件人邮箱
 * @param string $send_theme
 *        	主题
 * @param string $send_message
 *        	内容
 * @param array $send_attach
 *        	附件
 *        	包括附件地址，附件全名（包括后缀）
 *        	[['path'=>附件地址,'name'=>附件名称（包括后缀）]]
 * @param string $send_cc
 *        	抄送人
 * @param string $send_bcc
 *        	密送人
 * @return array $result
 */
function send_mail($send_to, $send_form, $send_theme, $send_message, $send_attach = [], $send_cc = [], $send_bcc = []){
	$server_smpt = C('mail_smtp_server');
	$server_port = C('mail_smtp_port');
	$server_secure = C('mail_smpt_secure');
	$server_user = C('mail_smtp_server_user');
	$server_pass = C('mail_smtp_server_pass');
	$server_type = C('mail_smpt_type');
	
	vendor('PHPMailer.PHPMailerAutoload');
	$phpmailer = new PHPMailer();
	
	// $phpmailer->SMTPDebug = 1; //发送调试
	
	$phpmailer->IsSMTP(); // 设置PHPMailer使用SMTP服务器发送Email
	$phpmailer->IsHTML(true); // 设置为html格式
	                             // $phpmailer->setLanguage('zh'); // 设置语言
	$phpmailer->Host = $server_smpt; // 设置SMTP服务器。
	$phpmailer->SMTPSecure = $server_secure; // 设置设置smtp_secure
	$phpmailer->Port = $server_port; // 设置端口
	$phpmailer->CharSet = 'UTF-8'; // 设置邮件的字符编码
	$phpmailer->SMTPAuth = true; // 设置为"需要验证"
	$phpmailer->Username = $server_user; // 设置用户名
	$phpmailer->Password = $server_pass; // 设置密码
	$phpmailer->From = $server_user; // 设置邮件头的From字段
	$phpmailer->FromName = $server_user; // 设置发件人名字
	$phpmailer->Subject = $send_theme; // 设置邮件标题
	$phpmailer->Body = $send_message; // 设置邮件正文
	                                  // 添加收件人地址，可以多次使用来添加多个收件人
	if(is_array($send_to)){
		foreach($send_to as $addressv){
			$phpmailer->AddAddress($addressv);
		}
	}else{
		$phpmailer->AddAddress($send_to);
	}
	// 添加抄送人地址
	if(! empty($send_cc)){
		if(is_array($send_cc)){
			foreach($send_cc as $addcc){
				$phpmailer->addCC(addcc);
			}
		}else{
			$phpmailer->addCC($send_cc);
		}
	}
	if(! empty($send_bcc)){
		// 添加密送人地址
		if(is_array($send_bcc)){
			foreach($send_bcc as $addbcc){
				$phpmailer->addBCC($addbcc);
			}
		}else{
			$phpmailer->addBCC($send_bcc);
		}
	}
	// 添加附件
	if(! empty($send_attach)){
		foreach($send_attach as $attach){
			$phpmailer->addAttachment($attach['path'], $attach['name']);
		}
	}
	// 发送邮件。
	if(! $phpmailer->Send()){
		$result = [
		'code' => 403,
		'message' => $phpmailer->ErrorInfo 
		];
	}else{
		$result = [
		'code' => 200,
		'message' => '发送成功' 
		];
	}
	return $result;
}
/**
 * 导入excel文件
 *
 * @param string $file
 *        	excel文件路径
 * @return array excel文件内容数组
 */
function import_excel($file){
	/*
	 * // 判断文件是什么格式
	 * $type = pathinfo($file);
	 * $type = strtolower($type["extension"]);
	 * $type=$type==='csv' ? $type : 'Excel5';
	 */
	set_time_limit(0);
	Vendor('PHPExcel.PHPExcel');
	// 判断使用哪种格式
	// /$objReader = PHPExcel_IOFactory::createReader($type);
	// 简化版，直接读取文件就可以，不用判断文件格式
	$objReader = PHPExcel_IOFactory::createReaderForFile($file);
	// 设置文件为可读
	$objReader->setReadDataOnly(true);
	// 加载文件
	$objPHPExcel = $objReader->load($file);
	// 获取表格中的第几个工作表默认为第一个下标从0开始
	$sheet = $objPHPExcel->getSheet(0);
	// 取得总行数
	$highestRow = $sheet->getHighestRow();
	// 取得总列数
	$highestColumn = $sheet->getHighestColumn();
	// 循环读取excel文件,读取一条,插入一条
	$data = array();
	// 从第一行开始读取数据
	for($j = 1; $j <= $highestRow; $j ++){
		// 从A列读取数据
		for($k = 'A'; $k <= $highestColumn; $k ++){
			// 读取单元格
			$data[$j][] = $objPHPExcel->getActiveSheet()->getCell("$k$j")->getValue();
		}
	}
	return $data;
}

/**
 * 对象转数组
 *
 * @param object $obj
 *        	对象实例
 * @return array
 */
function objectToArray($obj){
	$objarray = is_object($obj) ? get_object_vars($obj) : $obj;
	foreach($objarray as $key=>$val){
		$val = (is_array($val) || is_object($val)) ? $this->objectToArray($val) : $val;
		$arr[$key] = $val;
	}
	return $arr;
}

/**
 * xml数据转数组
 *
 * @param string $xml
 *        	xml数据
 * @return array
 */
function xmlToArray($xml){
	// LIBXML_NOCDATA 合并CDATA文本节点
	$xml = simplexml_load_file($xml, 'SimpleXMLElement', LIBXML_NOCDATA);
	// json_decode(),第二个参数为true是得到的是数组，默认是对象
	return json_decode(json_encode($xml), true);
}

/**
 *
 * @deprecated array数组数据转xml,
 *             数组转xml更好的函数。xml_encode(); tp自带解析array转xml
 *             只需要输出头为xml就可以了 header('Content-type:text/xml');
 * @param array $data
 *        	数组
 * @param string $root
 *        	更节点
 * @param
 *        	string @item 子节点
 * @param boolean $flag        	
 * @return string
 */
function arrayToXML($data, $root = 'root', $item = 'item', $flag = true){
	/*
	 * header('Content-type:text/xml');
	 * $xml=xml_encode($arr,'root');
	 */
	if($flag){
		header('Content-type:text/xml');
		$xml = '<?xml version="1.0" encoding="utf-8" ?><' . $root . '>';
	}
	foreach($data as $key=>$val){
		if(is_array($val)){
			$xml .= '<item>' . arrayToXML($val, $root, $item, false) . '</item>';
		}else{
			$xml .= '<' . $key . '>' . $val . '</' . $key . '>';
		}
	}
	if($flag)
		$xml .= '</' . $root . '>';
	return $xml;
}
// 测试代码执行时间开始时间
function startTime(){
	global $start;
	$mtime = explode(' ', microtime());
	$start = $mtime[0] + $mtime[1];
}
// 结束时间
function endTime(){
	global $start, $end;
	$emite = explode(' ', microtime());
	$end = $emite[0] + $emite[1];
	$gettime = $end - $start;
	echo '执行代码所用时间：' . $gettime . '秒<br>';
}

/**
 * 获取文本中的图片
 *
 * @param string $cont
 *        	文本内容
 * @param string $all
 *        	1.all 获取所有图片，2.one 获取文本第一张图片
 *        	默认 one
 * @param boolean $tag
 *        	是否返回带有img标签的图片 true 是 ，默认 false
 * @return string 返回图片地址信息或img标签的图片 或 空
 */
function getFirstImg($cont, $all = 'one', $tag = false){
	$preg = '/<img.*src=[\"](.*?)[\"].*?>/';
	preg_match_all($preg, $cont, $res);
	if($all == 'all' && $tag == true){
		$return = $res[0];
	}elseif($all == 'all' && $tag == false){
		$return = $res[1];
	}elseif($all == 'one' && $tag == true){
		$return = $res[0][0];
	}elseif($all == 'one' && $tag == false){
		$return = $res[1][0];
	}
	
	return empty($return) ? false : $return;
}
/**
 * 获取用户真实ip地址
 */
function getIp(){
	if(getenv('HTTP_CLIENT_IP') && strcasecmp(getenv('HTTP_CLIENT_IP'), 'unknown'))
		$ip = getenv('HTTP_CLIENT_IP');
	else if(getenv('HTTP_X_FORWARDED_FOR') && strcasecmp(getenv('HTTP_X_FORWARDED_FOR'), 'unknown'))
		$ip = getenv('HTTP_X_FORWARDED_FOR');
	else if(getenv('REMOTE_ADDR') && strcasecmp(getenv('REMOTE_ADDR'), 'unknown'))
		$ip = getenv('REMOTE_ADDR');
	else if(isset($_SERVER['REMOTE_ADDR']) && $_SERVER['REMOTE_ADDR'] && strcasecmp($_SERVER['REMOTE_ADDR'], 'unknown'))
		$ip = $_SERVER['REMOTE_ADDR'];
	else
		$ip = 'unknown';
	return ($ip);
}
/**
 * 根据ip地址获取用户地理位置信息
 * 通过淘宝ip地址库查询
 *
 * @param string $ip
 *        	ip地址
 * @return array
 */
function getLocation($ip){
	// 淘宝ip地址库
	$json = file_get_contents('http://ip.taobao.com/service/getIpInfo.php?ip=' . $ip);
	$json = json_decode($json, true)['data'];
	return json_encode([
	'date' => date('Y-m-d H:i:s'),
	'ip' => $json['ip'],
	'country' => $json['country'],
	'region' => $json['region'],
	'city' => $json['city'],
	'isp' => $json['isp'] 
	], JSON_UNESCAPED_UNICODE); // JSON_UNESCAPED_UNICODE防止中文被编码
}

/**
 * 回收数据
 *
 * @param string $table
 *        	回收表名
 * @param string $notes
 *        	回收表注释
 * @param int|array $id
 *        	回收表的id
 * @return int|boolean
 */
function recover_delete($table, $notes, $id){
	$recover = D('recover');
	// 将回收的数据对应表名，主键id，添加到回收表中
	if(is_array($id)){
		foreach($id as $val){
			$data[] = [
			'name' => $table,
			'notes' => $notes,
			'reid' => $val 
			];
		}
	}else{
		$data[] = [
		'name' => $table,
		'notes' => $notes,
		'reid' => $id 
		];
	}
	$res = $recover->addAll($data);
	return $res;
}
/**
 * 设置跳转文章详情url
 *
 * @param int $cid
 *        	类别id
 * @param int $id
 *        	文章id
 * @param int $i
 *        	导航下标
 * @return string $url 处理后的url
 */
function getArticleUrl($cid, $id, $i = false){
	if($i !== false)
		$i = $i . '/';
	$url = U('/article/' . $i . $cid . '/' . $id . '/' . subchar(20));
	return $url;
}
