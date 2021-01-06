---
title: "[Azure AD] Domain Services"
date: "2017-05-11"
categories: 
  - "azure-ad"
tags: 
  - "azure"
  - "azure-ad-domain-services"
  - "microsoft"
---

[![](https://cloudyjourney.fr/wp-content/uploads/2018/01/0601.download.png)](https://cloudyjourney.fr/wp-content/uploads/2018/01/0601.download.png)

En Octobre 2016, Microsoft a rendu disponible en GA Azure Active Directory Domain Services: [https://blogs.technet.microsoft.com/enterprisemobility/2016/10/12/azuread-domain-services-is-now-ga-lift-and-shift-to-the-cloud-just-got-way-easier/](https://blogs.technet.microsoft.com/enterprisemobility/2016/10/12/azuread-domain-services-is-now-ga-lift-and-shift-to-the-cloud-just-got-way-easier/)

Ce nouveau service vous permet d’avoir un domain controller sur Azure, géré par les équipes Microsoft. Vous aurez donc la possibilité de joindre des ordinateurs aux domains.

Concernant le prix de ce service, tout depend du nombre d’objet qu’il y aura. Vous trouverez plus d’informations ici: [https://azure.microsoft.com/en-us/pricing/details/active-directory-ds/](https://azure.microsoft.com/en-us/pricing/details/active-directory-ds/)

Bien sur, ce service a des limitations, mais vous pourrez tout de même effectuer les operations suivantes:

- Joindre des machines au domaine
- Configurer des GPO
- Gérer les DNS
- Créer des OU
- Donner des droits aux ordinateurs

Attention, si vous souhaitez installer des composants comme SCCM, Exchange, etc. ce ne sera pas possible car vous ne pouvez pas étendre le schema, etc.

Nous allons voir comment activer cette fonctionnalité. Attention, à l’heure où ce billet est écrit, ceci est uniquement disponible en ASM (ancien portail). Nous allons voir comment l’utiliser avec des VMs qui ont été déployées en ARM.

## Prerequis

- Un VNet Classic
- Un VNet ARM
- Un peering entre le VNet ARM et le VNet Classic: [https://cloudyjourney.fr/2016/12/20/azure-network-peering/](https://cloudyjourney.fr/2016/12/20/azure-network-peering/)

[![](https://cloudyjourney.fr/wp-content/uploads/2018/01/7266.AADDS01.png)](https://cloudyjourney.fr/wp-content/uploads/2018/01/7266.AADDS01.png)

[![](https://cloudyjourney.fr/wp-content/uploads/2018/01/3056.AADDS02.png)](https://cloudyjourney.fr/wp-content/uploads/2018/01/3056.AADDS02.png) [![](https://cloudyjourney.fr/wp-content/uploads/2018/01/5123.AADDS03.png)](https://cloudyjourney.fr/wp-content/uploads/2018/01/5123.AADDS03.png)

- Un Azure AD disponible
- Par défaut, vous n’êtes pas administrateur du domaine. Il faut créer un groupe nommé **AAD DC Administrators**et qui vous donnera un accès Administrateur au domaine et aux machines qui y sont jointes. Ajoutez les utilisateurs qui doivent être administrateurs dedans:

[![](https://cloudyjourney.fr/wp-content/uploads/2018/01/pastedimage1494404061109v1.png)](https://cloudyjourney.fr/wp-content/uploads/2018/01/pastedimage1494404061109v1.png)[![](https://cloudyjourney.fr/wp-content/uploads/2018/01/pastedimage1494404077328v2.png)](https://cloudyjourney.fr/wp-content/uploads/2018/01/pastedimage1494404077328v2.png)

## Activation du service

Allez dans votre Azure AD, dans l’onglet **Configure** et cherchez **domain service**. Activez le et choisissez un nom DNS (vérifié ou non) puis choisissez votre VNet Classic où les serveurs vont être connectés:

[![](https://cloudyjourney.fr/wp-content/uploads/2018/01/0317.AADDS04.png)](https://cloudyjourney.fr/wp-content/uploads/2018/01/0317.AADDS04.png)

Le déploiement commence et peut prendre jusqu’à 30 minutes:

[![](https://cloudyjourney.fr/wp-content/uploads/2018/01/8540.AADDS05.png)](https://cloudyjourney.fr/wp-content/uploads/2018/01/8540.AADDS05.png)

Une fois le déploiement terminé, vous devriez avoir l’IP adresse de votre premier serveur Active Directory. La seconde arrivera plus tard (pour la haute disponibilité):

[![](https://cloudyjourney.fr/wp-content/uploads/2018/01/4431.AADDS06.png)](https://cloudyjourney.fr/wp-content/uploads/2018/01/4431.AADDS06.png)

Modifiez vos réseaux virtuels en précisant comme DNS, l’IP de votre ou vos AD:

[![](https://cloudyjourney.fr/wp-content/uploads/2018/01/6406.AADDS07.png)](https://cloudyjourney.fr/wp-content/uploads/2018/01/6406.AADDS07.png)

Déployez une VM sur ce réseau.

Comme vous le voyez, on a un message qui nous indique que pour le moment, nos utilisateurs ne peuvent pas se connecter au domaine, car il faut activer le synchronisation des mots de passes. Ici vous avez 2 choix:

- [Cloud Only](https://docs.microsoft.com/en-us/azure/active-directory-domain-services/active-directory-ds-getting-started-password-sync): si vous gérez vos utilisateurs depuis le Cloud
- [Synced](https://docs.microsoft.com/en-us/azure/active-directory-domain-services/active-directory-ds-getting-started-password-sync-synced-tenant): si vous utilisez Azure AD Connect pour gérer vos utilisateurs

J’utilise la partie Cloud Only donc je vais expliquer cette dernière. Vous devez vous assurer que les utilisateurs peuvent remettre leur mot de passe à jour de façon autonome. Ceci est dans les configurations de l’Azure AD, **Users enabled for password reset**:

[![](https://cloudyjourney.fr/wp-content/uploads/2018/01/pastedimage1494404162865v3.png)](https://cloudyjourney.fr/wp-content/uploads/2018/01/pastedimage1494404162865v3.png)

Cette étape doit être effectué avant que les utilisateurs essayent de se connecter à une machine.

Allez sur votre profile et mettez votre mot de passe à jour:

[https://account.activedirectory.windowsazure.com/r#/profile](https://account.activedirectory.windowsazure.com/r#/profile)

[![](https://cloudyjourney.fr/wp-content/uploads/2018/01/3343.AADDS11.png)](https://cloudyjourney.fr/wp-content/uploads/2018/01/3343.AADDS11.png)

Ceci va metre à jour votre mot de passe dans l’Azure AD DS. 20 minutes après cette modification, vous pouvez vous servir de votre utilisateur pour joindre des ordinateurs au domaine.

## Rejoindre le domaine

Maintenant que ma VM est déployée, je vais la joindre à mon domaine.

Ceci est une étape classique que je ne vais pas décrire:

[![](https://cloudyjourney.fr/wp-content/uploads/2018/01/5428.AADDS12.png)](https://cloudyjourney.fr/wp-content/uploads/2018/01/5428.AADDS12.png)

[![](https://cloudyjourney.fr/wp-content/uploads/2018/01/4024.AADDS13.png)](https://cloudyjourney.fr/wp-content/uploads/2018/01/4024.AADDS13.png)

[![](https://cloudyjourney.fr/wp-content/uploads/2018/01/0714.AADDS14.png)](https://cloudyjourney.fr/wp-content/uploads/2018/01/0714.AADDS14.png)

Maintenant que la machine est jointe au domaine, je vais installer les outils d’administration du domaine, pour pouvoir gérer mes OUs, mes GPOs, etc…

[![](https://cloudyjourney.fr/wp-content/uploads/2018/01/2870.AADDS15.png)](https://cloudyjourney.fr/wp-content/uploads/2018/01/2870.AADDS15.png)

Avec les consoles lancées:

[![](https://cloudyjourney.fr/wp-content/uploads/2018/01/7651.AADDS16.png)](https://cloudyjourney.fr/wp-content/uploads/2018/01/7651.AADDS16.png)

Cette nouvelle fonctionnalité est très interéssante pour les entreprises qui ne veulent pas à avoir à gérer un AD mais qui en ont l’utilité. Seul petit bémol, le fait de devoir changer le mot de passe avant de pouvoir se connecter.
