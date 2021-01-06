---
title: "[Azure] Azure Site Recovery avec ARM - Partie 2"
date: "2017-02-22"
categories: 
  - "azure-site-recovery"
tags: 
  - "arm"
  - "azure"
  - "azure-site-recovery"
  - "failback"
  - "failover"
  - "microsoft"
---

[![](https://cloudyjourney.fr/wp-content/uploads/2018/01/ASRLogo.png)](https://cloudyjourney.fr/wp-content/uploads/2018/01/ASRLogo.png)

Voici donc la deuxième partie de l'implémentation de Azure Site Recovery avec ARM:

- [1er article: Mise en place de la solution Azure Site Recovery](https://cloudyjourney.fr/2017/02/21/azure-azure-site-recovery-avec-arm-partie-1/)
- 2ème article: Replication des VMs et Failover/Failback

## Réplication des premières VMs

Maintenant que l’infrastructure est prête sur Azure, nous allons pouvoir répliquer les VMs/Applications. Choisissez de où vous souhaitez répliquer les VMs (On-Premises pour moi) et sélectionnez le site Hyper-V que vous avez créé dans le premier article :

[![](https://cloudyjourney.fr/wp-content/uploads/2018/01/8244.Picture2.png)](https://cloudyjourney.fr/wp-content/uploads/2018/01/8244.Picture2.png)

Sélectionnez le compte de stockage que vous avez créé au début pour stocker les réplications, mais aussi le réseau que vous avez créé et le sous-réseau associé :

[![](https://cloudyjourney.fr/wp-content/uploads/2018/01/7128.Picture3.png)](https://cloudyjourney.fr/wp-content/uploads/2018/01/7128.Picture3.png)

Sélectionnez enfin les VMs que vous souhaitez protéger avec la réplication :

[![](https://cloudyjourney.fr/wp-content/uploads/2018/01/6685.Picture4.png)](https://cloudyjourney.fr/wp-content/uploads/2018/01/6685.Picture4.png)

Choisissez le type d’OS ainsi que le disque OS. Choisissez enfin les disques que vous souhaitez répliquer :

[![](https://cloudyjourney.fr/wp-content/uploads/2018/01/5518.Picture5.png)](https://cloudyjourney.fr/wp-content/uploads/2018/01/5518.Picture5.png)

Appliquez la police créée précédemment :

[![](https://cloudyjourney.fr/wp-content/uploads/2018/01/7360.Picture6.png)](https://cloudyjourney.fr/wp-content/uploads/2018/01/7360.Picture6.png)

La réplication commence :

[![](https://cloudyjourney.fr/wp-content/uploads/2018/01/3364.Picture7.png)](https://cloudyjourney.fr/wp-content/uploads/2018/01/3364.Picture7.png)

Depuis la console Hyper-V, vous pouvez voir que la réplication a commencé :

[![](https://cloudyjourney.fr/wp-content/uploads/2018/01/8055.Picture8.png)](https://cloudyjourney.fr/wp-content/uploads/2018/01/8055.Picture8.png)

## Modification de la VM avant Failover

Avant de tester le failover, il faut choisir la taille de la VM qui sera déployée et aussi, paramétrer le réseau. En effet, vous pouvez décider de faire tourner la VM sur une taille plus petite en mode dégradé. Et ici, étant donné que mon application a été mal codé et que j’ai une IP fixe dans le code, je vais réattribuer la même IP que dans mon réseau local actuel à cette VM. Si vous ne précisez rien, le DHCP prendra la première IP disponible dans le pool :

[![](https://cloudyjourney.fr/wp-content/uploads/2018/01/1207.Picture9.png)](https://cloudyjourney.fr/wp-content/uploads/2018/01/1207.Picture9.png)

## Test du Failover

Il est maintenant temps de tester le failover. J’ai éteint mon infrastructure, et donc, plus personne ne peut travailler. Dans la console Azure, sur votre réplication de votre application, cliquez sur **Unplanned Failover** pour dire que votre application doit être déployé sur Azure.

Choisissez le point de sauvegarde que vous souhaitez restaurer. Je n’ai pas synchronisé les derniers changements car mon infrastructure n’est plus disponible, et j’aurai donc perdu dans mon cas, maximum 15 minutes de données (délai de réplication des VMs vers Azure) :

[![](https://cloudyjourney.fr/wp-content/uploads/2018/01/8231.Picture10.png)](https://cloudyjourney.fr/wp-content/uploads/2018/01/8231.Picture10.png)

Le déploiement de ma VM sur Azure est en cours :

[![](https://cloudyjourney.fr/wp-content/uploads/2018/01/2110.Picture11.png)](https://cloudyjourney.fr/wp-content/uploads/2018/01/2110.Picture11.png)

10 minutes plus tard, ma VM a été déployé dans Azure :

[![](https://cloudyjourney.fr/wp-content/uploads/2018/01/4682.Picture12.png)](https://cloudyjourney.fr/wp-content/uploads/2018/01/4682.Picture12.png)

[![](https://cloudyjourney.fr/wp-content/uploads/2018/01/3146.Picture13.png)](https://cloudyjourney.fr/wp-content/uploads/2018/01/3146.Picture13.png)

## VNet Peering

J'ai créé un VNet Peering entre le réseau qui contient mon DC et mon réseau ASR. Vous pouvez retrouver la procédure pour faire ceci [ici](https://cloudyjourney.fr/2016/12/20/azure-network-peering/). Vous pouvez également automatiser cette partie.

[![](https://cloudyjourney.fr/wp-content/uploads/2018/01/5315.Picture14.png)](https://cloudyjourney.fr/wp-content/uploads/2018/01/5315.Picture14.png)

## Test de mon application

En me connectant sur mon DC sur Azure, je peux voir que je ping directement la nouvelle machine ASR (grâce au network peering) et que je peux accéder au site web :

[![](https://cloudyjourney.fr/wp-content/uploads/2018/01/0675.Picture15.png)](https://cloudyjourney.fr/wp-content/uploads/2018/01/0675.Picture15.png) [ ](https://cloudyjourney.fr/wp-content/uploads/2018/01/2110.Picture11.png) Et en rajoutant un NLB et en créant une règle NAT, sur le port de l’application, vers la VM qui vient d’être déployé, mes utilisateurs peuvent continuer à travailler, juste en faisant pointer votre DNS, vers la nouvelle IP public du NLB : [](https://cloudyjourney.fr/wp-content/uploads/2018/01/5315.Picture14.png) [ ](https://cloudyjourney.fr/wp-content/uploads/2018/01/8231.Picture10.png) [![](https://cloudyjourney.fr/wp-content/uploads/2018/01/8508.Picture16.png)](https://cloudyjourney.fr/wp-content/uploads/2018/01/8508.Picture16.png) [![](https://cloudyjourney.fr/wp-content/uploads/2018/01/pastedimage1487674762170v2.png)](https://cloudyjourney.fr/wp-content/uploads/2018/01/pastedimage1487674762170v2.png)

Maintenant que votre application est fonctionnelle, il faut faire un **Commit** du failover :

[![](https://cloudyjourney.fr/wp-content/uploads/2018/01/Picture18.png)](https://cloudyjourney.fr/wp-content/uploads/2018/01/Picture18.png)

## Failback

Votre datacenter est de nouveau opérationnel, il faut donc rapatrier les données avec les changements qu’il y a eu. Pour faire ceci, cliquez sur **Planned Failover :**

[![](https://cloudyjourney.fr/wp-content/uploads/2018/01/Picture19.png)](https://cloudyjourney.fr/wp-content/uploads/2018/01/Picture19.png)

Vous souhaitez faire le failover de Azure vers votre Datacenter. Si vous avez perdu vos données, vous pouvez décider de créer une nouvelle VM dans votre datacenter, sur un hôte bien précis :

[![](https://cloudyjourney.fr/wp-content/uploads/2018/01/Picture20.png)](https://cloudyjourney.fr/wp-content/uploads/2018/01/Picture20.png)

Une fois que le failback est terminé, vous devriez avoir ceci :

[![](https://cloudyjourney.fr/wp-content/uploads/2018/01/Picture21.png)](https://cloudyjourney.fr/wp-content/uploads/2018/01/Picture21.png)

Cliquez sur **Commit** pour valider le changement vers votre datacenter :

[![](https://cloudyjourney.fr/wp-content/uploads/2018/01/Picture22.png)](https://cloudyjourney.fr/wp-content/uploads/2018/01/Picture22.png)

Le dernier delta est envoyé :

[![](https://cloudyjourney.fr/wp-content/uploads/2018/01/Picture23.png)](https://cloudyjourney.fr/wp-content/uploads/2018/01/Picture23.png)

Enfin, le failback est terminé :

[![](https://cloudyjourney.fr/wp-content/uploads/2018/01/Picture24.png)](https://cloudyjourney.fr/wp-content/uploads/2018/01/Picture24.png)

Pour terminer, il faut réactiver la réplication de la VM vers Azure. Cliquez sur **Reverse replicate :**

[![](https://cloudyjourney.fr/wp-content/uploads/2018/01/Picture25.png)](https://cloudyjourney.fr/wp-content/uploads/2018/01/Picture25.png)

[![](https://cloudyjourney.fr/wp-content/uploads/2018/01/pastedimage1487675065873v3.png)](https://cloudyjourney.fr/wp-content/uploads/2018/01/pastedimage1487675065873v3.png)

Si je refais le test, depuis ma VM qui est sur Azure, vers la même IP qui est dans mon datacenter, vous pouvez voir que maintenant, je passe de nouveau par mon VPN S2S et que le site Web n’a pas changé :

[](https://cloudyjourney.fr/wp-content/uploads/2018/01/pastedimage1487675065873v3.png)[![](https://cloudyjourney.fr/wp-content/uploads/2018/01/pastedimage1487675073745v4.png)](https://cloudyjourney.fr/wp-content/uploads/2018/01/pastedimage1487675073745v4.png)

## Pour aller plus loin

Si vous souhaitez aller plus loin, ici nous avons fait le failover pour une seule VM. Vous pouvez créer un groupe de VM, dans la partie **Recovery Plan** pour faire un failover sur plusieurs VM d’un seul coup :

[![](https://cloudyjourney.fr/wp-content/uploads/2018/01/Picture28.png)](https://cloudyjourney.fr/wp-content/uploads/2018/01/Picture28.png)

Vous pouvez également gérer directement les paramètres de l’infrastructure ASR dans la console Azure, sans passer par le Step-By-Step :)

[![](https://cloudyjourney.fr/wp-content/uploads/2018/01/Picture29.png)](https://cloudyjourney.fr/wp-content/uploads/2018/01/Picture29.png)

## Conclusion

Cette fonctionnalité est très intéressante pour les sociétés qui ont des applications business critiques pour faire tourner l’entreprise. Même en mode dégradé, les employés peuvent continuer à travailler et donc, faire perdre un minimum d’argent à la société. Ne vous en passez donc pas :)
