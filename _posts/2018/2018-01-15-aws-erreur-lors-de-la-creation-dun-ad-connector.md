---
title: "[AWS] Erreur lors de la création d'un AD Connector"
date: "2018-01-15"
author: "Florent Appointaire"
permalink: "/2018/01/15/aws-erreur-lors-de-la-creation-dun-ad-connector"
summary: 
categories: 
  - "ad-connector"
  - "aws"
tags: 
  - "ad-connector"
  - "aws"
---
En voulant créer un AD Connector sur AWS, avec mon serveur Active Directory, qui se trouve sur AWS EC2, j'ai eu l'erreur suivante:

> Connectivity issues detected: DNS unavailable (TCP port 53) for IP: X.X.X.X. Please ensure that the listed ports are available and retry the operation.

J'ai donc testé les DNS depuis une autre machine, et le firewall/Security Group était bien ouvert. J'ai alors regardé du côté du VPC pour voir si le DNS était bien renseigné sur mon VPC. Et l'erreur était ici.

En effet, par défaut, la partie DHCP Option de AWS ne renseigne que les DNS de AWS. Il faut en créer un nouveau, dans **VPC > DHCP Options Sets > Create DHCP Option set:**

[![](https://cloudyjourney.fr/wp-content/uploads/2018/01/2018-01-15_16-21-24.png)](https://cloudyjourney.fr/wp-content/uploads/2018/01/2018-01-15_16-21-24.png)

Allez ensuite dans **VPC > Your VPC** et choisissez le VPC où vous allez déployer votre AD Connector puis cliquez sur **Actions > Edit DHCP Options Set** et choisissez le nouveau DHCP Option que vous venez de créer, puis sauvegardez:

[![](https://cloudyjourney.fr/wp-content/uploads/2018/01/2018-01-15_16-23-10.png)](https://cloudyjourney.fr/wp-content/uploads/2018/01/2018-01-15_16-23-10.png)

Relancez le déploiement, et ceci va fonctionner sans problème.

En espérant vous avoir été utile :)
