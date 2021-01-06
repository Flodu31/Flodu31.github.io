---
title: "[Azure] ExpressRoute et Application Gateway/WAF"
date: "2019-07-22"
categories: 
  - "azure"
tags: 
  - "application-gateway"
  - "azure"
  - "expressroute"
  - "microsoft"
  - "waf"
---

![](https://cloudyjourney.fr/wp-content/uploads/2018/01/Azure.png)

Souci étrange aujourd'hui chez un de mes clients au moment d'implémenter l'Application Gateway sur un VNet qui contient une VNet Gateway et un Express Route. J'ai en effet eu, à chaque essai de déploiement, le message d'erreur suivant:

![](https://i2.wp.com/cloudyjourney.fr/wp-content/uploads/2019/07/AppGW-ER-01.png?fit=762%2C950&ssl=1)

Après avoir contacté Microsoft pour savoir d'où provenait l'erreur, il s'avère que lorsque votre Express Route annonce une Default Gateway, cette dernière n'est pas supporté par le déploiement d'un Application Gateway/WAF sur ce même VNet.

Le workaround, vous l'aurez compris, est donc de déployer un 2ème VNet, spécialement pour l'Application Gateway/WAF, et faire un VNet peering entre les 2 VNets, en désactivant la propriété **gatewaytransit**.

Une fois que ceci est terminé, vous aurez juste à mettre les IPs/FQDN des VMs qui doivent se trouver dans des BackendPools.

Une mise à jour pour l'intégration de l'Application Gateway/WAF dans un VNet qui comprend un ExpressRoute avec une Default Gateway annoncé devrait voir le jour prochainement. Je ne manquerai pas de vous faire part de cette évolution.
