---
title: "[Azure] Création d'une application PowerApps pour une liste SharePoint"
date: "2018-11-06"
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

[![](https://cloudyjourney.fr/wp-content/uploads/2018/10/powerapps-logo.jpg)](https://cloudyjourney.fr/wp-content/uploads/2018/10/powerapps-logo.jpg)

Après avoir vu comment [créer un nouvel utilisateur dans l'Azure AD via une Azure Function](https://cloudyjourney.fr/2018/10/31/azure-creation-dun-utilisateur-avec-azure-function/), puis [appeler cette fonction depuis une liste SharePoint](https://cloudyjourney.fr/2018/11/05/azure-appel-dun-webhook-azure-function-via-une-liste-sharepoint-et-automatise-avec-flow/), nous allons voir comment rendre ça plus "User Friendly".

Pour commencer, allez sur votre liste SharePoint et cliquez sur **Create an app**:

[![](https://cloudyjourney.fr/wp-content/uploads/2018/10/PowerApps01.png)](https://cloudyjourney.fr/wp-content/uploads/2018/10/PowerApps01.png)

Donnez un nom à votre application:

[![](https://cloudyjourney.fr/wp-content/uploads/2018/10/PowerApps02.png)](https://cloudyjourney.fr/wp-content/uploads/2018/10/PowerApps02.png)

En cliquant sur **Create,** vous allez être renvoyer vers un nouveau site, et vous allez pouvoir customiser votre application, comme bon vous semble:

[![](https://cloudyjourney.fr/wp-content/uploads/2018/10/PowerApps03.png)](https://cloudyjourney.fr/wp-content/uploads/2018/10/PowerApps03.png)

Une fois terminé, sauvegardez l'application et publié la:

[![](https://cloudyjourney.fr/wp-content/uploads/2018/10/PowerApps04.png)](https://cloudyjourney.fr/wp-content/uploads/2018/10/PowerApps04.png)

Validez la version à publier:

[![](https://cloudyjourney.fr/wp-content/uploads/2018/10/PowerApps05.png)](https://cloudyjourney.fr/wp-content/uploads/2018/10/PowerApps05.png)

Ouvrez PowerApps sur votre téléphone. L'application doit apparaitre:

[![](https://cloudyjourney.fr/wp-content/uploads/2018/10/PowerApps06.png)](https://cloudyjourney.fr/wp-content/uploads/2018/10/PowerApps06.png)

Lancez là et créez un nouvel utilisateur. C'est la même chose que la création d'une liste dans SharePoint:

[![](https://cloudyjourney.fr/wp-content/uploads/2018/10/PowerApps07.png)](https://cloudyjourney.fr/wp-content/uploads/2018/10/PowerApps07.png)

Une fois validé, ceci va être envoyé à la liste SharePoint qui va appeler le Microsoft Flow, qui lui va déclancher la Azure Function qui va créer l'utilisateur:

[![](https://cloudyjourney.fr/wp-content/uploads/2018/10/PowerApps08.png)](https://cloudyjourney.fr/wp-content/uploads/2018/10/PowerApps08.png)

Après quelques secondes d'attente, l'utilisateur a été créé:

[![](https://cloudyjourney.fr/wp-content/uploads/2018/10/PowerApps09.png)](https://cloudyjourney.fr/wp-content/uploads/2018/10/PowerApps09.png)

C'est ainsi que ce termine cette série d'article sur l'automatisation, avec une interface user friendly (téléphone/tablette). Vous pouvez maintenant rendre accessible beaucoup d'action, sans être développeur, à vos employés. N'hésitez pas à me laisser des commentaires/questions, si ce n'est pas assez clair :)
