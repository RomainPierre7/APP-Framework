<?php
  $login = 'login'; /*To complete*/
  $db_pwd = 'password'; /*To complete*/
  $db_name = 'database_name'; /*To complete*/

  $connection_string = "host=localhost port=5432 dbname=".$db_name." user=".$login." password=".$db_pwd;
  $connection = pg_connect($connection_string);
  if(!$connection) {
     echo 'ERROR: Unable to connect to the database';
  }
?>