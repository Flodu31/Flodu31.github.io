---
title: "[Azure] Reçevoir les mises à jour de AKS et de Azure"
date: "2020-08-04"
author: "Florent Appointaire"
permalink: "/2020/08/04/azure-recevoir-les-mises-a-jour-de-aks-et-de-azure/"
summary:
categories: 
  - "azure"
tags: 
  - "azure"
  - "logic-app"
  - "microsoft"
---
Aujourd'hui, petit article pour vous montrer comment rester à jour sur Azure, en reçevant les news, directement par email/teams ou encore, comment les twitter.

Pour commencer, on a besoin:

- D'un Azure Logic App
- Du feed RSS de AKS: [https://github.com/Azure/AKS/releases.atom](https://github.com/Azure/AKS/releases.atom)
- Du feed RSS de Azure: [https://azurecomcdn.azureedge.net/en-us/updates/feed/](https://azurecomcdn.azureedge.net/en-us/updates/feed/)

Allez maintenant dans votre Logic App. Ici, je vais faire tourner mon Logic App 1x / jour. Mettez donc une récurrence:

![](https://cloudyjourney.fr/wp-content/uploads/2020/08/LogicApp_AKS02.png)

Ajoutez maintenant une action de type **List all RSS feed items** et donnez la première URL comme feed. Ajoutez également le paramètre **since**, avec l'expression suivante **addDays(utcNow(), -1)** ce qui permettra de prendre que les feeds RSS qui ont moins de 24h:

![](https://cloudyjourney.fr/wp-content/uploads/2020/08/LogicApp_AKS03.png)

Ajoutez ensuite ce que vous souhaitez faire. Envoyer un mail, écrire un message directement sur teams, ou bien poster sur Twitter:

![](https://cloudyjourney.fr/wp-content/uploads/2020/08/LogicApp_AKS04.png)

Ajoutez une **Parallel Branch** avec les mêmes informations qu'avant, mais en changeant le lien vers le feed RSS de Azure:

![](https://cloudyjourney.fr/wp-content/uploads/2020/08/LogicApp_AKS05.png)

Sauvegardez le flow, et exécutez le en cliquant sur Run:

![](https://cloudyjourney.fr/wp-content/uploads/2020/08/LogicApp_AKS06.png)

Le flow s'exécute, et comme un item du feed date de moins de 24h, le tweet est posté:

![](https://cloudyjourney.fr/wp-content/uploads/2020/08/LogicApp_AKS07.png)

![](https://cloudyjourney.fr/wp-content/uploads/2020/08/LogicApp_AKS01.png)

Vous pourrez trouver le code complet du LogicApp ici: [https://github.com/Flodu31/LogicApp/blob/master/FALA-LA-AzureStatus.json](https://github.com/Flodu31/LogicApp/blob/master/FALA-LA-AzureStatus.json)

Voila, en quelques minutes, vous pouvez rester informé sans pour autant visiter pleins de sites différents.
