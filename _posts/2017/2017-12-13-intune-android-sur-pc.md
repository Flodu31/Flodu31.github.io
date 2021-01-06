---
title: "[Intune] Android sur PC"
date: "2017-12-13"
categories: 
  - "intune"
tags: 
  - "android"
  - "bluestacks"
  - "intune"
  - "microsoft"
---

![](https://cloudyjourney.fr/wp-content/uploads/2018/01/3005.pastedimage1513177145769v1-300x61.png)

En préparant une démo Intune pour un de mes clients, et n'ayant pas de device Android sous la main, j'ai décidé de faire la démonstration Android via mon PC. Pour faire ceci, il existe plusieurs simulateur Android sur PC. J'ai décidé de choisir BlueStacks:

[https://www.bluestacks.com/](https://www.bluestacks.com/)

Ce logiciel est gratuit et simule une tablette Android. Installez ce dernier et exécutez le. Assurez vous d'avoir déployé, via Intune, une application. Pour ma part, j'ai décidé de déployer l'application Intune dans mon magasin d'application.

Ouvrez le navigateur sur votre tablette et allez sur votre portail Intune, à l'adresse suivante:

[https://portal.manage.microsoft.com/](https://portal.manage.microsoft.com/)

Connectez-vous avez votre compte Azure AD. Vous devriez avoir votre application disponible:

[![](https://www.cloudyjourney.fr/wp-content/uploads/2018/01/5584.pastedimage1513152135402v1.png)](https://www.cloudyjourney.fr/wp-content/uploads/2018/01/5584.pastedimage1513152135402v1.png)

Cliquez dessus. Vous devriez arriver sur le Google Play pour installer l'application. Installez la:

[![](https://www.cloudyjourney.fr/wp-content/uploads/2018/01/3823.pastedimage1513152209293v2.png)](https://www.cloudyjourney.fr/wp-content/uploads/2018/01/3823.pastedimage1513152209293v2.png)

[![](https://www.cloudyjourney.fr/wp-content/uploads/2018/01/5008.pastedimage1513152231525v3.png)](https://www.cloudyjourney.fr/wp-content/uploads/2018/01/5008.pastedimage1513152231525v3.png)

Une fois installée et connectée, vous devriez avoir les autres application publiées. Ici, Word, disponible via le Google Play:

[![](https://www.cloudyjourney.fr/wp-content/uploads/2018/01/8713.pastedimage1513152273491v4.png)](https://www.cloudyjourney.fr/wp-content/uploads/2018/01/8713.pastedimage1513152273491v4.png)

Au redémarrage de l'application, il va vous demander la catégorie dans laquel se trouve l'objet:

[![](https://www.cloudyjourney.fr/wp-content/uploads/2018/01/3515.pastedimage1513152356565v5.png)](https://www.cloudyjourney.fr/wp-content/uploads/2018/01/3515.pastedimage1513152356565v5.png)

Les applications déployées automatiquement et qui sont requises, vont être téléchargées et installées:

[![](https://www.cloudyjourney.fr/wp-content/uploads/2018/01/0044.pastedimage1513152387745v6.png)](https://www.cloudyjourney.fr/wp-content/uploads/2018/01/0044.pastedimage1513152387745v6.png)

[![](https://www.cloudyjourney.fr/wp-content/uploads/2018/01/2110.2017-12-13_8-49-29.png)](https://www.cloudyjourney.fr/wp-content/uploads/2018/01/2110.2017-12-13_8-49-29.png)

Je suis en train de découvrir Intune, et je dois avouer que se produit est quand même très intéressant pour gérer un parc mobile.
