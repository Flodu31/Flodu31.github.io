---
title: "[Azure] Changer la timezone d'une WebApp"
date: "2018-09-04"
categories: 
  - "azure-web-apps"
tags: 
  - "azure"
  - "microsoft"
  - "timezone"
  - "webapp"
---

[![](https://cloudyjourney.fr/wp-content/uploads/2018/09/WebApp_Logo.png)](https://cloudyjourney.fr/wp-content/uploads/2018/09/WebApp_Logo.png)

Après avoir migré un serveur IIS vers une WebApp PaaS de chez Azure, il y a eu un souci au niveau des dates. En effet, le code utilisait la date du serveur. Or, dans Azure, par défaut, la WebApp est sur UTC, pour un déploiement en West Eruope, comme vous pouvez le voir ci-dessous:

[![](https://cloudyjourney.fr/wp-content/uploads/2018/09/WebAppTimeZone01.png)](https://cloudyjourney.fr/wp-content/uploads/2018/09/WebAppTimeZone01.png)

Pour changer la timezone de la WebApp, il faut donc ajouter un paramètres dans **Application settings** avec comme nom **WEBSITE\_TIME\_ZONE**, comme vous pouvez le trouver dans la documentation suivante : [https://github.com/projectkudu/kudu/wiki/Configurable-settings#set-the-time-zone](https://github.com/projectkudu/kudu/wiki/Configurable-settings#set-the-time-zone)

Pour avoir les valeurs que vous pouvez associer, rendez-vous ici: [https://docs.microsoft.com/en-us/previous-versions/windows/it-pro/windows-vista/cc749073(v=ws.10)](https://docs.microsoft.com/en-us/previous-versions/windows/it-pro/windows-vista/cc749073(v=ws.10))

Pour ma part, j'ai mis **Romance Standard Time** qui correspond à Bruxelles:

[![](https://cloudyjourney.fr/wp-content/uploads/2018/09/WebAppTimeZone02.png)](https://cloudyjourney.fr/wp-content/uploads/2018/09/WebAppTimeZone02.png)

Sauvegardez. Votre WebApp utilise maintenant la bonne heure :)

[![](https://cloudyjourney.fr/wp-content/uploads/2018/09/WebAppTimeZone03.png)](https://cloudyjourney.fr/wp-content/uploads/2018/09/WebAppTimeZone03.png)
