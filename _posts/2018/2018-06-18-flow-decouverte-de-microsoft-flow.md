---
title: "[Flow] Découverte de Microsoft Flow"
date: "2018-06-18"
categories: 
  - "azure"
tags: 
  - "flow"
  - "microsoft"
  - "twitter"
---

[![](https://cloudyjourney.fr/wp-content/uploads/2018/05/flow-logo.png)](https://cloudyjourney.fr/wp-content/uploads/2018/05/flow-logo.png)

Aujourd'hui, je vais vous présenter un nouveau produit que j'ai découvert il y a un mois maintenant, Microsoft Flow. Pour commencer, allez sur [https://flow.microsoft.com](https://flow.microsoft.com) et complétez les informations tel que la région, etc. Vous allez avoir l'interface suivante:

[![](https://cloudyjourney.fr/wp-content/uploads/2018/06/Flow01.png)](https://cloudyjourney.fr/wp-content/uploads/2018/06/Flow01.png)

Comme vous pouvez le voir, il y a déjà des templates qui sont créés pour certains cas. Dans notre cas, nous allons en créer un nouveau. Dans **Popular Services**, vous avez les services qui sont supportés pour Microsoft Flow. En haut, cliquez sur **My flows > + Create from blank**. Cliquez sur **Create from blank**. Par exemple, ici, je voudrais recevoir un mail quand le mot **cloud** est tweeté. Cherchez twitter dans la nouvelle page et cliquez sur **Twitter – When a new tweet is posted**:

[![](https://cloudyjourney.fr/wp-content/uploads/2018/06/Flow02.png)](https://cloudyjourney.fr/wp-content/uploads/2018/06/Flow02.png)

Connectez votre compte Twitter en cliquant sur **Sign in:**

[![](https://cloudyjourney.fr/wp-content/uploads/2018/06/Flow03.png)](https://cloudyjourney.fr/wp-content/uploads/2018/06/Flow03.png)

Remplissez le champ avec le mot **cloud** et ajoutez une condition en cliquant sur **\+ New step:**

[![](https://cloudyjourney.fr/wp-content/uploads/2018/06/Flow04.png)](https://cloudyjourney.fr/wp-content/uploads/2018/06/Flow04.png)

Chaque tweet avec la mention **cloud** sera analysée. Avec la condition, on va ajouter notre nom de compte twitter, **florent\_app:**

[![](https://cloudyjourney.fr/wp-content/uploads/2018/06/Flow05.png)](https://cloudyjourney.fr/wp-content/uploads/2018/06/Flow05.png)

Donc, si le tweet contient le mot **cloud** et est tweeté par **florent\_app** je vais envoyer un mail à... moi :) vous voyez qu'ici vous pouvez déjà créer des listes de diffusions automatiques :) Ajoutez l'action **Send an email** et fournissez l'adresse email où envoyer les informations, et personnalisez le sujet et le champ principal:

[![](https://cloudyjourney.fr/wp-content/uploads/2018/06/Flow06-1.png)](https://cloudyjourney.fr/wp-content/uploads/2018/06/Flow06-1.png)

Sauvegardez votre workflow et attendez :) Vous pouvez voir tous les tweets qui sont analysés:

[![](https://cloudyjourney.fr/wp-content/uploads/2018/06/Flow07.png)](https://cloudyjourney.fr/wp-content/uploads/2018/06/Flow07.png)

Le résultat suivant est faux car le compte qui a tweeté n'est pas **florent\_app**:

[![](https://cloudyjourney.fr/wp-content/uploads/2018/06/Flow08.png)](https://cloudyjourney.fr/wp-content/uploads/2018/06/Flow08.png)

Donc on ne va pas recevoir de mail. Et, si je tweet le mot **cloud**, la condition est vraie:

[![](https://cloudyjourney.fr/wp-content/uploads/2018/06/Flow09.png)](https://cloudyjourney.fr/wp-content/uploads/2018/06/Flow09.png)

Et je reçoie un mail:

[![](https://cloudyjourney.fr/wp-content/uploads/2018/06/Flow10.png)](https://cloudyjourney.fr/wp-content/uploads/2018/06/Flow10.png)

Maintenant, laissez votre imagination faire le reste :)
