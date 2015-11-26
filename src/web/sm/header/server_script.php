<?php
	require_once "../db/auth.php";

	if(isset($_POST['value'])) {
		if($_POST['value'] == 'logout') {
			logout();	
		} else if($_POST['value'] == 'navigate' && isset($_POST['where'])) {
			if($_POST['where'] == 'home') {				
				$url = $GLOBALS['root'] . "Home";	
				echo $url;
			}
		}
	} else {
		authenticate();
	}

	function console_log( $data ){
		echo '<script>';
		echo 'console.log('. json_encode( $data ) .')';
		echo '</script>';
	}

?>