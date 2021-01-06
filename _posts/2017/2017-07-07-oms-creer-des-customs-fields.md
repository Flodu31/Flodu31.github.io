---
title: "[OMS] Créer des Customs Fields"
date: "2017-07-07"
categories: 
  - "oms"
tags: 
  - "custom-fields"
  - "microsoft"
  - "oms"
---

[![](https://cloudyjourney.fr/wp-content/uploads/2018/01/OMS.png)](https://cloudyjourney.fr/wp-content/uploads/2018/01/OMS.png)

Une nouvelle fonctionnalité vient d'apparaître depuis quelques mois sur OMS, la possibilité de créer des champs personnalisés (Custom Field). Ceci vous permet de classifier des recherches de façon plus simple et plus rapide que d'effectuer des longues recherches.

Pour commencer, assurez-vous d'avoir un workspace OMS et de récupérer des logs:

[![](https://cloudyjourney.fr/wp-content/uploads/2018/01/2100.OMS01.png)](https://cloudyjourney.fr/wp-content/uploads/2018/01/2100.OMS01.png)

Vérifiez également que dans la recherche, vous avez des logs disponibles:

[![](https://cloudyjourney.fr/wp-content/uploads/2018/01/1541.OMS02.png)](https://cloudyjourney.fr/wp-content/uploads/2018/01/1541.OMS02.png)

Sélectionnez un log qui vous intéresse et pour qui, vous souhaitez créer des customs fields. Je vais sélectionner un log de redémarrage de service:

[![](https://cloudyjourney.fr/wp-content/uploads/2018/01/4265.OMS03.png)](https://cloudyjourney.fr/wp-content/uploads/2018/01/4265.OMS03.png)

Puis cliquez sur les **...** qui se trouvent à côté de **ParameterXml** (vous pouvez le faire sur une autre catégorie si vous le souhaitez) et choisissez **Extract fields from 'Event' (Preview)**:

[![](https://cloudyjourney.fr/wp-content/uploads/2018/01/3617.OMS04.png)](https://cloudyjourney.fr/wp-content/uploads/2018/01/3617.OMS04.png)

Vous devriez arriver sur une page de sélection, comme celle-ci:

[![](https://cloudyjourney.fr/wp-content/uploads/2018/01/6332.OMS05.png)](https://cloudyjourney.fr/wp-content/uploads/2018/01/6332.OMS05.png)

Sélectionnez la partie qui vous intéresse, donnez lui un nom et cliquez sur **Extract**:

[![](https://cloudyjourney.fr/wp-content/uploads/2018/01/6332.OMS06.png)](https://cloudyjourney.fr/wp-content/uploads/2018/01/6332.OMS06.png)

De façon automatique, OMS va chercher dans les logs actuels si il y a des correspondances. Si il y en a, il va automatiquement les passer en bleu. Si ce n'est pas fait de façon automatique, ou si il manque une partie du texte, cliquez sur les 3 petits points suivants et choisissez **Modify this highlight**:

[![](https://cloudyjourney.fr/wp-content/uploads/2018/01/0045.OMS07.png)](https://cloudyjourney.fr/wp-content/uploads/2018/01/0045.OMS07.png)

Sélectionnez le texte et associez le au custom field créé précédemment:

[![](https://cloudyjourney.fr/wp-content/uploads/2018/01/0045.OMS08.png)](https://cloudyjourney.fr/wp-content/uploads/2018/01/0045.OMS08.png)

Quand tous résultats de la recherche sont associés au custom filed, cliquez sur **Save Extraction:**

[![](https://cloudyjourney.fr/wp-content/uploads/2018/01/8407.OMS09.png)](https://cloudyjourney.fr/wp-content/uploads/2018/01/8407.OMS09.png)

Faites de même avec le status du service, **stopped** ou **running**:

[![](https://cloudyjourney.fr/wp-content/uploads/2018/01/8407.OMS10.png)](https://cloudyjourney.fr/wp-content/uploads/2018/01/8407.OMS10.png)

A partir de maintenant, chaque service qui sera redémarré appliquera les customs fields que l'on a créé. Malheureusement, ça ne s'applique pas sur les logs créés avant d'avoir fait ceci.

[![](https://cloudyjourney.fr/wp-content/uploads/2018/01/2112.OMS11.png)](https://cloudyjourney.fr/wp-content/uploads/2018/01/2112.OMS11.png)

Une fois ceci terminé, vous pouvez utiliser ces customs fields dans la recherche:

[![](https://cloudyjourney.fr/wp-content/uploads/2018/01/2112.OMS12.png)](https://cloudyjourney.fr/wp-content/uploads/2018/01/2112.OMS12.png)

Et les utiliser dans une vue personnalisée:

[![](https://cloudyjourney.fr/wp-content/uploads/2018/01/5736.OMS13.png)](https://cloudyjourney.fr/wp-content/uploads/2018/01/5736.OMS13.png)

Cette fonctionnalité est très intéressante pour classer des logs et avoir un aperçu rapide et automatisé sans utiliser de scripts PowerShell ou autre qui sont lourds à déployer.

Si vous avez des questions, n'hésitez pas :)
