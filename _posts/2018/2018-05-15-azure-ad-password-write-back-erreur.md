---
title: "[Azure AD] Password Write back erreur"
date: "2018-05-15"
author: "Florent Appointaire"
permalink: "/2018/05/15/azure-ad-password-write-back-erreur/"
summary:
categories: 
  - "azure"
tags: 
  - "azure-ad"
  - "azure-ad-connect"
  - "microsoft"
  - "password-writeback"
---
En voulant utiliser la fonctionnalité de remise à zéro du mot de passe, via la plateforme Microsoft, en utilisant la fonctionnalité Password Write Back de Azure AD Connect, j'ai rencontré l'erreur suivante:

> An unexpected error has occurred during a password set operation...

[![](https://cloudyjourney.fr/wp-content/uploads/2018/05/AzAD01.png)](https://cloudyjourney.fr/wp-content/uploads/2018/05/AzAD01.png)

Il y avait également l'erreur suivante:

> The password could not be updated because the management agent credentials were denied access...

[![](https://cloudyjourney.fr/wp-content/uploads/2018/05/AzAD02.png)](https://cloudyjourney.fr/wp-content/uploads/2018/05/AzAD02.png)

Pour commencer, assurez vous que l'utilisateur en question n'a pas la case "Password never expires" cochée:

[![](https://cloudyjourney.fr/wp-content/uploads/2018/05/AzAD03.png)](https://cloudyjourney.fr/wp-content/uploads/2018/05/AzAD03.png)

Assurez-vous également que le compte qui est utilisé pour la synchronisation a bien les droits pour effectuer des remises à zéro de mot de passe, notamment pour les comptes Domain Admins:

[![](https://cloudyjourney.fr/wp-content/uploads/2018/05/AzAD04.png)](https://cloudyjourney.fr/wp-content/uploads/2018/05/AzAD04.png)

Après avoir corrigé ces 2 erreurs, j'ai pu remettre à zéro mon mot de passe de mon utilisateur Domain Admin sans souci:

[![](https://cloudyjourney.fr/wp-content/uploads/2018/05/AzAD05.png)](https://cloudyjourney.fr/wp-content/uploads/2018/05/AzAD05.png)
