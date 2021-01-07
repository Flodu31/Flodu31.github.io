---
title: "[Azure] Nettoyer les polices d'une souscription"
date: "2020-06-02"
author: "Florent Appointaire"
permalink: "/2020/06/02/azure-nettoyer-les-polices-dune-souscription/"
summary: 
categories: 
  - "azure"
  - "powershell"
tags: 
  - "azure"
  - "azure-policy"
  - "microsoft"
---
Jouant pas mal avec les blueprints et les polices en ce moment (pour les démos des sessions que je fais), je voulais un moyen simple et rapide d'effacer toutes les polices d'une souscription, pour la démo suivante. Par exemple, j'ai les polices suivantes déployées sur une souscription:

![](https://cloudyjourney.fr/wp-content/uploads/2020/05/AzurePolicy01.png)

Pour commencer, connectez vous à votre compte Azure, et sélectionnez la souscription à nettoyer:

```
Connect-AzAccount
Select-AzSubscription -SubscriptionId "VotreId"
```

![](https://cloudyjourney.fr/wp-content/uploads/2020/05/AzurePolicy02.png)

Exécutez maintenant la commande suivante pour effacer toutes les polices de la souscription:

```
$policies = Get-AzPolicyAssignment
foreach ($policy in $policies){Remove-AzPolicyAssignment -Id $policy.ResourceId}
```

![](https://cloudyjourney.fr/wp-content/uploads/2020/05/AzurePolicy03.png)

Une fois la commande terminée, votre souscription est vierge de toute police:

![](https://cloudyjourney.fr/wp-content/uploads/2020/05/AzurePolicy04.png)

Voila donc un moyen simple et efficace de nettoyer les polices d'une souscription :)
