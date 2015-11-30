<?php
	require_once "db_init.php";
	require_once "auth.php";

	authenticate();

	if(isset($_POST['method'])) {
		if($_POST['method'] == "loadTable") {
			loadTable($_POST['tableName']);
		} else if($_POST['method'] == "loadItemTypes") {
			loadItemTypes();
		} else if($_POST['method'] == "insertStorageTemplate") {
			insertStorageTemplate($_POST['data']);
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

	function insertStorageTemplate($templateData) {
		if(templateExists($templateData['name'])) {
			throwError("Template [" . $templateData['name'] .  "] already exists.");
		} elseif(!uniqueItemTypes($templateData['defaultItems'])) {
			throwError("Item type selections have to be unique.");
		}

		$ps = $GLOBALS['pdo']->prepare("
			INSERT INTO StorageTemplates(name, notes)
			VALUES (?, ?)
		");

		$success = $ps->execute(array($templateData['name'], $templateData['notes']));
		if(!$success) {
			throwError("Failed to insert new template.");
		} 

		$ps = $GLOBALS['pdo']->prepare("
			SELECT template_id
			FROM StorageTemplates
			WHERE name = ?
		");
		$ps->execute(array($templateData['name']));
		$newTemplateId = $ps->fetch();
		$newTemplateId = $newTemplateId['template_id'];
		
		// insert items for template
		foreach($templateData['defaultItems'] as $item) {
			$ps = $GLOBALS['pdo']->prepare("
				INSERT INTO StorageTemplateItems(template_id, item_type_id, quantity)
				VALUES (?, ?, ?)
			");

			$quantity = $item['quantity'] == null || $item['quantity'] == '' ? 0 : $item['quantity'];
			$success = $ps->execute(array($newTemplateId, $item['itemTypeId'], $quantity));

			// rollback if failed
			if(!$success) {
				deleteTemplateInfoFromDatabase($newTemplateId);				
			}
		}	

		echo "success";	
	}

	function templateExists($templateName) {
		$ps = $GLOBALS['pdo']->prepare("
			SELECT COUNT(*) > 0 AS table_exists
			FROM StorageTemplates
			WHERE name = ?
		");

		$ps->execute(array($templateName));
		$result = $ps->fetch();
		if($result['table_exists']) {
			return true;
		}
		return false;
	}

	function throwError($msg) {
		$errorData = array(
			"error" => $msg
		);
		echo json_encode($errorData);
		exit;
	}

	function uniqueItemTypes($items) {
		$itemTypeIds = array();
		foreach($items as $item) {
			$itemTypeIds[] = $item['itemTypeId'];
		}		
	
		return count(array_unique($itemTypeIds)) == count($items);
	}

	function deleteTemplateInfoFromDatabase($templateId) {
		$ps = $GLOBALS['pdo']->prepare("
			DELETE FROM StorageTemplateItems
			WHERE template_id = ?
		");			

		$success = $ps->execute(array($templateId));
		if(!$success) {
			throwError("Failed to rollback insertion of template data with id: " . $templateId);
		}
		$ps = $GLOBALS['pdo']->prepare("
			DELETE FROM StorageTemplates
			WHERE template_id = ?
		");			

		$success = $ps->execute(array($templateId));

		if(!$success) {
			throwError("Failed to rollback insertion of template data with id: " . $templateId);
		}
	}
?>

