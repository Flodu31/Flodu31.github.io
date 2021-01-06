---
title: "[Azure] Rôle RBAC customisés"
date: "2016-03-09"
categories: 
  - "azure"
tags: 
  - "azure"
  - "custom-roles"
  - "microsoft"
  - "rbac"
---

[![](https://cloudyjourney.fr/wp-content/uploads/2018/01/pastedimage1482154059354v1.png)](https://cloudyjourney.fr/wp-content/uploads/2018/01/pastedimage1482154059354v1.png)

Depuis le mois de Décembre 2015, Microsoft a rendu disponible le fait de pouvoir créer ses propres rôles RBAC. Je vais vous montrer comment faire ceci aujourd’hui. Tout d’abord, connectez-vous via PowerShell à Azure RM et sélectionnez votre suscription:

`Login-AzureRm Select-AzureRmSubscription -SubscriptionId XXXXXXXXXXXXXXXXXXXXX`

Une fois connecté, vous pouvez avoir la liste des Resource Provider qui sont disponibles avec la commande suivante:

`Get-AzureRmResourceProvider | FT ProviderNameSpace,ResourceTypes`

[![](https://cloudyjourney.fr/wp-content/uploads/2018/01/image_08395F18.png)](https://cloudyjourney.fr/wp-content/uploads/2018/01/image_08395F18.png)

Ce que je vais faire ici est assez simple. L’utilisateur/groupe qui sera dans le rôle que je vais créer, pourra créer et supprimer des cartes réseaux et lire/rejoindre les network security group ainsi que les réseaux virtuels. Je vais donc utiliser le Resource Provider **Microsoft.Network.** Pour avoir la liste des opérations disponibles, utilisez la commande suivante:

`Get-AzureRmProviderOperation -OperationSearchString Microsoft.Network/* | Select Operation,OperationName`

[![](https://cloudyjourney.fr/wp-content/uploads/2018/01/image_3C015569.png)](https://cloudyjourney.fr/wp-content/uploads/2018/01/image_3C015569.png)

Ici, les actions qui m’intéressent sont les suivantes:

- Microsoft.Network/networkInterfaces/read
- Microsoft.Network/networkInterfaces/write
- Microsoft.Network/networkInterfaces/delete
- Microsoft.Network/networkSecurityGroups/read
- Microsoft.Network/networkSecurityGroups/join/action
- Microsoft.Network/virtualNetworks/read
- Microsoft.Network/virtualNetworks/subnets/read
- Microsoft.Network/virtualNetworks/subnets/join/action

Les 3 premiers points concernent le fait de pouvoir lire/créer/supprimer les cartes réseaux, les 4ème et 5ème points concernent le fait de pouvoir lire les NSG et les rejoindre et enfin, les 3 derniers points sont pour lire les réseaux virtuels, les sous-réseaux et pouvoir récupérer une IP dans le pool.

Pour pouvoir stocker les cartes réseaux, il faut que l’utilisateur puisse écrire dans le groupe de ressource, et donc, le lire. Il faudra donc rajouter les 2 lignes suivantes:

- Microsoft.Resources/deployments/read
- Microsoft.Resources/deployments/write

Maintenant que nous avons toutes nos actions, nous pouvons créer le fichier JSON suivant:

`{ "Name": "Admin Network Card", "Id": "67794e3b-eeeb-4e5c-a98b-27cc053a0b35", "IsCustom": true, "Description": "Can create and delete Network Interfaces.", "Actions": [ "Microsoft.Network/networkInterfaces/read", "Microsoft.Network/networkInterfaces/write", "Microsoft.Network/networkInterfaces/delete", "Microsoft.Network/networkSecurityGroups/read", "Microsoft.Network/networkSecurityGroups/join/action", "Microsoft.Network/virtualNetworks/read", "Microsoft.Network/virtualNetworks/subnets/read", "Microsoft.Network/virtualNetworks/subnets/join/action", "Microsoft.Resources/deployments/read", "Microsoft.Resources/deployments/write", "Microsoft.Authorization/*/read", "Microsoft.Resources/subscriptions/resourceGroups/read", "Microsoft.Support/*" ], "NotActions": [` `], "AssignableScopes": [ "/subscriptions/XXXXXXXXXXXXXXXXXXX” ] }`

Bien sur, modifiez les XXXXXXXXXXX avec le numéro de la suscription pour laquelle il sera possible d’utiliser ce rôle. Vous pouvez ajouter plusieurs suscriptions. Vous pouvez également adapter la partie Name, Description:

[![](https://cloudyjourney.fr/wp-content/uploads/2018/01/SNAGHTML15e3629d_122371E5.png)](https://cloudyjourney.fr/wp-content/uploads/2018/01/SNAGHTML15e3629d_122371E5.png)

Enregistrez ce fichier avec l’extension **.json** et utilisez la commande suivante pour l’importer:

`New-AzureRmRoleDefinition -InputFile C:\Users\flore\Desktop\CustomRole.json`

[![](https://cloudyjourney.fr/wp-content/uploads/2018/01/SNAGHTML15f2696a_0A559C3A.png)](https://cloudyjourney.fr/wp-content/uploads/2018/01/SNAGHTML15f2696a_0A559C3A.png)

Avec un compte administrateur, allez dans le groupe de ressource qui aura les droits puis ajoutez le nouveau rôle en cliquant sur **Access > Add > Select a role:**

[![](https://cloudyjourney.fr/wp-content/uploads/2018/01/image_13F3C7AC.png)](https://cloudyjourney.fr/wp-content/uploads/2018/01/image_13F3C7AC.png)

Ajoutez le compte/groupe qui aura la possibilité de déployer des cartes réseaux:

[![](https://cloudyjourney.fr/wp-content/uploads/2018/01/image_6EF60732.png)](https://cloudyjourney.fr/wp-content/uploads/2018/01/image_6EF60732.png)

[![](https://cloudyjourney.fr/wp-content/uploads/2018/01/image_4CA1026A.png)](https://cloudyjourney.fr/wp-content/uploads/2018/01/image_4CA1026A.png)

Si vous allez dans **Access > Roles > Admin Network Card > Properties**, vous avez la possibilité de voir les permissions qui sont attribuées:

[![](https://cloudyjourney.fr/wp-content/uploads/2018/01/image_7A22222D.png)](https://cloudyjourney.fr/wp-content/uploads/2018/01/image_7A22222D.png)

[![](https://cloudyjourney.fr/wp-content/uploads/2018/01/image_29DFCAAD.png)](https://cloudyjourney.fr/wp-content/uploads/2018/01/image_29DFCAAD.png)

Maintenant, connectez-vous avez un compte qui a les droits de déployer une carte réseau virtuelle:

[![](https://cloudyjourney.fr/wp-content/uploads/2018/01/image_64C6FD76.png)](https://cloudyjourney.fr/wp-content/uploads/2018/01/image_64C6FD76.png)

Essayons de créer un NSG (nous avons les permissions seulement en lecture et de rejoindre un NSG):

[![](https://cloudyjourney.fr/wp-content/uploads/2018/01/image_59314037.png)](https://cloudyjourney.fr/wp-content/uploads/2018/01/image_59314037.png)

Nous avons une erreur, ce qui est normal. Le message est clair, nous n’avons pas les autorisations pour faire ceci:

[![](https://cloudyjourney.fr/wp-content/uploads/2018/01/image_26CD6CB8.png)](https://cloudyjourney.fr/wp-content/uploads/2018/01/image_26CD6CB8.png)

Je vais donc créer un réseau virtuel et un sous-réseau ainsi qu’un NSG, depuis un compte administrateur. Je peux maintenant lire les NSG et les réseaux virtuels qui sont dans le groupe de ressource où j’ai les droits:

[![](https://cloudyjourney.fr/wp-content/uploads/2018/01/image_2FBCFEF7.png)](https://cloudyjourney.fr/wp-content/uploads/2018/01/image_2FBCFEF7.png)

[![](https://cloudyjourney.fr/wp-content/uploads/2018/01/image_78E2AAB0.png)](https://cloudyjourney.fr/wp-content/uploads/2018/01/image_78E2AAB0.png)

Essayons maintenant de déployer une carte réseau qui pourra être attaché à une VM:

[![](https://cloudyjourney.fr/wp-content/uploads/2018/01/image_5F7AA776.png)](https://cloudyjourney.fr/wp-content/uploads/2018/01/image_5F7AA776.png)

Le déploiement s’est effectué correctement:

[![](https://cloudyjourney.fr/wp-content/uploads/2018/01/image_2D16D3F7.png)](https://cloudyjourney.fr/wp-content/uploads/2018/01/image_2D16D3F7.png)

[![](https://cloudyjourney.fr/wp-content/uploads/2018/01/image_419C2375.png)](https://cloudyjourney.fr/wp-content/uploads/2018/01/image_419C2375.png)

Si vous souhaitez modifier votre rôle, sans le supprimer/recréer, il suffit de récupérer son ID et de l’insérer dans votre fichier JSON:

`Get-AzureRmRoleDefinition -Name "Admin Network Card"`

[![](https://cloudyjourney.fr/wp-content/uploads/2018/01/SNAGHTML15f151a1_55B53FFE.png)](https://cloudyjourney.fr/wp-content/uploads/2018/01/SNAGHTML15f151a1_55B53FFE.png)

Exécutez ensuite la commande suivante pour le mettre à jour sur Azure:

`Set-AzureRmRoleDefinition -InputFile C:\Users\flore\Desktop\CustomRole.json`

[![](https://cloudyjourney.fr/wp-content/uploads/2018/01/SNAGHTML15e4bfbc_5F536B70.png)](https://cloudyjourney.fr/wp-content/uploads/2018/01/SNAGHTML15e4bfbc_5F536B70.png)

Cette nouvelle fonctionnalité vous permettra sans aucun doute de donner les bon droits aux bonnes personnes, sans avoir d’impacte sur le reste de la production puisqu’il n’est pas nécessaire d’être Coadministrateur de la suscription :)
