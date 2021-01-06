---
title: "[Azure] Ajouter plusieurs administrateurs d'un coup"
date: "2017-02-08"
author: "Florent Appointaire"
permalink: "/2017/02/08/azure-ajouter-plusieurs-administrateurs-dun-coup/"
summary:
categories: 
  - "azure-ad"
tags: 
  - "azure"
  - "microsoft"
  - "owner"
---
J'ai eu la demande d'ajouter plusieurs utilisateurs d'un Azure AD Administrateur de la suscription Azure, en ARM. Etant feignant et ne voulant pas ajouter les 10 utilisateurs à la main, j'ai décidé d'écrire un script PowerShell (au cas où on me demande de le refaire plus tard). Ce script est disponible sur Gallery Technet:

[https://gallery.technet.microsoft.com/Add-multiple-admins-in-an-07c7cf59](https://gallery.technet.microsoft.com/Add-multiple-admins-in-an-07c7cf59)

Pour l'utiliser, créez un fichier CSV au même endroit que votre script, avec les 3 colonnes suivantes:

- Email
- FirstName
- Lastname

[![](https://cloudyjourney.fr/wp-content/uploads/2018/01/pastedimage1486543883325v2.png)](https://cloudyjourney.fr/wp-content/uploads/2018/01/pastedimage1486543883325v2.png)

Sur mes 4 utilisateurs, je n'en ai que 1 qui est actuellement Owner. Le script ajoutera donc les 3 autres:

[![](https://cloudyjourney.fr/wp-content/uploads/2018/01/pastedimage1486543914274v3.png)](https://cloudyjourney.fr/wp-content/uploads/2018/01/pastedimage1486543914274v3.png)

Choisissez votre suscription Azure:

[![](https://cloudyjourney.fr/wp-content/uploads/2018/01/pastedimage1486543930479v4.png)](https://cloudyjourney.fr/wp-content/uploads/2018/01/pastedimage1486543930479v4.png)

Si il y a un souci pendant l'ajout, vous aurez un message d'erreur:

[![](https://cloudyjourney.fr/wp-content/uploads/2018/01/pastedimage1486543952572v5.png)](https://cloudyjourney.fr/wp-content/uploads/2018/01/pastedimage1486543952572v5.png)

Et si l'ajout se passe bien, vous aurez des messages d'informations:

[![](https://cloudyjourney.fr/wp-content/uploads/2018/01/pastedimage1486543974692v6.png)](https://cloudyjourney.fr/wp-content/uploads/2018/01/pastedimage1486543974692v6.png)

Et dans ma vue Azure:

[![](https://cloudyjourney.fr/wp-content/uploads/2018/01/pastedimage1486543983903v7.png)](https://cloudyjourney.fr/wp-content/uploads/2018/01/pastedimage1486543983903v7.png)

Si vous avez des questions, remarques ou suggestions, n'hésitez pas :)
