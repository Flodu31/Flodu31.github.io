---
title: "Créer une VPN Gateway Basic dans Azure"
date: "2024-02-08"
author: "Florent Appointaire"
permalink: "/2024/02/08/2024-02-08-Creer-VPN-Basic/"
summary: 
categories: 
  - "azure"
tags:
  - "azure"
  - "microsoft"
  - "vpn gateway"
  - "basic"
---

Comme vous le savez, à partir du 30 Septembre 2025, le SKU Basic pour les publics IPs sera retiré sur Azure, et à partir du 30 Mars 2025, il ne sera même plus possible d'en créer: <a href="https://azure.microsoft.com/en-us/updates/upgrade-to-standard-sku-public-ip-addresses-in-azure-by-30-september-2025-basic-sku-will-be-retired/" target="_blank">Upgrade to Standard SKU public IP addresses in Azure by 30 September 2025—Basic SKU will be retired</a>

L'annonce n'est pas nouvelle, mais Microsoft envoie déjà les mails de rappels pour ceux qui possèdent des publics IPs Basic, ce qui est mon cas dans ma souscription de test.

J'ai donc voulu migrer cette IP public vers un SKU Standard. Souci, ma VNet Gateway attachée ne me permettait pas de faire ça, je l'ai donc supprimer, et j'ai pu migrer mon IP publique vers le SKU Standard. Mais au moment de vouloir re-créer ma VNet Gateway, le SKU Basic n'était plus disponible. Les autres SKUs étant beaucoup trop cher pour ma souscription de test (Basic: 30€/mois vs VpnGw1: 130€/mois), j'ai décidé de
de rester sur du Basic, or, <a href="https://learn.microsoft.com/en-us/azure/vpn-gateway/vpn-gateway-vpn-faq#vpn-basic" target="_blank">le Basic ne peux plus se déployer via le portail</a>, mais que en CLI/PowerShell. J'ai donc fait ceci, et la nouvelle erreur. Le SKU Standard public IP n'est pas encore supporté pour une VPN Gateway Basic, <a href="https://learn.microsoft.com/en-us/azure/vpn-gateway/vpn-gateway-vpn-faq#is-vpn-gateway-basic-sku-retiring-as-well-" target="_blank">mais le sera prochainement</a>.

J'ai donc du recréer une public IP Basic, avec assignment dynamique, et j'ai enfin pu redéployer ma VPN Gateway Basic. Le script complet est ici:

<a href="https://github.com/Flodu31/Flodu31.github.io/blob/master/assets/images/2024/VNETGATEWAY_Basic.ps1" target="_blank">VNETGATEWAY_Basic.ps1</a>

Donc voila, il n'y a plus qu'à attendre que Microsoft rende disponible le support des IPs publiques Standard avec des VPN Gateway Basic :)