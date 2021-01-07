---
title: "[Azure] Supprimer les comptes de synchronisations Azure AD Connect"
date: "2019-02-25"
author: "Florent Appointaire"
permalink: "/2019/02/25/azure-supprimer-les-comptes-de-synchronisations-azure-ad-connect/"
summary: 
categories: 
  - "azure-ad"
tags: 
  - "azure-ad"
  - "microsoft"
  - "powershell"
---
Lorsque vous déployez ou migrez un Azure AD Connect, un compte de synchronisation va automatiquement être créé dans votre Azure AD. Ce compte ne peut pas être supprimé avec l'interface graphique, il va donc falloir passer par du PowerShell.

Comme vous pouvez le voir, ici j'ai effectué plusieurs migrations de mon Azure AD Connect:

![](https://cloudyjourney.fr/wp-content/uploads/2019/02/RemoveAzureADSvc01.png)

Je vais donc faire le tri, et garder seulement le compte **Sync\_FLOAPP-HPV02**. Pour faire ceci, vous devez avoir le module PowerShell **MSOnline** installé et ensuite, utilisez le script suivant pour avoir la liste des comptes Azure AD Connect:

```
Connect-MsolService
Get-MsolUser | Where {$_.UserPrincipalName -like "Sync_*"}
```

![](https://cloudyjourney.fr/wp-content/uploads/2019/02/RemoveAzureADSvc02.png)

Pour supprimer un compte, récupérez l'UPN et renseignez le dans la commande suivante:

```
Get-MsolUser -UserPrincipalName "Votre_UPN" | Remove-MsolUser
```

![](https://cloudyjourney.fr/wp-content/uploads/2019/02/RemoveAzureADSvc03.png)

Après avoir supprimé mes comptes, il ne me reste plus qu'un seul compte, qui est le seul utilisé à l'heure actuelle:

![](https://cloudyjourney.fr/wp-content/uploads/2019/02/RemoveAzureADSvc04.png)

![](https://cloudyjourney.fr/wp-content/uploads/2019/02/RemoveAzureADSvc05.png)
