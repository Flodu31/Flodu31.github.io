---
title: "Exporter vos Custom RBAC rôles"
date: "2022-09-27"
author: "Florent Appointaire"
permalink: "/2022/09/27/exporter-custom-rbac-roles/"
summary: 
categories: 
  - "azure"
tags:
  - "azure"
  - "microsoft"
  - "custom"
  - "rbac"
---

Après avoir vu comment <a href="https://cloudyjourney.fr/2022/09/12/exporter-iam-roles/">exporter vos rôles IAM</a>, voyons comment exporter les custom RBAC roles de vos souscription. Le script est ici et va exporter chaques rôles dans un dossier, par souscription et par nom:

<a href="https://github.com/Flodu31/Flodu31.github.io/blob/master/assets/images/2022/Export-CustomRBACRoles.ps1" target="_blank">Export-CustomRBACRoles.ps1</a>

Il suffit juste d'exécuter le script dans le dossier où vous souhaitez faire l'export, pour avoir un extract complet.
Par défault, le script analyse toutes les souscriptions auxquelles vous avez accès.
