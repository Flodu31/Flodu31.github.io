---
title: "[Azure] Failover manuel d'un compte de stockage"
date: "2020-06-22"
author: "Florent Appointaire"
permalink: "/2020/06/22/azure-failover-manuel-dun-compte-de-stockage/"
summary:
categories: 
  - "azure-storage"
tags: 
  - "azure"
  - "azure-storage"
  - "failover"
  - "microsoft"
  - "replication"
  - "storage"
---
Microsoft a annoncé il y a quelques temps, la possibilité de faire un failover manuel d'un compte de stockage, de la région principale, vers la région secondaire. Depuis ce Mercredi 17 Juin, cette feature est maintenant disponible de façon générale: [https://azure.microsoft.com/en-us/updates/azure-storage-account-failover-ga/](https://azure.microsoft.com/en-us/updates/azure-storage-account-failover-ga/)

Pour commencer, vous devez avoir un compte de stockage avec un SKU suivant:

- Geo-redundant storage (GRS) ou read-access geo-redundant storage (RA-GRS)
- Geo-zone-redundant storage (GZRS) ou read-access geo-zone-redundant storage (RA-GZRS)

Pour vérifier cette information, allez dans votre compte de stockage, et vous aurez l'information directement ici ou dans la partie **Geo-replication**:

![](https://cloudyjourney.fr/wp-content/uploads/2020/06/storage01.png)

Et on voit bien les régions disponibles:

![](https://cloudyjourney.fr/wp-content/uploads/2020/06/storage04.png)

Pour faire le failover, c'est très simple, vous avez 3 possibilités:

- Via PowerShell:

```
Install-Module PowerShellGet –Repository PSGallery –Force
Install-Module Az –Repository PSGallery –AllowClobber
# Le module en preview supporte le failover
Install-Module Az.Storage –Repository PSGallery -RequiredVersion 1.1.1-preview –AllowPrerelease –AllowClobber –Force
Invoke-AzStorageAccountFailover -ResourceGroupName Storage -Name cloudyjourney
```

- Via CLI:

```
az storage account show --name cloudyjourney--expand geoReplicationStats
az storage account failover --name accountName
```

- Via le portail, dans le compte de stockage, cliquez sur **Geo-replication** puis sur **Prepare for failover**:

![](https://cloudyjourney.fr/wp-content/uploads/2020/06/storage02.png)

Ici, on a des informations concernant le failover. Ecrivez **yes** pour démarrer le failover:

![](https://cloudyjourney.fr/wp-content/uploads/2020/06/storage03.png)

Le failover est en cours:

![](https://cloudyjourney.fr/wp-content/uploads/2020/06/storage05.png)

Une fois le failover terminé (après plusieurs minutes), la région principale est maintenant North Europe:

![](https://cloudyjourney.fr/wp-content/uploads/2020/06/storage06.png)

On peut voir que le nom DNS pour accéder au compte de stockage reste le même mais que l'IP a changé:

![](https://cloudyjourney.fr/wp-content/uploads/2020/06/storage07.png)

Le compte de stockage est également passé en LRS, vous pouvez le remettre en GRS, ce qui va rerépliquer les données en West Europe:

![](https://cloudyjourney.fr/wp-content/uploads/2020/06/storage08.png)

Une fois que c'est fait, vous retrouvez vos 2 régions:

![](https://cloudyjourney.fr/wp-content/uploads/2020/06/storage09.png)

![](https://cloudyjourney.fr/wp-content/uploads/2020/06/storage10.png)
