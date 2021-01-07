---
title: "[Azure Automation] Update d'un module bloqué sur \"Importing newer version\""
date: "2018-06-14"
author: "Florent Appointaire"
permalink: "/2018/06/14/azure-automation-update-dun-module-bloque-sur-importing-newer-version/"
summary:
categories: 
  - "azure-automation"
tags: 
  - "azure"
  - "azure-automation"
  - "importing-newer-version"
  - "microsoft"
---
En voulant mettre à jour le module PowerShell **AzureRM.profile** de mon compte Azure Automation, ce dernier, après 4 heures était bloqué avec le statut **Importing newer version:**

[![](https://cloudyjourney.fr/wp-content/uploads/2018/06/AzureRmProfileStuck01.png)](https://cloudyjourney.fr/wp-content/uploads/2018/06/AzureRmProfileStuck01.png)

J'ai essayé d'arréter le job, de le relancer, d'uploader le module à la main, sans succès. J'ai donc regardé quelles étaient les commandes du module PowerShell Automation, et je suis tombé sur la commande **Get-AzureRmAutomationModule**. Cette commande retourne tous les modules qui sont installés pour un compte Azure Automation. J'ai donc fait un filtre sur les modules qui avaient le statut **Creating** et la commande m'a retourné seulement, le module **AzureRm.profile**, une bonne nouvelle donc :

```
Get-AzureRmAutomationModule -ResourceGroupName TheRGoftheAAAcount -AutomationAccountName YourAutomationAccount | Where-Object { $_.ProvisioningState -eq "Creating"}
```

[![](https://cloudyjourney.fr/wp-content/uploads/2018/06/AzureRmProfileStuck02.png)](https://cloudyjourney.fr/wp-content/uploads/2018/06/AzureRmProfileStuck02.png)

J'ai décidé de le supprimer pour le réimporter par la suite. Ajoutez juste à la fin de la commande **Remove-AzureRmAutomationModule**:

```
Get-AzureRmAutomationModule -ResourceGroupName TheRGoftheAAAcount -AutomationAccountName YourAutomationAccount | Where-Object { $_.ProvisioningState -eq "Creating"} | Remove-AzureRmAutomationModule
```

[![](https://cloudyjourney.fr/wp-content/uploads/2018/06/AzureRmProfileStuck03.png)](https://cloudyjourney.fr/wp-content/uploads/2018/06/AzureRmProfileStuck03.png)

Le module est supprimé et réimporté avec la version de base, 1.0.3 directement:

[![](https://cloudyjourney.fr/wp-content/uploads/2018/06/AzureRmProfileStuck04.png)](https://cloudyjourney.fr/wp-content/uploads/2018/06/AzureRmProfileStuck04.png)

J'ai relancé la mise à jour des modules, et après quelques minutes, ce dernier a été mis à jour, avec la dernière version:

[![](https://cloudyjourney.fr/wp-content/uploads/2018/06/AzureRmProfileStuck05.png)](https://cloudyjourney.fr/wp-content/uploads/2018/06/AzureRmProfileStuck05.png)

[![](https://cloudyjourney.fr/wp-content/uploads/2018/06/AzureRmProfileStuck06.png)](https://cloudyjourney.fr/wp-content/uploads/2018/06/AzureRmProfileStuck06.png)

En espérant vous faire gagner du temps :)
