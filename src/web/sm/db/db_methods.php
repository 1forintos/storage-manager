<?php
	require_once "db_init.php";

	if(isset($_POST['method'])) {
		if($_POST['method'] == "loadTable") {
			loadTable($_POST['tableName']);
		} else if($_POST['method'] == "loadItemTypes") {
			loadItemTypes();
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

	function loadItemTypes() {
		$ps = $GLOBALS['pdo']->prepare("
			SELECT 
				item_type_id, 
				name, 
				quantity_unit
			FROM ItemTypes
		");

		$ps->execute();
		$result = $ps->fetchAll();
		$results = array();		
		$first = true;
		foreach($result as $row) {	
			$results[] = array();
			$i = count($results) - 1;
			$results[$i]['item_type_id'] = $row['item_type_id'];
			$results[$i]['name'] = utf8_encode($row['name']);
			$results[$i]['quantity_unit'] = utf8_encode($row['quantity_unit']);			
		}				
		echo json_encode($results);
	}
?>