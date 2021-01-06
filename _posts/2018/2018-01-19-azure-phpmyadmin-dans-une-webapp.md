---
title: "[Azure] Phpmyadmin dans une WebApp"
date: "2018-01-19"
author: "Florent Appointaire"
permalink: "/2018/01/19/azure-phpmyadmin-dans-une-webapp"
summary:
categories: 
  - "azure-web-apps"
tags: 
  - "app-service"
  - "azure"
  - "microsoft"
  - "mysql"
  - "phpmyadmin"
  - "webapp"
---
Aujourd'hui, un de mes clients m'a demandé si il était possible d'avoir PHPMYADMIN sur une WebApp/VM pour pouvoir administrer sa base de donnée Azure Database for MySQL Server.

Après une rapide recherche dans les extensions de la WebApp, j'ai pu apercevoir qu'il y avait une extension pour PhpMyAdmin. Je l'ai donc installé:

[![](https://cloudyjourney.fr/wp-content/uploads/2018/01/WebAppPhpmyadmin01.png)](https://cloudyjourney.fr/wp-content/uploads/2018/01/WebAppPhpmyadmin01.png)

[![](https://cloudyjourney.fr/wp-content/uploads/2018/01/WebAppPhpmyadmin02.png)](https://cloudyjourney.fr/wp-content/uploads/2018/01/WebAppPhpmyadmin02.png)

L'extension est maintenant installée:

[![](https://cloudyjourney.fr/wp-content/uploads/2018/01/WebAppPhpmyadmin03.png)](https://cloudyjourney.fr/wp-content/uploads/2018/01/WebAppPhpmyadmin03.png)

Pour y accéder, allez sur **https://votresite.scm.azurewebsites.net/phpmyadmin/** :

[![](https://cloudyjourney.fr/wp-content/uploads/2018/01/WebAppPhpmyadmin04.png)](https://cloudyjourney.fr/wp-content/uploads/2018/01/WebAppPhpmyadmin04.png)

Connectez-vous avez le nom d'utilisateur/mot de passe de votre serveur MySQL. Si vous avez une erreur, c'est normal. Nous n'avons pas précisé la chaîne de connexion vers notre serveur mysql, car sur localhost, il n'y a rien:

[![](https://cloudyjourney.fr/wp-content/uploads/2018/01/WebAppPhpmyadmin05.png)](https://cloudyjourney.fr/wp-content/uploads/2018/01/WebAppPhpmyadmin05.png)

Allez récupérer la chaîne de connexion dans votre base de donnée mysql. Il y a une partie **Web App**, déjà formaté comme il faut pour l'intégration. Copiez cette chaine et rajoutez le mot de passe de l'utilisateur, ainsi que la base de donnée par défaut, par exemple **mysql**:

`Database=mysql; Data Source=cloudyjourney.mysql.database.azure.com; User Id=florent@cloudyjourney; Password=Password!`

[![](https://cloudyjourney.fr/wp-content/uploads/2018/01/WebAppPhpmyadmin06.png)](https://cloudyjourney.fr/wp-content/uploads/2018/01/WebAppPhpmyadmin06.png)

Dans votre Web App, allez dans **Application settings > Connection strings** et choisissez MySQL. Donnez un nom et dans la partie **value**, renseignez la chaîne de connexion que vous avez créé juste avant:

[![](https://cloudyjourney.fr/wp-content/uploads/2018/01/WebAppPhpmyadmin07.png)](https://cloudyjourney.fr/wp-content/uploads/2018/01/WebAppPhpmyadmin07.png)

Si vous avez une erreur de ce type, c'est normal, c'est que vous n'avez pas autorisé l'IP de la Web App dans votre serveur MySQL:

[![](https://cloudyjourney.fr/wp-content/uploads/2018/01/WebAppPhpmyadmin08.png)](https://cloudyjourney.fr/wp-content/uploads/2018/01/WebAppPhpmyadmin08.png)

Sur votre base de donnée, dans la partie **Connection security**, vous avez la possibilité d'autorisé seulement les IPs de la Web App (disponible dans les propriétés de cette dernière), ou d'autoriser tous les services provenant de Azure:

[![](https://cloudyjourney.fr/wp-content/uploads/2018/01/WebAppPhpmyadmin09.png)](https://cloudyjourney.fr/wp-content/uploads/2018/01/WebAppPhpmyadmin09.png)

Retournez sur le Phpmyadmin. Vous pouvez maintenant vous connecter sans souci: [![](https://cloudyjourney.fr/wp-content/uploads/2018/01/WebAppPhpmyadmin10.png)](https://cloudyjourney.fr/wp-content/uploads/2018/01/WebAppPhpmyadmin10.png)

Et utiliser cette interface pour ajouter des bases de données, tables, etc...

[![](https://cloudyjourney.fr/wp-content/uploads/2018/01/WebAppPhpmyadmin11.png)](https://cloudyjourney.fr/wp-content/uploads/2018/01/WebAppPhpmyadmin11.png)

N'hésitez pas si vous avez des questions :)
