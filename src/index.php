<html>
<head>
  <meta charset="UTF-8">
  <title>App Name</title>
  <link href="css/styles.css" rel="stylesheet" />
  <link rel="icon" href="media/logo.png" type="image/x-icon">
</head>
<body>
  <?php 
    include "template/header.php";
    include "connect_database/connect_pg.php";
  ?>

  <!-- Your code here -->

  <?php include "template/footer.php"; ?>

  <!-- Easy access to the database, useful for development (remove in production) -->
  <h2 class="dev">Development tools</h2>
  <div class="menu-dev">
    <a href="admin_database/admin_reset.php"><button>Reset database</button></a>
    <a href="admin_database/admin_reset_test.php"><button>Reset database to test data</button></a>
    <a href="admin_database/admin_update_test.php"><button>Simulate action on test data</button></a>
  </div>

</body>
</html>