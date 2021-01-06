---
title: "[OMS] Erreur à la connexion d'un workspace sous Windows Server 2008 R2 SP1"
date: "2018-03-28"
categories: 
  - "oms"
tags: 
  - "error-2114"
  - "microsoft"
  - "oms"
---

[![](https://cloudyjourney.fr/wp-content/uploads/2018/01/OMS.png)](https://cloudyjourney.fr/wp-content/uploads/2018/01/OMS.png)

En voulant installer l'agent OMS sur un serveur déployé depuis le marketplace d'Azure, sous Windows Server 2008 R2 SP1, j'ai rencontré l'erreur suivante:

> The agent had an unknown failure 2114.

[![](https://cloudyjourney.fr/wp-content/uploads/2018/03/OMSError02.jpg)](https://cloudyjourney.fr/wp-content/uploads/2018/03/OMSError02.jpg)

Et depuis l'Event Viewer:

[![](https://cloudyjourney.fr/wp-content/uploads/2018/03/OMSError01.jpg)](https://cloudyjourney.fr/wp-content/uploads/2018/03/OMSError01.jpg)

J'ai regardé sur Internet, pas de solution. Après coup, je me suis aperçu que le serveur était loin d'être à jour. J'ai donc décidé d'installer les mises à jour Windows. Après le redémarrage, l'agent s'est connecté, sans souci:

[![](https://cloudyjourney.fr/wp-content/uploads/2018/03/OMSError03.png)](https://cloudyjourney.fr/wp-content/uploads/2018/03/OMSError03.png)

En espérant vous avoir aidé et que vous n'aurez pas trop perdu de temps, comme moi :)
