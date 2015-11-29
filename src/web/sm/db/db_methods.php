<?php
	require_once "db/db_init.php";

	if(isset($_POST['method'])) {
		if($_POST['method'] == "loadTable") {
			loadTable($_POST['tableName']);
		}
	}

	function loadTable($tableName) {
		$ps = $GLOBALS['pdo']->prepare("
			SELECT *
			FROM ?
		");

		$ps->execute(array($tableName));
		$ps->setFetchMode(PDO::FETCH_OBJ);
		$result = $ps->fetch();
	}
?>