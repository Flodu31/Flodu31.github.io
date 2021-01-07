---
title: "[Azure DevOps] Terraform et Azure DevOps CI/CD - Part 1"
date: "2019-02-27"
author: "Florent Appointaire"
permalink: "/2019/02/27/azure-devops-terraform-et-azure-devops-ci-cd-part-1/"
summary:
categories: 
  - "azure-devops"
tags: 
  - "azure-devops"
  - "ci-cd"
  - "microsoft"
  - "terraform"
---
Azure DevOps (anciennement VSTS) permet le déploiement automatisé de ressources, quelles soient en template ARM (JSON), en PowerShell, CLI, Terraform, etc.

Aujourd'hui, je vais me concentrer sur l'intégration avec Terraform. Attention, je ne rentrerai pas dans les détails Terraform ici, vous devez donc connaitre un minimum la technologie. La tarification concernant Azure DevOps est disponible ici: [https://azure.microsoft.com/en-us/pricing/details/devops/azure-pipelines/](https://azure.microsoft.com/en-us/pricing/details/devops/azure-pipelines/)

Par défaut, vous avez le droit à 5 utilisateurs de façon gratuite.

Avant de commencer, assurez-vous d'avoir une organisation Azure DevOps dans votre subscription:

![](https://cloudyjourney.fr/wp-content/uploads/2019/02/Azure_devops_part1_01.png)

Ouvrez via l'URL votre Azure DevOps et créez un nouveau projet en cliquant sur **Create project:**

![](https://cloudyjourney.fr/wp-content/uploads/2019/02/Azure_devops_part1_02.png)

Donnez lui un nom, et cliquez sur **Create**:

![](https://cloudyjourney.fr/wp-content/uploads/2019/02/Azure_devops_part1_03.png)

Une fois le projet créé, vous pouvez inviter des personnes, etc. :

![](https://cloudyjourney.fr/wp-content/uploads/2019/02/Azure_devops_part1_04.png)

Sur la gauche, allez dans **Repos > Files** et ajoutez un ou plusieurs fichiers dans le répertoire. Vous pouvez ajouter le **README** par exemple pour initialiser le projet, en cliquant sur **Initialize**:

![](https://cloudyjourney.fr/wp-content/uploads/2019/02/Azure_devops_part1_05.png)

Une fois l'initialisation terminée, vous aurez au moins un fichier dans votre répertoire:

![](https://cloudyjourney.fr/wp-content/uploads/2019/02/Azure_devops_part1_06.png)

Ici, créez un dossier, ainsi que 2 fichier, main.tf et variables.tf:

![](https://cloudyjourney.fr/wp-content/uploads/2019/02/Azure_devops_part1_07.png)

Ici, je vais déployer 1 VNet dans Azure, avec 2 sous-réseaux. Comme vous pouvez le voir, pour quelques variables, j'utilise des **\_\_** pour utiliser des variables directement depuis Azure DevOps. Voici le code utilisé:

**main.tf:**

```
terraform {
  required_version = ">= 0.11"
  backend "azurerm" {
    storage_account_name = "__terraformstorageaccount__"
    container_name       = "terraform"
    key                  = "terraform.tfstate"
    access_key           = "__storagekey__"
  }
}

resource "azurerm_resource_group" "rg" {
  name     = "__resource_group__"
  location = "__location__"
}

resource "azurerm_virtual_network" "vnet" {
  name                = "${var.virtual_network_name}"
  location            = "__location__"
  address_space       = ["${var.address_space}"]
  resource_group_name = "${azurerm_resource_group.rg.name}"
}

resource "azurerm_subnet" "subnetfrontend" {
  name                 = "${var.subnetname_prefixfrontend}"
  virtual_network_name = "${azurerm_virtual_network.vnet.name}"
  resource_group_name  = "${azurerm_resource_group.rg.name}"
  address_prefix       = "${var.subnet_prefixfrontend}"
}

resource "azurerm_subnet" "subnetbackend" {
  name                 = "${var.subnetname_prefixbackend}"
  virtual_network_name = "${azurerm_virtual_network.vnet.name}"
  resource_group_name  = "${azurerm_resource_group.rg.name}"
  address_prefix       = "${var.subnet_prefixbackend}"
}
```

**variables.tf:**

```
variable "virtual_network_name" {
  description = "The name for the virtual network."
  default     = "FLOAPP-vNet-Terra"
}

variable "address_space" {
  description = "The address space that is used by the virtual network. You can supply more than one address space. Changing this forces a new resource to be created."
  default     = "10.0.0.0/16"
}

variable "subnetname_prefixfrontend" {
  description = "The shortened abbreviation to represent your resource group that will go on the front of some resources."
  default     = "Frontend"
}

variable "subnetname_prefixbackend" {
  description = "The shortened abbreviation to represent your resource group that will go on the front of some resources."
  default     = "Backend"
}

variable "subnet_prefixfrontend" {
  description = "The address prefix to use for the subnet."
  default     = "10.0.10.0/24"
}

variable "subnet_prefixbackend" {
  description = "The address prefix to use for the subnet."
  default     = "10.0.20.0/24"
}
```

Nous allons maintenant créer la Build, qui permettra de vérifier si les ressources ont été modifiés dans un dossier en particulier, et donc, de créer une nouvelle build pour notre futur release. Cliquez sur **Pipelines > Builds > New pipeline**:

![](https://cloudyjourney.fr/wp-content/uploads/2019/02/Azure_devops_part1_08.png)

Ici, choisissez d'où viennent les sources et validez:

![](https://cloudyjourney.fr/wp-content/uploads/2019/02/Azure_devops_part1_09.png)

Choisissez ensuite le template, vide dans mon cas:

![](https://cloudyjourney.fr/wp-content/uploads/2019/02/Azure_devops_part1_10.png)

Donnez un nom, et choisissez un pool où un agent est installé. Ce pool peut être déployé sur une de vos VMs, pour limiter les coûts:

![](https://cloudyjourney.fr/wp-content/uploads/2019/02/Azure_devops_part1_11.png)

Ajoutez un job de type **Copy Files**. Donnez un nom, choisissez le dossier que vous avez créé avec vos fichier main et variables dedans, et choisissez de copier tout le contenu. Le dossier cible doit être le suivant: **$(build.artifactstagingdirectory)/Terraform**

![](https://cloudyjourney.fr/wp-content/uploads/2019/02/Azure_devops_part1_12.png)

Ajoutez un job de type **Publish Build Artifacts** et laissez le avec les paramètres par défaut:

![](https://cloudyjourney.fr/wp-content/uploads/2019/02/Azure_devops_part1_13.png)

Cliquez maintenant sur **Triggers** pour activer le **CI (Continuous Integration)** pour lancer cette build, à chaque modification d'un fichier qu'il y a dans la branch master:

![](https://cloudyjourney.fr/wp-content/uploads/2019/02/Azure_devops_part1_14.png)

Sauvegardez et exécutez la build:

![](https://cloudyjourney.fr/wp-content/uploads/2019/02/Azure_devops_part1_15.png)

![](https://cloudyjourney.fr/wp-content/uploads/2019/02/Azure_devops_part1_16.png)

Après quelques secondes, notre build c'est bien exécuté:

![](https://cloudyjourney.fr/wp-content/uploads/2019/02/Azure_devops_part1_17.png)

Vous recevez également un mail pour vous signifier que tout c'est bien passé pour votre build:

![](https://cloudyjourney.fr/wp-content/uploads/2019/02/Azure_devops_part1_18.png)

Et avec le CI activé, la raison de l'exécution de cette nouvelle build est **Continuous integration:**

![](https://cloudyjourney.fr/wp-content/uploads/2019/02/Azure_devops_part1_19.png)

Dans la deuxième partie, nous verrons comment faire l'intégration avec la release, pour déployer notre VNet avec Terraform, automatiquement.
