<?php
include_once 'config.php';   // Ya que functions.php no está incluido.
$mysqli = new mysqli(HOST, USER, PASSWORD, DATABASE);
// Si la conexión falla, aparece el error 
if($mysqli === false) { 
 echo 'Ha habido un error <br>'.mysqli_connect_error('no se pudo conectar'); 
} else {
 echo 'Conectado a la base de datos';
}
?>
