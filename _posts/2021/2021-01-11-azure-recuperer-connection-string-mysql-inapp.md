---
title: "[Azure] Récupérer la connection string de MySQL In App"
date: "2021-01-11"
author: "Florent Appointaire"
permalink: "/2021/01/11/azure-recuperer-connection-string-mysql-inapp/"
summary: 
categories: 
  - "azure"
tags:
  - "azure"
  - "microsoft"
  - "mysql in app"
---
Si vous souhaitez déployer un petit site web, avec une base de données MySQL, vous pouvez utiliser la fonctionnalité d'Azure Web App, MySQL in App. Attention, cette Web App doit être obligatoirement sous Windows. Dans ce test, j'ai choisi PHP comme stack.
Le problème maintenant, va être de trouver/utiliser la connection string.
Pour commencer, vous devez activer la fonctionnalité, dans la Web App:

![](/assets/images/2021/mysqlinapp01.jpg)

MySQL in App est maintenant activé. Vous pouvez importer une DB, depuis un compte de stockage. De même pour l'export:

![](/assets/images/2021/mysqlinapp02.jpg)

Créons maintenant 2 fichiers, à la racine de notre site, pour vérifier les informations de connexion à la base de données MySQL in App:

**mysql_in_app_infos.php**

```
<?php

$connectstr_dbhost = '';
$connectstr_dbname = '';
$connectstr_dbusername = '';
$connectstr_dbpassword = '';

foreach ($_SERVER as $key => $value) {
  if (strpos($key, "MYSQLCONNSTR_") !== 0) {
    continue;
  }

  $connectstr_dbhost = preg_replace("/^.*Data Source=(.+?);.*$/", "\\1", $value);
  $connectstr_dbname = preg_replace("/^.*Database=(.+?);.*$/", "\\1", $value);
  $connectstr_dbusername = preg_replace("/^.*User Id=(.+?);.*$/", "\\1", $value);
  $connectstr_dbpassword = preg_replace("/^.*Password=(.+?)$/", "\\1", $value);
}

echo "DBName: " . $connectstr_dbname . "<br>";
echo "Username: " . $connectstr_dbusername . "<br>";
echo "Password: " . $connectstr_dbpassword . "<br>";
echo "Hostname: " . $connectstr_dbhost . "<br>";

?>
```

**phpinfo.php**

```
<?php
phpinfo();
?>
```

![](/assets/images/2021/mysqlinapp03.jpg)

Naviguez sur votre URL, en ajoutant le fichier **phpinfo.php** à la fin de l'URL. Descendez jusqu'à la catégorie **Environment** et cherchez la ligne **MYSQLCONNSTR_localdb**. Vous verrez donc la connection string, avec le nom de la database, le hostname, le user et le mot de passe:

![](/assets/images/2021/mysqlinapp04.jpg)

Si vous allez sur l'url **mysql_in_app_infos.php**, vous aurez les informations suivantes:

![](/assets/images/2021/mysqlinapp05.jpg)

Si vous utilisez par exemple Wordpress, vous pouvez utiliser le code suivant pour ne pas avoir à vous occuper de la connexion string dans le fichier **wp-config.php**:

```
$connectstr_dbhost = '';
$connectstr_dbname = '';
$connectstr_dbusername = '';
$connectstr_dbpassword = '';

foreach ($_SERVER as $key => $value) {
  if (strpos($key, "MYSQLCONNSTR_") !== 0) {
    continue;
  }

  $connectstr_dbhost = preg_replace("/^.*Data Source=(.+?);.*$/", "\\1", $value);
  $connectstr_dbname = preg_replace("/^.*Database=(.+?);.*$/", "\\1", $value);
  $connectstr_dbusername = preg_replace("/^.*User Id=(.+?);.*$/", "\\1", $value);
  $connectstr_dbpassword = preg_replace("/^.*Password=(.+?)$/", "\\1", $value);
}

define('DB_NAME', $connectstr_dbname);
define('DB_USER', $connectstr_dbusername);
define('DB_PASSWORD', $connectstr_dbpassword);
define('DB_HOST', $connectstr_dbhost);
```

Voici une façon simple et rapide d'avoir la chaine de connexion à votre MySQL in App.