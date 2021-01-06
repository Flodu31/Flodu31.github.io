---
title: "[Azure] Intégration des serveurs pour le monitoring depuis WAC"
date: "2019-04-23"
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

![](https://cloudyjourney.fr/wp-content/uploads/2018/01/Azure.png)

Depuis les dernières version du Windows Admin Center, et à chaque nouvelle version, Microsoft ajoute des modules pour l'intégration de la partie On-Premises avec Azure. Par exemple, pour la partie patching, elle peut être gérée depuis le WAC, mais intégré avec Azure Automation Patch Management.

Aujourd'hui, je vais vous montrer comment intégrer le monitoring et les alertes, directement depuis le WAC, pour vos serveurs. Pour commencer, connectez vous à votre WAC, puis connectez vous sur une machine, et cliquez sur **Settings**:

![](https://i0.wp.com/cloudyjourney.fr/wp-content/uploads/2019/04/WAC-Monitoring-01.png?fit=762%2C416&ssl=1)

Allez dans **Monitoring Alerts > Set Up**. Connectez-vous à votre compte Azure qui contient un workspace Log Analytics:

![](https://i0.wp.com/cloudyjourney.fr/wp-content/uploads/2019/04/WAC-Monitoring-02.png?fit=762%2C415&ssl=1)

Confirmez la liaison en cliquant sur **Set Up**:

![](https://cloudyjourney.fr/wp-content/uploads/2019/04/WAC-Monitoring-03.png)

Si votre association s'est bien passée, rendez-vous dans votre Azure Monitor:

![](https://i2.wp.com/cloudyjourney.fr/wp-content/uploads/2019/04/WAC-Monitoring-04.png?fit=762%2C238&ssl=1)

Ici, vous pouvez faire une recherche pour les logs du serveur que vous venez d'ajouter, après quelques minutes. Pour créer une nouvelle alerte basé sur cette recherche, cliquez sur **New alert rule:**

![](https://i1.wp.com/cloudyjourney.fr/wp-content/uploads/2019/04/WAC-Monitoring-05.png?fit=762%2C396&ssl=1)

Vous pouvez créer votre alerte, et comment vous souhaitez recevoir les alertes:

![](https://i1.wp.com/cloudyjourney.fr/wp-content/uploads/2019/04/WAC-Monitoring-06.png?fit=762%2C632&ssl=1)

Vivement les nouvelles features pour l'intégration avec Azure.
