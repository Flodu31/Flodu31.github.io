---
title: "[Intune] Intégration de TeamViewer"
date: "2017-12-15"
categories: 
  - "intune"
tags: 
  - "assistance"
  - "intune"
  - "microsoft"
  - "teamviewer"
---

![](https://cloudyjourney.fr/wp-content/uploads/2018/01/3005.pastedimage1513177145769v1-300x61.png)

Toujours dans ma découverte de Intune, j'ai découvert la possibilité d'intégrer TeamViewer à Intune.

Pour mettre en place ceci, allez dans votre portail Azure, dans la partie **Microsoft Intune > Devices > TeamViewer Connector** et connectez vous à votre compte TeamViewer pour authoriser Intune:

[![](https://cloudyjourney.fr/wp-content/uploads/2018/01/6710.pastedimage1513177270893v2.png)](https://cloudyjourney.fr/wp-content/uploads/2018/01/6710.pastedimage1513177270893v2.png)

Allez ensuite sur un Devices où vous souhaitez prendre le controle. Seul Windows 10 et Android peuvent être controlés à distance. Cliquez sur **More > New Remote Assistance Session:**

[![](https://cloudyjourney.fr/wp-content/uploads/2018/01/6710.pastedimage1513177286889v3.png)](https://cloudyjourney.fr/wp-content/uploads/2018/01/6710.pastedimage1513177286889v3.png)

Cliquez ensuite sur **Start Remote Assistance:**

[![](https://cloudyjourney.fr/wp-content/uploads/2018/01/4162.pastedimage1513177350808v4.png)](https://cloudyjourney.fr/wp-content/uploads/2018/01/4162.pastedimage1513177350808v4.png)

Teamviewer va se lancer en local sur le PC:

[![](https://cloudyjourney.fr/wp-content/uploads/2018/01/4162.pastedimage1513177374223v5.png)](https://cloudyjourney.fr/wp-content/uploads/2018/01/4162.pastedimage1513177374223v5.png)

Votre client distant va recevoir une notification dans l'application **Company Portal**. Il doit cliquer dessus:

[![](https://cloudyjourney.fr/wp-content/uploads/2018/01/8875.pastedimage1513177403943v6.png)](https://cloudyjourney.fr/wp-content/uploads/2018/01/8875.pastedimage1513177403943v6.png)

Edge va s'ouvrir et va vous demander de lancer Teamviewer:

[![](https://cloudyjourney.fr/wp-content/uploads/2018/01/2500.pastedimage1513177422317v7.png)](https://cloudyjourney.fr/wp-content/uploads/2018/01/2500.pastedimage1513177422317v7.png)

Authorisez la connexion:

![](https://cloudyjourney.fr/wp-content/uploads/2018/01/2500.pastedimage1513177440131v8.png)

L'opérateur peut maintenant controler à distance l'ordinateur:

[![](https://cloudyjourney.fr/wp-content/uploads/2018/01/0842.pastedimage1513177462201v9.png)](https://cloudyjourney.fr/wp-content/uploads/2018/01/0842.pastedimage1513177462201v9.png)

Et sur Android:

[![](https://cloudyjourney.fr/wp-content/uploads/2018/01/0842.pastedimage1513177763065v10.png)](https://cloudyjourney.fr/wp-content/uploads/2018/01/0842.pastedimage1513177763065v10.png)

[![](https://cloudyjourney.fr/wp-content/uploads/2018/01/4666.pastedimage1513177770519v11.png)](https://cloudyjourney.fr/wp-content/uploads/2018/01/4666.pastedimage1513177770519v11.png)

[![](https://cloudyjourney.fr/wp-content/uploads/2018/01/4666.pastedimage1513177779266v12.png)](https://cloudyjourney.fr/wp-content/uploads/2018/01/4666.pastedimage1513177779266v12.png)

En espérant vous avoir aidé ?
