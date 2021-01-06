---
title: "[Azure Stack] Erreur de déploiement pour Orchard Web App"
date: "2016-02-16"
categories: 
  - "azure-stack"
tags: 
  - "azure-stack"
  - "microsoft"
  - "webapp-rp"
---

[![](https://cloudyjourney.fr/wp-content/uploads/2018/01/AzureStackLogo02.png)](https://cloudyjourney.fr/wp-content/uploads/2018/01/AzureStackLogo02.png)

Aujourd’hui, j’ai essayé de déployer Orchad CMS sur Azure Stack. J’ai eu une erreur et le site web ne fonctionnait pas. J’ai donc regardé les logs de déploiement sur le serveur File Server pour ce site web, dans **appManagerLog.xml**:

[![](https://cloudyjourney.fr/wp-content/uploads/2018/01/image_753F5803.png)](https://cloudyjourney.fr/wp-content/uploads/2018/01/image_753F5803.png)

Après quelques instants, je me suis aperçu que le problème venait du fait que le server **sqlrp** n’arrivait pas à être résolu au niveau DNS. Ceci est normal car les serveurs du RP WebApp ne sont pas dans le domaine et que le déploiement n’utilise pas le FQDN. J’ai trouvé que c’est le Web Worker qui essaye de résoudre ce nom. Ceci est normal, car les ressources que le site web va utiliser sont dessus, c’est à dire, les VMs WW0-VM, WW1-VM, etc… Pour régler ce problème, vous avez 2 solutions (la 2ème est la plus propre).

La première est de modifier le fichier host de votre VM, en faisant pointer le nom **sqlrp** vers son IP public:

[![](https://cloudyjourney.fr/wp-content/uploads/2018/01/image_6C525675.png)](https://cloudyjourney.fr/wp-content/uploads/2018/01/image_6C525675.png)

La deuxième solution est de modifier le DNS suffix dans les propriétés de la carte réseau:

![](https://cloudyjourney.fr/wp-content/uploads/2018/01/image_73055FF8.png)

Relancez le déploiement et maintenant, ça fonctionne:

[![](https://cloudyjourney.fr/wp-content/uploads/2018/01/image_79B8697B.png)](https://cloudyjourney.fr/wp-content/uploads/2018/01/image_79B8697B.png)

[![](https://cloudyjourney.fr/wp-content/uploads/2018/01/image_32631389.png)](https://cloudyjourney.fr/wp-content/uploads/2018/01/image_32631389.png)

Bon courage :)
