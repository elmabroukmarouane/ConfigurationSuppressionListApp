<?php
	$engine = base64_encode($_SERVER['SERVER_ADDR']);
	$arr = array('engine' => $engine);
	echo json_encode($arr);
?>
