---
title: "[AzureStack] Déploiement dans Azure"
date: "2017-07-19"
author: "Florent Appointaire"
permalink: "/2017/07/19/azurestack-deploiement-dans-azure/"
summary:
categories: 
  - "azure-stack"
tags: 
  - "asdk"
  - "azure"
  - "azure-stack"
  - "microsoft"
---
Avec la sortie récente des machines V3 sur Azure, il est maintenant possible de faire du Nested Hyper-V, comprenez donc de faire tourner des VMs dans un VM Azure.

Azure Stack Development Kit venant de sortir, c'est l'occasion pour moi de déployer cette dernière version dans Azure, n'ayant pas le matériel nécessaire pour le faire tourner chez moi. Attention, ce type de déploiement n'est pas supportée par Microsoft et ne peut être utilisé qu'en test.

Daniel Neumann, TSP Azure chez Microsoft a fourni une version de son installation, en L2: [http://www.danielstechblog.info/running-azure-stack-development-kit-azure/](http://www.danielstechblog.info/running-azure-stack-development-kit-azure/)

J'utiliserai certaines parties de ce billet pour mon installation. La différence est qu'il déploie Azure Stack dans une VM qui est sur la VM sur Azure. Alors que dans mon cas, on va déployer Azure Stack directement sur la VM Azure.

Avant de commencer, créez un compte Azure AD qui est Global Admin. Ce compte sera utilisé pour connecter votre Azure Stack à Azure AD.

Pour commencer, déployez une VM Windows Server 2016 sur Azure, de taille minimum E16s v3 (16 cores, 128 GB memory). Ce sont en effet les prérequis pour faire tourner Azure Stack: [https://docs.microsoft.com/en-us/azure/azure-stack/azure-stack-deploy](https://docs.microsoft.com/en-us/azure/azure-stack/azure-stack-deploy)

Une fois que la VM est deployée, connectez vous dessus et n'appliquez surtout pas les mises à jour, puis nous allons renommer le compte administrateur local pour ne pas à avoir à modifier tous les scripts:

`Rename-LocalUser -Name Florent -NewName Administrator`

Eteignez la VM via l'interface Azure, puis allez dans la partie disque. Agrandissez le disque OS à 256GB et ajoutez 4 disques pour la partie Storage Space Direct, de 256GB chacun minimum:

[![](https://cloudyjourney.fr/wp-content/uploads/2018/01/2133.AzureStack01.png)](https://cloudyjourney.fr/wp-content/uploads/2018/01/2133.AzureStack01.png)

 

Rallumez la VM et initialisez les disques, sans oublier d'étendre le disque OS. Adaptez la time zone en fonction de votre fuseau horaire, et désactivez le **IE Enhanced Security Configuration**. Vous pouvez maintenant installer des prérequis pour gagner du temps par la suite:

`Add-WindowsFeature Hyper-V, Failover-Clustering, Web-Server -IncludeManagementTools` `Add-WindowsFeature RSAT-AD-PowerShell, RSAT-ADDS -IncludeAllSubFeature` `Install-PackageProvider nuget -Verbose`

Redémarrez le serveur:

`Restart-Computer`

Vous pouvez maintenant télécharger Azure Stack: [https://azure.microsoft.com/en-us/overview/azure-stack/development-kit/](https://azure.microsoft.com/en-us/overview/azure-stack/development-kit/)

Une fois extrait, montez le disque **CloudBuilder.vhdx** et copiez les dossiers **CloudDeployment**, **fwupdate** et **tools**dans votre disque C. Vous pouvez éjecter le disque **CloudBuiler.** Ouvrez une console PowerShell puis faite:

`cd C:\CloudDeployment\Setup` `.\InstallAzureStackPOC.ps1 -InfraAzureDirectoryTenantName yourdirectory.onmicrosoft.com -NATIPv4Subnet 172.16.0.0/24 -NATIPv4Address 172.16.0.2 -NATIPv4DefaultGateway 172.16.0.1 -Verbose`

Pour les IPs adresses, utilisez des IPs qui ne sont pas utilisées sur votre VNet Azure ni pas Azure Stack. Vous allez avoir une première erreur qui vous dit que votre serveur n'est pas un serveur physique. Pas de panique. Il suffit de modifier le fichier **C:\\CloudDeployment\\Roles\\PhysicalMachines\\Tests\\BareMetal.Tests.ps1** et de rechercher **$isVirtualizedDeployment.** Cette variable est présente 3 fois dans le fichier. Retirez le **\-not** devant chaque variable. Relancez l'installation avec la commande suivante:

`.\InstallAzureStackPOC.ps1 -Rerun -Verbose`

Si vous avez une erreur avec CredSSP au moment de la modification du nombre maximum d'objet, effectuez ceci. Sur le serveur DC, exécutez la commande suivante:

`Enable-WSManCredSSP -Role Server`

Sur le serveur Hyper-V, exécutez les commandes suivantes:

`Set-Item wsman:localhost\client\trustedhosts -Value *` `Enable-WSManCredSSP -Role Client -DelegateComputer *`

Puis, ouvrez la console **gpedit.msc**, allez dans **Local Computer Policy > Computer Configuration > Administrative Templates > System > Credential Delegation.**

Activez **Allow Delegating Fresh Credentials with NTLM-only Server Authentication** et ajoutez la valeur **WSMAN/\***. Relancez le script.

Une fois la VM **BGPNAT** déployée, exécutez le script suivant pour créer un nouveau virtual switch qui donne accès à Internet à la VM, en adaptant avec l'adresse IP que vous avez utilisé lors du lancement du script:

`New-VMSwitch -Name "NATSwitch" -SwitchType Internal -Verbose` `$NIC=Get-NetAdapter|Out-GridView -PassThru` `New-NetIPAddress -IPAddress 172.16.0.1 -PrefixLength 24 -InterfaceIndex $NIC.ifIndex` `New-NetNat -Name "NATSwitch" -InternalIPInterfaceAddressPrefix "172.16.0.0/24" -Verbose`

Allez dans les paramètres de la VM BGPNAT et changez le virtual switch de la carte **NAT**de **PublicSwitch** vers **NATSwitch:**

[![](https://cloudyjourney.fr/wp-content/uploads/2018/01/2133.AzureStack02.png)](https://cloudyjourney.fr/wp-content/uploads/2018/01/2133.AzureStack02.png)

Vous pouvez maintenant pinger les IPs externes:

[![](https://cloudyjourney.fr/wp-content/uploads/2018/01/5756.AzureStack03.png)](https://cloudyjourney.fr/wp-content/uploads/2018/01/5756.AzureStack03.png)

Le déploiement de l'infrastructure continue:

[![](https://cloudyjourney.fr/wp-content/uploads/2018/01/5756.AzureStack04.png)](https://cloudyjourney.fr/wp-content/uploads/2018/01/5756.AzureStack04.png)

Après quelques heures, le déploiement est terminé, et vous pouvez vous connecter à l'interface utilisateur et d'administration:

[![](https://cloudyjourney.fr/wp-content/uploads/2018/01/5226.AzureStack05.png)](https://cloudyjourney.fr/wp-content/uploads/2018/01/5226.AzureStack05.png)

[![](https://cloudyjourney.fr/wp-content/uploads/2018/01/3554.AzureStack06.png)](https://cloudyjourney.fr/wp-content/uploads/2018/01/3554.AzureStack06.png) [![](https://cloudyjourney.fr/wp-content/uploads/2018/01/3554.AzureStack07.png)](https://cloudyjourney.fr/wp-content/uploads/2018/01/3554.AzureStack07.png)
