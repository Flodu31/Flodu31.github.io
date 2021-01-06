---
title: "[Azure] Windows Virtual Desktop"
date: "2019-04-24"
categories: 
  - "azure"
tags: 
  - "azure"
  - "microsoft"
  - "rds"
  - "remote-desktop-services"
  - "windows-virtual-desktop"
---

![](https://cloudyjourney.fr/wp-content/uploads/2018/01/Azure.png)

Microsoft a rendu disponible il y a quelques semaines maintenant, Windows Virtual Desktop, en Public Preview. Vous pouvez lire la news complète ici: [https://www.microsoft.com/en-us/microsoft-365/blog/2019/03/21/windows-virtual-desktop-public-preview](https://www.microsoft.com/en-us/microsoft-365/blog/2019/03/21/windows-virtual-desktop-public-preview)

La documentation complète est disponible ici: [https://docs.microsoft.com/en-us/azure/virtual-desktop/overview](https://docs.microsoft.com/en-us/azure/virtual-desktop/overview)

Pour commencer, enregistrez votre Tenant Azure sur ce site: [https://rdweb.wvd.microsoft.com/](https://rdweb.wvd.microsoft.com/) . Choisissez bien l'option **Server App** et connectez vous à votre tenant Azure, qui a les droits admins sur la subscription:

![](https://cloudyjourney.fr/wp-content/uploads/2019/04/WVD01-1024x429.png)

![](https://cloudyjourney.fr/wp-content/uploads/2019/04/WVD02-681x1024.png)

Attendez une minute après avoir validé (le temps que la réplication au niveau de Azure se fasse:

![](https://cloudyjourney.fr/wp-content/uploads/2019/04/WVD03.png)

Faites la même chose pour l'option **Client App:**

![](https://cloudyjourney.fr/wp-content/uploads/2019/04/WVD04-752x1024.png)

Vous devriez maintenant voir 2 nouvelles applications d'entreprise dans votre Azure AD:

![](https://cloudyjourney.fr/wp-content/uploads/2019/04/WVD05-1024x396.png)

Il faut maintenant ajouter un ou des utilisateurs avec le role **TenantCreator** pour permettre la création de pool RDS:

![](https://cloudyjourney.fr/wp-content/uploads/2019/04/WVD06-1024x561.png)

Il est maintenant temps de créer un tenant pour le Windows Virtual Desktop. C'est en PowerShell que ça se passe. Ce dernier module n'est pas compatible sur Mac, même si il s'installe sans souci:

![](https://cloudyjourney.fr/wp-content/uploads/2019/04/WVD07-1024x727.png)

Il vous faudra donc Windows et le script suivant, avec vos informations, pour créer le tenant:

```
Install-Module -Name Microsoft.RDInfra.RDPowerShell
Import-Module -Name Microsoft.RDInfra.RDPowerShell
Get-Command -Module Microsoft.RDInfra.RDPowerShell
$brokerurl = "https://rdbroker.wvd.microsoft.com"
$aadTenantId = "Votre Tenant ID"
$azureSubscriptionId = "L'ID de la subscription où le RDS sera déployé"
Add-RdsAccount -DeploymentUrl $brokerurl
```

![](https://cloudyjourney.fr/wp-content/uploads/2019/04/WVD08.png)

![](https://cloudyjourney.fr/wp-content/uploads/2019/04/WVD09.png)

Nous pouvons maintenant lancer la création de notre pool RDS. Dans le marketplace, cherchez **host pool** et sélectionnez l'item suivant:

![](https://cloudyjourney.fr/wp-content/uploads/2019/04/WVD10-1024x556.png)

Il faut maintenant fournir les informations suivantes lors de la 1ère étape:

- Le nom de votre pool
- Si ce sera des bureaux personnels ou partagés
- le nom des utilisateurs qui auront accès (voir à la fin de l'article pour ajouter de nouveaux utilisateurs)
- La subscription que vous avez défini dans le script précédent
- Un nom de RG
- La localisation

![](https://cloudyjourney.fr/wp-content/uploads/2019/04/WVD11-1024x635.png)

A l'étape 2, vous devez choisir le type de profil des utilisateurs, ceci correspond à la RAM/CPU par utilisateur, le nombre d'utilisateurs que vous prévoyez d'ajouter, et enfin la taille de la VM, qui en fonction du CPU/RAMe t du nombre d'utilisateurs, déploiera +/- de VM. Enfin, donnez un nom pour l'ordinateur, qui sera incrémenté en partant de 0, au fur et à mesure:

![](https://cloudyjourney.fr/wp-content/uploads/2019/04/WVD12-1024x532.png)

Choisissez ensuite d'où provient votre image source, l'OS, le type de stockage et renseignez un utilisateur qui a le droit de faire un domaine join pour un serveur. Vous pouvez également préciser l'OU où seront ajoutés les serveurs. Choisissez ensuite un VNet et un sous-réseau, qui puisse communiquer avec un controleur de domaine:

![](https://cloudyjourney.fr/wp-content/uploads/2019/04/WVD13-1024x775.png)

Donnez ensuite le nom du groupe tenant que vous avez créé précédemment (Default Tenant Group par défaut), le nom de votre tenant que vous avez défini avec le script, et l'UPN (sans MFA) du compte ou du Service principal que vous avez ajouté dans l'application d'entreprise **Windows Virtual Desktop** avec les droits **TenantCreator:**

![](https://cloudyjourney.fr/wp-content/uploads/2019/04/WVD14-1024x607.png)

Validez les deux dernières étapes, et après quelques minutes, dépendant du nombre de VMs à déployer, le déploiement est complet:

![](https://cloudyjourney.fr/wp-content/uploads/2019/04/WVD15-1024x557.png)

Et les 2 serveurs sont bien dans le domaine, dans l'OU que j'avais renseigné:

![](https://cloudyjourney.fr/wp-content/uploads/2019/04/WVD16.png)

Pour ajouter un nouvel utilisateur au pool RDS, utilisez les commandes suivantes:

```
Add-RdsAccount -DeploymentUrl $brokerurl
Set-RdsContext -TenantGroupName FlorentAppointaire
Add-RdsAppGroupUser FlorentAppointaire FLOAPP-WVD "Desktop Application Group" -UserPrincipalName fappointaire@florentappointaire.cloud
```

![](https://cloudyjourney.fr/wp-content/uploads/2019/04/WVD17.png)

Allez maintenant sur [http://aka.ms/wvdweb](http://aka.ms/wvdweb) ou sur [https://rdweb.wvd.microsoft.com/webclient/index.html](https://rdweb.wvd.microsoft.com/webclient/index.html) et connectez vous avec un utilisateur qui a les droits. Vous devriez voir ceci:

![](https://cloudyjourney.fr/wp-content/uploads/2019/04/WVD18-1024x153.png)

Choisissez de vous connecter à une session bureau à distance, et connectez-vous de nouveau:

![](https://cloudyjourney.fr/wp-content/uploads/2019/04/WVD19-1024x598.png)

Vous pouvez maintenant travailler directement depuis votre navigateur web, avec une session hébergée sur Azure:

![](https://cloudyjourney.fr/wp-content/uploads/2019/04/WVD20-1024x560.png)

Dans un prochain tutoriel, je vous montrerai comment publier des applications :)
