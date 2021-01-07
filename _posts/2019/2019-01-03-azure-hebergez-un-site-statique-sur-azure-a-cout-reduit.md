---
title: "[Azure] Hébergez un site statique sur Azure, à coût réduit"
date: "2019-01-03"
author: "Florent Appointaire"
permalink: "/2019/01/03/azure-hebergez-un-site-statique-sur-azure-a-cout-reduit/"
summary:
categories: 
  - "azure"
  - "azure-storage"
tags: 
  - "azure"
  - "azure-storage"
  - "microsoft"
  - "website"
---

Si vous avez un site web, avec des page statique à héberger, ne cherchez plus une solution compliqué, Microsoft fournit aujourd'hui l'hébergement sur un compte de stockage Azure. Les coûts de stockage sont disponibles ici: [https://azure.microsoft.com/en-us/pricing/details/storage/page-blobs/](https://azure.microsoft.com/en-us/pricing/details/storage/page-blobs/)

Adieu donc les serveurs IIS/Apache, qui coûtent cher en ressources et en maintenance, pour héberger des sites fixent.

Pour commencer, créez un compte de stockage sur Azure, de type v2:

![](https://cloudyjourney.fr/wp-content/uploads/2019/01/AzureStaticWebsite01.png)

Allez ensuite dans la partie **Static website** et activez la fonctionnalité:

![](https://cloudyjourney.fr/wp-content/uploads/2019/01/AzureStaticWebsite02.png)

Choisissez le nom de votre page d'accueil, et si vous en avez un, le nom de la page d'erreur. Vous avez également l'URL qui vous donne accès au site. Un conteneur a également été créé pour héberger vos pages:

![](https://cloudyjourney.fr/wp-content/uploads/2019/01/AzureStaticWebsite03.png)

Vous pouvez y accéder directement depuis l'interface web, via le **Storage Explorer**. Sélectionnez le conteneur web, et envoyez vos fichiers HTML, que vous souhaitez afficher:

![](https://cloudyjourney.fr/wp-content/uploads/2019/01/AzureStaticWebsite04.png)

Votre site web est maintenant accessible, depuis un compte de stockage, sans configuration, pas mal non? :)

![](https://cloudyjourney.fr/wp-content/uploads/2019/01/AzureStaticWebsite05.png)

Si vous avez besoin d'une URL personnalisée, comme cloudyjourney.fr par exemple, il vous suffit d'enregistrer votre DNS dans la partie **Custom Domain** de votre compte de stockage:

![](https://cloudyjourney.fr/wp-content/uploads/2019/01/AzureStaticWebsite06.png)

Comme vous pouvez le voir, il est maintenant très simple d'héberger un site web, sans connaissance spécifique en IT, et ce, à moindre coût.
