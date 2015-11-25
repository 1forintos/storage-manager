<?php
	$login = "root";
	$password = "";
	$dsn = "mysql:host=localhost;dbname=StorageManager";
	$opt = array(
    	// any occurring errors wil be thrown as PDOException
	    PDO::ATTR_ERRMODE => PDO::ERRMODE_EXCEPTION
	);

	$pdo = new PDO($dsn, $login, $password);

	$ps = $pdo->prepare("SELECT * FROM `Users`");
	$ps->execute();
	$ps->setFetchMode(PDO::FETCH_OBJ);

	foreach ($ps as $row) {
    	echo print_r($row, true);
    	echo "<br>";
	}

?>