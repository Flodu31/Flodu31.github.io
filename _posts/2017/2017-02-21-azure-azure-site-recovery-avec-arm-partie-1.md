---
title: "[Azure] Azure Site Recovery avec ARM - Partie 1"
date: "2017-02-21"
author: "Florent Appointaire"
permalink: "/2017/02/21/azure-azure-site-recovery-avec-arm-partie-1/"
summary:
categories: 
  - "azure-site-recovery"
tags: 
  - "arm"
  - "asr"
  - "azure"
  - "azure-site-recovery"
  - "failback"
  - "failover"
  - "microsoft"
---
Aujourd’hui, nous allons voir comment implémenter une solution de DRP, avec Azure Site Recovery. Je vais déployer cette solution, basé sur ARM. ASR peut également servir pour des migrations de VM vers Azure mais aussi de VMWare vers Azure, etc.

Dans mon plan de DRP, le service que j’ai défini comme critique est un site web. Je vais donc répliquer cette VM sur Azure, avec ASR. J’aurais pu faire de même avec une application multi tier.

Dans mon architecture, j'ai une VPN Site-2-Site vers Azure. Attaché au réseau qui est connecté au 2ème VPN, se trouve mon deuxième contrôleur de domaine, qui fait également DNS.

Il y aura 2 articles:

- 1er article: Mise en place de la solution Azure Site Recovery
- 2ème article: Replication des VMs et Failover/Failback

## Virtual Network et stockage

Dans un premier temps, je vais préparer mon réseau qui accueillera mon DRP. Ce réseau aura le **même** sous-réseau que mon réseau dans mon datacenter. Pourquoi ? Car mon application web a été mal codé et qu’il y a des IPs en dur dans le code :)

[![](https://cloudyjourney.fr/wp-content/uploads/2018/01/Picture1.png)](https://cloudyjourney.fr/wp-content/uploads/2018/01/Picture1.png)

Vous pouvez également modifier les DNS, etc. de ce réseau.

Créez également un compte de stockage qui contiendra les réplications.

## Nouveau Recovery Volt

Maintenant que le réseau est prêt, créez un nouveau **Recovery Volt** en allant sur **\+ > Storage > Backup and Site Recovery (OMS) :**

[![](https://cloudyjourney.fr/wp-content/uploads/2018/01/Picture2.png)](https://cloudyjourney.fr/wp-content/uploads/2018/01/Picture2.png)

Donnez un nom à votre vault et choisissez la destination et le groupe de ressource associé :

[![](https://cloudyjourney.fr/wp-content/uploads/2018/01/Picture3.png)](https://cloudyjourney.fr/wp-content/uploads/2018/01/Picture3.png)

Après quelques instants, le vault a été créé :

[![](https://cloudyjourney.fr/wp-content/uploads/2018/01/Picture4.png)](https://cloudyjourney.fr/wp-content/uploads/2018/01/Picture4.png)

## Configuration

La première étape étant terminé, il est maintenant temps de commencer la configuration. Dans votre vault, cliquez sur **Site Recovery > Step 1 : Prepare Infrastructure** et choisissez où vous souhaitez répliquer vos machines (Azure dans mon cas, mais ça peut être sur un site secondaire), si les machines sont virtuelles et si oui, sur quel type d’hyperviseur (Hyper-V pour moi, mais ce peut être VMWare) et enfin, choisissez si vous utilisez SCVMM pour gérer vos hôtes :

[![](https://cloudyjourney.fr/wp-content/uploads/2018/01/Picture5.png)](https://cloudyjourney.fr/wp-content/uploads/2018/01/Picture5.png)

Il faut maintenant créer un site Hyper-V. Ce site contiendra tous les Hyper-V d’un site, par exemple Bruxelles. Vous pouvez par la suite ajouter d’autres sites. Cliquez sur **\+ Hyper-V Site** et donnez un nom à ce site :

[![](https://cloudyjourney.fr/wp-content/uploads/2018/01/Picture6.png)](https://cloudyjourney.fr/wp-content/uploads/2018/01/Picture6.png)

Sélectionnez-le et cliquez sur **\+ Hyper-V Server** pour installer l’agent sur le/les serveur(s) Hyper-V qui contient la/les VM à répliquer sur Azure pour le DRP :

[![](https://cloudyjourney.fr/wp-content/uploads/2018/01/Picture7.png)](https://cloudyjourney.fr/wp-content/uploads/2018/01/Picture7.png)

Dans les instructions, il est dit que l’Hyper-V doit au moins être sur Windows Server 2012 R2, que le proxy doit autoriser les URLs de ASR et ensuite, il vous propose de télécharger l’agent de ASR ainsi que la clé du vault pour le site que vous avez créé précédemment :

[![](https://cloudyjourney.fr/wp-content/uploads/2018/01/Picture8.png)](https://cloudyjourney.fr/wp-content/uploads/2018/01/Picture8.png)

Copiez l’agent et la clé sur l’Hyper-V. Pour l’installer, utilisant la partie Server Core pour mes Hyper-V, j’ai utilisé les lignes de commandes suivantes pour installer l’agent et installer la clé :

`.\AzureSiteRecoveryProvider.exe /x:. /q`

[![](https://cloudyjourney.fr/wp-content/uploads/2018/01/Picture9.png)](https://cloudyjourney.fr/wp-content/uploads/2018/01/Picture9.png)

`Cd ‘C:\Program Files\Microsoft Azure Site Recovery Provider\’`

`.\DRConfigurator.exe /r /Friendlyname ‘FLOAPP-HPV02’ /Credentials ‘C:\Temp\ASRFLOAPP_HYPERVFLOAPP_Wed Feb 15 2017.VaultCredentials’`

[![](https://cloudyjourney.fr/wp-content/uploads/2018/01/Picture10.png)](https://cloudyjourney.fr/wp-content/uploads/2018/01/Picture10.png)

Après quelques minutes, l’Hyper-V apparaît dans la console Azure :

[![](https://cloudyjourney.fr/wp-content/uploads/2018/01/Picture11.png)](https://cloudyjourney.fr/wp-content/uploads/2018/01/Picture11.png)

Choisissez maintenant sur quelques suscriptions Azure vous souhaitez répliquer la VM avec ASR (la suscription où vous avez créé le compte de stockage et le réseau) ainsi que le type de déploiement que vous souhaitez utiliser, Classic ou Resource Manager (ARM) :

[![](https://cloudyjourney.fr/wp-content/uploads/2018/01/Picture12.png)](https://cloudyjourney.fr/wp-content/uploads/2018/01/Picture12.png)

Nous allons maintenant créer une règle pour la réplication, pour définir la durée entre chaque point de réplication, le nombre de point de réplication que vous souhaitez conserver, etc. Cliquez sur **Create and Associate :**

[![](https://cloudyjourney.fr/wp-content/uploads/2018/01/Picture13.png)](https://cloudyjourney.fr/wp-content/uploads/2018/01/Picture13.png)

Et fournissez les valeurs suivants ce que vous souhaitez implémenter :

[![](https://cloudyjourney.fr/wp-content/uploads/2018/01/Picture14.png)](https://cloudyjourney.fr/wp-content/uploads/2018/01/Picture14.png)

Une fois la règle créée, sélectionnez la et cliquez sur **OK:**

[![](https://cloudyjourney.fr/wp-content/uploads/2018/01/Picture15.png)](https://cloudyjourney.fr/wp-content/uploads/2018/01/Picture15.png)

Exécutez le capacity planner ([https://docs.microsoft.com/en-us/azure/site-recovery/site-recovery-capacity-planner](https://docs.microsoft.com/en-us/azure/site-recovery/site-recovery-capacity-planner)) et une fois que ceci est terminé, cliquez sur **OK :**

[![](https://cloudyjourney.fr/wp-content/uploads/2018/01/Picture16.png)](https://cloudyjourney.fr/wp-content/uploads/2018/01/Picture16.png)

Dans le prochain article, nous verrons comment répliquer les VMs et faire le failover/failback :)
