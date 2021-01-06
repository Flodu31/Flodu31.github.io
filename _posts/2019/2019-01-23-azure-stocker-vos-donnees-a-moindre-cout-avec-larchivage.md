---
title: "[Azure] Stocker vos données à moindre coût avec l'archivage"
date: "2019-01-23"
categories: 
  - "azure-storage"
tags: 
  - "archivage"
  - "azure"
  - "microsoft"
  - "storage"
---

![](https://cloudyjourney.fr/wp-content/uploads/2019/01/image.png)

Si vous devez garder des fichiers pendant X années, pour des raisons légales, et qu'elle sont rarement voir quasiment jamais accédées, il existe sur les comptes de stockages Azure, une partie Archive.

En effet, le plan tarifaire de la partie Archive dans Azure est très interéssante. Prenons le cas, que nous devons héberger 1TB de données sur Azure. En **Hot** ceci vous coûtera 16,6€ en West Europe, en **Cool** 8,5€ et en **Archive** 1,9€.

Comme vous pouvez le voir, la différence est grande pour seulement 1TB, alors imaginez, pour des PB, sur 10 ans? Une économie non négligeable. Les coûts pour le stockage sur Azure sont disponibles ici: [https://azure.microsoft.com/en-us/pricing/details/storage/blobs/](https://azure.microsoft.com/en-us/pricing/details/storage/blobs/)

Pour passer un fichier en mode Archive, sélectionnez le fichier en question dans le portail Azure (attention, le compte de stockage doit être de type V2 ou Blob Storage et en Standard), puis sélectionnez le type accès, **Archive**:

![](https://i1.wp.com/cloudyjourney.fr/wp-content/uploads/2019/01/AzureStorageArchive01.png?fit=762%2C401&ssl=1)

Sauvegardez:

![](https://cloudyjourney.fr/wp-content/uploads/2019/01/AzureStorageArchive02.png)

Votre fichier est maintenant en **Archive**:

![](https://i2.wp.com/cloudyjourney.fr/wp-content/uploads/2019/01/AzureStorageArchive03.png?fit=762%2C164&ssl=1)

Comme vous le voyez, il n'est plus possible de télécharger ce fichier, étant donné que c'est maintenant une archive:

![](https://cloudyjourney.fr/wp-content/uploads/2019/01/AzureStorageArchive04.png)

Si vous souhaitez accéder de nouveau à ce fichier, il faut le "réhydrater", c'est-à-dire, le repasser dans un tier Hot ou Cool. Vous pouvez le faire via le portail, ou sinon, en CLI:

```
az storage blob set-tier --container-name archive --name "Install Kubernetes.docx" --account-name cloudyjourney --tier Hot
```

![](https://i1.wp.com/cloudyjourney.fr/wp-content/uploads/2019/01/AzureStorageArchive05.png?fit=762%2C45&ssl=1)

Le changement de tier est en cours, et peut prendre [jusqu'à 15 heures](https://docs.microsoft.com/en-us/azure/storage/blobs/storage-blob-storage-tiers#archive-access-tier):

![](https://cloudyjourney.fr/wp-content/uploads/2019/01/AzureStorageArchive06.png)

Une fois le fichier réhydraté, vous pouvez de nouveau le retélécharger et rechanger son tier:

![](https://cloudyjourney.fr/wp-content/uploads/2019/01/AzureStorageArchive07.png)

Vous pouvez également utiliser l'outil Azure Storage Explorer pour effectuer ces changements également.
