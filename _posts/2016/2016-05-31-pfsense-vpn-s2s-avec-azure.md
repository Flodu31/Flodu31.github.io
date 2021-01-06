---
title: "[pfSense] VPN S2S avec Azure"
date: "2016-05-31"
author: "Florent Appointaire"
permalink: "/2016/05/31/pfsense-vpn-s2s-avec-azure/"
summary: 
categories: 
  - "reseau"
tags: 
  - "azure"
  - "microsoft"
  - "pfsense"
  - "s2s-vpn"
---
Voulant avoir un VPN chez moi et pourquoi pas un VPN avec Azure, on m’a conseillé d’utiliser [pfSense](https://www.pfsense.org/). Cette distribution est extrêmement flexible et vous offre la possibilité de connecter votre VM directement en PPPoE mais encore d’avoir un firewall performant, d’effectuer des connexions VPN, en IPSec, L2TP, OpenVPN, etc.

L’idée dans cet article sera donc de créer un VPN S2S avec Azure RM via pfSense.

J’ai dans un premier temps connecté ma VM pfSense (1vCPU, 512MB RAM), en PPPoE à mon FAI. Ayant une IP publique dynamique, j’ai créé un compte sur noip.com ainsi qu’un enregistrement DNS. J’ai ensuite connecté mon pfSense pour  mettre à jour cette IP publique automatiquement, dans **Services > Dynamic DNS**:

[![](https://cloudyjourney.fr/wp-content/uploads/2018/01/SNAGHTMLeb3953b_03B4FC3B.png)](https://cloudyjourney.fr/wp-content/uploads/2018/01/SNAGHTMLeb3953b_03B4FC3B.png)

Dès que ma VM va redémarrer ou que mon lease sera terminé, mon IP sera mise à jour directement sur mon NOIP.

# Azure

Je vais maintenant pouvoir créer mon VPN sur Azure. Allez sur [https://portal.azure.com](https://portal.azure.com/) et connectez vous sur votre suscription. Assurez vous d’avoir créé réseau virtuel, dans Resource Manager:

[![](https://cloudyjourney.fr/wp-content/uploads/2018/01/image_65D67839.png)](https://cloudyjourney.fr/wp-content/uploads/2018/01/image_65D67839.png)

Il faut ensuite créer une **Virtual Network Gateway,** en choisissant le réseau virtuel créé précédemment, en choisissant un sous-réseau pour la Gateway ainsi qu’une IP publique. Choisissez le type **VPN**, avec un VPN de type **Route based****:**

![](https://cloudyjourney.fr/wp-content/uploads/2018/01/image_454F3887.png)

Après plusieurs minutes, notre Gateway est prête. Il faut donc créer une **Local Network Gateway,** qui contiendra notre IP publique de notre pfSense ainsi que les réseaux locaux auxquels le VPN pourra accéder:

[![](https://cloudyjourney.fr/wp-content/uploads/2018/01/SNAGHTMLed9b5f9_199E6E8B.png)](https://cloudyjourney.fr/wp-content/uploads/2018/01/SNAGHTMLed9b5f9_199E6E8B.png)

Si vous avez une IP dynamique, vous pouvez regarder par là: [https://cloudyjourney.fr/2016/05/30/powershell-mettre-a-jour-son-ip-publique-dun-vpn-s2s-avec-une-ip-dynamique/](https://cloudyjourney.fr/2016/05/30/powershell-mettre-a-jour-son-ip-publique-dun-vpn-s2s-avec-une-ip-dynamique/)

Il faut maintenant associer notre local network à notre Gateway virtuel. Allez sur votre Gateway créée précédemment et cliquez sur **Add:**

[![](https://cloudyjourney.fr/wp-content/uploads/2018/01/SNAGHTMLedfe068_3BF60404.png)](https://cloudyjourney.fr/wp-content/uploads/2018/01/SNAGHTMLedfe068_3BF60404.png)

Choisissez **Site-to-site (IPSec)** ainsi que la Gateway local créée précédemment. Renseignez également une clé partagée. Cette clé sera utilisée dans la configuration de pfSense:

![](https://cloudyjourney.fr/wp-content/uploads/2018/01/image_572E5D05.png)

Ma connexion:

[![](https://cloudyjourney.fr/wp-content/uploads/2018/01/SNAGHTMLedf7b26_6494700B.png)](https://cloudyjourney.fr/wp-content/uploads/2018/01/SNAGHTMLedf7b26_6494700B.png)

# pfSense

Maintenant nous allons configurer notre pfSense pour avoir la connectivité vers Azure. Allez dans **VPN > IPSec** et ajoutez une nouvelle phase 1. Donnez l’IP publique de la Gateway Azure, ainsi que votre clé partagée:

[![](https://cloudyjourney.fr/wp-content/uploads/2018/01/SNAGHTMLee301eb_22ED1C35.png)](https://cloudyjourney.fr/wp-content/uploads/2018/01/SNAGHTMLee301eb_22ED1C35.png)

Désactivez également DPD:

![](https://cloudyjourney.fr/wp-content/uploads/2018/01/image_2046F135.png)

Sauvegardez, et à cette phase 1, ajoutez une phase 2 en renseignant bien le réseau que vous avez créé sur Azure:

![](https://cloudyjourney.fr/wp-content/uploads/2018/01/image_74962738.png)

Appliquez les changements:

[![](https://cloudyjourney.fr/wp-content/uploads/2018/01/image_61E12D81.png)](https://cloudyjourney.fr/wp-content/uploads/2018/01/image_61E12D81.png)

Mon VPN est maintenant connecté:

![](https://cloudyjourney.fr/wp-content/uploads/2018/01/SNAGHTMLeeaf6d8_76667CFF.png)

Il suffit de déployer une VM sur Azure, sur le réseau qui est connecté au VPN, sans IP publique et ensuite de se connecter depuis le réseau local:

[![](https://cloudyjourney.fr/wp-content/uploads/2018/01/image_63B18348.png)](https://cloudyjourney.fr/wp-content/uploads/2018/01/image_63B18348.png)

En espérant que ceci vous sera utile :)
