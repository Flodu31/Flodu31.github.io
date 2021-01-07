---
title: "[Azure] Intégration des serveurs pour le monitoring depuis WAC"
date: "2019-04-23"
author: "Florent Appointaire"
permalink: "/2019/04/23/azure-integration-des-serveurs-pour-le-monitoring-depuis-wac/"
summary:
categories: 
  - "azure"
  - "oms"
tags: 
  - "azure"
  - "log-analytics"
  - "microsoft"
  - "oms"
  - "wac"
  - "windows-admin-center"
---
Depuis les dernières version du Windows Admin Center, et à chaque nouvelle version, Microsoft ajoute des modules pour l'intégration de la partie On-Premises avec Azure. Par exemple, pour la partie patching, elle peut être gérée depuis le WAC, mais intégré avec Azure Automation Patch Management.

Aujourd'hui, je vais vous montrer comment intégrer le monitoring et les alertes, directement depuis le WAC, pour vos serveurs. Pour commencer, connectez vous à votre WAC, puis connectez vous sur une machine, et cliquez sur **Settings**:

![](https://cloudyjourney.fr/wp-content/uploads/2019/04/WAC-Monitoring-01.png)

Allez dans **Monitoring Alerts > Set Up**. Connectez-vous à votre compte Azure qui contient un workspace Log Analytics:

![](https://cloudyjourney.fr/wp-content/uploads/2019/04/WAC-Monitoring-02.png)

Confirmez la liaison en cliquant sur **Set Up**:

![](https://cloudyjourney.fr/wp-content/uploads/2019/04/WAC-Monitoring-03.png)

Si votre association s'est bien passée, rendez-vous dans votre Azure Monitor:

![](https://cloudyjourney.fr/wp-content/uploads/2019/04/WAC-Monitoring-04.png)

Ici, vous pouvez faire une recherche pour les logs du serveur que vous venez d'ajouter, après quelques minutes. Pour créer une nouvelle alerte basé sur cette recherche, cliquez sur **New alert rule:**

![](https://cloudyjourney.fr/wp-content/uploads/2019/04/WAC-Monitoring-05.png)

Vous pouvez créer votre alerte, et comment vous souhaitez recevoir les alertes:

![](https://cloudyjourney.fr/wp-content/uploads/2019/04/WAC-Monitoring-06.png)

Vivement les nouvelles features pour l'intégration avec Azure.