---
title: "Exporter les propriétés de vos Azure Key vault"
date: "2022-09-28"
author: "Florent Appointaire"
permalink: "/2022/09/28/exporter-keyvault-properties/"
summary: 
categories: 
  - "azure"
tags:
  - "azure"
  - "microsoft"
  - "custom"
  - "key vault"
---

Si vous souhaitez vérifier les propriétés de vos Key vault, notamment savoir si le soft delete, la retention du soft delete et la purge protection sont activés et les exporter dans un fichier CSV, il suffit juste d'exécuter ce script, avec le nom de votre management groupe, pour démarrer l'export:

<a href="https://github.comcom/Flodu31/Flodu31.github.io/blob/master/assets/images/2022/Export-Keyvault-Properties-MgmtGroup.ps1" target="_blank">Export-Keyvault-Properties-MgmtGroup.ps1</a>

Vous aurez un fichier excel, avec les propriétés exportées, et ainsi vérifier la compliance de vos Key vaults.
