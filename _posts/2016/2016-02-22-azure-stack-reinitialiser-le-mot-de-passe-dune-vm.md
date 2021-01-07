---
title: "[Azure Stack] Réinitialiser le mot de passe d’une VM"
date: "2016-02-22"
author: "Florent Appointaire"
permalink: "/2016/02/22/azure-stack-reinitialiser-le-mot-de-passe-dune-vm/"
summary: 
categories: 
  - "azure-stack"
tags: 
  - "azure-stack"
  - "microsoft"
---
Aujourd’hui, j’ai essayé de me connecter à une VM mais j’ai reçu un message d’erreur pour me signifier que le mot de passe n’était pas correct:

[![](https://cloudyjourney.fr/wp-content/uploads/2018/01/image_5BCF2AD5.png)](https://cloudyjourney.fr/wp-content/uploads/2018/01/image_5BCF2AD5.png)

[![](https://cloudyjourney.fr/wp-content/uploads/2018/01/image_0BF9064A.png)](https://cloudyjourney.fr/wp-content/uploads/2018/01/image_0BF9064A.png)

[![](https://cloudyjourney.fr/wp-content/uploads/2018/01/image_5275F652.png)](https://cloudyjourney.fr/wp-content/uploads/2018/01/image_5275F652.png)

J’ai donc décidé de le réinitialiser via le portail, mais cette fonctionnalité n’est pas encore implémentée:

[![](https://cloudyjourney.fr/wp-content/uploads/2018/01/image_54B27F0E.png)](https://cloudyjourney.fr/wp-content/uploads/2018/01/image_54B27F0E.png)

Donc, la seule façon de faire ceci est en PowerShell. Assurez-vous de bien avoir l’extension VMAccess installée. Si vous ne l’avez pas, installez la avec le script PowerShell suivant, en changeant les 3 premières variables et exécutez le:

```
# Add the Microsoft Azure Stack environment 
[net.mail.mailaddress]$AadFullMailAddress="whitepaper@azurelabdvo.onmicrosoft.com" 
$RGName = "Compute" 
$vmName = "WS2012R2" 
$AadTenantId=(Invoke-WebRequest -Uri ('[https://login.windows.net/'+(](https://login.windows.net/%E2%80%99+()$AadFullMailAddress.Host)+'/.well-known/openid-configuration') -UseBasicParsing|ConvertFrom-Json).token_endpoint.Split('/')[3] 
# Configure the environment with the Add-AzureRmEnvironment cmdlt 
Add-AzureRmEnvironment -Name 'Azure Stack' -ActiveDirectoryEndpoint ("[https://login.windows.net/](https://login.windows.net/)$AadTenantId/") -ActiveDirectoryServiceEndpointResourceId "https://azurestack.local-api/" -ResourceManagerEndpoint ("[https://api.azurestack.local/")](https://api.azurestack.local/%22)) -GalleryEndpoint ("[https://gallery.azurestack.local/")](https://gallery.azurestack.local/%22)) -GraphEndpoint "[https://graph.windows.net/"](https://graph.windows.net/%22) 
# Authenticate a user to the environment (you will be prompted during authentication) 
$privateEnv = Get-AzureRmEnvironment 'Azure Stack'
$privateAzure = Add-AzureRmAccount -Environment $privateEnv -Verbose 
Select-AzureRmProfile -Profile $privateAzure
$extensionName = "VMAccessAgent" 
$publisher = "Microsoft.Compute" 
$version = "2.0" 
Set-AzureRmVMExtension -ExtensionName $extensionName -Publisher $publisher -Version $version -ExtensionType $extensionName -Location local -ResourceGroupName $RGName -VMName $vmName –Verbose
```

[![](https://cloudyjourney.fr/wp-content/uploads/2018/01/image_181D1122.png)](https://cloudyjourney.fr/wp-content/uploads/2018/01/image_181D1122.png)

Après quelques minutes, votre extension est installée:

[![](https://cloudyjourney.fr/wp-content/uploads/2018/01/image_7321E159.png)](https://cloudyjourney.fr/wp-content/uploads/2018/01/image_7321E159.png)

[![](https://cloudyjourney.fr/wp-content/uploads/2018/01/image_5F971269.png)](https://cloudyjourney.fr/wp-content/uploads/2018/01/image_5F971269.png)

Vous pouvez maintenant réinitialiser le mot de passe de la VM. Exécutez le script suivant avec le nom d’utilisateur de la VM en question, pour moi Florent:

```
$cred = Get-Credential "Florent" –Message "Name of the current account and the new password" 
Set-AzureRmVMAccessExtension -ResourceGroupName $RGName -VMName $vmName -Name $extensionName -UserName $cred.GetNetworkCredential().Username -Password $cred.GetNetworkCredential().Password -Location local
```

[![](https://cloudyjourney.fr/wp-content/uploads/2018/01/image_3622D129.png)](https://cloudyjourney.fr/wp-content/uploads/2018/01/image_3622D129.png)

Après 2 minutes, la réinitialisation du mot de passe est terminée:

[![](https://cloudyjourney.fr/wp-content/uploads/2018/01/image_1CBD5EA0.png)](https://cloudyjourney.fr/wp-content/uploads/2018/01/image_1CBD5EA0.png)

Vous pouvez maintenant vous connecter avec votre nouveau mot de passe:

[![](https://cloudyjourney.fr/wp-content/uploads/2018/01/image_5CABF07A.png)](https://cloudyjourney.fr/wp-content/uploads/2018/01/image_5CABF07A.png)

[![](https://cloudyjourney.fr/wp-content/uploads/2018/01/image_00D3DBBB.png)](https://cloudyjourney.fr/wp-content/uploads/2018/01/image_00D3DBBB.png)
