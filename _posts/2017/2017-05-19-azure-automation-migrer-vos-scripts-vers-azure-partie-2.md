---
title: "[Azure Automation] Migrer vos scripts vers Azure – Partie 2"
date: "2017-05-19"
author: "Florent Appointaire"
permalink: "/2017/05/19/azure-automation-migrer-vos-scripts-vers-azure-partie-2/"
summary: 
categories: 
  - "azure-automation"
tags: 
  - "azure-automation"
  - "dsc"
  - "microsoft"
---
Je me suis récemment intéréssé à Azure Automation, de fond en comble. C’est pourquoi, dans les 2 prochains articles, nous allons voir comment utiliser cette outil, de A à Z:

- [\[Azure Automation\] Découverte de l’interface – Partie 1](https://cloudyjourney.fr/2017/05/09/azure-automation-decouverte-de-linterface-partie-1/) 
- \[Azure Automation\] Migrer vos scripts vers Azure – Partie 2 (ce billet)

Aujourd'hui nous allons voir comment migrer les scripts qui sont On-Premises, vers Azure Automation. Dans mon environnement, j'ai 5 scripts PowerShell, qui tournent avec des tâches planifiées:

- BackupOneDriveFolder: Backup mon dossier OneDrive vers mon Synology & vers un Blob Storage Azure
- BackuppfSenseConfiguration: Backup la configuration de mon pfSense vers un Blob Storage Azure
- CheckCertificateValidity: Vérifie la validité des certificats de mes sites web
- GetHyperVReport: Génère un rapport de mes serveurs Hyper-V
- UpdateS2SPublicIP: Met à jour mon IP publique, basé sur mon NoIP

Le principe est simple: migrer ces 5 scripts vers Azure Automation. Je vais avoir besoin de Azure et d'un Hybrid Worker pour exécuter ces scripts. La première étapes est de créer vos **Schedules**, qui correspondent à ceux de vos tâches planifiées. Sur votre compte Azure Automation, allez dans **Schedules** et créez les schedules dont vous avez besoin:

[![](https://cloudyjourney.fr/wp-content/uploads/2017/05/5531.AA01.png)](https://cloudyjourney.fr/wp-content/uploads/2017/05/5531.AA01.png)

La prochaine étape est d'importer les modules dont vous avez besoin dans vos scripts, dans la partie **Modules**. Si vous utilisez des Hybrid Worker, installez également les bons modules sur le serveur qui aura la connexion Hybrid:

[![](https://cloudyjourney.fr/wp-content/uploads/2017/05/5531.AA02.png)](https://cloudyjourney.fr/wp-content/uploads/2017/05/5531.AA02.png)

Dans la partie **Assets**, créez les **Variables** dont vous avez besoin dans vos scripts. Créez également des **Credentials**:

[![](https://cloudyjourney.fr/wp-content/uploads/2017/05/8255.AA03.png)](https://cloudyjourney.fr/wp-content/uploads/2017/05/8255.AA03.png)

[![](https://cloudyjourney.fr/wp-content/uploads/2017/05/7607.AA04.png)](https://cloudyjourney.fr/wp-content/uploads/2017/05/7607.AA04.png)

Quand les prérequis sont prêts, vous pouvez commencer la migration.

Premièrement, créez un nouveau runbook, nommez le et choisissez comme type PowerShell. Collez le script PowerShell associé à votre script:

[![](https://cloudyjourney.fr/wp-content/uploads/2017/05/7607.AA05.png)](https://cloudyjourney.fr/wp-content/uploads/2017/05/7607.AA05.png)

Adaptez les variables que vous utilisez On-Prem, les utilisateurs/mots de passes ou les clés avec les variables que vous avez créé. Vous utiliserez **Get-AutomationVariable** pour récupérer les variable et **Get-AutomationPSCredential** pour récupérer les credentials. Normalement, c'est la seul chose que vous avez besoin de changer. Le script reste le même. Vous pouvez tester le script avec le **Test Pane**. Et parce que j'ai besoin de copier des fichiers sur mon Synology qui est On-Prem, je dois utiliser un connexion Hybrid Worker:

[![](https://cloudyjourney.fr/wp-content/uploads/2017/05/1321.AA06.png)](https://cloudyjourney.fr/wp-content/uploads/2017/05/1321.AA06.png)

Quand le script est terminé, vous devriez voir ceci dans la partie logs:

[![](https://cloudyjourney.fr/wp-content/uploads/2017/05/1321.AA07.png)](https://cloudyjourney.fr/wp-content/uploads/2017/05/1321.AA07.png)

Maintenant que vous avez vérifié que votre script fonctionnait correctement, sauvegardez le script en cliquant sur **Save** et publiez le en cliquant sur **Publish**. Vous pouvez lier un schedule à ce runbook, basé sur les schedules créés avant. N'oubliez pas de modifier les paramètres en choisissant si vous souhaitez exécuter le runbook On-Prem avec un Hybrid Worker ou sur Azure. Si votre script a besoin de paramètres, vous pouvez les compléter ici:

[![](https://cloudyjourney.fr/wp-content/uploads/2017/05/4035.AA08.png)](https://cloudyjourney.fr/wp-content/uploads/2017/05/4035.AA08.png)

Faites ceci pour chaque script que vous souhaitez migrer. Vous pouvez suivre l'exécution des scripts directement dans la partie **Jobs** de votre compte Azure Automation:

[![](https://cloudyjourney.fr/wp-content/uploads/2017/05/85345.AA09.png)](https://cloudyjourney.fr/wp-content/uploads/2017/05/85345.AA09.png)

Comme dans une session PowerShell, si des erreurs apparaissent, vous pouvez les consulter dans les logs:

[![](https://cloudyjourney.fr/wp-content/uploads/2017/05/3487.AA10.png)](https://cloudyjourney.fr/wp-content/uploads/2017/05/3487.AA10.png)

Le process est très simple. Après que vous ayez migré tous vos scripts, vous avez juste une console pour gérer les scripts, les logs, les variables, etc. Donc, n'hésitez pas à migrer  :)
