---
title: "[Azure] Network Peering"
date: "2016-12-20"
author: "Florent Appointaire"
permalink: "/2016/12/20/azure-network-peering/"
summary: 
categories: 
  - "reseau"
tags: 
  - "azure"
  - "microsoft"
  - "virtual-network-peering"
---
Le 28 Septembre 2016, Microsoft a rendu disponible en GA, le Virtual Network peering.

Cette nouvelle fonctionnalité vous donne la possibilité de connecter 2 Virtual Network sur Azure ensemble, en utilisant directement le réseau du datacenter Azure. Vous pouvez donc abandonner les VPN S2S pour connecter vos différents sous-réseaux :)

Pour utiliser cette nouvelle fonctionnalité, il y a quelques prérequis:

- Être dans la même région Azure (Europe de l'Ouest dans mon cas)
- L'overlapping n'est pas autorisé (impossible de faire un peering de 10.0.0.0/8 vers 10.0.0.0/8)

Concenrnant le prix, il dépend du nombre de données transférées. Plus d'informations ici: [https://azure.microsoft.com/en-us/pricing/details/virtual-network/](https://azure.microsoft.com/en-us/pricing/details/virtual-network/)

Vous pouvez effectuer le VNet Peering entre:

- ARM VNet vers ARM VNet dans la même suscription
- ARM VNet vers Classique VNet dans la même suscription
- ARM VNet vers ARM VNet dans 2 suscriptions différentes (coming soon)

# Arm vers Arm Virtual Network peering dans la même suscription

Pour commencer un VNet Peering entre 2 virtuals networks ARM, allez sur votre premier virtual network, dans **Peerings** et cliquez sur **Add:**

[![](https://cloudyjourney.fr/wp-content/uploads/2018/01/pastedimage1482154073532v2.png)](https://cloudyjourney.fr/wp-content/uploads/2018/01/pastedimage1482154073532v2.png)

Donnez un nom à cette connexion, choisissez le mode **Resource Manager**, choisissez vers quel VNet vous voulez faire le peering, si vous voulez activer ou pas cette connexion, et choisissez d'autres options comme le routage à travers les passerelles de chaque réseau, etc.:

[![](https://cloudyjourney.fr/wp-content/uploads/2018/01/pastedimage1482154087985v3.png)](https://cloudyjourney.fr/wp-content/uploads/2018/01/pastedimage1482154087985v3.png)

Le **Peering Status** est actuellement en **Initiated** parce que nous avons besoin de faire le même peering, sur l'autre virtual network:

[![](https://cloudyjourney.fr/wp-content/uploads/2018/01/pastedimage1482154107315v4.png)](https://cloudyjourney.fr/wp-content/uploads/2018/01/pastedimage1482154107315v4.png)

Sur le deuxième virtual network, cliquez sur **Add** dans **Peerings**:

[![](https://cloudyjourney.fr/wp-content/uploads/2018/01/pastedimage1482154123746v5.png)](https://cloudyjourney.fr/wp-content/uploads/2018/01/pastedimage1482154123746v5.png)

Une fois que vous avez cliquez sur **OK**, le statut change en **Connected** parce que les 2 VNet sont connectés entre eux:

[![](https://cloudyjourney.fr/wp-content/uploads/2018/01/pastedimage1482154153968v6.png)](https://cloudyjourney.fr/wp-content/uploads/2018/01/pastedimage1482154153968v6.png)

Je vais maintenant effectuer un ping d'une VM d'un VNet vers le deuxième VNet:

[![](https://cloudyjourney.fr/wp-content/uploads/2018/01/pastedimage1482154171627v7.png)](https://cloudyjourney.fr/wp-content/uploads/2018/01/pastedimage1482154171627v7.png)

Le ping fonctionne correctement :)

# Arm vers Classique Virtual Network peering dans la même suscription

Dans la version classique du portail, j'ai un virtual network avec une VM connectée.

Dans ce cas, je vais avoir besoin d'un seul lien peering, de ARM vers Classique:

[![](https://cloudyjourney.fr/wp-content/uploads/2018/01/pastedimage1482154227431v8.png)](https://cloudyjourney.fr/wp-content/uploads/2018/01/pastedimage1482154227431v8.png)

Comme vous pouvez le voir, le peering est directement connecté:

[![](https://cloudyjourney.fr/wp-content/uploads/2018/01/pastedimage1482154233384v9.png)](https://cloudyjourney.fr/wp-content/uploads/2018/01/pastedimage1482154233384v9.png)

Pour tester la connectivité, je vais faire un ping d'une VM qui est en classique vers une VM ARM:

[![](https://cloudyjourney.fr/wp-content/uploads/2018/01/pastedimage1482154241084v10.png)](https://cloudyjourney.fr/wp-content/uploads/2018/01/pastedimage1482154241084v10.png)

Et ça fonctionne aussi :)

# Arm vers Arm Virtual Network peering dans 2 suscriptions differentes

Pour créer un network peering entre 2 réseaux dans 2 suscriptions différentes, vous **DEVEZ** être owner des 2 suscriptions. Ajoutez un peering et cochez la case **I know my resource ID**. Fournissez le VNet de l'autre suscription avec le format suivant, en remplaçant XXX-XXX-XXX-XXXX par votre suscription ID et en changeant le groupe de ressource et le nom du réseau virtuel:

[![](https://cloudyjourney.fr/wp-content/uploads/2018/01/1033.Picture1.png)](https://cloudyjourney.fr/wp-content/uploads/2018/01/1033.Picture1.png)

/subscriptions/XXXXX-XXXX-XXXX-XXXX-XXXXXXXXX/resourceGroups/Network/providers/Microsoft.Network/virtualNetworks/FLOAPP-VNet

J'ai coché la case **Use remote gateways** pour pouvoir utiliser mon ExpressRoute qui est connecté sur l'autre réseau virtuel.

[![](https://cloudyjourney.fr/wp-content/uploads/2018/01/4747.Picture2.png)](https://cloudyjourney.fr/wp-content/uploads/2018/01/4747.Picture2.png)

Faites de même sur l'autre réseau:

![](https://cloudyjourney.fr/wp-content/uploads/2018/01/7462.Picture3.png)

Quand c'est terminé, la connexion est effectuée:

[![](https://cloudyjourney.fr/wp-content/uploads/2018/01/6813.Picture4.png)](https://cloudyjourney.fr/wp-content/uploads/2018/01/6813.Picture4.png)

Cette nouvelle fonctionnalité qu'est le Network Peering est très utile pour connecter différente suscription/Vnet entre eux, sans passer par Internet, en utilisant le réseau backbone des datacenters Azure.
