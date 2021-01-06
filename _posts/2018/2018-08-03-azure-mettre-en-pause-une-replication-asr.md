---
title: "[Azure] Mettre en pause une réplication ASR"
date: "2018-08-03"
categories: 
  - "azure-site-recovery"
tags: 
  - "asr"
  - "azure"
  - "azure-site-recovery"
  - "microsoft"
  - "vmware"
---

[![](https://cloudyjourney.fr/wp-content/uploads/2018/01/ASRLogo.png)](https://cloudyjourney.fr/wp-content/uploads/2018/01/ASRLogo.png)

Etant en cours de migration pour un de mes clients, de VMWare vers Azure, j'ai utilisé Azure Site Recovery. Le souci est que lorsque vous répliquez une ou plusieurs VMs, la bande passante peut vite être saturée, ce qui est mon cas. Nous sommes bridés à 20 Mbps en continu, ce qui empêche les utilisateurs de pouvoir utiliser Internet, etc. J'ai donc cherché comment mettre en pause les réplications sans devoir recommencer à chaque fois.

J'ai trouvé les 3 services suivants:

- Azure Site Recovery VSS Provider
- InMage Scout Application Service
- InMage Scout VX Agent - Sentinel/Outpost

Qu'il faut arrêter sur la machine qui réplique. Comme vous le voyez, ma réplication est en cours:

[![](https://cloudyjourney.fr/wp-content/uploads/2018/08/ASRPauseRep01.png)](https://cloudyjourney.fr/wp-content/uploads/2018/08/ASRPauseRep01.png)

J'ai donc exécuté les commandes suivantes pour arrêter les 3 services:

Get-Service "Azure Site Recovery VSS Provider", "InMage Scout Application Service", "svagents"

Stop-Service "Azure Site Recovery VSS Provider" -Force
Stop-Service "InMage Scout Application Service" -Force
Stop-Service "svagents" -Force

Get-Service "Azure Site Recovery VSS Provider", "InMage Scout Application Service", "svagents"

[![](https://cloudyjourney.fr/wp-content/uploads/2018/08/ASRPauseRep02.png)](https://cloudyjourney.fr/wp-content/uploads/2018/08/ASRPauseRep02.png)

La réplication est passé en Critique:

[![](https://cloudyjourney.fr/wp-content/uploads/2018/08/ASRPauseRep03.png)](https://cloudyjourney.fr/wp-content/uploads/2018/08/ASRPauseRep03.png)

Avec ce message d'erreur, qui indique bien que la machine source n'est plus disponible:

[![](https://cloudyjourney.fr/wp-content/uploads/2018/08/ASRPauseRep04.png)](https://cloudyjourney.fr/wp-content/uploads/2018/08/ASRPauseRep04.png)

Il faudra bien entendu attendre que la queue du serveur Master se vide avant de voir la bande passante redescendre, mais en arretant les 3 services, elle ne se rempliera plus :)

Pour redémarrer ces 3 services pour reprendre la réplication, utilisez les commandes suivantes:

Start-Service "Azure Site Recovery VSS Provider"
Start-Service "InMage Scout Application Service"
Start-Service "svagents"
