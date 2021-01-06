---
title: "[OMS] Récupérer des informations avec PowerShell"
date: "2017-09-14"
author: "Florent Appointaire"
permalink: "/2017/09/14/oms-recuperer-des-informations-avec-powershell/"
summary:
categories: 
  - "azure"
  - "oms"
tags: 
  - "microsoft"
  - "oms"
  - "oms-powershell-query"
  - "powershell"
---
Voulant automatiser la classification des agents OMS qui sont connectés à mon workspace, j'ai cherché différentes options pour récupérer le nom des serveurs avec des agents installés. Il y a 2 possibilités:

- PowerShell
- API

J'ai choisi la méthode PowerShell, la plus simple pour moi. Ceci fonctionne avec les version 1 et 2 de OMS. Pour commencer, vous avez besoin des informations suivantes:

- Le nom du workspace
- Le groupe de ressource où le workspace OMS est
- Le module AzureRM.OperationalInsights avec la version 3.3.1 minimum

Vous pouvez effectuer vos requêtes suivant 2 types:

- Nouvelle requête
- Requête qui est sauvegardée sur votre workspace OMS

Afin de faire des requêtes, nous allons importer le module et nous connecter à notre suscription Azure, qui a les droits sur le groupe de ressource OMS:

`Import-Module AzureRM.OperationalInsights -MinimumVersion 3.3.1` `Login-AzureRmAccount` `Select-AzureRmSubscription -SubscriptionId SubscriptionID`

Quand ceci est terminé, adaptez les variables suivantes avec vos informations:

`$rgName = "oms"` `$WorkSpaceName = "florentappointaire"` `$dynamicQuery = "Heartbeat | distinct Computer"`

Ici, je vais récupérer la liste de mes serveurs qui sont connectés à OMS:

[![](https://cloudyjourney.fr/wp-content/uploads/2018/01/0435.Screen-Shot-2017-09-14-at-09.17.20.png)](https://cloudyjourney.fr/wp-content/uploads/2018/01/0435.Screen-Shot-2017-09-14-at-09.17.20.png)Exécutez maintenant la commande suivante, pour obtenir, en PowerShell, le résultat:

`$result = Get-AzureRmOperationalInsightsSearchResults -ResourceGroupName $rgName -WorkspaceName $WorkSpaceName -Query $dynamicQuery -Top 1000`

[![](https://cloudyjourney.fr/wp-content/uploads/2018/01/0435.OMS03.png)](https://cloudyjourney.fr/wp-content/uploads/2018/01/0435.OMS03.png)

Comme vous le voyez, ceci n'est pas très parlant. Mais la bonne nouvelle est que ceci est formaté en JSON. Donc, avec la commande suivante, on obtient quelque chose de plus joli et utilisable:

`$result.Value | ConvertFrom-Json`

[![](https://cloudyjourney.fr/wp-content/uploads/2018/01/8877.Screen-Shot-2017-09-14-at-09.21.38.png)](https://cloudyjourney.fr/wp-content/uploads/2018/01/8877.Screen-Shot-2017-09-14-at-09.21.38.png)

Si vous souhaitez utiliser une query qui est sauvegardée sur votre workspace OMS, utilisez la commande suivante, pour la V1:

`$savedSearchId = "General Exploration|DistinctComputer" Get-AzureRmOperationalInsightsSavedSearchResults -ResourceGroupName $rgName -WorkspaceName $WorkSpaceName -SavedSearchId $savedSearchId`

Où $savedSearchId est le nom de la catégorie où la recherche se trouve, suivi du nom de la recherche.

Seulement, si vous utilisez la V2 de OMS, il faudra utiliser d'autres commande, car vous aurez l'erreur suivante:

`Get-AzureRmOperationalInsightsSavedSearchResults : Saved search result not supported for the new query language` `At line:1 char:1` `+ Get-AzureRmOperationalInsightsSavedSearchResults -ResourceGroupName $ ...` `+ ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~` `+ CategoryInfo : NotSpecified: (:) [Get-AzureRmOper...edSearchResults], CloudException` `+ FullyQualifiedErrorId : Microsoft.Rest.Azure.CloudException,Microsoft.Azure.Commands.OperationalInsights.GetAzureOperationalInsightsSavedSearchResultsCommand`

[![](https://cloudyjourney.fr/wp-content/uploads/2018/01/8877.Screen-Shot-2017-09-14-at-09.38.23.png)](https://cloudyjourney.fr/wp-content/uploads/2018/01/8877.Screen-Shot-2017-09-14-at-09.38.23.png)

Utilisez alors le script suivant:

`$savedSearchId = "General Exploration|DistinctComputer"` `$query = Get-AzureRmOperationalInsightsSavedSearch -ResourceGroupName $rgName -WorkspaceName $WorkSpaceName -SavedSearchId $savedSearchId`

`$result2 = Get-AzureRmOperationalInsightsSearchResults -ResourceGroupName $rgName -WorkspaceName $WorkSpaceName -Query $query.Properties.Query -Top 1000` `$result2.value | ConvertFrom-Json`

[![](https://cloudyjourney.fr/wp-content/uploads/2018/01/2502.Screen-Shot-2017-09-14-at-09.43.29.png)](https://cloudyjourney.fr/wp-content/uploads/2018/01/2502.Screen-Shot-2017-09-14-at-09.43.29.png)

Comme vous pouvez le voir, ceci est très pratique pour automatiser vos différents workloads.
