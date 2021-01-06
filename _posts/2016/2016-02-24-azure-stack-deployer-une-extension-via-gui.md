---
title: "[Azure Stack] Déployer une Extension via GUI"
date: "2016-02-24"
author: "Florent Appointaire"
permalink: "/2020/02/24/azure-stack-deployer-une-extension-via-gui/"
summary: 
categories: 
  - "azure-stack"
tags: 
  - "azure-stack"
  - "microsoft"
  - "powershell"
---
Actuellement, sur Azure Stack, le seul moyen de déployer une extension sur une VM est en PowerShell. C’est pourquoi j’ai eu l’idée de créer une interface pour déployer une extension sur une VM. Vous pourrez trouver le script sur la galerie TechNet: [https://gallery.technet.microsoft.com/Deploy-extension-on-Azure-49857cf0](https://gallery.technet.microsoft.com/Deploy-extension-on-Azure-49857cf0 "https://gallery.technet.microsoft.com/Deploy-extension-on-Azure-49857cf0")

[![](https://cloudyjourney.fr/wp-content/uploads/2018/01/2016-02-24_16-51-23.png)](https://cloudyjourney.fr/wp-content/uploads/2018/01/2016-02-24_16-51-23.png)

J’ai essayé le script pour les extensions BGInfo et VMAccess. Je testerai les autres rapidement.

N’hésitez pas à me contacter si vous trouvez des bugs.