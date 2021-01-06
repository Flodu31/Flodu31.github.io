---
title: "[Azure Automation] Découverte de l’interface – Partie 1"
date: "2017-05-09"
author: "Florent Appointaire"
permalink: "/2017/05/09/azure-automation-decouverte-de-linterface-partie-1/"
summary: 
categories: 
  - "azure-automation"
tags: 
  - "azure-automation"
  - "dsc"
  - "microsoft"
---
Je me suis récemment intéréssé à Azure Automation, de fond en comble. C’est pourquoi, dans les 2 prochains articles, nous allons voir comment utiliser cette outil, de A à Z:

- \[Azure Automation\] Découverte de l’interface – Partie 1 (ce billet)
- [\[Azure Automation\] Migrer vos scripts vers Azure – Partie 2](https://cloudyjourney.fr/2017/05/19/azure-automation-migrer-vos-scripts-vers-azure-partie-2/)

Commençons de suite avec le premier article.

Azure Automation est un service d’orchestration qui est disponible sur Azure, et qui vous offre la possibilité d’avoir 500 minutes gratuites et 5 noeuds DSC gratuits. Après ça, la minute coûte 0.002€ et le noeud DSC coûte 5.06€ : [https://azure.microsoft.com/en-us/pricing/details/automation/](https://azure.microsoft.com/en-us/pricing/details/automation/)

Azure automation va vous permettre d’avoir une seul et unique interface, pour gérez vos scripts. Par le passé, on utilisait le Task Scheduler de windows, sur plusieurs serveurs. Difficile de s’y retrouver après quelques années, et de savoir quel script tourne sur quell serveur. En rassemblant vos scripts sur Azure Automation, vous n’aurez plus ce problème, vous gererez vos scripts sur une seule et unique interface. Et pour les souci des scripts qui doivent accéder aux serveurs On-Premises, il y a la solution Hybrid Worker, qui, en installant un agent sur le serveur, vous permet d’exécuter les runbooks directement sur ce serveur.

Vous pouvez créer un compte Azure Automation, depuis l’interface Azure. Une fois ce compte créé, vous arrivez sur une interface semblable à celle-ci:

[![](https://cloudyjourney.fr/wp-content/uploads/2017/05/7875.AA01.png)](https://cloudyjourney.fr/wp-content/uploads/2017/05/7875.AA01.png)

Plusieurs points sont importants ici:

- Runbooks: ce sont vos scripts PowerShell, vos workflow que vous gérez ici.
- Jobs: Historique des tâches qui ont tourné.
- Assets: C’est ici que vous allez gérer vos variables, credentials, certificats, etc.
- Hybrid Worker Groups: Gérez les connexions vers vos serveurs ici.
- DSC Configurations: Gérez vos configurations DSC.
- DSC Nodes: Gérez vos noeuds DSC.

## Runbooks

Commençons par la partie **Runbooks.** Vous allez créer vos runbooks directement ici. Vous avez la possibilité de créer des Runbook avec PowerShell ou en Graphique, en normal ou en workflow:

![](https://cloudyjourney.fr/wp-content/uploads/2017/05/0042.AA02.png)

Vous pouvez également importer des runbooks qui ont été créés sur un autre compte Azure Automation ou des scripts PowerShell qui existent déjà.

## Jobs

Concernant la partie **Jobs,** c’est ici que vous allez avoir l’historique des runbooks qui ont été exécutés et si il y a des erreurs ou pas:

[![](https://cloudyjourney.fr/wp-content/uploads/2017/05/6470.AA03.png)](https://cloudyjourney.fr/wp-content/uploads/2017/05/6470.AA03.png)

## Assets

Passons à la partie **Assets.** Ici, vous allez pouvoir créer:

- Des schedules
- Importer des modules via la galerie ou que vous avez créé
- Des certificats
- Des connexions (vers Azure)
- Des variables
- Des Credentials

Les **schedules** vont vous permettre d’automatiser le départ de vos runbooks à des heures/jours bien précis:

[![](https://cloudyjourney.fr/wp-content/uploads/2017/05/8546.AA04.png)](https://cloudyjourney.fr/wp-content/uploads/2017/05/8546.AA04.png)

Les **modules** sont très importants. En effet, si vous souhaitez  utiliser des commandes d’un module, ce module doit être importé. Si vous executez le runbook avec un Hybrid Worker, le module doit être installé sur le serveur en question. Vous pouvez importer vos propre modules ou utiliser la galerie:

![](https://cloudyjourney.fr/wp-content/uploads/2017/05/1512.AA05.png)

La partie **Certificates** contient les certificats qui peuvent être utilisés dans les scripts (les extensions cer et pfx sont autorisées):

[![](https://cloudyjourney.fr/wp-content/uploads/2017/05/7041.AA06.png)](https://cloudyjourney.fr/wp-content/uploads/2017/05/7041.AA06.png)

La partie **Connections** vous permet de faire des connexions directement vers Azure ou un autre service et de les utiliser par la suite dans des scripts:

![](https://cloudyjourney.fr/wp-content/uploads/2017/05/0116.AA07.png)

Explorons maintenant la partie **Variables**. Cette partie est très interéssante car c’est ici que vous allez créer des variables pour utiliser dans les scripts. L’utilisation de variables est pratique car vous avez juste à modifier la variable sans toucher au script. Vous avez plusieurs type pour les variables et vous pouvez les encrypter si jamais vous voulez stocker des mot de passes, etc.

![](https://cloudyjourney.fr/wp-content/uploads/2017/05/5807.AA08.png)

Pour terminer, explorons la partie **Credentials**. Ici, vous allez créer une combinaison utilisateur/mot de passe, comme si vous utilisiez un Get-Credential en PowerShell:

[![](https://cloudyjourney.fr/wp-content/uploads/2017/05/3568.AA09.png)](https://cloudyjourney.fr/wp-content/uploads/2017/05/3568.AA09.png)

## Hybrid Workers

La partie hybrid workers va vous permettre d’exécuter des scripts On-Premises. En effet, après avoir installé l’agent sur un serveur, quand vous exécutez un runbook, vous pouvez choisir de l’exéctuer sur Azure ou sur un groupe Hybrid Worker. Ceci à l’avantage de faire tourner des scripts directement sur votre réseau local.

Pour faire ceci, vous devez disposer d’un workspace OMS: [https://www.microsoft.com/oms](https://www.microsoft.com/oms)

Avec la solution Azure Automation installée. Une fois ceci terminé, déployez l’agent OMS sur le serveur qui sera utilisé dans le groupe Hybrid Worker. Vous pouvez avoir plusieurs serveurs dans un groupe.

Configuez ensuite l’agent pour qu’il communique avec Azure Automation: [https://docs.microsoft.com/en-us/azure/automation/automation-hybrid-runbook-worker](https://docs.microsoft.com/en-us/azure/automation/automation-hybrid-runbook-worker)

Une fois la connexion établit, celle-ci apparait dans Azure Automation:

[![](https://cloudyjourney.fr/wp-content/uploads/2017/05/5635.AA10.png)](https://cloudyjourney.fr/wp-content/uploads/2017/05/5635.AA10.png)

## DSC Configuration

Ici, vous allez pouvoir importer vos configurations DSC:

[![](https://cloudyjourney.fr/wp-content/uploads/2017/05/3252.AA11.png)](https://cloudyjourney.fr/wp-content/uploads/2017/05/3252.AA11.png)

Et les compiler:

[![](https://cloudyjourney.fr/wp-content/uploads/2017/05/6406.AA12.png)](https://cloudyjourney.fr/wp-content/uploads/2017/05/6406.AA12.png)

[![](https://cloudyjourney.fr/wp-content/uploads/2017/05/7563.AA13.png)](https://cloudyjourney.fr/wp-content/uploads/2017/05/7563.AA13.png)

## DSC Nodes

Pour gérer les noeuds DSC, et appliquer les configurations, vous pouvez le faire directement depuis l’interface. Vous pouvez enregistrer des noeuds qui sont sur Azure (l’extension sera déployée automatiquement) ou enregistrer un serveur On-Premises:

[![](https://cloudyjourney.fr/wp-content/uploads/2017/05/0638.AA14.png)](https://cloudyjourney.fr/wp-content/uploads/2017/05/0638.AA14.png)

Une fois les noeuds sélectionnez, vous pouvez appliquer une première configuration:

[![](https://cloudyjourney.fr/wp-content/uploads/2017/05/2705.AA15.png)](https://cloudyjourney.fr/wp-content/uploads/2017/05/2705.AA15.png)

Après quelques minutes, l’agent est deployé, et les noeuds sont **Compliant:**

[![](https://cloudyjourney.fr/wp-content/uploads/2017/05/7585.AA16.png)](https://cloudyjourney.fr/wp-content/uploads/2017/05/7585.AA16.png)

## Monitoring

Pour avoir un aperçu rapide et complet, il y a sur la page d’accueil, les statistiques:

[![](https://cloudyjourney.fr/wp-content/uploads/2017/05/0652.AA17.png)](https://cloudyjourney.fr/wp-content/uploads/2017/05/0652.AA17.png)

Vous pouvez retrouver les clés si vous souhaitez appeler des runbooks depuis l’exterieur du compte Azure Automation:

[![](https://cloudyjourney.fr/wp-content/uploads/2017/05/5432.AA18.png)](https://cloudyjourney.fr/wp-content/uploads/2017/05/5432.AA18.png)

Mais aussi le détail sur les minutes gratuites restantes sur votre compte Azure Automation:

![](https://cloudyjourney.fr/wp-content/uploads/2017/05/2308.AA19.png)

Vous pouvez ensuite régler le controle des sources, avec Github, VSTS, etc:

[![](https://cloudyjourney.fr/wp-content/uploads/2017/05/8737.AA20.png)](https://cloudyjourney.fr/wp-content/uploads/2017/05/8737.AA20.png)

Enfin, pour terminer, vous pouvez utiliser des RunAs account vers votre Azure AD:

[![](https://cloudyjourney.fr/wp-content/uploads/2017/05/1803.AA21.png)](https://cloudyjourney.fr/wp-content/uploads/2017/05/1803.AA21.png)

C’est ainsi que se termine cette première découverte de Azure Automation. Dans la prochaine partie, nous allons voir par où commencer pour migrer vos scripts On-Premises vers Azure Automation.
