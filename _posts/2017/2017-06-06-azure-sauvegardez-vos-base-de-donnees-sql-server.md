---
title: "[Azure] Sauvegardez vos base de données SQL Server"
date: "2017-06-06"
author: "Florent Appointaire"
permalink: "/2017/06/06/azure-sauvegardez-vos-base-de-donnees-sql-server/"
summary:
categories: 
  - "azure"
  - "sql-server"
tags: 
  - "azure"
  - "backup"
  - "microsoft"
  - "sql-server"
---
Si vous souhaitez sauvegarder vos serveur de base de données SQL Server, mais que vous êtes limité en terme de stockage ou que vous ne souhaitez pas investir dans du nouveau matériel ou simplement pour sauvegarder votre LAB, vous avez la solution du backup sur Azure. Pour ceci, c’est très simple, et vous ne payez que le stockage.

## Prérequis

Commencez par créer un compte de stockage de type BLOB:

[![](https://cloudyjourney.fr/wp-content/uploads/2018/01/BCKSQL01.png)](https://cloudyjourney.fr/wp-content/uploads/2018/01/BCKSQL01.png)

Créez ensuite un conteneur à l’intérieur de ce compte de stockage:

[![](https://cloudyjourney.fr/wp-content/uploads/2018/01/BCKSQL02.png)](https://cloudyjourney.fr/wp-content/uploads/2018/01/BCKSQL02.png)

## Backup

Pour sauvegardez votre base de données, cliquez droit sur la base de donnée en question > **Tasks > Back Up…:**

[![](https://cloudyjourney.fr/wp-content/uploads/2018/01/BCKSQL03.png)](https://cloudyjourney.fr/wp-content/uploads/2018/01/BCKSQL03.png)

Changez la destination vers **URL** et cliquez sur **Add:**

[![](https://cloudyjourney.fr/wp-content/uploads/2018/01/BCKSQL04-1.png)](https://cloudyjourney.fr/wp-content/uploads/2018/01/BCKSQL04-1.png)

Dans la nouvel fenêtre qui apparait, sélectionnez **New Container** pour vous connecter à votre compte Azure. Connectez-vous ensuite à votre compte Azure en cliquant sur **Sign In:**

[![](https://cloudyjourney.fr/wp-content/uploads/2018/01/BCKSQL05.png)](https://cloudyjourney.fr/wp-content/uploads/2018/01/BCKSQL05.png)

[](https://microsofttouch.fr/cfs-file/__key/communityserver-blogs-components-weblogfiles/00-00-00-00-69/BCKSQL05.png)Une fois connectez, sélectionnez la subscription Azure qui contient le compte de stockage créé au début, le compte de stockage, le conteneur et générez une nouvelle clé avec une date d’expiration en cliquant sur **Create Credential:**

[![](https://cloudyjourney.fr/wp-content/uploads/2018/01/BCKSQL06.png)](https://cloudyjourney.fr/wp-content/uploads/2018/01/BCKSQL06.png)

Vous avez maintenant la connexion qui est établie avec votre compte de stockage Azure:

[![](https://cloudyjourney.fr/wp-content/uploads/2018/01/BCKSQL07.png)](https://cloudyjourney.fr/wp-content/uploads/2018/01/BCKSQL07.png)

Choisissez le type de backup (FULL) et l’URL sera générée pour votre backup:

[![](https://cloudyjourney.fr/wp-content/uploads/2018/01/BCKSQL08.png)](https://cloudyjourney.fr/wp-content/uploads/2018/01/BCKSQL08.png)

Cliquez sur **OK** pour démarrer le backup:

[![](https://cloudyjourney.fr/wp-content/uploads/2018/01/BCKSQL09.png)](https://cloudyjourney.fr/wp-content/uploads/2018/01/BCKSQL09.png)

Suivant la taille de la base de donnée, après un certain temps, le backup s’est effectué correctement:

[![](https://cloudyjourney.fr/wp-content/uploads/2018/01/BCKSQL10.png)](https://cloudyjourney.fr/wp-content/uploads/2018/01/BCKSQL10.png)

Je vais maintenant créer une base de donnée vièrge, avec une table:

[![](https://cloudyjourney.fr/wp-content/uploads/2018/01/BCKSQL11.png)](https://cloudyjourney.fr/wp-content/uploads/2018/01/BCKSQL11.png)

Sauvegardez la via la procedure précédente et supprimez la:

[![](https://cloudyjourney.fr/wp-content/uploads/2018/01/BCKSQL12.png)](https://cloudyjourney.fr/wp-content/uploads/2018/01/BCKSQL12.png)

Vous pouvez également automatiser le backup en utilisant le script suivant: [https://github.com/Flodu31/PowerShell-Scripts/blob/master/SQLServer/Backup\_DB\_To\_Azure\_v1.0.ps1](https://github.com/Flodu31/PowerShell-Scripts/blob/master/SQLServer/Backup_DB_To_Azure_v1.0.ps1)

## Restauration

Nous allons maintenant la restaurer. Cliquez droit sur **Databases > Restore Database…:**

[![](https://cloudyjourney.fr/wp-content/uploads/2018/01/BCKSQL13.png)](https://cloudyjourney.fr/wp-content/uploads/2018/01/BCKSQL13.png)

Choisissez la source **Device** et cliquez sur le bloc avec les **… :**

[![](https://cloudyjourney.fr/wp-content/uploads/2018/01/BCKSQL14.png)](https://cloudyjourney.fr/wp-content/uploads/2018/01/BCKSQL14.png)

Choisissez le media de type **URL** et cliquez sur **Add:**

[![](https://cloudyjourney.fr/wp-content/uploads/2018/01/BCKSQL15.png)](https://cloudyjourney.fr/wp-content/uploads/2018/01/BCKSQL15.png)

Choisissez le compte de stockage qui est déjà enregistré et cliquez sur **Add:**

[![](https://cloudyjourney.fr/wp-content/uploads/2018/01/BCKSQL16.png)](https://cloudyjourney.fr/wp-content/uploads/2018/01/BCKSQL16.png)

Choisissez la subscription Azure, le compte de stockage et le conteneur où la base de donnée a été sauvegardé. Créez une nouvelle clé:

[![](https://cloudyjourney.fr/wp-content/uploads/2018/01/BCKSQL17.png)](https://cloudyjourney.fr/wp-content/uploads/2018/01/BCKSQL17.png)

Vous êtes maintenant connecté au stockage qui contient le backup de votre base de donnée:

[![](https://cloudyjourney.fr/wp-content/uploads/2018/01/BCKSQL18.png)](https://cloudyjourney.fr/wp-content/uploads/2018/01/BCKSQL18.png)

Choisissez le backup à restaurer et cliquez sur **OK:**

[![](https://cloudyjourney.fr/wp-content/uploads/2018/01/BCKSQL19.png)](https://cloudyjourney.fr/wp-content/uploads/2018/01/BCKSQL19.png)

Choisissez le backup à restaurer et cliquez sur **OK:**

[![](https://cloudyjourney.fr/wp-content/uploads/2018/01/BCKSQL20.png)](https://cloudyjourney.fr/wp-content/uploads/2018/01/BCKSQL20.png)

Choisissez le nom de la database où vous souhaitez restaurer la base de donnée et cliquez sur **OK:**

[![](https://cloudyjourney.fr/wp-content/uploads/2018/01/BCKSQL21.png)](https://cloudyjourney.fr/wp-content/uploads/2018/01/BCKSQL21.png)

Après quelques instants, dépendant de la taille de la base, votre base de donnée a été restaurée correctement:

[![](https://cloudyjourney.fr/wp-content/uploads/2018/01/BCKSQL22.png)](https://cloudyjourney.fr/wp-content/uploads/2018/01/BCKSQL22.png)

Si vous refaites un select, les données sont de nouveau présentes:

[![](https://cloudyjourney.fr/wp-content/uploads/2018/01/BCKSQL23.png)](https://cloudyjourney.fr/wp-content/uploads/2018/01/BCKSQL23.png)

Cette solution a pour avantage d’être rapide, flexible et avec un coût moindre parce que le coût du stockage sur Azure n’est pas elevé compare au fait que vous deviez acheter du matériel, des disques et surtout, avoir quelqu’un pour maintenir l’infrastructure.
