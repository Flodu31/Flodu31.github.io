---
title: "[Azure] Erreur OMS Gateway"
date: "2020-03-02"
author: "Florent Appointaire"
permalink: "/2020/03/02/azure-erreur-oms-gateway/"
summary: 
categories: 
  - "oms"
tags: 
  - "azure"
  - "event-id-105"
  - "microsoft"
  - "oms"
  - "oms-gateway"
---
En déployant une Gateway OMS, pour Windows Defender ATP, j'ai eu l'erreur suivante:

```
2020-02-28 13:19:05 [47] ERROR GatewayLogic - Target host (winatp-gw-uks.microsoft.com) is forbidden. Destination server is not in allowed list. Ensure that the Microsoft Monitoring Agent on your Gateway box and the agents talking to the Gateway, are both connected to the same Log Analytics workspace.
```

![](https://cloudyjourney.fr/wp-content/uploads/2020/02/image-1.png)

Cette erreur indique que la gateway OMS ne peut pas communiquer avec l'URL qui est indiquée. J'ai donc regardé les connexions entrante sur le serveur OMS gateway, et j'ai pu voir que certains serveurs étaient avec le status **TIME\_WAIT** après avoir fait un **netstat -an**:

![](https://cloudyjourney.fr/wp-content/uploads/2020/02/image.png)

Après quelques recherches, j'ai trouvé la commande PowerShell **Add-OMSGatewayAllowedHost** sur la gateway. J'ai donc autorisé les URLs que j'avais en erreur, et redémarré le service **OMSGatewayService**:

```
Add-OMSGatewayAllowedHost -Host winatp-gw-weu.microsoft.com -Force
Add-OMSGatewayAllowedHost -Host winatp-gw-cus.microsoft.com -Force
Add-OMSGatewayAllowedHost -Host winatp-gw-eus.microsoft.com -Force
Add-OMSGatewayAllowedHost -Host eu-v20.events.data.microsoft.com -Force
Add-OMSGatewayAllowedHost -Host v20.events.data.microsoft.com -Force
Add-OMSGatewayAllowedHost -Host settings-win.data.microsoft.com -Force
Restart-Service OMSGatewayService 
```

![](https://cloudyjourney.fr/wp-content/uploads/2020/02/image-2.png)

Après le redémarrage du service, plus aucune erreur n'est apparue:

![](https://cloudyjourney.fr/wp-content/uploads/2020/02/image-3.png)

En espérant vous avoir fait gagner du temps :)