---
title: "[OMS] Créer des rapports dans PowerBI"
date: "2017-07-18"
categories: 
  - "oms"
tags: 
  - "microsoft"
  - "oms"
  - "powerbi"
---

[![](https://cloudyjourney.fr/wp-content/uploads/2018/01/7563.OMSPowerBI00.png)](https://cloudyjourney.fr/wp-content/uploads/2018/01/7563.OMSPowerBI00.png)

Aujourd'hui nous allons découvrir comment connecté votre workspace OMS à PowerBI. Ceci est actuellement en Preview.

Pour commencer, connectez vous à votre workspace OMS et allez dans **Settings > Preview Features** et activez **PowerBI Integration:**

[![](https://cloudyjourney.fr/wp-content/uploads/2018/01/2376.OMSPowerBI01.png)](https://cloudyjourney.fr/wp-content/uploads/2018/01/2376.OMSPowerBI01.png)

Rafraichissez la page web. Dans **Settings,** vous avez un nouvel onglet, **Power BI.** Allez dans **Accounts > Workspace Information** et cliquez sur **Connect to Power BI Account.** Ce compte doit être un compte d'entreprise, connecté à Office 365 par exemple:

[![](https://cloudyjourney.fr/wp-content/uploads/2018/01/3343.OMSPowerBI02.png)](https://cloudyjourney.fr/wp-content/uploads/2018/01/3343.OMSPowerBI02.png)

Le compte est maintenant connecté:

[![](https://cloudyjourney.fr/wp-content/uploads/2018/01/3343.OMSPowerBI03.png)](https://cloudyjourney.fr/wp-content/uploads/2018/01/3343.OMSPowerBI03.png)

Si vous allez dans la partie **Log Search**, vous avez un nouvel icône, Power BI. Exécutez la recherche que vous souhaitez envoyer dans votre dashboard PowerBI et cliquez sur l'icône:

[![](https://cloudyjourney.fr/wp-content/uploads/2018/01/7167.OMSPowerBI04.png)](https://cloudyjourney.fr/wp-content/uploads/2018/01/7167.OMSPowerBI04.png)

Renseignez le nom de cette recherche et modifiez le temps d'execution de cette recherche. Donnez un nom au Dataset. Ce nom sera utilisé dans PowerBI.

[![](https://cloudyjourney.fr/wp-content/uploads/2018/01/7167.OMSPowerBI05.png)](https://cloudyjourney.fr/wp-content/uploads/2018/01/7167.OMSPowerBI05.png)

Si vous allez dans vos Settings, vous verrez votre recherche:

[![](https://cloudyjourney.fr/wp-content/uploads/2018/01/1781.OMSPowerBI06.png)](https://cloudyjourney.fr/wp-content/uploads/2018/01/1781.OMSPowerBI06.png)

Maintenant, allez sur [https://app.powerbi.com](https://app.powerbi.com/) et connectez vous avez le compte que vous avez utilisé dans OMS. Après quelques minutes, le dataset apparait:

[![](https://cloudyjourney.fr/wp-content/uploads/2018/01/1781.OMSPowerBI07.png)](https://cloudyjourney.fr/wp-content/uploads/2018/01/1781.OMSPowerBI07.png)

Vous pouvez maintenant créer un rapport. Dans mon exemple, il correspond aux OS qu'il y a dans mon environnement:

[![](https://cloudyjourney.fr/wp-content/uploads/2018/01/8233.OMSPowerBI08.png)](https://cloudyjourney.fr/wp-content/uploads/2018/01/8233.OMSPowerBI08.png)

[![](https://cloudyjourney.fr/wp-content/uploads/2018/01/3857.OMSPowerBI09.png)](https://cloudyjourney.fr/wp-content/uploads/2018/01/3857.OMSPowerBI09.png)

Vous avez les résultats directement sur le dashboard:

[![](https://cloudyjourney.fr/wp-content/uploads/2018/01/3857.OMSPowerBI10.png)](https://cloudyjourney.fr/wp-content/uploads/2018/01/3857.OMSPowerBI10.png)

Cliquez sur **Save** pour sauvegarder ce rapport pour y accéder plus facilement plus tard:

[![](https://cloudyjourney.fr/wp-content/uploads/2018/01/1200.OMSPowerBI11.png)](https://cloudyjourney.fr/wp-content/uploads/2018/01/1200.OMSPowerBI11.png)

Donnez lui un nom:

[![](https://cloudyjourney.fr/wp-content/uploads/2018/01/1200.OMSPowerBI12.png)](https://cloudyjourney.fr/wp-content/uploads/2018/01/1200.OMSPowerBI12.png)

Vous pouvez maintenant accéder au rapport rapidement:

[![](https://cloudyjourney.fr/wp-content/uploads/2018/01/4024.OMSPowerBI13.png)](https://cloudyjourney.fr/wp-content/uploads/2018/01/4024.OMSPowerBI13.png)

Cette nouvelle fonctionnalité est très intéressante, notamment pour les membres d'une équipe de management, qui doit avoir des rapport de façon régulière, etc.

Vous pouvez créer rapidement des dashboards dynamiques, sans connaissances dans OMS :)
