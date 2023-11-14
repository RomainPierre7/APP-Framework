<html>
<head>
  <meta charset="UTF-8">
  <title>App Name</title>
  <link href="../css/styles.css" rel="stylesheet" />
  <link rel="icon" href="../media/logo.png" type="image/x-icon">
</head>
<body>
  <?php
  include "../template/header.php";
  include "../connect_database/connect_pg.php";

  echo "<h1>Reset database</h1>";
  echo "<div class='container'>";

  $sqlScript = file_get_contents('../sql/drop.sql');
  $result = pg_query($connection, $sqlScript);
  if ($result) {
    echo "drop.sql script executed successfully";
  } else {
    echo "Error executing drop.sql script : " . pg_last_error($connection);
  }
  echo "<br>";

  $sqlScript = file_get_contents('../sql/create.sql');
  $result = pg_query($connection, $sqlScript);
  if ($result) {
    echo "create.sql script executed successfully";
  } else {
    echo "Error executing create.sql script : " . pg_last_error($connection);
  }

  pg_close($connection);

  echo "</div>";  
?>

<div class="dev-menu">
  <a href="../index.php"><button>Back to home</button></a>
</div>

</body>
</html>