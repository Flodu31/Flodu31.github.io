---
title: "[PowerShell] Créer un serveur DSC sur Azure"
date: "2017-05-23"
categories: 
  - "powershell"
tags: 
  - "dsc"
  - "microsoft"
  - "powershell"
  - "pull-server"
---

[![](https://cloudyjourney.fr/wp-content/uploads/2018/01/PowerShell.png)](https://cloudyjourney.fr/wp-content/uploads/2018/01/PowerShell.png)

Aujourd’hui, je vais vous montrer comment déployer un serveur DSC sur Azure, qui aura pour fonction d’être le serveur de référence, et donc, de faire office de serveur **PULL.**

Pour commencer, déployez un serveur sur Azure (Windows Server 2016 pour ma part) et autorisez dans le NSG, le port 8080 et 443.

Installez la feature suivante ainsi que le module DSC, avec les commandes suivantes:

`Install-WindowsFeature DSC-Service -IncludeManagementTools`

`Install-Module xPsDesiredStateConfiguration`

`winrm quickconfig`

[![](https://cloudyjourney.fr/wp-content/uploads/2018/01/0486.PDSDSC01.png)](https://cloudyjourney.fr/wp-content/uploads/2018/01/0486.PDSDSC01.png)

Enregistrez ensuite le script suivant pour configurer votre serveur DSC:

[https://github.com/Flodu31/PowerShellDSC/blob/master/DSCPullServer.ps1](https://github.com/Flodu31/PowerShellDSC/blob/master/DSCPullServer.ps1)

Vous pouvez bien sur ajouter un certificate et adapter les ports. Exécutez le pour générer la configuration MOF pour votre serveur:

[![](https://cloudyjourney.fr/wp-content/uploads/2018/01/4520.PDSDSC02.png)](https://cloudyjourney.fr/wp-content/uploads/2018/01/4520.PDSDSC02.png)

Lancez la configuration du serveur en exécutant cette commande:

`Start-DscConfiguration -Path C:\Users\florent\Desktop\PullDSC\NewPullServer\ -Wait`

[![](https://cloudyjourney.fr/wp-content/uploads/2018/01/6685.PDSDSC03.png)](https://cloudyjourney.fr/wp-content/uploads/2018/01/6685.PDSDSC03.png)

Pour vérifier que la configuration a bien été effectuée, rendez-vous sur l’URL suivante sur votre serveur:

[http://localhost:8080/PSDSCPullServer.svc/](http://localhost:8080/PSDSCPullServer.svc/)

Vous devriez avoir ceci:

[![](https://cloudyjourney.fr/wp-content/uploads/2018/01/2475.PDSDSC04.png)](https://cloudyjourney.fr/wp-content/uploads/2018/01/2475.PDSDSC04.png)

Nous allons maintenant créer la configuration pour notre serveur qui va recevoir l’installation des RSAT. Utilisez le script suivant, en remplaçant le **Computername** et l’**OutputPath:**

[https://github.com/Flodu31/PowerShellDSC/blob/master/DeployRSATDSC.ps1](https://github.com/Flodu31/PowerShellDSC/blob/master/DeployRSATDSC.ps1)

Exécutez le:

[![](https://cloudyjourney.fr/wp-content/uploads/2018/01/8814.PDSDSC05.png)](https://cloudyjourney.fr/wp-content/uploads/2018/01/8814.PDSDSC05.png)

Un nouveau fichier MOF est apparu. Il contient la configuration pour votre serveur. Parceque nous allons utiliser ce fichier pour plusieurs serveurs, depuis notre serveur Pull, il faut le renommer. Utilisons un GUID pour que ce soit plus simple:

`Rename-Item -Path C:\Users\florent\Desktop\ClientDSC\dscclienteco01.westeurope.cloudapp.azure.com.mof -NewName "$([guid]::NewGuid()).mof"`

[![](https://cloudyjourney.fr/wp-content/uploads/2018/01/1070.PDSDSC06.png)](https://cloudyjourney.fr/wp-content/uploads/2018/01/1070.PDSDSC06.png)

Pour que nos serveurs cibles puissant récupérer les fichiers de configurations, nous devons copier les fichiers dans **C:\\Program Files\\WindowsPowerShell\\DscService\\Configuration**. Utilisez la commande suivante pour faire ceci:

`Copy-Item .\8c3fd4c9-9166-45c1-8559-872e431d8902.mof "C:\Program Files\WindowsPowerShell\DscService\Configuration"`

`ls "C:\Program Files\WindowsPowerShell\DscService\Configuration"`

[![](https://cloudyjourney.fr/wp-content/uploads/2018/01/3146.PDSDSC07.png)](https://cloudyjourney.fr/wp-content/uploads/2018/01/3146.PDSDSC07.png)

Pour s’assurer de la provenance des fichiers de configurations, il faut générer un checksum associé à la configuration:

`New-DSCChecksum 'C:\Program Files\WindowsPowerShell\DscService\Configuration\8c3fd4c9-9166-45c1-8559-872e431d8902.mof'`

`ls "C:\Program Files\WindowsPowerShell\DscService\Configuration"`

[![](https://cloudyjourney.fr/wp-content/uploads/2018/01/8836.PDSDSC08.png)](https://cloudyjourney.fr/wp-content/uploads/2018/01/8836.PDSDSC08.png)

Nous allons maintenant appliquer la configuration à notre serveur cible, pour qu’il vienne automatiquement chercher des nouvelles configurations sur le serveurs PULL. Téléchargez le script suivant:

[https://github.com/Flodu31/PowerShellDSC/blob/master/DSCPullMode.ps1](https://github.com/Flodu31/PowerShellDSC/blob/master/DSCPullMode.ps1)

Adaptez le avec votre ServerUrl que vous pouvez accéder, l’adresse IP de votre serveur cible (connexion en WinRM, donc ça doit être configuré et autorisé) et le GUID qui a été généré pour le fichier de configuration. Executez ensuite le script:

[![](https://cloudyjourney.fr/wp-content/uploads/2018/01/0003.PDSDSC09.png)](https://cloudyjourney.fr/wp-content/uploads/2018/01/0003.PDSDSC09.png)

Un nouveau fichier MOF a été configuré.

Allez maintenant sur le client et vérifiez avec les commandes suivantes, que la configuration a bien été appliquée:

`Get-DscLocalConfigurationManager`

`(Get-DscLocalConfigurationManager).DownloadManagerCustomDat`

[![](https://cloudyjourney.fr/wp-content/uploads/2018/01/0407.PDSDSC10.png)](https://cloudyjourney.fr/wp-content/uploads/2018/01/0407.PDSDSC10.png)

Après 15 minutes, le client télécharge le fichier, et l’applique sans souci:

[![](https://cloudyjourney.fr/wp-content/uploads/2018/01/6011.PDSDSC11.png)](https://cloudyjourney.fr/wp-content/uploads/2018/01/6011.PDSDSC11.png)

Vous pouvez automatiser beaucoup de chose avec DSC, comme le déploiement de nouveaux serveurs IIS, Active Directory, SQL, etc.

Beaucoup d’exemples sont disponibles sur Internet et sur Github. Bon courage :)
