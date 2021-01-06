---
title: "[RDS] Nouvelle interface en HTML5 disponible"
date: "2018-07-24"
categories: 
  - "autres"
tags: 
  - "html5"
  - "microsoft"
  - "remote-desktop-services"
---

[![](https://cloudyjourney.fr/wp-content/uploads/2018/07/RDSLogo.png)](https://cloudyjourney.fr/wp-content/uploads/2018/07/RDSLogo.png)

Microsoft a rendu disponible le lundi 16 Juillet 2018 la version HTML 5 de son portail vieillissant RDS: [https://cloudblogs.microsoft.com/enterprisemobility/2018/07/16/remote-desktop-web-client-now-generally-available/](https://cloudblogs.microsoft.com/enterprisemobility/2018/07/16/remote-desktop-web-client-now-generally-available/) 

Ce dernier peut cohabiter avec l'ancien portail, ne vous privez donc pas de l'installer. Attention, il ne fonctionne qu'avec les ordinateurs sous Windows 10.

Tous les détails de l'installation sont disponibles ici : [https://docs.microsoft.com/en-us/windows-server/remote/remote-desktop-services/clients/remote-desktop-web-client-admin](https://docs.microsoft.com/en-us/windows-server/remote/remote-desktop-services/clients/remote-desktop-web-client-admin)

Pour commencer, vous devez exporter le certificat utilisé par le Connection Broker, en CER:

[![](https://cloudyjourney.fr/wp-content/uploads/2018/07/NewRDS01.png)](https://cloudyjourney.fr/wp-content/uploads/2018/07/NewRDS01.png)

Utilisez ensuite les commandes suivantes pour installer le module PowerShell qui va permettre le déploiement:

Install-Module -Name PowerShellGet -Force
Install-Module -Name RDWebClientManagement

[![](https://cloudyjourney.fr/wp-content/uploads/2018/07/NewRDS02.png)](https://cloudyjourney.fr/wp-content/uploads/2018/07/NewRDS02.png)

Si vous avez le warning comme j'ai eu, il suffit de fermer la console PowerShell, et de supprimer les anciennes versions dans C:\\Program Files\\WindowsPowerShell\\Modules\\PowerShellGet :

[![](https://cloudyjourney.fr/wp-content/uploads/2018/07/NewRDS03.png)](https://cloudyjourney.fr/wp-content/uploads/2018/07/NewRDS03.png)

Relancez la commande, l'installation va vous demander d'accepter la licence:

[![](https://cloudyjourney.fr/wp-content/uploads/2018/07/NewRDS04.png)](https://cloudyjourney.fr/wp-content/uploads/2018/07/NewRDS04.png)

Une fois le module PowerShell installé, utilisez les commandes suivantes pour installer la nouvelle interface:

Install-RDWebClientPackage
Import-RDWebClientBrokerCert C:\\Users\\FAppointaire\\Downloads\\CERFile.cer
Publish-RDWebClientPackage -Type Production -Latest

[![](https://cloudyjourney.fr/wp-content/uploads/2018/07/NewRDS05.png)](https://cloudyjourney.fr/wp-content/uploads/2018/07/NewRDS05.png)

Allez ensuite sur l'URL de votre serveur RDS, en ajoutant /webclient/index.html après le RDWeb, dans votre URL, pour utiliser le nouveau portail, puis connectez-vous avec votre compte habituel:

[![](https://cloudyjourney.fr/wp-content/uploads/2018/07/NewRDS06.png)](https://cloudyjourney.fr/wp-content/uploads/2018/07/NewRDS06.png)

Vous avez accès aux mêmes ressources que sur votre ancien portail:

[![](https://cloudyjourney.fr/wp-content/uploads/2018/07/NewRDS07.png)](https://cloudyjourney.fr/wp-content/uploads/2018/07/NewRDS07.png)

[![](https://cloudyjourney.fr/wp-content/uploads/2018/07/NewRDS08.png)](https://cloudyjourney.fr/wp-content/uploads/2018/07/NewRDS08.png)

L'arrivée du SSO sera disponible lors d'une prochaine version, comme le montre la Preview actuelle: [https://cloudblogs.microsoft.com/enterprisemobility/2018/07/09/remote-desktop-web-client-preview-updated-with-sso/](https://cloudblogs.microsoft.com/enterprisemobility/2018/07/09/remote-desktop-web-client-preview-updated-with-sso/)

N'hésitez donc pas à utiliser cette nouvelle interface :)
