---
title: "[Azure] Déploiement de Cloudyn"
date: "2018-03-07"
author: "Florent Appointaire"
permalink: "/2018/03/07/azure-deploiement-de-cloudyn"
summary:
categories: 
  - "azure"
tags: 
  - "azure"
  - "cloudyn"
  - "microsoft"
---

[![](https://cloudyjourney.fr/wp-content/uploads/2018/01/Azure.png)](https://cloudyjourney.fr/wp-content/uploads/2018/01/Azure.png)

Depuis quelques temps maintenant, Microsoft a racheté Cloudyn. Et maintenant, il est gratuit si vous avez un subscription Azure :)

Vous pourrez connecter votre subscription EA, CSP ou autre pour suivre les coûts associés à votre subscription Azure. Il pourra entre autre, vous aider à avoir une vue globale sur vos dépenses, mais aussi, à optimiser vos coûts, etc.

Voyons donc comment le déployer. Allez sur le portail Azure et sélectionnez une de vos subscription Azure. Relevé son **Offer ID** et cliquez sur la banière violette.

[![](https://cloudyjourney.fr/wp-content/uploads/2018/03/CloudynAzure01.png)](https://cloudyjourney.fr/wp-content/uploads/2018/03/CloudynAzure01.png)

Sur la page qui s'ouvre, cliquez sur **Go to Cost Management** pour aller sur Cloudyn:

[![](https://cloudyjourney.fr/wp-content/uploads/2018/03/CloudynAzure02.png)](https://cloudyjourney.fr/wp-content/uploads/2018/03/CloudynAzure02.png)

Une fois sur Cloudyn, les informations concernant les notifications et l'organisation doivent être complétées. Si elles ne le sont pas, faites le. Choisissez le type de subscription, dans mon cas, ce sont des subscriptions individuelles:

[![](https://cloudyjourney.fr/wp-content/uploads/2018/03/CloudynAzure03.png)](https://cloudyjourney.fr/wp-content/uploads/2018/03/CloudynAzure03.png)

Renseignez l'Offer ID que vous avez relevé au début:

[![](https://cloudyjourney.fr/wp-content/uploads/2018/03/CloudynAzure04.png)](https://cloudyjourney.fr/wp-content/uploads/2018/03/CloudynAzure04.png)

Cliquez sur **Next** pour être redirigé vers l'interface pour donner les autorisations à Azure:

[![](https://cloudyjourney.fr/wp-content/uploads/2018/03/CloudynAzure05.png)](https://cloudyjourney.fr/wp-content/uploads/2018/03/CloudynAzure05.png)

Accepter pour donner les autorisations à Cloudyn de créer une application dans votre Azure AD et de donner les bonnes permissions sur les subscriptions:

[![](https://cloudyjourney.fr/wp-content/uploads/2018/03/CloudynAzure06.png)](https://cloudyjourney.fr/wp-content/uploads/2018/03/CloudynAzure06.png)

Une fois terminé, vous pouvez aller sur Cloudyn. A noter que la collection des données prend à peu près 24 heures, pour les subscriptions Azure, sur les 6 derniers mois.

[![](https://cloudyjourney.fr/wp-content/uploads/2018/03/CloudynAzure07.png)](https://cloudyjourney.fr/wp-content/uploads/2018/03/CloudynAzure07.png)

Sur l'interface de Cloudyn, si vous avez l'erreur suivante, c'est simplement que le compte d'application a été créé, mais que les permissions n'ont pas pu être appliquées:

> Failed to grant read access for subscription. Message: Principal deab18c2be364a49beb85aedec0dade0 does not exist in the directory 4c58cbef-8923-450e-a31d-a8f181728c86. Correlation ID: 9fac2cec-5660-4b90-bd82-9398d831f763

[![](https://cloudyjourney.fr/wp-content/uploads/2018/03/CloudynAzure10-1.png)](https://cloudyjourney.fr/wp-content/uploads/2018/03/CloudynAzure10-1.png)Supprimez toute les subscriptions, sauf la première, qui est votre tenant:

[![](https://cloudyjourney.fr/wp-content/uploads/2018/03/CloudynAzure11.png)](https://cloudyjourney.fr/wp-content/uploads/2018/03/CloudynAzure11.png)

Et faites une nouvelle découverte en cliquant sur **Add new account:**

[![](https://cloudyjourney.fr/wp-content/uploads/2018/03/CloudynAzure12.png)](https://cloudyjourney.fr/wp-content/uploads/2018/03/CloudynAzure12.png)

Renseignez votre **Tenant ID** et choisissez l'**Offer ID** du début:

[![](https://cloudyjourney.fr/wp-content/uploads/2018/03/CloudynAzure13.png)](https://cloudyjourney.fr/wp-content/uploads/2018/03/CloudynAzure13.png)

Vous devriez avoir un message qui confirme l'ajout des subscriptions:

[![](https://cloudyjourney.fr/wp-content/uploads/2018/03/CloudynAzure14.png)](https://cloudyjourney.fr/wp-content/uploads/2018/03/CloudynAzure14.png)

L'ajout est maintenant complet: [![](https://cloudyjourney.fr/wp-content/uploads/2018/03/CloudynAzure15.png)](https://cloudyjourney.fr/wp-content/uploads/2018/03/CloudynAzure15.png) Modifiez chaque subscription, pour l'associer à son bon **Offer ID:**

[![](https://cloudyjourney.fr/wp-content/uploads/2018/03/CloudynAzure09.png)](https://cloudyjourney.fr/wp-content/uploads/2018/03/CloudynAzure09.png)

Quand ceci est terminé, et que vous avez attendu plus de 24 heures, vous devriez avoir des données dans votre interface:

[![](https://cloudyjourney.fr/wp-content/uploads/2018/03/CloudynAzure16.png)](https://cloudyjourney.fr/wp-content/uploads/2018/03/CloudynAzure16.png)

Vous pouvez également regarder quels sont les services qui consomment le plus, etc. pour optimiser votre infrastructure. Dans mon cas, le réseau me coûte cher comparé au reste. Il me reste plus qu'à investiguer pourquoi :)

[![](https://cloudyjourney.fr/wp-content/uploads/2018/03/CloudynAzure17.png)](https://cloudyjourney.fr/wp-content/uploads/2018/03/CloudynAzure17.png)

En espérant vous avoir été utile. Dans le prochain article, nous verrons comment intégrer AWS à Cloudyn :)
