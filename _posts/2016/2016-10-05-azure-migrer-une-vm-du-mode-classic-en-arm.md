---
title: "[Azure] Migrer une VM du mode Classic en ARM"
date: "2016-10-05"
author: "Florent Appointaire"
permalink: "/2016/10/05/azure-migrer-une-vm-du-mode-classic-en-arm/"
summary: 
categories: 
  - "azure"
tags: 
  - "arm"
  - "azure"
  - "classic"
  - "microsoft"
  - "resource-manager"
---
Un client a déployé aujourd’hui toutes ses VMs en Classic plutôt qu’en ARM (mais aussi un compte de stockage/vm, etc.). Vu la facilité de gestion de facilité de Resource Manager et sa flexibilité ainsi que ses différentes évolutions, je lui ai conseillé de migrer de Azure Classic vers Azure ARM.

Nous avons donc créé un nouveau groupe de ressource dans ARM, ainsi qu’un nouveau réseau. Le client avait déjà commencé à personnaliser ses VMs et voulait éviter de tout refaire. C’est pourquoi, je lui ai proposé de migrer tous les VHDs des comptes de stockages classic vers le modèle RM et aussi, un seul et unique compte de stockage (10 VMs donc assez d’IOPS).

J’ai alors suivi les explications qui sont disponibles ici: [https://azure.microsoft.com/en-us/blog/migrate-azure-virtual-machines-between-storage-accounts/](https://azure.microsoft.com/en-us/blog/migrate-azure-virtual-machines-between-storage-accounts/ "https://azure.microsoft.com/en-us/blog/migrate-azure-virtual-machines-between-storage-accounts/")

Pour commencer, il faut arrêter toutes les VMS. Ensuite, il faut executer le script suivant, en adaptant avec vos paramètres:

```
Select-AzureSubscription "ClientSub"
# VHD blob to copy #
$blobName = "NomduVHD.vhd"

# Source Storage Account Information # 
$sourceStorageAccountName = "nom du compte de stockage classic"
$sourceKey = "la clé primaire associée"
$sourceContext = New-AzureStorageContext –StorageAccountName $sourceStorageAccountName -StorageAccountKey $sourceKey 
$sourceContainer = "vhds"

# Destination Storage Account Information #
$destinationStorageAccountName = "nom du compte de stockage sur RM"
$destinationKey = "la clé primaire associée"
$destinationContext = New-AzureStorageContext –StorageAccountName $destinationStorageAccountName -StorageAccountKey $destinationKey

# Create the destination container #
$destinationContainerName = "vhds"
New-AzureStorageContainer -Name $destinationContainerName -Context $destinationContext

# Copy the blob #
$blobCopy = Start-AzureStorageBlobCopy -DestContainer $destinationContainerName -DestContext $destinationContext -SrcBlob $blobName -Context $sourceContext -SrcContainer $sourceContainer
```

En validant la dernière ligne, ceci va initier la copie:

[![](https://cloudyjourney.fr/wp-content/uploads/2018/01/2016-10-05_10-30-45.png)](https://cloudyjourney.fr/wp-content/uploads/2018/01/2016-10-05_10-30-45.png)

Pour suivre la copie, il suffit d’exécuter la commande suivante (ceci va faire un check toutes les 30 secondes):

`while(($blobCopy | Get-AzureStorageBlobCopyState).Status -eq "Pending"){ Start-Sleep -s 30 $blobCopy | Get-AzureStorageBlobCopyState }`

[![](https://cloudyjourney.fr/wp-content/uploads/2018/01/2016-10-05_10-34-50.png)](https://cloudyjourney.fr/wp-content/uploads/2018/01/2016-10-05_10-34-50.png)

Une fois que le **Status** est **Success**, vous pouvez commencer à recréer les VMs. Pour faire ceci, Marc Van Eijk, Senior Program Manager chez Microsoft, a publié sur GitHub un modèle qui permet de déployer une VM depuis un VHD existant et qui se trouve sur un compte de stockage sur Azure: [https://github.com/Azure/azure-quickstart-templates/tree/master/201-specialized-vm-in-existing-vnet](https://github.com/Azure/azure-quickstart-templates/tree/master/201-specialized-vm-in-existing-vnet "https://github.com/Azure/azure-quickstart-templates/tree/master/201-specialized-vm-in-existing-vnet")

Cliquez sur **Deploy To Azure**. Une fenêtre va s’ouvrir avec comme site web Azure et sur une page à remplir avec les informations suivantes:

- VMName: Nom de la VM dans Azure RM
- OS Type: Windows ou Linux
- OSDiskVHDURI: URL vers le VHD qui vient d’être copié (sur ARM)
- VMSize: Taille de votre VM (Standard\_A3, etc.)
- ExistingVirtualNetworkName: Nom du VNet où la VM sera connectée
- ExistingVirtualNetworkResourceGroup: Nom du Resource Group où le VNet a été créé
- SubnetName: Nom du sous réseau où la VM sera connecté et récuperera une IP
- DNSNameForPublicIP: Nom DNS publique pour accèder à la VM depuis Internet

[![](https://cloudyjourney.fr/wp-content/uploads/2018/01/2016-10-05_10-36-30.png)](https://cloudyjourney.fr/wp-content/uploads/2018/01/2016-10-05_10-36-30.png)

[![](https://cloudyjourney.fr/wp-content/uploads/2018/01/2016-10-05_10-37-19.png)](https://cloudyjourney.fr/wp-content/uploads/2018/01/2016-10-05_10-37-19.png)

Une fois la VM créée, vous devriez la voir dans la partie VM du portail:

[![](https://cloudyjourney.fr/wp-content/uploads/2018/01/2016-10-05_10-37-33.png)](https://cloudyjourney.fr/wp-content/uploads/2018/01/2016-10-05_10-37-33.png)

Si tout est OK, vous pouvez supprimer l’ancienne VM et les ressources associées.

Bon courage :)
