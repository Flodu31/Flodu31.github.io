---
title: "[PowerShell] Mettre à jour son IP Publique d’un VPN S2S avec une IP dynamique"
date: "2016-05-30"
categories: 
  - "azure"
  - "powershell"
tags: 
  - "azure"
  - "azure-automation"
  - "microsoft"
  - "powershell"
---

[![](https://cloudyjourney.fr/wp-content/uploads/2018/01/PowerShell.png)](https://cloudyjourney.fr/wp-content/uploads/2018/01/PowerShell.png)

Voulant faire un VPN S2S avec ma suscription Azure, et n’ayant pas d’IP fixe chez moi sur mon lab, j’ai cherché sur internet et j’ai trouvé ce sujet, qui traité ce problème: [https://www.vnext.be/2013/12/01/windows-azure-s2s-vpn-with-dynamic-public-ip/](https://www.vnext.be/2013/12/01/windows-azure-s2s-vpn-with-dynamic-public-ip/)

Le seul souci ici, c’est que ce script est adapté pour Azure classique et non pas Azure Resource Manager.

J’ai donc adapté ce script pour pouvoir mettre à jour votre IP publique dynamique  sur Azure, pour que votre VPN S2S via ARM fonctionne avec une interruption limitée. Chez moi, ce script est exécuté toutes les 5 minutes. Je ferai la version pour Azure Automation un peu plus tard.

N’hésitez pas à me donnez vos commentaires/remarques :)

Le lien: [https://gallery.technet.microsoft.com/Update-AzureRM-S2S-VPN-c46cc39e](https://gallery.technet.microsoft.com/Update-AzureRM-S2S-VPN-c46cc39e "https://gallery.technet.microsoft.com/Update-AzureRM-S2S-VPN-c46cc39e")
