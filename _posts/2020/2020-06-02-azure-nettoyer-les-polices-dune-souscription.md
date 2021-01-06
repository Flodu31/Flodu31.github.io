---
title: "[Azure] Nettoyer les polices d'une souscription"
date: "2020-06-02"
categories: 
  - "azure"
  - "powershell"
tags: 
  - "azure"
  - "azure-policy"
  - "microsoft"
---

![](https://cloudyjourney.fr/wp-content/uploads/2018/01/Azure.png)

Jouant pas mal avec les blueprints et les polices en ce moment (pour les démos des sessions que je fais), je voulais un moyen simple et rapide d'effacer toutes les polices d'une souscription, pour la démo suivante. Par exemple, j'ai les polices suivantes déployées sur une souscription:

![](https://i0.wp.com/cloudyjourney.fr/wp-content/uploads/2020/05/AzurePolicy01.png?fit=762%2C273&ssl=1)

Pour commencer, connectez vous à votre compte Azure, et sélectionnez la souscription à nettoyer:

```
Connect-AzAccount
Select-AzSubscription -SubscriptionId "VotreId"
```

![](https://i1.wp.com/cloudyjourney.fr/wp-content/uploads/2020/05/AzurePolicy02.png?fit=762%2C142&ssl=1)

Exécutez maintenant la commande suivante pour effacer toutes les polices de la souscription:

```
$policies = Get-AzPolicyAssignment
foreach ($policy in $policies){Remove-AzPolicyAssignment -Id $policy.ResourceId}
```

![](https://i0.wp.com/cloudyjourney.fr/wp-content/uploads/2020/05/AzurePolicy03.png?fit=762%2C127&ssl=1)

Une fois la commande terminée, votre souscription est vierge de toute police:

![](https://i2.wp.com/cloudyjourney.fr/wp-content/uploads/2020/05/AzurePolicy04.png?fit=762%2C277&ssl=1)

Voila donc un moyen simple et efficace de nettoyer les polices d'une souscription :)
