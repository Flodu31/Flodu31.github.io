---
title: "[Azure] Windows Virtual Desktop - Publication d'applications"
date: "2019-04-25"
author: "Florent Appointaire"
permalink: "/2019/04/25/azure-windows-virtual-desktop-publication-dapplications/"
summary:
categories: 
  - "azure"
tags: 
  - "azure"
  - "microsoft"
  - "rds"
  - "remote-desktop-services"
  - "windows-virtual-desktop"
---
Après avoir vu [comment déployer Windows Virtual Desktop](https://cloudyjourney.fr/2019/04/24/azure-windows-virtual-desktop/), en mode session, nous allons voir comment déployer des applications.

Utilisant l'image de base, je n'ai que les applications de base à publier. Si vous souhaitez déployer des applications personnalisées, il vous faudra créer une image, et l'utiliser comme image de base pour votre déploiement.

Pour publier une application, vous devez commencer par créer un groupe, avec les commandes suivantes:

```
$brokerurl = "https://rdbroker.wvd.microsoft.com"
Add-RdsAccount -DeploymentUrl $brokerurl
New-RdsAppGroup FlorentAppointaire FLOAPP-WVD "RemoteApp Application Group" -ResourceType "RemoteApp"
Get-RdsAppGroup FlorentAppointaire FLOAPP-WVD
```

![](https://cloudyjourney.fr/wp-content/uploads/2019/04/WVD1-01.png)

Vous pouvez ensuite récupérer les applications qui peuvent être publiées, avec la commande suivante:

```
Get-RdsStartMenuApp FlorentAppointaire FLOAPP-WVD "RemoteApp Application Group"
```

![](https://cloudyjourney.fr/wp-content/uploads/2019/04/WVD1-02.png)

Pour publier une ou des applications, utilisez les commandes suivantes:

```
New-RdsRemoteApp FlorentAppointaire FLOAPP-WVD "RemoteApp Application Group" -Name "Internet Explorer" -AppAlias "internetexplorer"
New-RdsRemoteApp FlorentAppointaire FLOAPP-WVD "RemoteApp Application Group" -Name "Task Manager" -AppAlias "taskmanager"
New-RdsRemoteApp FlorentAppointaire FLOAPP-WVD "RemoteApp Application Group" -Name "Paint" -AppAlias "paint"
New-RdsRemoteApp FlorentAppointaire FLOAPP-WVD "RemoteApp Application Group" -Name "Wordpad" -AppAlias "wordpad"
```

![](https://cloudyjourney.fr/wp-content/uploads/2019/04/WVD1-03.png)

Vous pouvez vérifier que les applications ont bien été publiées:

```
Get-RdsRemoteApp FlorentAppointaire FLOAPP-WVD "RemoteApp Application Group"
```

![](https://cloudyjourney.fr/wp-content/uploads/2019/04/WVD1-04.png)

Il faut ensuite assigner ce groupe à un utilisateur. Attention, pour le moment, [un utilisateur peut être assigné à un seul groupe](https://github.com/MicrosoftDocs/azure-docs/issues/28080) et cet utilisateur ne doit pas avoir de MFA actif:

```
Add-RdsAppGroupUser FlorentAppointaire FLOAPP-WVD "RemoteApp Application Group" -UserPrincipalName florent.appointaire@florentappointaire.cloud
```

![](https://cloudyjourney.fr/wp-content/uploads/2019/04/WVD1-05.png)

En vous connectant avec cet utilisateur, vous pouvez voir les applications qui ont été publiées sur le portail:

![](https://cloudyjourney.fr/wp-content/uploads/2019/04/WVD1-06.png)

![](https://cloudyjourney.fr/wp-content/uploads/2019/04/WVD1-07.png)

Ou depuis l'application:

![](https://cloudyjourney.fr/wp-content/uploads/2019/04/WVD1-08.png)

![](https://cloudyjourney.fr/wp-content/uploads/2019/04/WVD1-09.png)

A noter que des raccourcis sont apparus dans le menu démarrer:

![](https://cloudyjourney.fr/wp-content/uploads/2019/04/WVD1-10.png)

Windows Virtual Desktop est encore en Preview c'est pourquoi il manque certaines fonctionnalités. Cependant, à terme, WVD devrait être un concurrent sérieux à Citrix on Azure.