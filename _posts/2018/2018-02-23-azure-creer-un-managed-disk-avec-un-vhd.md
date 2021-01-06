---
title: "[Azure] Créer un Managed Disk avec un VHD"
date: "2018-02-23"
author: "Florent Appointaire"
permalink: "/2018/02/23/azure-creer-un-managed-disk-avec-un-vhd"
summary:
categories: 
  - "azure"
  - "azure-storage"
tags: 
  - "azure"
  - "managed-disk"
  - "microsoft"
  - "storage"
  - "vhd"
---
J'ai du déployé récemment un F5 Big-IP sur Azure, avec une image spécifique qui n'était pas disponible dans le Marketplace de Azure. L'image que j'ai téléchargé est spécifique pour Azure. Je l'ai uploadé.

Comme l'environnement est entièrement en Managed disk, j'ai du créer un Managed disk, basé sur ce VHD. Allez dans **Disks** sur Azure et cliquez sur **Add:**

[![](https://cloudyjourney.fr/wp-content/uploads/2018/02/AzureManagedDisk01.png)](https://cloudyjourney.fr/wp-content/uploads/2018/02/AzureManagedDisk01.png)

Donnez un nom au disque, la subscription qui sera utilisé, le groupe de ressource, la localisation, si c'est du standard ou premium, et enfin, où est le VHD qui doit servir d'image source. Sélectionnez également le type d'OS ainsi que la taille et validez:

[![](https://cloudyjourney.fr/wp-content/uploads/2018/02/AzureManagedDisk02.png)](https://cloudyjourney.fr/wp-content/uploads/2018/02/AzureManagedDisk02.png)

1 minute après pour ma part, le disque était disponible. Cliquez sur **Create VM** pour créer une VM, basé sur ce disque:

[![](https://cloudyjourney.fr/wp-content/uploads/2018/02/AzureManagedDisk03.png)](https://cloudyjourney.fr/wp-content/uploads/2018/02/AzureManagedDisk03.png)

Simple n'est-ce pas? :)
