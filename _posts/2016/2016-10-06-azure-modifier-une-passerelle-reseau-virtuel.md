---
title: "[Azure] Modifier une passerelle réseau virtuel"
date: "2016-10-06"
categories: 
  - "azure"
  - "reseau"
tags: 
  - "azure"
  - "microsoft"
---

[![](https://cloudyjourney.fr/wp-content/uploads/2018/01/pastedimage1482154059354v1.png)](https://cloudyjourney.fr/wp-content/uploads/2018/01/pastedimage1482154059354v1.png)

Aujourd’hui, un client m’a demandé de changé le **SKU** de sa Virtual Network Gateway de **Standard** à **Basic.** Pour plus d’information, allez jeter un œil ici: [https://azure.microsoft.com/en-us/documentation/articles/vpn-gateway-about-vpngateways/#gateway-skus](https://azure.microsoft.com/en-us/documentation/articles/vpn-gateway-about-vpngateways/#gateway-skus "https://azure.microsoft.com/en-us/documentation/articles/vpn-gateway-about-vpngateways/#gateway-skus")

Le problème ici, est qu’il n’a pas trouvé comment le faire par l’interface graphique. Ceci n’est pas disponible pour le moment. Le seul moyen de le faire est donc de le faire avec PowerShell

Pour commencer, nous allons vérifier que le Virtual Network Gateway à modifier est bien sur le **SKU Standard:**

`Get-AzureRmVirtualNetworkGateway –ResourceGroupName Microsofttouch –Name MSTouchVNG`

[![](https://cloudyjourney.fr/wp-content/uploads/2018/01/2016-10-05_19-28-12.png)](https://cloudyjourney.fr/wp-content/uploads/2018/01/2016-10-05_19-28-12.png)

Stockez le résultat dans une variable que nous utiliserons pour la modification:

[![](https://cloudyjourney.fr/wp-content/uploads/2018/01/2016-10-05_19-28-59.png)](https://cloudyjourney.fr/wp-content/uploads/2018/01/2016-10-05_19-28-59.png)

Pour mettre à jour, utilisez maintenant la commande suivante:

`Set-AzureRmVirtualNetworkGateway –VirtualNetworkGateway $Gateway –GatewaySku Basic`

[![](https://cloudyjourney.fr/wp-content/uploads/2018/01/2016-10-05_19-29-09.png)](https://cloudyjourney.fr/wp-content/uploads/2018/01/2016-10-05_19-29-09.png)

La mise à jour est en cours et a pris chez moi 10 minutes:

[![](https://cloudyjourney.fr/wp-content/uploads/2018/01/2016-10-05_19-30-41.png)](https://cloudyjourney.fr/wp-content/uploads/2018/01/2016-10-05_19-30-41.png)

Une fois terminé, vous devriez avoir ceci:

[![](https://cloudyjourney.fr/wp-content/uploads/2018/01/2016-10-05_19-30-53.png)](https://cloudyjourney.fr/wp-content/uploads/2018/01/2016-10-05_19-30-53.png)
