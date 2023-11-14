<div class="header">
  <div class="logo">
    <?php
    $imagePaths = [
      "../media/logo.png",
      "media/logo.png"
    ];

    $linkPaths = [
      "../index.php",
      "index.php"
    ];
    function fileExists($path) {
      return file_exists($path);
    }

    $existingImagePath = null;
    foreach ($imagePaths as $path) {
      if (fileExists($path)) {
        $existingImagePath = $path;
        break;
      }
    }

    if ($existingImagePath == "../media/logo.png"){
      echo '<a href="../index.php"><img src="' . $existingImagePath . '" alt="Logo"></a>';
    } else if ($existingImagePath == "media/logo.png") {
      echo '<a href="index.php"><img src="' . $existingImagePath . '" alt="Logo"></a>';
    } else {
      echo '<p>No logo found</p>';
    }
    ?>
  </div>
  <div class="header-text">
    <h1>Welcome on <span class="app_name">App Name</span></h1>
    <p>Your slogan here</p>
  </div>
</div>
