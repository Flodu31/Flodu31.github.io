---
title: "[Azure] Migrez vos sites bases de données SQL Server rapidement et simplement"
date: "2018-10-22"
categories: 
  - "azure-sql"
tags: 
  - "azure"
  - "azure-sql"
  - "microsoft"
  - "migration"
  - "sql-server"
---

[![](https://cloudyjourney.fr/wp-content/uploads/2018/10/Azure-SQL-Database-Logo.png)](https://cloudyjourney.fr/wp-content/uploads/2018/10/Azure-SQL-Database-Logo.png)

Après avoir vu [comment migrer rapidement et simplement vos sites IIS](https://cloudyjourney.fr/2018/10/17/azure-migrez-vos-sites-iis-rapidement-et-simplement/), on va découvrir comment migrer les bases de données SQL Server, avec un temps réduit d'indisponibilité, vers Azure SQL. Attention, cette fonctionnalité est encore en preview.

J'ai pour cette démonstartion, une base de données **learningsql** qui tourne sur SQL Server 2017 Standard, sur Windows Server 2019, avec des données dedant:

![](https://cloudyjourney.fr/wp-content/uploads/2018/10/PaaS-Migration-SQL-01.png)

Pour commencer, vous devez télécharger [Data Migration Assistant](https://www.microsoft.com/en-us/download/details.aspx?id=53595) et l'installer sur une machine qui a accès:

- Au serveur source
- A internet

Il faut ensuite, avant de lancer le logiciel, vérifier quelques points pour effectuer cette migration en ligne (pas nécessaire si vous souhaitez faire la migration hors ligne, qui sera plus longue).

La première chose à vérifier, c'est de savoir si votre SQL Server est supérieur à 2005. Ensuite, le Recovery Model de votre base de données doit être en Full ou Bulk-logged. Vous pouvez vérifier ceci, avec la requête suivante:

SELECT name, recovery\_model\_desc
  FROM sys.databases
    WHERE name = 'learningsql';
GO

[![](https://cloudyjourney.fr/wp-content/uploads/2018/10/PaaS-Migration-SQL-02.png)](https://cloudyjourney.fr/wp-content/uploads/2018/10/PaaS-Migration-SQL-02.png)

Si vous n'avez pas un des 2 modes, veuillez regarder comment changer ceci, ici: [https://docs.microsoft.com/en-us/sql/relational-databases/backup-restore/view-or-change-the-recovery-model-of-a-database-sql-server?view=sql-server-2017](https://docs.microsoft.com/en-us/sql/relational-databases/backup-restore/view-or-change-the-recovery-model-of-a-database-sql-server?view=sql-server-2017)

Il faut également une sauvegarde full de la base de données. Exécutez la requête suivante pour voir si vous avez déjà fait une sauvegarde full de la base:

SELECT count(type) as result
  FROM msdb.dbo.backupset bk
    WHERE bk.database\_name = 'learningsql' AND type = 'D';

[![](https://cloudyjourney.fr/wp-content/uploads/2018/10/PaaS-Migration-SQL-03.png)](https://cloudyjourney.fr/wp-content/uploads/2018/10/PaaS-Migration-SQL-03.png)

Si le chiffre est 0, alors suivez les instructions qui se trouvent ici: [https://docs.microsoft.com/en-us/sql/relational-databases/backup-restore/full-database-backups-sql-server?view=sql-server-2017](https://docs.microsoft.com/en-us/sql/relational-databases/backup-restore/full-database-backups-sql-server?view=sql-server-2017)

Un autre point important est que, si les tables n'ont pas de clés primaires, vous devez activer le CDC (Change Data Capture) sur la base et les tables qui n'ont pas de clés primaires. Pour savoir ce qu'il en est, exécutez la requête suivante:

USE learningsql;
SELECT is\_tracked\_by\_cdc, name AS TableName
  FROM sys.tables WHERE type = 'U' and is\_ms\_shipped = 0 AND
  OBJECTPROPERTY(OBJECT\_ID, 'TableHasPrimaryKey') = 0;

[![](https://cloudyjourney.fr/wp-content/uploads/2018/10/PaaS-Migration-SQL-04.png)](https://cloudyjourney.fr/wp-content/uploads/2018/10/PaaS-Migration-SQL-04.png)

Si vous avez des résultats, regardez par ici: [https://docs.microsoft.com/en-us/sql/relational-databases/track-changes/enable-and-disable-change-data-capture-sql-server?view=sql-server-2017](https://docs.microsoft.com/en-us/sql/relational-databases/track-changes/enable-and-disable-change-data-capture-sql-server?view=sql-server-2017)

Enfin, pour terminer les prérequis, il faut vérifier que le service **SQL Server Replication** est bien installé, avec la requête suivante:

USE master;
DECLARE @installed int;
EXEC @installed = sys.sp\_MS\_replication\_installed;
SELECT @installed as installed;

[![](https://cloudyjourney.fr/wp-content/uploads/2018/10/PaaS-Migration-SQL-05.png)](https://cloudyjourney.fr/wp-content/uploads/2018/10/PaaS-Migration-SQL-05.png)

Si comme moi, le service n'est pas installé, montez l'ISO sur le serveur, et ajoutez la feature **SQL Server Replication** sur l'instance où se trouve la base à migrer:

[![](https://cloudyjourney.fr/wp-content/uploads/2018/10/PaaS-Migration-SQL-06.png)](https://cloudyjourney.fr/wp-content/uploads/2018/10/PaaS-Migration-SQL-06.png)

Revérifiez voir si l'installation est bien détectée:

[![](https://cloudyjourney.fr/wp-content/uploads/2018/10/PaaS-Migration-SQL-07.png)](https://cloudyjourney.fr/wp-content/uploads/2018/10/PaaS-Migration-SQL-07.png)

Regardez ensuite si le rôle de distribution est configuré, avec la commande suivante:

EXEC sp\_get\_distributor;

[![](https://cloudyjourney.fr/wp-content/uploads/2018/10/PaaS-Migration-SQL-08.png)](https://cloudyjourney.fr/wp-content/uploads/2018/10/PaaS-Migration-SQL-08.png)

Si la colonne **distribution server** est vide, vous devez configurer le service à l'aide de l'article suivant (vous pouvez le faire avec la console, ou via une requête): [https://docs.microsoft.com/en-us/sql/relational-databases/replication/configure-publishing-and-distribution?view=sql-server-2017](https://docs.microsoft.com/en-us/sql/relational-databases/replication/configure-publishing-and-distribution?view=sql-server-2017)

[![](https://cloudyjourney.fr/wp-content/uploads/2018/10/PaaS-Migration-SQL-09.png)](https://cloudyjourney.fr/wp-content/uploads/2018/10/PaaS-Migration-SQL-09.png)

Revérifier. Vous devriez voir apparaître le nom que vous avez donné lors de la configuration:

[![](https://cloudyjourney.fr/wp-content/uploads/2018/10/PaaS-Migration-SQL-10.png)](https://cloudyjourney.fr/wp-content/uploads/2018/10/PaaS-Migration-SQL-10.png)

La vérification des prérequis est maintenant terminée.

Vous devez maintenant créer une base de données sur Azure SQL, pour effectuer la migration. Si vous souhaitez un peu d'aide, rendez-vous ici : [https://docs.microsoft.com/en-us/azure/sql-database/sql-database-get-started-portal](https://docs.microsoft.com/en-us/azure/sql-database/sql-database-get-started-portal) 

Vous pouvez lancer la console **Data Migration Assistant** et cliquer sur le +, pour démarrer un nouveau projet:

[![](https://cloudyjourney.fr/wp-content/uploads/2018/10/PaaS-Migration-SQL-11.png)](https://cloudyjourney.fr/wp-content/uploads/2018/10/PaaS-Migration-SQL-11.png)

Donnez un nom au projet, choisissez la source, la destination, et ce que vous souhaitez migrer:

[![](https://cloudyjourney.fr/wp-content/uploads/2018/10/PaaS-Migration-SQL-12.png)](https://cloudyjourney.fr/wp-content/uploads/2018/10/PaaS-Migration-SQL-12.png)

Renseignez ensuite les informations nécessaires pour se connecter à l'instance qui héberge la base de données à migrer, sélectionner la base de données à migrer et cliquez sur **Next:**

[![](https://cloudyjourney.fr/wp-content/uploads/2018/10/PaaS-Migration-SQL-13.png)](https://cloudyjourney.fr/wp-content/uploads/2018/10/PaaS-Migration-SQL-13.png)

Renseignez les informations de votre serveur Azure SQL, qui reçevra les données de la base qui est On-Premises, et si, le serveur a plusieurs bases, sélectionnez la base que vous souhaitez utiliser:

[![](https://cloudyjourney.fr/wp-content/uploads/2018/10/PaaS-Migration-SQL-14.png)](https://cloudyjourney.fr/wp-content/uploads/2018/10/PaaS-Migration-SQL-14.png)

Choisissez la ou les tables à migrer, et générez le script SQL qui servira pour la création du schéma sur la base Azure SQL:

[![](https://cloudyjourney.fr/wp-content/uploads/2018/10/PaaS-Migration-SQL-15.png)](https://cloudyjourney.fr/wp-content/uploads/2018/10/PaaS-Migration-SQL-15.png)

Cliquez sur **Deploy schema** pour déployer le schéma de votre base On-Premises vers Azure SQL:

[![](https://cloudyjourney.fr/wp-content/uploads/2018/10/PaaS-Migration-SQL-16.png)](https://cloudyjourney.fr/wp-content/uploads/2018/10/PaaS-Migration-SQL-16.png)

Vous pouvez maintenant passer à l'étape de migration des données, si tout c'est passé correctement, en cliquant sur **Migrate data**:

[![](https://cloudyjourney.fr/wp-content/uploads/2018/10/PaaS-Migration-SQL-17.png)](https://cloudyjourney.fr/wp-content/uploads/2018/10/PaaS-Migration-SQL-17.png)

Cliquez sur **Start data migration** pour démarrer la migration des données, après avoir sélectionné les données des tables à migrer:

[![](https://cloudyjourney.fr/wp-content/uploads/2018/10/PaaS-Migration-SQL-18.png)](https://cloudyjourney.fr/wp-content/uploads/2018/10/PaaS-Migration-SQL-18.png)

La migration commence:

[![](https://cloudyjourney.fr/wp-content/uploads/2018/10/PaaS-Migration-SQL-19.png)](https://cloudyjourney.fr/wp-content/uploads/2018/10/PaaS-Migration-SQL-19.png)

N'ayant pas beaucoup de données dans mes tables, la migration a duré moins de 1 minute:

[![](https://cloudyjourney.fr/wp-content/uploads/2018/10/PaaS-Migration-SQL-20.png)](https://cloudyjourney.fr/wp-content/uploads/2018/10/PaaS-Migration-SQL-20.png)

Si je me connecte sur mon serveur Azure SQL, avec le Management Studio, et que je regarde ma base de données, je retrouve les tables que j'ai souhaité migrer, ainsi que les données:

[![](https://cloudyjourney.fr/wp-content/uploads/2018/10/PaaS-Migration-SQL-21.png)](https://cloudyjourney.fr/wp-content/uploads/2018/10/PaaS-Migration-SQL-21.png)

Cette nouvelle fonctionnalité, de migrer les données à chaud, avec très peu d'interruption est très prometteuse et vous permettra très rapidement et facilement de migrer vers Azure SQL.
