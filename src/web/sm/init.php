<?php

	if(!isset($GLOBALS['root'])) {
	 	$root = getRootURL();
	}

	function getCurPageURL() {
		# TODO https?
		$pageURL = 'http';
		if($_SERVER["SERVER_PORT"] == "443") {
			$pageURL .= "s";
		}
		$pageURL .= "://";
		
		$pageURL .= $_SERVER["SERVER_NAME"].$_SERVER["REQUEST_URI"];	
		return $pageURL;
	}

	function getRootURL() {
		$pageURL = 'http';
		if($_SERVER["SERVER_PORT"] == "443") {
			$pageURL = $pageURL . "s";
		}
		$pageURL .= "://";
		
		$pageURL .= $_SERVER["SERVER_NAME"];
		return $pageURL . "/sm/";
	}
?>