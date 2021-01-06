---
title: "[Azure AD] Authentification Passthrough et SSO"
date: "2016-12-14"
author: "Florent Appointaire"
permalink: "/2016/12/14/azure-ad-authentification-passthrough-et-sso/"
summary: 
categories: 
  - "azure-ad"
tags: 
  - "azure"
  - "azure-ad"
  - "azure-ad-connect"
  - "microsoft"
  - "sso"
---
Microsoft a publié une nouvelle version de Azure AD Connect (anciennement DirSync) qui permet de synchroniser votre Active Directory vers Azure AD. 2 nouvelles fonctionnalités sont apparues:

- Passthrough authentication => Permet de vérifier la validité d'un compte (mot de passe, etc.) sans ADFS ni même agent en DMZ.
- Seamless SSO => Ajoute la possibilité de se connecter aux services Microsoft (office, azure, etc) sans passer par un ADFS.

Ces fonctionnalités sont actuellement en Preview. Donc ne les utilisez pas en prod :)

Plus d'informations ici: [https://blogs.technet.microsoft.com/enterprisemobility/2016/12/07/introducing-azuread-pass-through-authentication-and-seamless-single-sign-on/](https://blogs.technet.microsoft.com/enterprisemobility/2016/12/07/introducing-azuread-pass-through-authentication-and-seamless-single-sign-on/)

Commençons par le début, l'installation de Azure AD Connect. Téléchargez le [ici](https://www.microsoft.com/en-us/download/details.aspx?id=47594) et lancez l'installation:

[![](https://cloudyjourney.fr/wp-content/uploads/2018/01/2016-12-13_15-46-34.png)](https://cloudyjourney.fr/wp-content/uploads/2018/01/2016-12-13_15-46-34.png)

Une fois l'installation terminée, nous allons commencer la configuration. Acceptez la licence:

[![](https://cloudyjourney.fr/wp-content/uploads/2018/01/pastedimage1481643891543v1.png)](https://cloudyjourney.fr/wp-content/uploads/2018/01/pastedimage1481643891543v1.png)

Choisissez une installation personnalisée:

[![](https://cloudyjourney.fr/wp-content/uploads/2018/01/pastedimage1481643907449v2.png)](https://cloudyjourney.fr/wp-content/uploads/2018/01/pastedimage1481643907449v2.png)

Définissez si vous souhaitez modifier le chemin d'installation, si vous souhaitez utiliser un serveur SQL existant, un compte de service, etc:

[![](https://cloudyjourney.fr/wp-content/uploads/2018/01/pastedimage1481643950034v3.png)](https://cloudyjourney.fr/wp-content/uploads/2018/01/pastedimage1481643950034v3.png)

C'est ici que nous allons choisir les 2 nouveautés, PassThrough Authentication et SSO:

[![](https://cloudyjourney.fr/wp-content/uploads/2018/01/pastedimage1481643986117v4.png)](https://cloudyjourney.fr/wp-content/uploads/2018/01/pastedimage1481643986117v4.png)

Connectez vous à votre Azure AD:

[![](https://cloudyjourney.fr/wp-content/uploads/2018/01/pastedimage1481644005880v5.png)](https://cloudyjourney.fr/wp-content/uploads/2018/01/pastedimage1481644005880v5.png)

Ajoutez ensuite les forêt que vous souhaitez synchroniser:

[![](https://cloudyjourney.fr/wp-content/uploads/2018/01/pastedimage1481644031344v6.png)](https://cloudyjourney.fr/wp-content/uploads/2018/01/pastedimage1481644031344v6.png)

Votre domaine doit être vérifié pour continuer:

[![](https://cloudyjourney.fr/wp-content/uploads/2018/01/pastedimage1481644050721v7.png)](https://cloudyjourney.fr/wp-content/uploads/2018/01/pastedimage1481644050721v7.png)

Choisissez quelle OU vous voulez synchroniser avec Azure AD:

[![](https://cloudyjourney.fr/wp-content/uploads/2018/01/pastedimage1481644067265v8.png)](https://cloudyjourney.fr/wp-content/uploads/2018/01/pastedimage1481644067265v8.png)

Choisissez ensuite comment identifier de façon unique vos utilisateurs:

[![](https://cloudyjourney.fr/wp-content/uploads/2018/01/pastedimage1481644090408v9.png)](https://cloudyjourney.fr/wp-content/uploads/2018/01/pastedimage1481644090408v9.png)

Pour un POC, vous pouvez sélectionner la 1ère option. En production, sélectionnez un groupe avec des utilisateurs de tests à synchroniser:

[![](https://cloudyjourney.fr/wp-content/uploads/2018/01/pastedimage1481644137598v10.png)](https://cloudyjourney.fr/wp-content/uploads/2018/01/pastedimage1481644137598v10.png)

Si vous souhaitez synchroniser les mots de passes, etc. sélectionnez les options qui conviennent:

[![](https://cloudyjourney.fr/wp-content/uploads/2018/01/pastedimage1481644163156v11.png)](https://cloudyjourney.fr/wp-content/uploads/2018/01/pastedimage1481644163156v11.png)

Renseignez ensuite un compte qui a les droits pour créer des objets de types ordinateurs dans votre AD:

[![](https://cloudyjourney.fr/wp-content/uploads/2018/01/pastedimage1481644195886v12.png)](https://cloudyjourney.fr/wp-content/uploads/2018/01/pastedimage1481644195886v12.png)

Lancez la synchronisation:

[![](https://cloudyjourney.fr/wp-content/uploads/2018/01/pastedimage1481644207922v13.png)](https://cloudyjourney.fr/wp-content/uploads/2018/01/pastedimage1481644207922v13.png)

Vous pouvez vérifier que vos utilisateurs ont bien été synchronisés: [![](https://cloudyjourney.fr/wp-content/uploads/2018/01/pastedimage1481644235410v14.png)](https://cloudyjourney.fr/wp-content/uploads/2018/01/pastedimage1481644235410v14.png)

[![](https://cloudyjourney.fr/wp-content/uploads/2018/01/pastedimage1481644327391v15.png)](https://cloudyjourney.fr/wp-content/uploads/2018/01/pastedimage1481644327391v15.png)

Dans votre Active Directory, un compte ordinateur a été créé pour le SSO:

[![](https://cloudyjourney.fr/wp-content/uploads/2018/01/pastedimage1481644355453v16.png)](https://cloudyjourney.fr/wp-content/uploads/2018/01/pastedimage1481644355453v16.png)

Voici les 2 URLs qui sont utilisées pour le SSO. Vous pouvez trouver ceci dans l'édition d'attribut, dans l'attribut **servicePrincipalName**:

[![](https://cloudyjourney.fr/wp-content/uploads/2018/01/pastedimage1481644414530v18.png)](https://cloudyjourney.fr/wp-content/uploads/2018/01/pastedimage1481644414530v18.png)

Avant de tester la connexion, nous allons ajouter par GPO ces 2 URLs à Internet Explorer pour utiliser la connexion en SSO. Ouvrez **gpedit.msc** et allez dans **User Configuration > Policies > Administrative Templates > Windows Components > Internet Explorer > Internet Control Panel > Security Page** et modifiez le paramètre **Site to Zone Assignment List**. Ajoutez les 2 URLs suivantes, avec une valeur à 1:

- [https://autologon.microsoftazuread-sso.com](https://autologon.microsoftazuread-sso.com/)
- [https://aadg.windows.net.nsatc.net](https://aadg.windows.net.nsatc.net/)

[![](https://cloudyjourney.fr/wp-content/uploads/2018/01/pastedimage1481644653565v19.png)](https://cloudyjourney.fr/wp-content/uploads/2018/01/pastedimage1481644653565v19.png)

Effectuez un **gpupdate /force** sur le client/serveur sur lequel vous allez tester la connexion.

Pour terminer, rendez vous sur [https://portal.office.com](https://portal.office.com/) avec Internet Explorer et renseignez votre adresse email. Vous n'aurez pas le temps de tapper votre mot de passe que l'authentification sera terminée :)

[![](https://cloudyjourney.fr/wp-content/uploads/2018/01/2016-12-13_16-32-52.gif)](https://cloudyjourney.fr/wp-content/uploads/2018/01/2016-12-13_16-32-52.gif)

Cette nouvelle fonctionnalité est très intéressante car vous n'avez plus besoin d'infrastructure ADFS qui peut être lourde en terme de ressource et couteuse (certificat, etc.).
