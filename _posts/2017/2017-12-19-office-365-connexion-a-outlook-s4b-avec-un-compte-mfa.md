---
title: "[Office 365] Connexion à Outlook/S4B avec un compte MFA"
date: "2017-12-19"
author: "Florent Appointaire"
permalink: "/2017/12/19/office-365-connexion-a-outlook-s4b-avec-un-compte-mfa/"
summary:
categories: 
  - "office-365"
tags: 
  - "mfa"
  - "microsoft"
  - "office-365"
  - "s4b"
---

![](https://cloudyjourney.fr/wp-content/uploads/2018/01/6840.pastedimage1513327969388v1-300x104.jpeg)

Après avoir vu comment activer le MFA sur un compte Office 365, j'ai voulu me connecter à S4B et paramétrer mon compte O365. Seul problème, au moment de rentrer mon mot de passe, j'ai eu une erreur comme quoi le mot de passe n'était pas bon, bizarre... Après quelques recherches, je me suis rendu compte que pour se connecter à Outlook ou S4B, il faut un mot de passe de type **App Password**.

Pour faire ceci, vous devez aller dans vos paramètres dans votre compte O365:

[![](https://cloudyjourney.fr/wp-content/uploads/2018/01/0654.pastedimage1513328101664v2.png)](https://cloudyjourney.fr/wp-content/uploads/2018/01/0654.pastedimage1513328101664v2.png)

Cliquez ensuite sur **Manage security & privacy:**

[![](https://cloudyjourney.fr/wp-content/uploads/2018/01/2620.pastedimage1513328169043v3.png)](https://cloudyjourney.fr/wp-content/uploads/2018/01/2620.pastedimage1513328169043v3.png)

Cliquez sur **Additional security verification** puis sur le lien qui apparait:

[![](https://cloudyjourney.fr/wp-content/uploads/2018/01/7510.pastedimage1513328191342v4.png)](https://cloudyjourney.fr/wp-content/uploads/2018/01/7510.pastedimage1513328191342v4.png)

Cliquez ensuite dans la nouvelle fenêtre sur **app passwords** puis sur **create:**

[![](https://cloudyjourney.fr/wp-content/uploads/2018/01/4466.pastedimage1513328224919v5.png)](https://cloudyjourney.fr/wp-content/uploads/2018/01/4466.pastedimage1513328224919v5.png)

Donnez un nom et cliquez sur **Next:**

[![](https://cloudyjourney.fr/wp-content/uploads/2018/01/8171.pastedimage1513328253147v6.png)](https://cloudyjourney.fr/wp-content/uploads/2018/01/8171.pastedimage1513328253147v6.png)

Un mot de passe va s'afficher. Vous ne pourrez plus l'afficher une fois que vous aurez fermé la fenêtre:

[![](https://cloudyjourney.fr/wp-content/uploads/2018/01/6433.pastedimage1513328269925v7.png)](https://cloudyjourney.fr/wp-content/uploads/2018/01/6433.pastedimage1513328269925v7.png)

Attention, ce nouveau mot de passe ne fonctionne qu'avec des applications de types Outlook. Vous ne pourrez pas vous connecter au portail Office via votre navigateeur avec ce mot de passe.

[![](https://cloudyjourney.fr/wp-content/uploads/2018/01/0247.pastedimage1513328299554v8.png)](https://cloudyjourney.fr/wp-content/uploads/2018/01/0247.pastedimage1513328299554v8.png)

Vous pouvez maintenant connecter votre compte O365 au client Outlook/S4B en utilisant ce mot de passe.

Quand Microsoft va intégrer le MFA dans ses applications bureaux? On a toujours pas de réponse...
