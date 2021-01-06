---
title: "[Azure] Changer le subnet d’une VM"
date: "2015-12-02"
categories: 
  - "azure"
  - "reseau"
tags: 
  - "azure"
  - "microsoft"
---

[![](https://cloudyjourney.fr/wp-content/uploads/2018/01/pastedimage1482154059354v1.png)](https://cloudyjourney.fr/wp-content/uploads/2018/01/pastedimage1482154059354v1.png)

Hier, j’ai créé un VM sur Azure pour SQL Server. Après avoir terminé l’installation et la configuration, j’ai vu que la VM n’était pas dans le bon sous réseau dans mon Virtual Network.

J’ai cherché sur Internet comment changé de subnet et j’ai trouvé [cette documentation](https://azure.microsoft.com/en-us/documentation/articles/virtual-networks-move-vm-role-to-subnet/).

Je vais vous expliquer comment changé de sous réseau avec PowerShell (c’est la seule solution pour faire ceci, pour le moment). Comme vous pouvez le voir, j’ai l’adresse IP 10.0.0.4:

[![](https://cloudyjourney.fr/wp-content/uploads/2018/01/SNAGHTML21dc9f7b_5358317F.png)](https://cloudyjourney.fr/wp-content/uploads/2018/01/SNAGHTML21dc9f7b_5358317F.png)

Mes 2 sous-réseaux dans mon Virtual Network sont les suivants:

[![](https://cloudyjourney.fr/wp-content/uploads/2018/01/SNAGHTML21d5b844_03820CF4.png)](https://cloudyjourney.fr/wp-content/uploads/2018/01/SNAGHTML21d5b844_03820CF4.png)

Comme vous pouvez le voir, la VM est actuellement dans le subnet **FrontEnd** et je voudrais l’avoir dans le subnet **BackEnd**. Pour faire ceci, exécutez la commande PowerShell suivante:

`Get-AzureVM -Name sql-001 -ServiceName Demo | Set-AzureSubnet -SubnetNames BackEnd | Update-AzureVM`

[![](https://cloudyjourney.fr/wp-content/uploads/2018/01/SNAGHTML21db5a77_511E3974.png)](https://cloudyjourney.fr/wp-content/uploads/2018/01/SNAGHTML21db5a77_511E3974.png)

La VM va redémarrer après l’exécution de la commande **Update-AzureVM**. Quand ceci est terminé, retournez sur l’interface de la VM Azure. Vous pouvez voir que la nouvel IP appartient bien au subnet **BackEnd:**

[![](https://cloudyjourney.fr/wp-content/uploads/2018/01/SNAGHTML21df4df1_05BE95B0.png)](https://cloudyjourney.fr/wp-content/uploads/2018/01/SNAGHTML21df4df1_05BE95B0.png)

N’oubliez pas de changer l’IP dans votre DNS si vous n’avez pas autorisé les mises à jour dynamique. Dans ma VM, j’ai la configuration suivante: [![](https://cloudyjourney.fr/wp-content/uploads/2018/01/SNAGHTML220bb08d_7A28D870.png)](https://cloudyjourney.fr/wp-content/uploads/2018/01/SNAGHTML220bb08d_7A28D870.png)
