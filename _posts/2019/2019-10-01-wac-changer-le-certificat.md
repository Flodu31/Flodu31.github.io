---
title: "[WAC] Changer le certificat"
date: "2019-10-01"
categories: 
  - "autres"
tags: 
  - "azure"
  - "certificat"
  - "microsoft"
  - "wac"
  - "windows-admin-center"
---

![](https://cloudyjourney.fr/wp-content/uploads/2019/10/WAC_Logo.jpg)

Aujourd'hui, en me connectant sur mon environnement Windows Admin Center, j'ai eu le message d'erreur suivant, qui signifie que mon certificat est expiré:

![](https://i1.wp.com/cloudyjourney.fr/wp-content/uploads/2019/10/WAC_Certificate_01.png?fit=762%2C548&ssl=1)

J'ai donc renouvelé mon certificat, et pour le changer dans le WAC, il suffit d'importer le nouveau certificat sur le serveur, et de récupérer son thumbprint:

![](https://i1.wp.com/cloudyjourney.fr/wp-content/uploads/2019/10/WAC_Certificate_04.png?fit=762%2C967&ssl=1)

Une fois cette clé récupérée, il suffit d'aller dans le panneau de configuration, de chercher le **Windows Admin Center** et cliquer sur **Change**:

![](https://i0.wp.com/cloudyjourney.fr/wp-content/uploads/2019/10/WAC_Certificate_02.png?fit=762%2C197&ssl=1)

Choisissez de modifier le WAC:

![](https://cloudyjourney.fr/wp-content/uploads/2019/10/WAC_Certificate_03.png)

Remplacez le thumbprint par votre nouveau certificat que vous avez copié précédemment et cliquez sur **Change**:

![](https://cloudyjourney.fr/wp-content/uploads/2019/10/WAC_Certificate_05.png)

Le service WAC va redémarrer. Une fois terminé, le certificat de votre WAC est bien changé:

![](https://cloudyjourney.fr/wp-content/uploads/2019/10/WAC_Certificate_06.png)
