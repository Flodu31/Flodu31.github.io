---
title: "[AWS] Votre premier workflow - Partie 2"
date: "2018-02-12"
categories: 
  - "amazon-connect"
tags: 
  - "aws"
  - "aws-connect"
  - "call-center"
  - "workflow"
---

[![](https://cloudyjourney.fr/wp-content/uploads/2018/01/2000px-AmazonWebservices_Logo.svg_.png)](https://cloudyjourney.fr/wp-content/uploads/2018/01/2000px-AmazonWebservices_Logo.svg_.png)

 

Après [le premier article](https://cloudyjourney.fr/2018/01/30/aws-votre-premier-workflow-partie-1/) qui a permis de créer une queue, nous allons maintenant créer notre premier workflow, qui permettra de rediriger un appel, vers un agent du call center.

Pour commencer, allez dans **Routing > Contact flows** et cliquez sur **Create contact flow**. Donnez un nom à ce flow:

[![](https://cloudyjourney.fr/wp-content/uploads/2018/02/AWSConnectFlow01.png)](https://cloudyjourney.fr/wp-content/uploads/2018/02/AWSConnectFlow01.png)

Ajoutez les éléments suivants, pour pouvoir utiliser le workflow:

- **Set > Set queue** et choisissez la queue que nous avons créé lors du premier article
- **Branch > Check hours of operation** qui va vérifier si les heures d'ouverture correspondent bien à celle de la queue, dans ce cas la, on peut transférer l'appel
- **Interact > Play prompt** et choisissez un texte ou une musique. Attention, c'est seulement à la fin du texte/musique que l'appel est transféré.
- **Terminate / Transfer > Transfer to queue** qui va transférer à la queue que l'on a défini au début du workflow
- **Terminate / Transfer > Disconnect / hang up** qui va raccrocher en cas d'erreur (vous pouvez également transférer vers un autre numéro par exemple)

Il faut maintenant inter-connecter tout ces items. Pour commencer, reliez le **Start** à **Set queue**. Si le set de la queue est **Success** alors on passe au **Checking hours of operation**, sinon on raccroche avec **Disconnect / hand up**. Si l'appel est dans les heures de la queue, alors on transfert vers le **Play prompt**, sinon, on raccroche. Reliez maintenant le **Play prompt** à **T****ransfer to queue:**

[![](https://cloudyjourney.fr/wp-content/uploads/2018/02/AWSConnectFlow02-2.png)](https://cloudyjourney.fr/wp-content/uploads/2018/02/AWSConnectFlow02-2.png)

Sauvegardez et publiez votre workflow:

[![](https://cloudyjourney.fr/wp-content/uploads/2018/02/AWSConnectFlow03.png)](https://cloudyjourney.fr/wp-content/uploads/2018/02/AWSConnectFlow03.png)

Allez maintenant dans la partie **Routing > Phone numbers** pour associer votre numéro à votre workflow:

[![](https://cloudyjourney.fr/wp-content/uploads/2018/02/AWSConnectFlow04.png)](https://cloudyjourney.fr/wp-content/uploads/2018/02/AWSConnectFlow04.png)

Cliquez maintenant sur le téléphone en haut à droite de l'interface. C'est grâce à ça que vous allez pouvoir recevoir des appels. Passez le status à disponible:

[![](https://cloudyjourney.fr/wp-content/uploads/2018/02/AWSConnectFlow05-1.png)](https://cloudyjourney.fr/wp-content/uploads/2018/02/AWSConnectFlow05-1.png)

Avec un téléphone, appelez le numéro qui vous a été attribué dans Amazon Connect. Le téléphone sonne sur votre ordinateur. Vous pouvez raccorcher ou accepter l'appel:

[![](https://cloudyjourney.fr/wp-content/uploads/2018/02/AWSConnectFlow06.png)](https://cloudyjourney.fr/wp-content/uploads/2018/02/AWSConnectFlow06.png)

Si vous faites autre chose, une notification apparait dans le bas de l'écran:

[![](https://cloudyjourney.fr/wp-content/uploads/2018/02/AWSConnectFlow07.png)](https://cloudyjourney.fr/wp-content/uploads/2018/02/AWSConnectFlow07.png)

Une fois que l'appel est accepté, vous pouvez transférer l'appel, raccorcher ou le mettre en pause:

[![](https://cloudyjourney.fr/wp-content/uploads/2018/02/AWSConnectFlow08.png)](https://cloudyjourney.fr/wp-content/uploads/2018/02/AWSConnectFlow08.png)

Quand l'appel est terminé, n'oubliez pas de vous remettre disponible, sinon vous ne pourrez pas recevoir de call:

[![](https://cloudyjourney.fr/wp-content/uploads/2018/02/AWSConnectFlow09.png)](https://cloudyjourney.fr/wp-content/uploads/2018/02/AWSConnectFlow09.png)

Dans le prochain article, je parlerai de la partie reporting de AWS connect :)
