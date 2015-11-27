<!DOCTYPE html>
<html>
  <head>
    <meta charset="utf-8">
    <meta name="viewport" content="width=device-width, initial-scale=1">

	<!-- Latest compiled and minified CSS -->
	<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.5/css/bootstrap.min.css" integrity="sha512-dTfge/zgoMYpP7QbHy4gWMEGsbsdZeCXz7irItjcC3sPUFtf0kuFbDz/ixG7ArTxmDjLXDmezHubeNikyKGVyQ==" crossorigin="anonymous">

	<!-- Optional theme -->
	<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.sudo /com/bootstrap/3.3.5/css/bootstrap-theme.min.css" integrity="sha384-aUGj/X2zp5rLCbBxumKTCw2Z50WgIr1vs/PFN4praOTvYXWlVyh2UtNUU0KAUhAX" crossorigin="anonymous">

	<link rel="stylesheet" href="css/styles.css">
	<link rel="stylesheet" href="/sm/header/css/header.css">

	<script src="https://code.jquery.com/jquery-2.1.4.min.js"></script>

	<script src="/sm/header/js/header.js"></script>
	<script src="js/script.js"></script>
  </head>
  <body style="background-color: #AAA;">
	<header class="navbar-inverse">
	  	<div class="container">
	  		<nav>
			  <div class="container-fluid">
			    <!-- Brand and toggle get grouped for better mobile display -->
			    <div class="navbar-header">
			      <button type="button" class="navbar-toggle collapsed" data-toggle="collapse" data-target="#bs-example-navbar-collapse-1" aria-expanded="false">
			        <span class="sr-only">Toggle navigation</span>
			        <span class="icon-bar"></span>
			        <span class="icon-bar"></span>
			        <span class="icon-bar"></span>
			      </button>
			      <a class="navbar-brand" href="" onclick="navigateHome()">Home</a>
			    </div>

			    <!-- Collect the nav links, forms, and other content for toggling -->
			    <div class="collapse navbar-collapse" id="bs-example-navbar-collapse-1">
			      <ul class="nav navbar-nav">
			        <!-- <li class="active"><a href="#">Link <span class="sr-only">(current)</span></a></li> -->
			        <?php 
			        	foreach(getModules() as $moduleName => $subModules):
			        		if(count($subModules) > 1):
			        ?>
						    	<li class="dropdown">
						          <a href="#" class="dropdown-toggle" data-toggle="dropdown" role="button" aria-haspopup="true" aria-expanded="false"><?php echo $moduleName; ?> <span class="caret"></span></a>
						          <ul class="dropdown-menu">
							          <?php foreach($subModules as $subModule): ?>
							          	 <li><a href=<?php echo "\"" . $subModule["path"] . "\"";?> ><?php echo $subModule["name"]; ?></a></li>
							          <?php endforeach; ?>
						          </ul>
			    			<?php endif; ?>
			    	<?php endforeach; ?>			        
			      </ul>
			      <ul class="nav navbar-nav navbar-right">
			        <li><a href="" onclick="logout();">Logout</a></li>			        
			      </ul>			      			     
			    </div><!-- /.navbar-collapse -->
			  </div><!-- /.container-fluid -->
			</nav>			
		</div>
	</header>