---
title: "[Azure] Sauvegarde de vos bases de données SQL Server"
date: "2018-08-02"
author: "Florent Appointaire"
permalink: "/2018/08/02/azure-sauvegarde-de-vos-base-de-donnees-sql-server/"
summary:
categories: 
  - "azure"
tags: 
  - "azure"
  - "azure-backup"
  - "microsoft"
  - "sql-server"
---
Microsoft a rendu disponible il y a quelques semaines, une fonctionnalité pour sauvegarder le base de données SQL Server, directement depuis Azure Backup. Vous trouverez plus d'informations sur les prerequis et les limites ici : [https://docs.microsoft.com/en-us/azure/backup/backup-azure-sql-database](https://docs.microsoft.com/en-us/azure/backup/backup-azure-sql-database)

# Backup

Pour commencer, ouvrez votre vault, et choisissez **SQL Server in Azure VM** au lieu de **Virtual Machines**. Comme vous le voyez, étant donné que les VMs que je souhaite backup sont déployées à la main, et non via le market place, il y aura une action manuelle à effectuer. Sélectionnez les VMs qui contiennent un serveur SQL:

[![](https://cloudyjourney.fr/wp-content/uploads/2018/08/AzureSQL01.png)](https://cloudyjourney.fr/wp-content/uploads/2018/08/AzureSQL01.png)

Une extension va être déployé sur chaque VM, pour accéder aux données SQL:

![](https://cloudyjourney.fr/wp-content/uploads/2018/08/AzureSQL03.png)

Un message d'erreur va apparaitre, pour nous signifier qu'il faut ajouter les droits sysadmin, sur les instances à backup, au compte qui a été créé via l'extension, **NT Service\\AzureWLBackupPluginSvc:**

[![](https://cloudyjourney.fr/wp-content/uploads/2018/08/AzureSQL02.png)](https://cloudyjourney.fr/wp-content/uploads/2018/08/AzureSQL02.png)

> Error Code : UserErrorSQLNoSysadminMembership Error Message : Azure Backup service creates a service account “NT Service\\AzureWLBackupPluginSvc” for all operations and this account needs SQL sysadmin priviledge. Recommended Action : Please provide Sys Admin privileges to AzureWLBackupPluginSvc.

[![](https://cloudyjourney.fr/wp-content/uploads/2018/08/AzureSQL04.png)](https://cloudyjourney.fr/wp-content/uploads/2018/08/AzureSQL04.png)

Une fois terminé, relancez le scan des instances pour découvrir les DBs:

[![](https://cloudyjourney.fr/wp-content/uploads/2018/08/AzureSQL05.png)](https://cloudyjourney.fr/wp-content/uploads/2018/08/AzureSQL05.png)

Nos DBs ont été découvertes:

[![](https://cloudyjourney.fr/wp-content/uploads/2018/08/AzureSQL06.png)](https://cloudyjourney.fr/wp-content/uploads/2018/08/AzureSQL06.png)

Cliquez maintenant sur **Configure Backup:**

[![](https://cloudyjourney.fr/wp-content/uploads/2018/08/AzureSQL07.png)](https://cloudyjourney.fr/wp-content/uploads/2018/08/AzureSQL07.png)

Et choisissez les bases de données à sauvegarder:

[![](https://cloudyjourney.fr/wp-content/uploads/2018/08/AzureSQL08.png)](https://cloudyjourney.fr/wp-content/uploads/2018/08/AzureSQL08.png)

Choisissez également une police de backup pour les logs:

[![](https://cloudyjourney.fr/wp-content/uploads/2018/08/AzureSQL09.png)](https://cloudyjourney.fr/wp-content/uploads/2018/08/AzureSQL09.png)

Nos bases de données ont été ajoutées au backup correctement. Cliquez dessus pour accéder aux bases:

[![](https://cloudyjourney.fr/wp-content/uploads/2018/08/AzureSQL10.png)](https://cloudyjourney.fr/wp-content/uploads/2018/08/AzureSQL10.png)

Choisissez une DB et lancez le Full backup:

[![](https://cloudyjourney.fr/wp-content/uploads/2018/08/AzureSQL11.png)](https://cloudyjourney.fr/wp-content/uploads/2018/08/AzureSQL11.png)

Tous les Full backups se sont déroulés correctement:

[![](https://cloudyjourney.fr/wp-content/uploads/2018/08/AzureSQL12.png)](https://cloudyjourney.fr/wp-content/uploads/2018/08/AzureSQL12.png)

# Restore

Pour restaurer une base, il suffit d'aller sur la base en question, et de cliquer sur restaurer. Vous pouvez créer une nouvelle base à partir du backup, ou remplacer la base de donnée initial:

[![](https://cloudyjourney.fr/wp-content/uploads/2018/08/AzureSQL13.png)](https://cloudyjourney.fr/wp-content/uploads/2018/08/AzureSQL13.png)

Choisissez un point de restauration:

[![](https://cloudyjourney.fr/wp-content/uploads/2018/08/AzureSQL14.png)](https://cloudyjourney.fr/wp-content/uploads/2018/08/AzureSQL14.png)

Et le lieu où restaurer cette base:

[![](https://cloudyjourney.fr/wp-content/uploads/2018/08/AzureSQL15.png)](https://cloudyjourney.fr/wp-content/uploads/2018/08/AzureSQL15.png)

La base de donnée est en cours de restauration:

[![](https://cloudyjourney.fr/wp-content/uploads/2018/08/AzureSQL16.png)](https://cloudyjourney.fr/wp-content/uploads/2018/08/AzureSQL16.png)

La base de donnée a bien été restaurée:

[![](https://cloudyjourney.fr/wp-content/uploads/2018/08/AzureSQL17.png)](https://cloudyjourney.fr/wp-content/uploads/2018/08/AzureSQL17.png)

Cette nouvelle fonctionnalité est très intéressante et fonctionne très bien pour une preview. L'ajout d'autres types de base de données comme Oracle, MySQL, PostGre, etc. pourrait être  également un atout supplémentaire :)
