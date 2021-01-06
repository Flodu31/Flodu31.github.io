---
title: "[Azure AD] Changer la méthode du MFA"
date: "2017-12-14"
categories: 
  - "azure-ad"
tags: 
  - "azure-ad"
  - "mfa"
  - "microsoft"
---

![](https://cloudyjourney.fr/wp-content/uploads/2018/01/0601.download-300x158.png)

Par défaut, quand vous activer le MFA à un utilisateur Azure AD, le deuxième facteur d'authentification est l'envoi d'un SMS.

Cette méthode peut ne pas convenir à tout le monde, et il est plus simple de cliquer sur une notification sur son smartphone que de rentrer un code où l'on peut faire des erreurs (oui oui, je suis feignant ? ).

Pour changer la méthode d'authetification, allez sur [https://myapps.microsoft.com/](https://myapps.microsoft.com/) et connectez vous avec votre compte. Allez ensuite dans votre compte en haut à droite, et cliquez sur **Profile.** Cliquez ensuite sur **Additional security verification**. En arrivant sur cette page, vous devriez voir que votre méthode d'authentification est le **text code**:

[![](https://www.cloudyjourney.fr/wp-content/uploads/2018/01/3324.pastedimage1513162971027v1.png)](https://www.cloudyjourney.fr/wp-content/uploads/2018/01/3324.pastedimage1513162971027v1.png)

Changez le part **Notify me through app:**

[![](https://www.cloudyjourney.fr/wp-content/uploads/2018/01/6038.pastedimage1513163169568v2.png)](https://www.cloudyjourney.fr/wp-content/uploads/2018/01/6038.pastedimage1513163169568v2.png)

Cochez la case **Authenticator app**, puis sur **Configure.** Vous devriez arriver sur la page suivante. Installez l'application **Microsoft authenticator** sur Windows Phone, Android ou iOS et choisissez d'ajouter un compte **Work or school.** Scannez le QRCode ou rentrez les informations disponibles. Cliquez sur **Next:**

[![](https://www.cloudyjourney.fr/wp-content/uploads/2018/01/6038.pastedimage1513164053537v4.png)](https://www.cloudyjourney.fr/wp-content/uploads/2018/01/6038.pastedimage1513164053537v4.png)

La mise en place est terminée. Pour tester ceci, allez sur une page Microsoft, par exemple [https://portal.azure.com](https://portal.azure.com/) et renseignez votre premier facteur d'authentification qui est votre mot de passe:

[![](https://www.cloudyjourney.fr/wp-content/uploads/2018/01/5481.pastedimage1513164079094v5.png)](https://www.cloudyjourney.fr/wp-content/uploads/2018/01/5481.pastedimage1513164079094v5.png)

Vous allez ensuite recevoir une notification sur votre smartphone:

[![](https://www.cloudyjourney.fr/wp-content/uploads/2018/01/5481.pastedimage1513164104934v7.png)](https://www.cloudyjourney.fr/wp-content/uploads/2018/01/5481.pastedimage1513164104934v7.png)

Acceptez ou refusez:

[![](https://www.cloudyjourney.fr/wp-content/uploads/2018/01/8105.20171213_111919000_iOS.png)](https://www.cloudyjourney.fr/wp-content/uploads/2018/01/8105.20171213_111919000_iOS.png)

Sans plus aucune action, vous êtes authentifié:

[![](https://www.cloudyjourney.fr/wp-content/uploads/2018/01/8105.pastedimage1513164147878v8.png)](https://www.cloudyjourney.fr/wp-content/uploads/2018/01/8105.pastedimage1513164147878v8.png)

En espérant vous avoir aidé ?
