---
title: "[Azure] Déployer des ressources avec Terraform"
date: "2019-05-15"
author: "Florent Appointaire"
permalink: "/2019/05/15/azure-deployer-des-ressources-avec-terraform/"
summary:
categories: 
  - "terraform"
tags: 
  - "azure"
  - "hasicorp"
  - "microsoft"
  - "terraform"
---
Nous parlons beaucoup en ce moment, de IaC, Infrastructure As Code. Ceci vous donne la possibilité, de déployer une infrastructure, de 0, à partir de code, tout ça sans être un grand développeur (si si, je vous assure, moi et le code, ce n'est pas une grande histoire d'amour :) ). Vous avez actuellement, les outils suivants pour faire de l'IaC:

- PowerShell DSC
- Ansible
- Puppet
- Chef
- Azure Resource Manager
- Etc.
- Et bien sûr, Terraform

Dans cet article, je vais vous montrer, comment déployer, via Terraform (qui est Open Source et fourni par la société HashiCorp), une plateforme de test, sur Azure. Ceci comprendra un VNet, et une VM Windows Server avec une IP Publique.

Pour commencer, vous devez télécharger et installer Terraform: [https://www.terraform.io/downloads.html](https://www.terraform.io/downloads.html)

Des exemples de code sont disponibles ici: [https://registry.terraform.io/search?q=azure](https://registry.terraform.io/search?q=azure)

La documentation du provider AzureRM pour Terraform est disponible ici: [https://www.terraform.io/docs/providers/azurerm/index.html](https://www.terraform.io/docs/providers/azurerm/index.html)

Une fois installé, nous allons créer plusieurs fichiers:

- **provider.tf** qui contiendra les informations pour se connecter à notre souscription Azure
- **maint.tf** qui contiendra ce que l'on souhaite créer, et l'appel des modules
- **variables.tf** qui contiendra les valeurs des ressources que l'on souhaite créer
- un dossier **modules**
    - un sous dossier **1-network**
        - un fichier **1-create\_base\_network.tf**
        - un fichier **variables.tf**
    - un sous dossier **2-windows\_vm**
        - un fichier **1-virtual-machine.tf**
        - un fichier **variables.tf**

![](https://cloudyjourney.fr/wp-content/uploads/2019/05/Terraform01.png)

Je vais utiliser des modules. L'avantage d'utiliser des modules est le fait que vous pouvez réutiliser des modules dans d'autres projets par la suite, sans refaire le code. Voici mon fichier **provider.tf** qui contient les informations pour se connecter à l'environnement (si vous souhaitez préciser la version du provider Azure RM à utiliser, insérez version = "=1.22.0", sinon ne mettez rien pour utiliser la dernière version):

```
provider "azurerm" {
  subscription_id = "la souscription où déployer les ressources"
  client_id       = "l'application id qui a les droits pour déployer des ressources"
  client_secret   = "le mot de passe associé"
  tenant_id       = "l'id de votre tenant Azure AD"
}
```

Voici mon **main.tf** qui va créer un groupe de ressource réseau, qui va créer le réseau en appelant le module réseau et qui va créer la vm Windows en appelant le module windows:

```
// Create Resource Group
resource "azurerm_resource_group" "rg_network" {
  name                = "${var.rg_network}"
  location            = "${var.location}"
}
// Create Network
module "create_network" {
  source                    = "./modules/1-network"
  location                  = "${azurerm_resource_group.rg_network.location}"
  rg_network                = "${azurerm_resource_group.rg_network.name}"
}
// Create Windows VM
module "windows_vm" {
  source                    = "./modules/2-windows_vm"
  computer_name_Windows     = "${var.computer_name_Windows}"
  rg_network                = "${azurerm_resource_group.rg_network.name}"
  subnet_id                 = "${module.create_network.mgmt_sub_id}"
  location                  = "${azurerm_resource_group.rg_network.location}"
  vmsize                    = "${var.vmsize}"
  os_ms                     = "${var.os_ms}"
  admin_username            = "${var.admin_username}"
  admin_password            = "${var.admin_password}"
}
```

Le fichier **variables.tf** contiendra les valeurs des ressources à créer. Ici mon mot de passe est en clair, mais il est possible de récupérer le mot de passe depuis un Keyvault ([Article disponible ici](https://cloudyjourney.fr/2019/05/22/azure-recuperer-une-valeur-dans-un-keyvault-pour-terraform/)):

```
variable "location" {
  default = "westeurope"
}
variable "admin_username" {
  default = "testadmin"
} 
variable "admin_password" {
  default = "Password1234!"
}
variable "computer_name_Windows" {
  default = "WS01"
}
variable "rg_network" {
  default = "Network-Test"
}

variable "vmsize" {
  description = "VM Size for the Production Environment"
  type        = "map"

      default = {
        small         =   "Standard_DS1_v2"
        medium        =   "Standard_D2s_v3"
        large         =   "Standard_D4s_v3"
        extralarge    =   "Standard_D8s_v3"
      }
}

variable "os_ms" {
  description = "Operating System for Database (MSSQL) on the Production Environment"
  type        = "map"

      default = {
        publisher   =   "MicrosoftWindowsServer"
        offer       =   "WindowsServer"
        sku         =   "2019-Datacenter"
        version     =   "latest"
      }
}
```

Mon fichier **1-create\_base\_network.tf** et **variables.tf** sont les suivants. Ils vont déployer un VNet avec un sous réseau **LAN**. Notez qu'il est possible d'ajouter des valeurs par défaut dans les variables, en ajoutant pour chaque variable **default = "valeur"**. Ici je ne l'utilise pas, pour forcer les valeurs dans le fichier **valeurs.tf** principal. Notez également l'utilisation de **output** pour utiliser les valeurs de ce fichier, directement dans mon fichier **main.tf** avec la valeur **module**:

```
resource "azurerm_virtual_network" "mgmt_vnet" {
  name                = "FLOAPP-VNet-Test"
  location            = "${var.location}"
  resource_group_name = "${var.rg_network}"
  address_space       = ["10.0.0.0/8"]
  dns_servers         = ["8.8.8.8"]
}

resource "azurerm_subnet" "mgmt_sub_db" {
  name                      =   "LAN"
  resource_group_name       =   "${var.rg_network}"
  virtual_network_name      =   "${azurerm_virtual_network.mgmt_vnet.name}"
  address_prefix            =   "10.0.0.0/24"
}
output "mgmt_sub_id" {
  value = "${azurerm_subnet.mgmt_sub_db.id}"
}
```

```
variable "location" {
  description = "Location where to deploy resources"
}
variable "rg_network" {
  description = "Name of the Resource Group where resources will be deployed"
}
```

Voici les fichiers **1-virtual-machine.tf** et **variables.tf** qui permettront de déployer la VM Windows en utilisant le VNet précédemment créé:

```
resource "azurerm_network_interface" "windows_nic" {
  name                            = "${var.computer_name_Windows}-NIC"
  location                        = "${var.location}"
  resource_group_name             = "${var.rg_network}"

  ip_configuration {
    name                          = "ipconfig"
    subnet_id                     = "${var.subnet_id}"
    private_ip_address_allocation = "Dynamic"
  }
}

resource "azurerm_virtual_machine" "windows_vm" {
  name                          = "${var.computer_name_Windows}"
  location                      = "${var.location}"
  resource_group_name           = "${var.rg_network}"
  network_interface_ids         = ["${azurerm_network_interface.windows_nic.id}"]
  vm_size                       = "${var.vmsize["medium"]}"

  delete_os_disk_on_termination = true
  delete_data_disks_on_termination = true

  storage_image_reference {
    publisher = "${var.os_ms["publisher"]}"
    offer     = "${var.os_ms["offer"]}"
    sku       = "${var.os_ms["sku"]}"
    version   = "${var.os_ms["version"]}"
  }
  storage_os_disk {
    name              = "${var.computer_name_Windows}-OS"
    caching           = "ReadWrite"
    create_option     = "FromImage"
    managed_disk_type = "Standard_LRS"
  }
  
  os_profile {
    computer_name  = "${var.computer_name_Windows}"
    admin_username = "${var.admin_username}"
    admin_password = "${var.admin_password}"
  }
  os_profile_windows_config {
    provision_vm_agent = "true"
    timezone           = "Romance Standard Time"
  }
}

output "computer_name_Windows" {
  value = "${azurerm_virtual_machine.windows_vm.name}"
}
```

```
variable "location" {
  description = "Location where to deploy resources"
}
variable "rg_network" {
  description = "Name of the Resource Group where resources will be deployed"
}
variable "computer_name_Windows" {
  description = "Name of the computer"
}
variable "subnet_id" {
  description = "Subnet Id where to join the VM"
}

variable "admin_username" {
  description = "The username associated with the local administrator account on the virtual machine"
}

variable "admin_password" {
  description = "The password associated with the local administrator account on the virtual machine"
}

variable "vmsize" {
  description = "VM Size for the Production Environment"
  type        = "map"

    default = {
      small         =   "Standard_DS1_v2"
      medium        =   "Standard_D2s_v3"
      large         =   "Standard_D4s_v3"
      extralarge    =   "Standard_D8s_v3"
    }
}

variable "os_ms" {
  description = "Operating System for Database (MSSQL) on the Production Environment"
  type        = "map"

    default = {
      publisher   =   "MicrosoftWindowsServer"
      offer       =   "WindowsServer"
      sku         =   "2019-Datacenter"
      version     =   "latest"
    }
}
```

Sauvegardez le tout. Il est maintenant temps d'exécuter les commandes pour le déploiement de notre environnement. Rendez-vous dans le dossier principal et faites un **terraform init** pour initialiser le projet:

![](https://cloudyjourney.fr/wp-content/uploads/2019/05/Terraform02.png)

Exécutez ensuite un **terraform plan** pour voir ce qu'il va être effectuer sur la souscription. Ici, il va ajouter 5 ressources:

- Un groupe de ressource
- Un VNet
- Un sous-réseau
- Une NIC
- Une VM Windows

![](https://cloudyjourney.fr/wp-content/uploads/2019/05/Terraform03.png)

Pour lancer le déploiement, faites **terraform apply** et confirmez le déploiement avec **yes:**

![](https://cloudyjourney.fr/wp-content/uploads/2019/05/Terraform04.png)

Après quelques minutes, les ressources ont été déployées:

![](https://cloudyjourney.fr/wp-content/uploads/2019/05/Terraform05.png)

![](https://cloudyjourney.fr/wp-content/uploads/2019/05/Terraform06.png)

L'avantage de Terraform est le fait de pouvoir modifier seulement ce dont on a besoin. Par exemple, si je rajoute dans mon fichier **1-virtual-machine.tf:**

```
resource "azurerm_resource_group" "rg_compute" {
  name                = "Compute-CloudyJourney"
  location            = "${var.location}"
}
```

Et que je fais **terraform plan** il va comparer ce qui a été fait par le passé (ceci est stocké dans un fichier **terraform.tfstate**) avec ce qu'on doit faire maintenant. Dans notre cas, il va ajouter une ressource. C'est pareil pour ce qui est de la modification/suppression:

![](https://cloudyjourney.fr/wp-content/uploads/2019/05/Terraform07.png)

Si vous souhaitez supprimer ce qui a été fait, exécutez la commande **terraform destroy**:

![](https://cloudyjourney.fr/wp-content/uploads/2019/05/Terraform08.png)

Après quelques instants, tout a été supprimé:

![](https://cloudyjourney.fr/wp-content/uploads/2019/05/Terraform09.png)

Tout ce code est disponible sur mon Github: [https://github.com/Flodu31/Terraform/tree/master/Deploy\_New\_Environment](https://github.com/Flodu31/Terraform/tree/master/Deploy_New_Environment)

Voici un exemple simple de déploiement avec Terraform. Bien sur, il est possible d'aller beaucoup plus loin. Dans les prochains articles, je parlerai de la récupération de [valeurs sensibles dans un keyvault](https://cloudyjourney.fr/2019/05/22/azure-recuperer-une-valeur-dans-un-keyvault-pour-terraform/) et aussi de l'exécution de commandes directement dans une VM après son déploiement.
