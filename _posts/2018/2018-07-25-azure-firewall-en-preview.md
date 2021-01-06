---
title: "[Azure] Firewall en Preview"
date: "2018-07-25"
categories: 
  - "reseau"
tags: 
  - "azure"
  - "firewall"
  - "microsoft"
---

[![](https://cloudyjourney.fr/wp-content/uploads/2018/07/firewall-overview.png)](https://cloudyjourney.fr/wp-content/uploads/2018/07/firewall-overview.png)

Microsoft a rendu disponible en Preview, une nouvelle feature sur Azure, Azure Firewall. Ce dernier va vous permettre de protéger votre infrastructure, directement depuis Azure, sans déployer d'appliance virtuel, qui peuvent parfois coûter cher. La documentation complète se trouve ici : [https://docs.microsoft.com/en-us/azure/firewall/](https://docs.microsoft.com/en-us/azure/firewall/)

Pour commencer, il faut activer le RP qui va nous permettre d'utiliser Azure Firewall, avec les commandes suivantes:

Connect-AzureRmAccount

Register-AzureRmProviderFeature -FeatureName AllowRegionalGatewayManagerForSecureGateway -ProviderNamespace Microsoft.Network

Register-AzureRmProviderFeature -FeatureName AllowAzureFirewall -ProviderNamespace Microsoft.Network

[![](https://cloudyjourney.fr/wp-content/uploads/2018/07/AzureFirewall01.png)](https://cloudyjourney.fr/wp-content/uploads/2018/07/AzureFirewall01.png)

Après plus ou moins 30 minutes, vous pouvez vérifier que la Preview a bien été activée (Registered) avec les commandes suivantes:

Get-AzureRmProviderFeature -FeatureName AllowRegionalGatewayManagerForSecureGateway -ProviderNamespace Microsoft.Network

Get-AzureRmProviderFeature -FeatureName AllowAzureFirewall -ProviderNamespace Microsoft.Network

Et de réactiver le RP réseau :

Register-AzureRmResourceProvider -ProviderNamespace Microsoft.Network

[![](https://cloudyjourney.fr/wp-content/uploads/2018/07/AzureFirewall02.png)](https://cloudyjourney.fr/wp-content/uploads/2018/07/AzureFirewall02.png)

Il faut maintenant créer un sous réseau dédié à notre Azure Firewall. Il doit obligatoirement s'appeler **AzureFirewallSubnet**:

[![](https://cloudyjourney.fr/wp-content/uploads/2018/07/AzureFirewall03.png)](https://cloudyjourney.fr/wp-content/uploads/2018/07/AzureFirewall03.png)

Allez ensuite sur le VNet où vous souhaitez activer la feature Azure Firewall, et cliquez sur **Firewall (Preview) > Click here to add a new firewall:**

[![](https://cloudyjourney.fr/wp-content/uploads/2018/07/AzureFirewall04.png)](https://cloudyjourney.fr/wp-content/uploads/2018/07/AzureFirewall04.png)

Donnez un nom à ce firewall et où vous souhaitez le déployer. Choisissez également le VNet où vous souhaitez le lier. Créez ou sélectionnez une IP Publique:

[![](https://cloudyjourney.fr/wp-content/uploads/2018/07/AzureFirewall05.png)](https://cloudyjourney.fr/wp-content/uploads/2018/07/AzureFirewall05.png)

Après plusieurs minutes, le firewall est déployé sur votre réseau:

[![](https://cloudyjourney.fr/wp-content/uploads/2018/07/AzureFirewall06.png)](https://cloudyjourney.fr/wp-content/uploads/2018/07/AzureFirewall06.png)

Récupérez l'adresse IP Privée de votre Firewall:

[![](https://cloudyjourney.fr/wp-content/uploads/2018/07/AzureFirewall07.png)](https://cloudyjourney.fr/wp-content/uploads/2018/07/AzureFirewall07.png)

Il faut maintenant créer une nouvelle route table, pour dire à toutes nos VMs de passer par ce Firewall avant d'accéder à l'extérieur. Créez une nouvelle route table, comme ceci:

[![](https://cloudyjourney.fr/wp-content/uploads/2018/07/AzureFirewall08.png)](https://cloudyjourney.fr/wp-content/uploads/2018/07/AzureFirewall08.png)

Associez le sous réseau que vous souhaitez protéger à cette table de routage:

[![](https://cloudyjourney.fr/wp-content/uploads/2018/07/AzureFirewall09.png)](https://cloudyjourney.fr/wp-content/uploads/2018/07/AzureFirewall09.png)

Puis, créez une nouvelle route, avec comme préfixe 0.0.0.0/0 pour router tout le traffic vers ce firewall, et choisissez comme Next op, une virtual appliance et renseignez l'IP de votre Azure Firewall:

[![](https://cloudyjourney.fr/wp-content/uploads/2018/07/AzureFirewall10.png)](https://cloudyjourney.fr/wp-content/uploads/2018/07/AzureFirewall10.png)

Si vous allez sur la VM qui est protégé par ce Azure Firewall, et que vous essayez d'aller sur un site web ou d'ouvrir une session RDP vers une machine, tout sera bloqué par défaut, comme vous pouvez le voir dans mes 2 exemples suivants:

[![](https://cloudyjourney.fr/wp-content/uploads/2018/07/AzureFirewall11.png)](https://cloudyjourney.fr/wp-content/uploads/2018/07/AzureFirewall11.png)

[![](https://cloudyjourney.fr/wp-content/uploads/2018/07/AzureFirewall12.png)](https://cloudyjourney.fr/wp-content/uploads/2018/07/AzureFirewall12.png)

Ajoutez une règle de type **Network** pour autoriser les connexions réseaux vers l'exterieur. Dans mon cas, c'est du RDP, je rajoute donc une règle avec comme Protocole TCP, comme source n'importe quelle IP, comme destination l'IP de la VM que je souhaite attaquer en RDP et comme port 3389:

[![](https://cloudyjourney.fr/wp-content/uploads/2018/07/AzureFirewall13.png)](https://cloudyjourney.fr/wp-content/uploads/2018/07/AzureFirewall13.png)

Après quelques secondes, le firewall est mis à jour et le système est débloqué:

[![](https://cloudyjourney.fr/wp-content/uploads/2018/07/AzureFirewall14.png)](https://cloudyjourney.fr/wp-content/uploads/2018/07/AzureFirewall14.png)

Faites de même pour la partie application. Ajoutez les règles pour les sites que vous souhaitez afficher, dans mon cas cloudyjourney.fr, sur les ports 443 et 80:

[![](https://cloudyjourney.fr/wp-content/uploads/2018/07/AzureFirewall15.png)](https://cloudyjourney.fr/wp-content/uploads/2018/07/AzureFirewall15.png)

Vous pouvez maintenant accéder au site sans souci:

[![](https://cloudyjourney.fr/wp-content/uploads/2018/07/AzureFirewall16.png)](https://cloudyjourney.fr/wp-content/uploads/2018/07/AzureFirewall16.png)

Cette nouvelle fonctionnalité est plus qu'intéréssante. Elle va permettre de gérer le traffic simplement, depuis Azure, vers l'extérieur, et ceci en mode PaaS :)
