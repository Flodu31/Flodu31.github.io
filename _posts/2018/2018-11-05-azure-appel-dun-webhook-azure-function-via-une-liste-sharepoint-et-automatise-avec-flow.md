---
title: "[Azure] Appel d'un webhook Azure Function via une liste SharePoint et automatisé avec Flow"
date: "2018-11-05"
categories: 
  - "azure"
tags: 
  - "azure"
  - "azure-function"
  - "flow"
  - "list"
  - "microsoft"
  - "powerapps"
  - "sharepoint"
---

[![](https://cloudyjourney.fr/wp-content/uploads/2018/10/sharepoint-logo.jpg)](https://cloudyjourney.fr/wp-content/uploads/2018/10/sharepoint-logo.jpg)

Maintenant que l'[on a notre Azure Function qui fonctionne](https://cloudyjourney.fr/2018/10/31/azure-creation-dun-utilisateur-avec-azure-function/), nous allons nous connecter à un site SharePoint Online, et dans **Site contents**, créez une liste, pour gérer l'automatisation de notre process:

[![](https://cloudyjourney.fr/wp-content/uploads/2018/10/SharePointList01.png)](https://cloudyjourney.fr/wp-content/uploads/2018/10/SharePointList01.png)

Donnez un nom et une description à cette liste. Vous pouvez choisir de l'afficher dans le panneau latéral ou non:

[![](https://cloudyjourney.fr/wp-content/uploads/2018/10/SharePointList02.png)](https://cloudyjourney.fr/wp-content/uploads/2018/10/SharePointList02.png)

Modifiez la colonne **Title**, avec comme nouveau nom **LastName** et ajoutez une colonne, de type **Single line of text:**

[![](https://cloudyjourney.fr/wp-content/uploads/2018/10/SharePointList03.png)](https://cloudyjourney.fr/wp-content/uploads/2018/10/SharePointList03.png)

Donnez lui le nom **Firstname** et n'oubliez pas de dire que cette colonne doit obligatoirement avoir des informations avant de pouvoir être publié:

[![](https://cloudyjourney.fr/wp-content/uploads/2018/10/SharePointList04.png)](https://cloudyjourney.fr/wp-content/uploads/2018/10/SharePointList04.png)

Maintenant que nos 2 colonnes sont prêtes, on va utiliser Flow pour automatiser l'appel vers notre Webhook. Cliquez sur **Flow > Create a flow:**

[![](https://cloudyjourney.fr/wp-content/uploads/2018/10/SharePointList05.png)](https://cloudyjourney.fr/wp-content/uploads/2018/10/SharePointList05.png)

Choisissez le flow **Start approval when a new item is added**:

[![](https://cloudyjourney.fr/wp-content/uploads/2018/10/SharePointList06.png)](https://cloudyjourney.fr/wp-content/uploads/2018/10/SharePointList06.png)

Une nouvelle fenêtre va apparaitre, sur le site dédié à Microsoft Flow. Cliquez sur **Continue**:

[![](https://cloudyjourney.fr/wp-content/uploads/2018/10/SharePointList07.png)](https://cloudyjourney.fr/wp-content/uploads/2018/10/SharePointList07.png)

Ici, on va enlever l'approbation. Enlevez tous les items, sauf le premier, et ajoutez ensuite un item de type HTTP. Configurez la méthode **POST**, donnez l'URI que vous avez récupéré dans votre Azure Function, et dans le body, ajoutez le JSON que l'on a utilisé pour les tests, en remplaçant les valeurs par les items SharePoint **Firstname** et **Lastname**:

[![](https://cloudyjourney.fr/wp-content/uploads/2018/10/SharePointList08.png)](https://cloudyjourney.fr/wp-content/uploads/2018/10/SharePointList08.png)

Une fois sauvegardé, retournez sur votre liste SharePoint et cliquez sur **New**. Renseignez un nom et un prénom pour qu'un nouvel utilisateur soit créé:

[![](https://cloudyjourney.fr/wp-content/uploads/2018/10/SharePointList09-1.png)](https://cloudyjourney.fr/wp-content/uploads/2018/10/SharePointList09-1.png)

L'utilisateur a bien été ajouté à la liste, il devrait donc déclancher le Flow:

[![](https://cloudyjourney.fr/wp-content/uploads/2018/10/SharePointList10-1.png)](https://cloudyjourney.fr/wp-content/uploads/2018/10/SharePointList10-1.png)

Après quelques instants, le job de Flow est terminé. Vous pouvez cliquer dessus pour avoir plus de détails:

[![](https://cloudyjourney.fr/wp-content/uploads/2018/10/SharePointList11.png)](https://cloudyjourney.fr/wp-content/uploads/2018/10/SharePointList11.png)

[![](https://cloudyjourney.fr/wp-content/uploads/2018/10/SharePointList12-1.png)](https://cloudyjourney.fr/wp-content/uploads/2018/10/SharePointList12-1.png)

Et mon utilisateur a bien été créé:

[![](https://cloudyjourney.fr/wp-content/uploads/2018/10/SharePointList13.png)](https://cloudyjourney.fr/wp-content/uploads/2018/10/SharePointList13.png)

[Dans la dernière partie](https://cloudyjourney.fr/2018/11/06/azure-creation-dune-application-powerapps-pour-une-liste-sharepoint/), nous verrons comment créer une application "User Friendly" pour notre team HR par exemple, qui s'occupera de l'arrivée des nouveaux employés :)
