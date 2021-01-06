---
title: "[Azure] Route par défaut dans une VNet Gateway"
date: "2020-10-02"
author: "Florent Appointaire"
permalink: "/2020/10/02/azure-route-par-defaut-dans-une-vnet-gateway/"
summary:
categories: 
  - "azure"
tags: 
  - "azure"
  - "powershell"
  - "s2s-vpn"
  - "vnet-gateway"
---
En voulant rediriger tout le trafic vers le VPN S2S, même le trafic internet, j'ai créé une route table avec la route 0.0.0.0/0 vers la Virtual Network Gateway.

Mais ceci ne suffit pas, dans votre local network gateway, vous devez également ajouter le 0.0.0.0/0. Seulement, ceci n'est pas possible.

En cherchant sur la doc de Microsoft, je suis tombé sur cet article, avec la ligne 7, qui permet de faire cette route, en PowerShell:

[https://docs.microsoft.com/en-us/azure/vpn-gateway/vpn-gateway-forced-tunneling-rm#configure-forced-tunneling](https://docs.microsoft.com/en-us/azure/vpn-gateway/vpn-gateway-forced-tunneling-rm#configure-forced-tunneling)

J'ai donc exécuté ces 3 commandes:

```
$LocalGateway = Get-AzLocalNetworkGateway -Name "LN01" -ResourceGroupName "S2SVPN"
$VirtualGateway = Get-AzVirtualNetworkGateway -Name "VNetGW01" -ResourceGroupName "S2SVPN"
Set-AzVirtualNetworkGatewayDefaultSite -GatewayDefaultSite $LocalGateway -VirtualNetworkGateway $VirtualGateway
```

![](https://cloudyjourney.fr/wp-content/uploads/2020/10/AzureVNetLocal01-1024x531.png)

Maintenant, tout le trafic est redirigé via mon VPN S2S.
