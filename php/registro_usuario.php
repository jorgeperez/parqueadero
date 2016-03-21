<?php
include("variables.php");

if(isset($_POST['temp']))
{
//Registrar usuario
	$cedula=$_POST['cedula'];
	$usuario=$_POST['usuario'];
	$password=$_POST['password-usuario'];
	$primer_nombre=$_POST['primernombre-usuario'];
	$segundo_nombre=$_POST['segundonombre-usuario'];
	$primer_apellido=$_POST['primerapellido-usuario'];
	$segundo_apellido=$_POST['segundoapellido-usuario'];
	$cedula=$_POST['telefono-usuario'];
	$cedula=$_POST['email-usuario'];
	$cedula=$_POST['estado-usuario'];
	$cedula=$_POST['rol-usuario'];
	$insert="INSERT INTO usuarios (cedula,usuario,password_usuario,nombres_usuario,apellidos_usuario,telefono_usuario,) VALUES ('$c','$ema'
	,'$pas')";
	mysqli_query($link,$insert);
	$filasafectadas=mysqli_affected_rows($link);
	if($filasafectadas>0){
	$rta="<span style='color:green;'>Registrado con Exito</span>";	
	}
	else{
	$rta="<span style='color:red;'>Usuario no Registrado</span>";	
	}
	echo $rta;
}
?>