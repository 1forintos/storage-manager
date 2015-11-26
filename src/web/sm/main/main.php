<?php
	require_once "../db/auth.php";

	if(isset($_POST['value'])) {
		if($_POST['value'] == 'logout') {
			logout();	
		}
	} else {
		authenticate();
	}
?>