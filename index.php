<?php
/*require ('include/db_conexion.php');*/
include_once ('include/db_conexion.php');
?>

<html lang="en">
<head>
	<meta charset="UTF-8">
	<meta name="viewport" content="width=device-width, user-scalable=no, initial-scale=1.0, maximum-scale=1.0, minimum-scale=1.0">
	<link rel="stylesheet" href="css/bootstrap.min.css">
	<link rel="stylesheet" href="css/buttons.css">
	<link rel="stylesheet" href="css/estilo.css">
	<title>Parking System</title>
</head>
<body id="cuerpo" class="bg">

	<div class="container-fluid">
		<div class="row">

			<div class="loggin col-xs-8 col-xs-offset-2 col-sm-8 col-sm-offset-2 col-md-6 col-md-offset-3">
				<h2 >Parking System</h2>
		<form class="form-horizontal">

		  <div class="form-group">
		    <div class="col-xs-offset-1 col-sm-10 col-sm-offset-1 col-md-10 col-md-offset-1">
		    	<div class="input-group" >
		    		<div  class="hidden-xs input-group-addon icono_form"><span class="glyphicon glyphicon-user" </span></div>
		      		<input type="text" class="form-control" id="user" type="text" placeholder="Usuario" onfocus="this.placeholder=''" onblur="this.placeholder='Usuario'">
		    	</div>
		    </div>
		  </div>

		 <div class="form-group">
		    <div class="col-xs-offset-1 col-sm-10 col-sm-offset-1 col-md-10 col-md-offset-1">
		    	<div class="input-group ">
		    		<div class="hidden-xs input-group-addon icono_form"><span class="glyphicon glyphicon-lock" </span></div>
		      		<input type="password" class="form-control" id="contraseña" placeholder="Contraseña" onfocus="this.placeholder=''" onblur="this.placeholder='Contraseña' ">
		    	</div>
		    </div>
		  </div>

		  <div class="form-group">
		    <div id="boton-ingresar-index" class="col-xs-8 col-xs-offset-1 col-sm-12 col-md-10 col-md-offset-4">
		      <a id="boton1" class="button button-highlight button-large" href="inc/panel.html" role="button">Ingresar</a>
		    </div>
		  </div>
		
		</form>	
		</div>
	</div>
	<script src="js/jquery-1.11.2.js"></script>
	<script src="js/jquery-ui.js"></script>
	<script src="js/bootstrap.min.js"></script>
	
	</body>
</html>