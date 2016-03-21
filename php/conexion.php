<?php
$hostmysql="localhost";
$usuariomysql="versatia";
$passwordmysql="v3rs4t14";
$bdmysql="parqueadero";
$link=mysqli_connect($hostmysql,$usuariomysql,$passwordmysql,$bdmysql) or 
die("Error ".mysqli_error($link));
?>