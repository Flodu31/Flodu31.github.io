---
title: "[Azure] Calculez le coût de votre data center dans Azure"
date: "2017-09-19"
categories: 
  - "azure"
tags: 
  - "azure"
  - "map"
  - "microsoft"
  - "tco"
---

[![](https://cloudyjourney.fr/wp-content/uploads/2018/01/7411.MAP00.jpg)](https://cloudyjourney.fr/wp-content/uploads/2018/01/7411.MAP00.jpg)

Pendant l'été, Microsoft a rendu disponible un outil pour calculer le TCO (Total Cost of Ownership). Cet outil est une plateforme en ligne, où vous pouvez y accéder depuis ici: [https://www.tco.microsoft.com/](https://www.tco.microsoft.com/)

Cet outil peut être utilisé de façon manuelle, en fournissant les informations des serveurs manuellement, ou de façon semi-automatiquen en utilisant l'outil MAP: [https://www.microsoft.com/en-us/download/details.aspx?id=7826](https://www.microsoft.com/en-us/download/details.aspx?id=7826)

La dernière version date de Février 2017, et vous aidera à faire l'assessment, sur les serveurs qui sont Online.

Pour commencer, lancez MAP sur un ordinateur ou serveur et choisissez de créer une base de donnée, pour l'inventaire:

[![](https://cloudyjourney.fr/wp-content/uploads/2018/01/7411.MAP01.png)](https://cloudyjourney.fr/wp-content/uploads/2018/01/7411.MAP01.png)

Cliquez sur **Perform an inventory** pour démarrer l'inventaire de vos serveurs:

[![](https://cloudyjourney.fr/wp-content/uploads/2018/01/7411.MAP02.png)](https://cloudyjourney.fr/wp-content/uploads/2018/01/7411.MAP02.png)

Une nouvelle fenêtre apparait. Choisissez quel type de serveur vous souhaitez évaluer. Ces serveurs seront évalués pour aller sur Azure:

[![](https://cloudyjourney.fr/wp-content/uploads/2018/01/1134.MAP03.png)](https://cloudyjourney.fr/wp-content/uploads/2018/01/1134.MAP03.png)

Sélectionnez la méthode que vous souhaitez utiliser pour découvrir les ordinateurs, par exemple Active Directory:

[![](https://cloudyjourney.fr/wp-content/uploads/2018/01/1134.MAP04.png)](https://cloudyjourney.fr/wp-content/uploads/2018/01/1134.MAP04.png)

Renseignez des credentials qui peuvent être utiliser pour lire les objets Computers dans l'Active Directory:

[![](https://cloudyjourney.fr/wp-content/uploads/2018/01/0576.MAP05.png)](https://cloudyjourney.fr/wp-content/uploads/2018/01/0576.MAP05.png)

Sélectionnez les OU que vous souhaitez scanner dans votre AD:

![](https://cloudyjourney.fr/wp-content/uploads/2018/01/4150.pastedimage1505812951590v1.png)

Fournissez un utilisateur qui a les droits de se connecter aux ordinateurs qui seront scannés, avec WMI (administrateur local par exemple) ou autre, dépendant des ordinateurs que vous souhaitez scanner:

[![](https://cloudyjourney.fr/wp-content/uploads/2018/01/3201.MAP07.png)](https://cloudyjourney.fr/wp-content/uploads/2018/01/3201.MAP07.png)

Ajoutez chaque compte avec chaque technologie:

[![](https://cloudyjourney.fr/wp-content/uploads/2018/01/6825.MAP08.png)](https://cloudyjourney.fr/wp-content/uploads/2018/01/6825.MAP08.png)

Si vous utilisez des credentials spécifiques pour des groupes d'ordinateurs, modifiez l'ordre d'utilisation:

[![](https://cloudyjourney.fr/wp-content/uploads/2018/01/6825.MAP09.png)](https://cloudyjourney.fr/wp-content/uploads/2018/01/6825.MAP09.png)

Cliquez sur **Finish** pour démarrer l'évaluation:

[![](https://cloudyjourney.fr/wp-content/uploads/2018/01/5367.MAP10.png)](https://cloudyjourney.fr/wp-content/uploads/2018/01/5367.MAP10.png)

L'évaluation est en cours:

[![](https://cloudyjourney.fr/wp-content/uploads/2018/01/5367.MAP11.png)](https://cloudyjourney.fr/wp-content/uploads/2018/01/5367.MAP11.png)

Quand l'évaluation est terminée, vous pouvez fermer la fenêtre:

[![](https://cloudyjourney.fr/wp-content/uploads/2018/01/8081.MAP12.png)](https://cloudyjourney.fr/wp-content/uploads/2018/01/8081.MAP12.png)

Dans la fenêtre MAP, cliquez sur **Environment:**

[![](https://cloudyjourney.fr/wp-content/uploads/2018/01/8081.MAP13.png)](https://cloudyjourney.fr/wp-content/uploads/2018/01/8081.MAP13.png)

Double cliquez sur **Inventory Results**:

[![](https://cloudyjourney.fr/wp-content/uploads/2018/01/6837.MAP14.png)](https://cloudyjourney.fr/wp-content/uploads/2018/01/6837.MAP14.png)

Dans la nouvelle fenêtre, cliquez sur **Generate Inventory Result Report**:

[![](https://cloudyjourney.fr/wp-content/uploads/2018/01/2234.MAP15.png)](https://cloudyjourney.fr/wp-content/uploads/2018/01/2234.MAP15.png)

Le rapport Excel est généré, il nous servira pour le TCO:

![](https://cloudyjourney.fr/wp-content/uploads/2018/01/5857.MAP16.png)

Ouvrez le fichier Excel et supprimez les 3 premières lignes:

[![](https://cloudyjourney.fr/wp-content/uploads/2018/01/8562.MAP17.png)](https://cloudyjourney.fr/wp-content/uploads/2018/01/8562.MAP17.png)

Si certains ordinateurs étaient éteint pendant l'évaluation, ceci a généré des lignes avec des valeurs **Insufficient Data.** Vous **DEVEZ** supprimer ces valeurs, en supprimant la ligne entière de l'ordinateur en question, sinon le calculateur TCO ne fonctionnera pas:

[![](https://cloudyjourney.fr/wp-content/uploads/2018/01/8562.MAP18.png)](https://cloudyjourney.fr/wp-content/uploads/2018/01/8562.MAP18.png)

Maintenant allez sur le calculateur TCO et cliquez sur **Start Now**:

[https://www.tco.microsoft.com/](https://www.tco.microsoft.com/)

[![](https://cloudyjourney.fr/wp-content/uploads/2018/01/7024.MAP19.png)](https://cloudyjourney.fr/wp-content/uploads/2018/01/7024.MAP19.png)

Cliquez sur **Bulk Input** pour importer votre fichier Excel, et modifiez la région, la devise ainsi que sur combien d'années vous souhaitez faire le calcul:

[![](https://cloudyjourney.fr/wp-content/uploads/2018/01/1638.MAP20.png)](https://cloudyjourney.fr/wp-content/uploads/2018/01/1638.MAP20.png)

Choisissez le fichier Excel que vous avez modifié, et choisissez votre capacité de stockage, SSD ou non. Cliquez sur **Calculate:**

**[![](https://cloudyjourney.fr/wp-content/uploads/2018/01/1638.MAP21.png)](https://cloudyjourney.fr/wp-content/uploads/2018/01/1638.MAP21.png)**

Après quelques secondes, vous aurez un aperçu du prix sur Azure par and, avec les serveurs qui ont été scannés, et le coût économisé en allant sur Azure:

[![](https://cloudyjourney.fr/wp-content/uploads/2018/01/0181.MAP22.png)](https://cloudyjourney.fr/wp-content/uploads/2018/01/0181.MAP22.png)

En haut du rapport, vous pouvez télécharger le **Bulk Report** avec chaque détail, pour chaque ordinateur. Vous aurez également l'équivalent OnPrem vers Azure:

[![](https://cloudyjourney.fr/wp-content/uploads/2018/01/0181.MAP23.png)](https://cloudyjourney.fr/wp-content/uploads/2018/01/0181.MAP23.png)

Cet outil est très interéssant pour faire une rapide évaluation et pour avoir un équivalent sur Azure. Mais, attention avec l'estimation du coût que vous allez économisé en allant sur Azure. En effet, ceci dépend des serveurs que vous utilisez, du pays où ils sont, etc. Dans mon exemple, mes VMs OnPrem tournent sur un Intel NUC, et je n'ai pas 1000€ d'électricité par an pour ce NUC. Donc utilisez cet outil pour avoir une rapide overview du prix sur Azure pour votre environnement, mais comparez les valeurs avec les valeurs réels de votre datacenter.
