---
title: "[Azure AD] Suppression d'une application impossible"
date: "2017-12-20"
author: "Florent Appointaire"
permalink: "/2017/12/20/azure-ad-suppression-dune-application-impossible/"
summary:
categories: 
  - "azure"
  - "azure-ad"
tags: 
  - "azure"
  - "azure-ad"
  - "microsoft"
---
En voulant faire le ménage dans mes applications dans mon Azure AD, je suis tombé sur des applications où le bouton **Delete** n'était pas disponible. J'ai donc essayé en PowerShell, avec l'erreur suivante: 

`Remove-AzureAdApplication : Deletion of multi-tenant application is currently not supported.`

[![](https://cloudyjourney.fr/wp-content/uploads/2018/01/5808.2017-12-19_7-18-52.png-831x642.png)](https://cloudyjourney.fr/wp-content/uploads/2018/01/5808.2017-12-19_7-18-52.png)

Il s'avère que le paramètre **AvailableToOtherTenants** est à **True**. Pour pouvoir supprimer les applications, il faut le mettre à **False**. Vous pouvez le faire en utilisant la commande suivante, pour chaque nom:

```
Get-AzureRmADApplication -DisplayNameStartWith "Azure Bridge" | ForEach-Object {Set-AzureRmADApplication -ObjectId $_.ObjectId -AvailableToOtherTenants $false }
```

[![](https://cloudyjourney.fr/wp-content/uploads/2018/01/7065.pastedimage1513673712317v6.png-847x458.png)](https://cloudyjourney.fr/wp-content/uploads/2018/01/7065.pastedimage1513673712317v6.png)

Le paramètre est maintenant à **False** et il est donc possible de supprimer les applications :

[![](https://cloudyjourney.fr/wp-content/uploads/2018/01/5417.pastedimage1513674088307v7.png-828x44.png)](https://cloudyjourney.fr/wp-content/uploads/2018/01/5417.pastedimage1513674088307v7.png)
