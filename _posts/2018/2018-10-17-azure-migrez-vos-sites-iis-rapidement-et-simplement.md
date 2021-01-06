---
title: "[Azure] Migrez vos sites IIS rapidement et simplement"
date: "2018-10-17"
categories: 
  - "azure-web-apps"
tags: 
  - "azure"
  - "iis"
  - "microsoft"
  - "migration"
  - "webapp"
---

[![](https://cloudyjourney.fr/wp-content/uploads/2018/09/WebApp_Logo.png)](https://cloudyjourney.fr/wp-content/uploads/2018/09/WebApp_Logo.png)

Microsoft fournit un outil très intéressant, qui vous permet de migrer simplement et rapidement vos sites IIS, vers Azure. J'ai déployé pour faire le test, un serveur Windows Server 2019, avec IIS, et un site web:

[![](https://cloudyjourney.fr/wp-content/uploads/2018/10/PaaSMigration01.png)](https://cloudyjourney.fr/wp-content/uploads/2018/10/PaaSMigration01.png)

Téléchargez ensuite l'outil Microsoft qui permet de faire la migration (Online ou Offline) ici : [https://www.movemetothecloud.net/WindowsMigration](https://www.movemetothecloud.net/WindowsMigration)

Installez-le et lancez-le. Choisissez où est le site à migrer. Si vous êtes sur le serveur directement, sélectionnez la première option. Si vous êtes à distance, choisissez la seconde, et renseignez les informations du serveur qui contient le site:

[![](https://cloudyjourney.fr/wp-content/uploads/2018/10/PaaSMigration02.png)](https://cloudyjourney.fr/wp-content/uploads/2018/10/PaaSMigration02.png)

Les sites qui sont sur le serveur vont être détectés. Sélectionnez ceux à migrer:

[![](https://cloudyjourney.fr/wp-content/uploads/2018/10/PaaSMigration03.png)](https://cloudyjourney.fr/wp-content/uploads/2018/10/PaaSMigration03.png)

Vous pouvez ensuite sauvegarder localement l'assessment, ou déployer le site directement avec un publishing profile. Pour ma part, je vais faire le readiness assessment:

[![](https://cloudyjourney.fr/wp-content/uploads/2018/10/PaaSMigration04.png)](https://cloudyjourney.fr/wp-content/uploads/2018/10/PaaSMigration04.png)

Vous pouvez voir les warning. Rien de bloquant ici:

[![](https://cloudyjourney.fr/wp-content/uploads/2018/10/PaaSMigration05.png)](https://cloudyjourney.fr/wp-content/uploads/2018/10/PaaSMigration05.png)

Démarrez les migration en cliquant sur **Begin Migration**:

[![](https://cloudyjourney.fr/wp-content/uploads/2018/10/PaaSMigration06.png)](https://cloudyjourney.fr/wp-content/uploads/2018/10/PaaSMigration06.png)

Connectez-vous à votre compte Azure:

[![](https://cloudyjourney.fr/wp-content/uploads/2018/10/PaaSMigration07.png)](https://cloudyjourney.fr/wp-content/uploads/2018/10/PaaSMigration07.png)

Choisissez sur quel tenant, souscription et quelle région vous souhaitez déployer ce site:

[![](https://cloudyjourney.fr/wp-content/uploads/2018/10/PaaSMigration08.png)](https://cloudyjourney.fr/wp-content/uploads/2018/10/PaaSMigration08.png)

Vous devez créer un nouveau site. Mais vous pouvez, si vous le souhaitez, utiliser un App Service plan existant:

[![](https://cloudyjourney.fr/wp-content/uploads/2018/10/PaaSMigration09.png)](https://cloudyjourney.fr/wp-content/uploads/2018/10/PaaSMigration09.png)

La création du site est en cours:

[![](https://cloudyjourney.fr/wp-content/uploads/2018/10/PaaSMigration10.png)](https://cloudyjourney.fr/wp-content/uploads/2018/10/PaaSMigration10.png)

Le site a été créé correctement et vous pouvez y accéder:[![](https://cloudyjourney.fr/wp-content/uploads/2018/10/PaaSMigration12.png)](https://cloudyjourney.fr/wp-content/uploads/2018/10/PaaSMigration12.png)

Cliquez sur **Begin Publish** pour migrer le site web:

[![](https://cloudyjourney.fr/wp-content/uploads/2018/10/PaaSMigration11.png)](https://cloudyjourney.fr/wp-content/uploads/2018/10/PaaSMigration11.png)

Après quelques instants, dépendant de la quantité de données à migrer, votre site est migré:

[![](https://cloudyjourney.fr/wp-content/uploads/2018/10/PaaSMigration13.png)](https://cloudyjourney.fr/wp-content/uploads/2018/10/PaaSMigration13.png)

Il ne vous reste plus qu'à faire pointer vos DNS, avec un CNAME, vers l'adresse azurewebsites.net.

Du côté Azure, un nouveau groupe de ressource a été créé, avec mon site web et mon app service plan:

[![](https://cloudyjourney.fr/wp-content/uploads/2018/10/PaaSMigration14.png)](https://cloudyjourney.fr/wp-content/uploads/2018/10/PaaSMigration14.png)

Ce logiciel va simplifier les migrations des sites web vers Azure. Dans un prochain article, nous verrons comment migrer un site web qui est sous Linux Apache et ensuite, [comment migrer une base de données](https://wp.me/p9yp9C-ps) :)
