---
title: "[Azure] Export des polices existantes dans un environnement"
date: "2019-05-23"
author: "Florent Appointaire"
permalink: "/2019/05/23/azure-export-des-polices-existantes-dans-un-environnement/"
summary:
categories: 
  - "azure"
  - "powershell"
tags: 
  - "azure"
  - "azure-policy"
  - "microsoft"
  - "powershell"
---
Aujourd'hui j'ai eu besoin d'exporter toutes les polices qui existent (built-in et custom) sur une subscription. N'ayant rien trouvé mentionnant ceci sur internet ou même, ne trouvant pas l'existance d'un bouton export sur Azure, je suis passé par PowerShell.

Connectez-vous à votre environnement et sélectionnez la subscription où les polices doivent être exportées:

```
Connect-AzAccount
Select-AzSubscription -SubscriptionName "Visual Studio Enterprise"
```

Et exécutez les 2 commandes suivantes:

```
$policies = Get-AzPolicyDefinition | Select -ExpandProperty Properties
$policies | Select-Object -Property displayName,description | Export-Csv policies.csv
```

Ceci aura pour but de vous faire un fichier CSV, avec toutes les polices à l'intérieur, avec le nom et la description :

![](https://cloudyjourney.fr/wp-content/uploads/2019/05/AZPolicyExport01.png)

En espérant vous avoir fait gagner du temps :)
