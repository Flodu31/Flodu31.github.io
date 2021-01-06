---
title: "[Azure] Erreur SELinux au redémarrage d'une VM Linux"
date: "2019-06-11"
categories: 
  - "azure"
tags: 
  - "azure"
  - "microsoft"
  - "policy-error"
  - "red-hat"
  - "selinux"
---

![](https://cloudyjourney.fr/wp-content/uploads/2018/01/Azure.png)

Aujourd'hui, un de mes clients a fait une modification du SELinux sur une VM sur Azure, avec du coup, le message suivant comme erreur dans la Serial Console de Azure:

**Failed to load SELinux policy. Freezing.**

![](https://i2.wp.com/cloudyjourney.fr/wp-content/uploads/2019/06/SELinux01.png?fit=762%2C502&ssl=1)

Pour corriger ceci, cliquez sur le petit bouton power et cliquez sur **Restart VM** puis appuyez sur **e** sur votre clavier pour modifier le boot:

![](https://i2.wp.com/cloudyjourney.fr/wp-content/uploads/2019/06/SELinux02-1.png?fit=762%2C432&ssl=1)

Choisissez la première ligne, et descendez jusqu'en bas. Ajoutez dans la ligne **linux16** après **root=...** ceci:

**selinux=0**

Ceci va faire bypasser le SELinux au boot:

![](https://i0.wp.com/cloudyjourney.fr/wp-content/uploads/2019/06/SELinux03.png?fit=762%2C414&ssl=1)

Faites **Ctrl + X** et le serveur devrait démarrer sans souci:

![](https://i0.wp.com/cloudyjourney.fr/wp-content/uploads/2019/06/SELinux04.png?fit=762%2C580&ssl=1)
