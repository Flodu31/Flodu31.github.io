---
title: "[AWS] Votre premier workflow - Partie 1"
date: "2018-01-30"
author: "Florent Appointaire"
permalink: "/2018/01/30/aws-votre-premier-workflow-partie-1"
summary:
categories: 
  - "amazon-connect"
tags: 
  - "amazon-connect"
  - "aws"
  - "call-center"
  - "queues"
  - "routing-profiles"
  - "workflow"
---
Dans les 2 prochains articles, nous allons voir comment enregistrer des agents, les mettre dans des routing profiles, des queues (première partie), et enfin, terminer avec la création d'un workflow ([deuxième partie](https://cloudyjourney.fr/2018/02/12/aws-votre-premier-workflow-partie-2/)) :)

La première étape va être de créer des queues que vous utiliserez pour associer avec vos workflows et routing profiles. Cette queue peut avoir plusieurs paramètres:

- Les heures d'opérations de la queue
- Un nom lorsque vous appelez vers l'exterieur
- Un numéro qui s'affichera lors de vos appels vers l'extérieur
- Un workflow associé
- un nombre limite de contact dans la queue et enfin, des agents quick connects, ce qui permet de transférer les appels entre les différents agents qui sont disponibles mais aussi de parler avec eux

Créez une **Queue** en allant dans **Routing > Queues** et cliquez sur **Add new queue**. Remplissez les informations suivants vos désirs (les heures d'opérations peuvent être définies dans **Routing > Hours of** **operation**) :

[![](https://cloudyjourney.fr/wp-content/uploads/2018/01/AWSConnectQueue01.png)](https://cloudyjourney.fr/wp-content/uploads/2018/01/AWSConnectQueue01.png)

Quand ceci est terminé, nous allons définir des **Routing Profile**. Ces profils seront associés à un utilisateur. Attention, un utilisateur peut avoir un seul routing profile, mais ce routing profile peut contenir plusieurs queue. Par exemple, si vous avez une queue pour Windows Server, une pour Azure, une pour AWS, etc., elles peuvent être dans le même routing profile, avec des priorités différentes, ce qui permet de bien dispatcher au niveau des agents, suivant les centres de compétences.

Pour créer un nouveau Routing Profile, allez dans **Users > Routing profiles** et cliquez sur **Add new profile**. Donnez un nom et une description. Associez ici les queues pour lequel ce routing profile pourra être associé, avec des priorités et des délais si il le faut. Si le routing profile peut être utilisé pour emettre des appels vers l'extérieur, sélectionnez la queue à associer:

[![](https://cloudyjourney.fr/wp-content/uploads/2018/01/AWSConnectQueue02.png)](https://cloudyjourney.fr/wp-content/uploads/2018/01/AWSConnectQueue02.png)

Une fois sauvegardé, il ne reste qu'à ajouter les agents qui se trouvent dans notre Active Directory et les associer à un routing profile que vous aurez défini. Allez dans **Users > User Management** et cliquez sur **Add new users**. Choisissez comment vous souhaitez importer vos utilisateurs, dans mon cas, de mon Active Directory:

[![](https://cloudyjourney.fr/wp-content/uploads/2018/01/AWSConnectQueue03.png)](https://cloudyjourney.fr/wp-content/uploads/2018/01/AWSConnectQueue03.png)

Sélectionnez les utilisateurs à ajouter. Attention, sélectionnez uniquement les utilisateurs à qui vous souhaitez associer le même Routing Profile et Security Profile:

[![](https://cloudyjourney.fr/wp-content/uploads/2018/01/AWSConnectQueue04.png)](https://cloudyjourney.fr/wp-content/uploads/2018/01/AWSConnectQueue04.png)

Sélectionnez ensuite le routing profile que vous avez créé précédemment, mais aussi le security profile, Agent dans mon cas. Vous pouvez également configurer le type de téléphone:

[![](https://cloudyjourney.fr/wp-content/uploads/2018/01/AWSConnectQueue05.png)](https://cloudyjourney.fr/wp-content/uploads/2018/01/AWSConnectQueue05.png)

Vérifiez que tout est correctet cliquez sur **Create users** pour créer les utilisateurs:

[![](https://cloudyjourney.fr/wp-content/uploads/2018/01/AWSConnectQueue06.png)](https://cloudyjourney.fr/wp-content/uploads/2018/01/AWSConnectQueue06.png)

Vos utilisateurs sont maintenant ajoutés:

[![](https://cloudyjourney.fr/wp-content/uploads/2018/01/AWSConnectQueue07.png)](https://cloudyjourney.fr/wp-content/uploads/2018/01/AWSConnectQueue07.png)

Dans [le prochain tutoriel](https://cloudyjourney.fr/2018/02/12/aws-votre-premier-workflow-partie-2/), nous allons créer notre workflow et y associer des agents :)
