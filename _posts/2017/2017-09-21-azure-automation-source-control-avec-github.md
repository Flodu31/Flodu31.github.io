---
title: "[Azure Automation] Source Control avec Github"
date: "2017-09-21"
author: "Florent Appointaire"
permalink: "/2017/09/21/azure-automation-source-control-avec-github/"
summary:
categories: 
  - "azure"
  - "azure-automation"
tags: 
  - "azure"
  - "azure-automation"
  - "github"
  - "microsoft"
  - "source-control"
---
Aujourd'hui je vais vous parler d'une nouvelle feature que j'ai découvert le week-end dernier, lors du PowerShell Saturday User Group à Paris, l'intégration entre Azure Automation et Github. Cette intégration vous permettra d'avoir le contrôle et le versionning de vos sources.

Pour commencer, allez dans votre compte Azure Automation et allez dans **Source Control**:

![](https://cloudyjourney.fr/wp-content/uploads/2018/01/3056.AASCG01.png)

Cliquez sur **Choose Source** pour choisir votre source, **Github** (c'est la seule source disponible au moment où j'écris cet article):

![](https://cloudyjourney.fr/wp-content/uploads/2018/01/3056.AASCG02.png)

Après ça, dans la partie **Authorization**, connectez vous à votre compte Github:

![](https://cloudyjourney.fr/wp-content/uploads/2018/01/6661.AASCG03.png)

![](https://cloudyjourney.fr/wp-content/uploads/2018/01/3755.AASCG04.png)

Dans la section **Choose repository**, sélectionnez le dossier où vos scripts Azure Automation sont ou seront sauvegardés:

![](https://cloudyjourney.fr/wp-content/uploads/2018/01/3755.AASCG05.png)

Dans la partie **Choose Branch**, choisissez votre branch, **master** dans mon cas:

[![](https://cloudyjourney.fr/wp-content/uploads/2018/01/6735.AASCG06.png)](https://cloudyjourney.fr/wp-content/uploads/2018/01/6735.AASCG06.png)

Dans la partie **Runbook Folder Path**, spécifiez si les scripts sont stockés dans un dossier spécifique. Dans mon cas, j'ai dédier un dossier pour ça dans mon compte Github, c'est pourquoi j'ai donné le chemin root:

![](https://cloudyjourney.fr/wp-content/uploads/2018/01/6735.AASCG07.png)

Quand la configuration est terminée, cliquez sur **OK**:

[![](https://cloudyjourney.fr/wp-content/uploads/2018/01/0550.AASCG08.png)](https://cloudyjourney.fr/wp-content/uploads/2018/01/0550.AASCG08.png)

Si un script existe dans votre dossier Github, cliquez sur **Sync** pour l'importer:

[![](https://cloudyjourney.fr/wp-content/uploads/2018/01/0550.AASCG09.png)](https://cloudyjourney.fr/wp-content/uploads/2018/01/0550.AASCG09.png)

Quand c'est terminé, le status passe à **Completed**:

[![](https://cloudyjourney.fr/wp-content/uploads/2018/01/4452.AASCG10.png)](https://cloudyjourney.fr/wp-content/uploads/2018/01/4452.AASCG10.png)

Et le script apparait comme nouveau Runbook si il n'existait pas:

[![](https://cloudyjourney.fr/wp-content/uploads/2018/01/4452.AASCG11.png)](https://cloudyjourney.fr/wp-content/uploads/2018/01/4452.AASCG11.png)

Personne n'a modifié ce Runbook car il vient d'être importé de Github:

[![](https://cloudyjourney.fr/wp-content/uploads/2018/01/8176.AASCG12.png)](https://cloudyjourney.fr/wp-content/uploads/2018/01/8176.AASCG12.png)

Si vous mettez localement à jour le script, l'uploadez sur Github et que vous faites une nouvelle synchronisation, le résultat est le même:

[![](https://cloudyjourney.fr/wp-content/uploads/2018/01/8176.AASCG13.png)](https://cloudyjourney.fr/wp-content/uploads/2018/01/8176.AASCG13.png)

[![](https://cloudyjourney.fr/wp-content/uploads/2018/01/2781.AASCG14.png)](https://cloudyjourney.fr/wp-content/uploads/2018/01/2781.AASCG14.png)

Si vous modifiez votre script sur Azure Automation, vous pouvez le pousser sur Github en cliquant sur **Check in**:

[![](https://cloudyjourney.fr/wp-content/uploads/2018/01/2781.AASCG15.png)](https://cloudyjourney.fr/wp-content/uploads/2018/01/2781.AASCG15.png)

Dans l'interface Github, votre script a été mis à jour depuis Azure Automation, comme vous le voyez dans les commentaires:

[![](https://cloudyjourney.fr/wp-content/uploads/2018/01/5140.AASCG16.png)](https://cloudyjourney.fr/wp-content/uploads/2018/01/5140.AASCG16.png)

Comme vous pouvez le voir, c'est maintenant **TO** à la place de **FROM** pour Github:

[![](https://cloudyjourney.fr/wp-content/uploads/2018/01/5140.AASCG17.png)](https://cloudyjourney.fr/wp-content/uploads/2018/01/5140.AASCG17.png)

Cette feature est très intéréssante pour avoir un Source Control pour vos scripts Azure Automation, gratuitement. J'espère voir apparaître rapidement d'autres Source control rapidement.
