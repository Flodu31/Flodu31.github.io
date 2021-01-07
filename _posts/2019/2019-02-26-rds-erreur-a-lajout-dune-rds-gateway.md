---
title: "[RDS] Erreur à l'ajout d'une RDS Gateway"
date: "2019-02-26"
author: "Florent Appointaire"
permalink: "/2019/02/26/rds-erreur-a-lajout-dune-rds-gateway/"
summary: 
categories: 
  - "autres"
tags: 
  - "microsoft"
  - "rds-gateway"
---
En voulant ajouter un serveur RDS Gateway à une ferme RDS déjà existante, je me suis confronté à l'erreur suivante:

> Unable to configure the RD Gateway server: FLOAPP-HPV02.florentappointaire.cloud. The error is 2147749890.

![](https://cloudyjourney.fr/wp-content/uploads/2019/02/RDS_Gateway_Error.png)

Après quelques recherches sur internet, j'en suis arrivé à la conclusion que c'était un rôle qui pouvait faire conflit.

En effet, mon serveur RDS Gateway avait déjà les rôles NPAS/Remote Access installés. J'ai désinstallé les rôles et redémarré le serveur. L'installation de la RDS Gateway a fonctionné sans souci après le redémarrage, et j'ai donc, par la suite, réinstallé mes rôles, avec succès.
