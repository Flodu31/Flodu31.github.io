---
title: "[Azure] Créer un Service Catalog"
date: "2018-06-19"
author: "Florent Appointaire"
permalink: "/2018/06/19/azure-creer-un-service-catalog/"
summary:
categories: 
  - "azure"
tags: 
  - "azure"
  - "microsoft"
  - "service-catalog"
---
Microsoft a rendu disponible il y a quelques mois la possibilité de créer son propre service catalogue, pour différentes équipes, directement dans Azure. Avec cette feature, vous pouvez pré construire vos templates, contrôler les paramètres, et donner la possibilité à vos équipes de déployer des applications, sans faire d'erreurs ou sélectionner des grosses VMs qui sont chères.

La documentation est disponible ici : [https://docs.microsoft.com/en-us/azure/managed-applications/](https://docs.microsoft.com/en-us/azure/managed-applications/)

Le template est composé de 2 fichiers:

- mainTemplate.json
- createUiDefinition.json

Le premier est un template ARM comme quand vous déployez une ressource dans Azure, sans UI. Le second est l'interface utilisateur avec les paramètres qui seront disponibles. Dans l'exemple d'aujourd'hui, nous allons déployer une nouvelle machine virtuel, dans un nouveau réseau. Créez un nouveau fichier nommé **mainTemplate.json** (sensible à la case) et insérez le code suivant:

```
{
    "$schema": "https://schema.management.azure.com/schemas/2015-01-01/deploymentTemplate.json#",
    "contentVersion": "1.0.0.0",
    "parameters": {
        "userName": {
            "type": "string",
            "metadata": {
                "description": "Username for the Virtual Machine."
            }
        },
        "pwd": {
            "type": "securestring",
            "metadata": {
                "description": "Password for the Virtual Machine."
            }
        },
        "vmName": {
            "type": "string",
            "metadata": {
                "description": "Virtual Machine name."
            }
        },
        "dnsName": {
            "type": "string",
            "metadata": {
                "description": "Unique DNS Name for the Public IP used to access the Virtual Machine."
            }
        },
        "publicIPAddressName": {
            "type": "string",
            "metadata": {
                "description": "Name of the public IP address for the Virtual Machine."
            }
        },
        "vmSize": {
            "type": "string",
            "defaultValue": "Standard\_D2s\_v3",
            "allowedValues": \[
              "Standard\_D2s\_v3",
              "Standard\_D4s\_v3",
              "Standard\_D8s\_v3"
            \],
            "metadata": {
              "description": "Size of the VM"
            }
        },
        "location": {
            "type": "string",
            "defaultValue": "\[resourceGroup().location\]",
            "allowedValues": \[
                "westeurope",
                "northeurope"
            \],
            "metadata": {
                "description": "Location for all resources."
            }
        }
    },
    "variables": {
        "storageAccountName": "\[concat(uniquestring(resourceGroup().id), 'sawinvm')\]",
        "nicName": "FloAppVMNic",
        "addressPrefix": "10.0.0.0/16",
        "subnetName": "FloAppSubnet",
        "subnetPrefix": "10.0.0.0/24",
        "virtualNetworkName": "FloAPP-MyVNET",
        "subnetRef": "\[resourceId('Microsoft.Network/virtualNetworks/subnets', variables('virtualNetworkName'), variables('subnetName'))\]"
    },
    "resources": \[
        {
            "type": "Microsoft.Storage/storageAccounts",
            "name": "\[variables('storageAccountName')\]",
            "apiVersion": "2016-01-01",
            "location": "\[parameters('location')\]",
            "sku": {
                "name": "Standard\_LRS"
            },
            "kind": "Storage",
            "properties": {}
        },
        {
            "apiVersion": "2016-03-30",
            "type": "Microsoft.Network/publicIPAddresses",
            "name": "\[parameters('publicIPAddressName')\]",
            "location": "\[parameters('location')\]",
            "properties": {
                "publicIPAllocationMethod": "Dynamic",
                "dnsSettings": {
                    "domainNameLabel": "\[parameters('dnsName')\]"
                }
            }
        },
        {
            "apiVersion": "2016-03-30",
            "type": "Microsoft.Network/virtualNetworks",
            "name": "\[variables('virtualNetworkName')\]",
            "location": "\[parameters('location')\]",
            "properties": {
                "addressSpace": {
                    "addressPrefixes": \[
                        "\[variables('addressPrefix')\]"
                    \]
                },
                "subnets": \[
                    {
                        "name": "\[variables('subnetName')\]",
                        "properties": {
                            "addressPrefix": "\[variables('subnetPrefix')\]"
                        }
                    }
                \]
            }
        },
        {
            "apiVersion": "2016-03-30",
            "type": "Microsoft.Network/networkInterfaces",
            "name": "\[variables('nicName')\]",
            "location": "\[parameters('location')\]",
            "dependsOn": \[
                "\[resourceId('Microsoft.Network/publicIPAddresses/', parameters('publicIPAddressName'))\]",
                "\[resourceId('Microsoft.Network/virtualNetworks/', variables('virtualNetworkName'))\]"
            \],
            "properties": {
                "ipConfigurations": \[
                    {
                        "name": "ipconfig1",
                        "properties": {
                            "privateIPAllocationMethod": "Dynamic",
                            "publicIPAddress": {
                                "id": "\[resourceId('Microsoft.Network/publicIPAddresses',parameters('publicIPAddressName'))\]"
                            },
                            "subnet": {
                                "id": "\[variables('subnetRef')\]"
                            }
                        }
                    }
                \]
            }
        },
        {
            "apiVersion": "2017-03-30",
            "type": "Microsoft.Compute/virtualMachines",
            "name": "\[parameters('vmName')\]",
            "location": "\[parameters('location')\]",
            "dependsOn": \[
                "\[resourceId('Microsoft.Storage/storageAccounts/', variables('storageAccountName'))\]",
                "\[resourceId('Microsoft.Network/networkInterfaces/', variables('nicName'))\]"
            \],
            "properties": {
                "hardwareProfile": {
                    "vmSize": "\[parameters('vmSize')\]"
                },
                "osProfile": {
                    "computerName": "\[parameters('vmName')\]",
                    "adminUsername": "\[parameters('userName')\]",
                    "adminPassword": "\[parameters('pwd')\]"
                },
                "storageProfile": {
                    "imageReference": {
                        "publisher": "MicrosoftWindowsServer",
                        "offer": "WindowsServer",
                        "sku": "2016-Datacenter",
                        "version": "latest"
                    },
                    "osDisk": {
                        "createOption": "FromImage"
                    }
                },
                "networkProfile": {
                    "networkInterfaces": \[
                        {
                            "id": "\[resourceId('Microsoft.Network/networkInterfaces',variables('nicName'))\]"
                        }
                    \]
                },
                "diagnosticsProfile": {
                    "bootDiagnostics": {
                        "enabled": true,
                        "storageUri": "\[reference(resourceId('Microsoft.Storage/storageAccounts/', variables('storageAccountName'))).primaryEndpoints.blob\]"
                    }
                }
            }
        }
    \],
    "outputs": {
        "hostname": {
            "type": "string",
            "value": "\[reference(parameters('publicIPAddressName')).dnsSettings.fqdn\]"
        }
    }
}
```

Vous pouvez adapter le template avec vos valeurs. Maintenant, créez un second fichier nommé **createUiDefinition.json** et collez le code suivant:

```
{
    "handler": "Microsoft.Compute.MultiVm",
    "version": "0.1.2-preview",
    "parameters": {
        "basics": \[
            {}
        \],
        "steps": \[
            {
                "name": "credentialsConfig",
                "label": "VM Credential",
                "subLabel": {
                    "preValidation": "Configure the VM credentials",
                    "postValidation": "Done"
                },
                "bladeTitle": "Credential",
                "elements": \[
                    {
                        "name": "adminUsername",
                        "type": "Microsoft.Compute.UserNameTextBox",
                        "label": "User name",
                        "toolTip": "Admin username for the virtual machine",
                        "osPlatform": "Windows",
                        "constraints": {
                            "required": true
                        }
                    },
                    {
                        "name": "adminPassword",
                        "type": "Microsoft.Compute.CredentialsCombo",
                        "label": {
                            "password": "Password",
                            "confirmPassword": "Confirm password"
                        },
                        "toolTip": {
                            "password": "Admin password for the virtual machine"
                        },
                        "osPlatform": "Windows",
                        "constraints": {
                            "required": true
                        }
                    }
                \]
            },
            {
                "name": "vmConfig",
                "label": "Virtual Machine settings",
                "subLabel": {
                    "preValidation": "Configure the virtual machine settings",
                    "postValidation": "Done"
                },
                "bladeTitle": "VM Settings",
                "elements": \[
                    {
                        "name": "vmNamePrefix",
                        "type": "Microsoft.Common.TextBox",
                        "label": "Virtual Machine Name",
                        "toolTip": "VM Name",
                        "defaultValue": "",
                        "constraints": {
                            "required": true,
                            "regex": "\[a-z\]\[a-z0-9-\]{5,15}\[a-z0-9\]$",
                            "validationMessage": "Must be 5-15 characters."
                        }
                    },
                    {
                        "name": "vmSize",
                        "type": "Microsoft.Compute.SizeSelector",
                        "label": "Virtual machine size",
                        "toolTip": "The size of the virtual machine",
                        "recommendedSizes": \[
                            "Standard\_D2s\_v3"
                        \],
                        "constraints": {
                            "allowedSizes": \[
                                "Standard\_D2s\_v3",
                                "Standard\_D4s\_v3",
                                "Standard\_D8s\_v3"
                            \]
                        },
                        "osPlatform": "Windows",
                        "count": 1
                    },
                    {
                        "name": "dnsAndPublicIP",
                        "type": "Microsoft.Network.PublicIpAddressCombo",
                        "label": {
                            "publicIpAddress": "Public IP address",
                            "domainNameLabel": "DNS label"
                        },
                        "toolTip": {
                            "domainNameLabel": "DNS endpoint"
                        },
                        "defaultValue": {
                            "publicIpAddressName": "ip01"
                        },
                        "options": {
                            "hideNone": true,
                            "hideDomainNameLabel": false
                        },
                        "constraints": {
                            "required": {
                                "domainNameLabel": true
                            }
                        }
                    }
                \]
            }
        \],
        "outputs": {
            "location": "\[location()\]",
            "userName": "\[steps('credentialsConfig').adminUsername\]",
            "pwd": "\[steps('credentialsConfig').adminPassword.password\]",
            "vmSize": "\[steps('vmConfig').vmSize\]",
            "vmName": "\[steps('vmConfig').vmNamePrefix\]",
            "dnsName": "\[steps('vmConfig').dnsAndPublicIP.domainNameLabel\]",
            "publicIPAddressName": "\[steps('vmConfig').dnsAndPublicIP.name\]"
        }
    }
}
```

Dans la partie **outputs**, la variable doit être identique à celle qui se trouve dans votre main template, sinon, ceci ne fonctionnera pas car il ne recevra pas les bons paramètres. Quand c'est terminé, faites une archive zip de vos 2 fichiers, à la racine du zip:

[![](https://cloudyjourney.fr/wp-content/uploads/2018/05/azuresc01.png)](https://cloudyjourney.fr/wp-content/uploads/2018/05/azuresc01.png)

[![](https://cloudyjourney.fr/wp-content/uploads/2018/05/azuresc02.png)](https://cloudyjourney.fr/wp-content/uploads/2018/05/azuresc02.png)

Nous allons maintenant créer un nouveau groupe de ressource dans Azure, qui va héberger le compte de stockage qui va contenir notre template (le fichier zip). Exécutez le script PowerShell suivant pour faire ceci, en adaptant votre numéro de subscription, le nom du groupe de ressource et la localisation. Adaptez également le chemin où se trouve votre fichier zip:

```
Login-AzureRmAccount
Select-AzureRmSubscription -SubscriptionId Your Subscription Id
$rgName = "FloAPPServiceCatalog"
$location = "westeurope"

New-AzureRmResourceGroup -Name $rgName -Location $location
$storageAccount = New-AzureRmStorageAccount -ResourceGroupName $rgName -Name "floappservicecatalog" -Location $location -SkuName Standard\_LRS -Kind Storage

$ctx = $storageAccount.Context

New-AzureStorageContainer -Name appcontainer -Context $ctx -Permission blob
Set-AzureStorageBlobContent -File "C:\\Users\\florent.appointaire\\Downloads\\managedvm\\FloAPPWindowsServer.zip" -Container appcontainer -Blob "FloAPPWindowsServer.zip" -Context $ctx
```

[![](https://cloudyjourney.fr/wp-content/uploads/2018/05/azuresc03.png)](https://cloudyjourney.fr/wp-content/uploads/2018/05/azuresc03.png)

Nous allons maintenant créer l'application qui sera disponible pour vos équipes. Vous pouvez assigner des permissions à un groupe spécifique et choisir quel rôle RBAC vous souhaitez donner, **Contributor** dans mon cas. Donnez un nom à votre application. Cette application sera visible dans votre groupe de ressource. Vous pouvez changer le nom qui sera affiché pour votre équipe, et la description:

```
$groupID = (Get-AzureRmADGroup -SearchString "ServiceCatalog").Id
$ownerID = (Get-AzureRmRoleDefinition -Name "Contributor").Id

$blob = Get-AzureStorageBlob -Container appcontainer -Blob "FloAPPWindowsServer.zip" -Context $ctx

New-AzureRmManagedApplicationDefinition -Name "ManagedVM" -Location $location \`
  -ResourceGroupName $rgName -LockLevel ReadOnly -DisplayName "Managed Virtual Machine" \`
  -Description "Managed Azure Virtual Machine" \`
  -Authorization "NULL:$ownerID" \`
  -PackageFileUri $blob.ICloudBlob.StorageUri.PrimaryUri.AbsoluteUri
```

Si vous avez l'erreur suivante quand vous essayez de déployer votre application:

[![](https://cloudyjourney.fr/wp-content/uploads/2018/05/azuresc04.png)](https://cloudyjourney.fr/wp-content/uploads/2018/05/azuresc04.png)

C'est parceque vous n'avez pas enregistré le provider **Microsoft.Solutions**. Allez dans votre subscription, sur Azure, dans **Resource Providers** et enregistrez **Microsoft.Solutions:**

[![](https://cloudyjourney.fr/wp-content/uploads/2018/05/azuresc05.png)](https://cloudyjourney.fr/wp-content/uploads/2018/05/azuresc05.png)

[![](https://cloudyjourney.fr/wp-content/uploads/2018/05/azuresc06.png)](https://cloudyjourney.fr/wp-content/uploads/2018/05/azuresc06.png)

L'application a été déployée correctement:

[![](https://cloudyjourney.fr/wp-content/uploads/2018/05/azuresc07.png)](https://cloudyjourney.fr/wp-content/uploads/2018/05/azuresc07.png)

Vous avez maintenant votre application, avec votre compte de stockage:

[![](https://cloudyjourney.fr/wp-content/uploads/2018/05/azuresc08.png)](https://cloudyjourney.fr/wp-content/uploads/2018/05/azuresc08.png)

Cliquez sur le boutton **+** pour accéder au Marketplace, avec un compte qui a les droits pour déployer cette application (dans le groupe que vous avez fourni plus tôt) et cherchez **Service Catalog**. Choisissez **Service Catalog Managed Application** et cliquez sur **Create**. Vous allez voir votre application que vous avez déployé plus tôt (les étapes suivantes peuvent également être faite en PowerShell). Sélectionnez la et cliquez sur **Create**:

[![](https://cloudyjourney.fr/wp-content/uploads/2018/05/azuresc09.png)](https://cloudyjourney.fr/wp-content/uploads/2018/05/azuresc09.png)

Choisissez le groupe de ressource où vous souhaitez déployer ceci, et la localisation. Sur l'écran suivant, vous aurez la première étape qui était dans le fichier createUiDefinition.json, qui vous demande le nom d'utilisateur/mot de passe:

[![](https://cloudyjourney.fr/wp-content/uploads/2018/05/azuresc10.png)](https://cloudyjourney.fr/wp-content/uploads/2018/05/azuresc10.png)

A l'étape suivante, donnez un nom à votre VM, choisissez une taille (limité à 3 dans notre exemple) et choisissez une IP Public ou créez en une nouvelle. Fournissez également un nom DNS unique:

[![](https://cloudyjourney.fr/wp-content/uploads/2018/05/azuresc11.png)](https://cloudyjourney.fr/wp-content/uploads/2018/05/azuresc11.png)

[![](https://cloudyjourney.fr/wp-content/uploads/2018/05/azuresc12.png)](https://cloudyjourney.fr/wp-content/uploads/2018/05/azuresc12.png)

Les tests de validation ont été validés, vous pouvez déployer votre VM :)

[![](https://cloudyjourney.fr/wp-content/uploads/2018/05/azuresc13.png)](https://cloudyjourney.fr/wp-content/uploads/2018/05/azuresc13.png)

Le déploiement commence:

[![](https://cloudyjourney.fr/wp-content/uploads/2018/05/azuresc14.png)](https://cloudyjourney.fr/wp-content/uploads/2018/05/azuresc14.png)

Et après 5 minutes, le déploiement est terminé:

[![](https://cloudyjourney.fr/wp-content/uploads/2018/05/azuresc15.png)](https://cloudyjourney.fr/wp-content/uploads/2018/05/azuresc15.png)

Si vous regardez les ressources de votre groupe de ressource, vous verez votre Vnet, la VM, etc.:

[![](https://cloudyjourney.fr/wp-content/uploads/2018/05/azuresc16.png)](https://cloudyjourney.fr/wp-content/uploads/2018/05/azuresc16.png)

Et dans le groupe de ressource parent, vous verrez votre application:

[![](https://cloudyjourney.fr/wp-content/uploads/2018/05/azuresc17.png)](https://cloudyjourney.fr/wp-content/uploads/2018/05/azuresc17.png)

Si vous cliquez dessus, vous allez être redirigé vers le nom du groupe de ressource parent et quelques caractères aléatoires.

Vous pouvez maintenant vous connecter à votre VM, avec le nom DNS que vous avez renseignez plus tôt:

[![](https://cloudyjourney.fr/wp-content/uploads/2018/05/azuresc18.png)](https://cloudyjourney.fr/wp-content/uploads/2018/05/azuresc18.png)

Cette nouvelle fonctionnalité est très intéréssante si vous souhaitez donner la possibilité à vos équipes de déployer des ressources Azure de façon indépendante, en limitant les tailles, et donc le coût :)
