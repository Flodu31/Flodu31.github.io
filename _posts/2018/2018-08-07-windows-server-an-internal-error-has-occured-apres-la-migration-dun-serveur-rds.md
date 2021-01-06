---
title: "[Windows Server] An internal error has occured après la migration d'un serveur RDS"
date: "2018-08-07"
categories: 
  - "autres"
tags: 
  - "azure"
  - "microsoft"
  - "remote-desktop-services"
---

[![](https://cloudyjourney.fr/wp-content/uploads/2018/08/Windows-server-2016_logo.png)](https://cloudyjourney.fr/wp-content/uploads/2018/08/Windows-server-2016_logo.png)

En migrant une VM RDS de On-Premises vers Azure (seul l'adresse IP a changé), je me suis retrouvé dans l'incapacité de me connecter à la VM, via RDS. Toutes les connexions à distance fonctionnaient, sauf le RDP, avec le message suivant:

> An internal error has occured

[![](https://cloudyjourney.fr/wp-content/uploads/2018/08/RDPInternalError01.png)](https://cloudyjourney.fr/wp-content/uploads/2018/08/RDPInternalError01.png)

Après quelques recherches, je suis tombé sur [ce sujet](https://community.spiceworks.com/topic/1272466-remote-desktop-error-an-internal-error-has-occurred?page=2), qui donne la solution suivante, en regénérant le certificat utilisé pour le RDP, avec les commandes suivantes:

New-SelfSignedCertificate -Certstorelocation cert:\\localmachine\\my -Dnsname FQDN-Of-The-Server
wmic /namespace:\\\\root\\CIMV2\\TerminalServices PATH Win32\_TSGeneralSetting Set SSLCertificateSHA1Hash="Thumbprint of certificate generate before"

[![](https://cloudyjourney.fr/wp-content/uploads/2018/08/RDPInternalError02.png)](https://cloudyjourney.fr/wp-content/uploads/2018/08/RDPInternalError02.png)

Après avoir fait ceci, j'ai pu me reconnecter, sans impact, à mon serveur :)
