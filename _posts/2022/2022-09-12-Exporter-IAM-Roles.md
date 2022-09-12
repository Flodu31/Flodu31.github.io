---
title: "Exporter vos rôles IAM"
date: "2022-09-12"
author: "Florent Appointaire"
permalink: "/2022/09/12/exporter-iam-roles/"
summary: 
categories: 
  - "azure"
tags:
  - "azure"
  - "microsoft"
  - "iam"
---

Petit article aujourd'hui pour vous partager un script que j'ai rapidement créer, pour exporter les roles qui sont assignés aux ressources d'une souscription Azure, et les exporter en CSV. Le script est ici:

![](/assets/images/2022/Get-IAMResources.ps1)

Pour l'exécuter, il suffit juste d'exécuter le script en lui passant la souscription que vous souhaitez analyser:

![](/assets/images/2022/IAM01.png)

Dépendant du nombre de ressources que vous devez exporter, le script va prendre plus ou moins de temps pour générer l'export:

![](/assets/images/2022/IAM02.png)

Une source d'amélioration serait de pouvoir filtrer sur un utilisateur ou groupe.
