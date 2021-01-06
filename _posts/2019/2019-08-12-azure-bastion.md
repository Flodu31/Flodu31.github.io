---
title: "[Azure] Bastion"
date: "2019-08-12"
categories: 
  - "azure"
tags: 
  - "azure"
  - "bastion"
  - "microsoft"
---

![](https://cloudyjourney.fr/wp-content/uploads/2018/01/Azure.png)

Microsoft a rendu disponible avant l'été Azure Bastion. J'étais dans la Private Preview, mais, étant donné que c'était sous NDA, je ne pouvais pas blogguer dessus. Je profite donc de mes vacances et d'avoir un peu de temps, pour rattraper mon retard :)

Azure Bastion vous permet d'accéder, de façon sécuriser, via le portail Azure, à vos VMs qui tournent sur Azure. Voici comment fonctionne Azure Bastion. Ce schéma provient de la [documentation officielle Microsoft](https://docs.microsoft.com/en-us/azure/bastion/bastion-overview).

![](https://cloudyjourney.fr/wp-content/uploads/2019/08/AzureBastion00.png)

Voyons comment implémenter ce Bastion. Pour commencer, vous devez enregistrer le provider, Azure Bastion étant encore en Preview, mais publique cette fois:

```
Register-AzureRmProviderFeature -FeatureName AllowBastionHost -ProviderNamespace Microsoft.Network
 
Register-AzureRmResourceProvider -ProviderNamespace Microsoft.Network
 
Get-AzureRmProviderFeature -ProviderNamespace Microsoft.Network
```

![](https://i2.wp.com/cloudyjourney.fr/wp-content/uploads/2019/08/AzureBastion01.png?fit=762%2C415&ssl=1)

Pour pouvoir déployer le Bastion, vous devez y accéder depuis une URL spécifique pour le moment: [https://aka.ms/BastionHost](https://aka.ms/BastionHost)

Ensuite, il faut dédié un sous-réseau, avec minimum un /27, au VNet où le Bastion sera déployé. Il doit impérativement se nommer **AzureBastionSubnet**:

![](https://i1.wp.com/cloudyjourney.fr/wp-content/uploads/2019/08/AzureBastion02.png?fit=762%2C372&ssl=1)

Allez ensuite dans le Marketplace, et cherchez **Bastion** puis cliquez dessus:

![](https://i0.wp.com/cloudyjourney.fr/wp-content/uploads/2019/08/AzureBastion03.png?fit=762%2C492&ssl=1)

Choisissez ensuite où sera stocké votre Bastion, ainsi qu'un nom, et la région où le VNet, où sera déployé le Bastion, se trouve. Choisissez le subnet que vous avez créé précédemment et choisissez une Public IP ou créez en une nouvelle:

![](https://i1.wp.com/cloudyjourney.fr/wp-content/uploads/2019/08/AzureBastion04.png?fit=762%2C756&ssl=1)

Après quelques minutes, le Bastion est déployé:

![](https://i0.wp.com/cloudyjourney.fr/wp-content/uploads/2019/08/AzureBastion05.png?fit=762%2C317&ssl=1)

Toujours sur le même portail, allez maintenant sur une VM, qui n'a pas d'IP public et cliquez sur **Connect**. Vous avez maintenant un nouvel onglet, nommé **BASTION**. Rentrez un nom d'utilisateur/mot de passe (de domaine ou non), choisissez si vous voulez ouvrir la connexion dans une nouvelle fenêtre ou non:

![](https://cloudyjourney.fr/wp-content/uploads/2019/08/AzureBastion06.png)

Vous êtes maintenant connecté, via votre navigateur, sur votre VM:

![](https://i2.wp.com/cloudyjourney.fr/wp-content/uploads/2019/08/AzureBastion07.png?fit=762%2C385&ssl=1)

Ce nouveau service est très simple a utiliser, sans exposer des port dangereux sur internet. Il manque encore quelques features, comme le support de l'Azure AD, le MFA (qui arrivera rapidement) mais aussi le choix du port RDP/SSH par exemple, car dans mon cas, je n'utilise pas le port 3389 sur mes serveurs :)
