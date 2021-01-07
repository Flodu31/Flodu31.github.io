---
title: "[Azure] Erreur SELinux au redémarrage d'une VM Linux"
date: "2019-06-11"
author: "Florent Appointaire"
permalink: "/2019/06/11/azure-erreur-selinux-au-redemarrage-dune-vm-linux/"
summary:
categories: 
  - "azure"
tags: 
  - "azure"
  - "microsoft"
  - "policy-error"
  - "red-hat"
  - "selinux"
---
Aujourd'hui, un de mes clients a fait une modification du SELinux sur une VM sur Azure, avec du coup, le message suivant comme erreur dans la Serial Console de Azure:

**Failed to load SELinux policy. Freezing.**

![](https://cloudyjourney.fr/wp-content/uploads/2019/06/SELinux01.png)

Pour corriger ceci, cliquez sur le petit bouton power et cliquez sur **Restart VM** puis appuyez sur **e** sur votre clavier pour modifier le boot:

![](https://cloudyjourney.fr/wp-content/uploads/2019/06/SELinux02-1.png)

Choisissez la première ligne, et descendez jusqu'en bas. Ajoutez dans la ligne **linux16** après **root=...** ceci:

**selinux=0**

Ceci va faire bypasser le SELinux au boot:

![](https://cloudyjourney.fr/wp-content/uploads/2019/06/SELinux03.png)

Faites **Ctrl + X** et le serveur devrait démarrer sans souci:

![](https://cloudyjourney.fr/wp-content/uploads/2019/06/SELinux04.png)
