---
title: "[Starwind] Cloud VTL avec Amazon Web Services and Veeam"
date: "2017-10-11"
categories: 
  - "aws"
  - "starwind"
tags: 
  - "amazon-web-services"
  - "aws"
  - "backup"
  - "cloud"
  - "starwind"
  - "veeam"
  - "vtl"
---

![](https://cloudyjourney.fr/wp-content/uploads/2017/10/StarWind_Software.png)

Aujourd’hui nous allons voir comment déployer la solution Starwind VTL et l’utiliser avec Veeam, avec un backup dans Amazon Web Services.

Pour commencer, vous devez avoir les prérequis suivants:

- Un serveur Veeam Backup and Replication
- Un compte Amazon Web Services: [https://aws.amazon.com/](https://aws.amazon.com/)
- Un server Starwind VTL avec du stockage

Vous pouvez ensuite télécharger le logiciel Starwind Cloud VTL directement ici: [https://www.starwindsoftware.com/starwind-cloud-vtl-for-veeam](https://www.starwindsoftware.com/starwind-cloud-vtl-for-veeam)

Commencez l’installation du logiciel Virtual Tape Library en cochant bien **Cloud Replicator VTL** pour active la function de replication vers le Cloud:

[![](https://cloudyjourney.fr/wp-content/uploads/2017/10/2158.Picture1.png)](https://www.cloudyjourney.fr/wp-content/uploads/2017/10/2158.Picture1.png)

Une fois le logiciel installé, créez un VTL et ajoutez une tape:

[![](https://www.cloudyjourney.fr/wp-content/uploads/2017/10/5873.Picture2.png)](https://www.cloudyjourney.fr/wp-content/uploads/2017/10/5873.Picture2.png)

Si vous souhaitez héberger vote fichier tape dans un dossier personnalisé, choisissez le:

[![](https://www.cloudyjourney.fr/wp-content/uploads/2017/10/5873.Picture3.png)](https://www.cloudyjourney.fr/wp-content/uploads/2017/10/5873.Picture3.png)

Choisissez le nombre de tape à créer, ainsi que le type et la taille (1500Gb par défaut):

[![](https://www.cloudyjourney.fr/wp-content/uploads/2017/10/8507.Picture4.png)](https://www.cloudyjourney.fr/wp-content/uploads/2017/10/8507.Picture4.png)

Notre tape a été créée correctement:

[![](https://www.cloudyjourney.fr/wp-content/uploads/2017/10/8507.Picture5.png)](https://www.cloudyjourney.fr/wp-content/uploads/2017/10/8507.Picture5.png)

Allez maintenant sur votre compte Amazon, et créez un bucket (compte de stockage) pour héberger vos backups tape.

Allez ensuite dans la partie IAM pour gérer les utilisateurs:

[![](https://www.cloudyjourney.fr/wp-content/uploads/2017/10/7848.Picture6.png)](https://www.cloudyjourney.fr/wp-content/uploads/2017/10/7848.Picture6.png)

Ajoutez un nouvel utilisateur:

[![](https://www.cloudyjourney.fr/wp-content/uploads/2017/10/7848.Picture7.png)](https://www.cloudyjourney.fr/wp-content/uploads/2017/10/7848.Picture7.png)

Donnez lui un accès **Programmatic:**

[![](https://www.cloudyjourney.fr/wp-content/uploads/2017/10/1663.Picture8.png)](https://www.cloudyjourney.fr/wp-content/uploads/2017/10/1663.Picture8.png)

Puis donnez lui les permissions **AmazonGlacierFullAccess** et **AmazonS3FullAccess:**

[![](https://www.cloudyjourney.fr/wp-content/uploads/2017/10/1663.Picture9.png)](https://www.cloudyjourney.fr/wp-content/uploads/2017/10/1663.Picture9.png)

Quand l’utilisateur a été créé, récupérez les valeur **Access key ID** ainsi que **Secret Access key:**

[![](https://www.cloudyjourney.fr/wp-content/uploads/2017/10/8015.Picture10.png)](https://www.cloudyjourney.fr/wp-content/uploads/2017/10/8015.Picture10.png)

Dans la console Starwind VTL, cliquez sur **Cloud Replication…:**

[![](https://www.cloudyjourney.fr/wp-content/uploads/2017/10/8015.Picture11.png)](https://www.cloudyjourney.fr/wp-content/uploads/2017/10/8015.Picture11.png)

Renseignez l’access key ID que vous avez récupéré précédemment, ainsi que la clé secrète. Choisissez où le bucket a été créé, et renseignez son nom:

[![](https://www.cloudyjourney.fr/wp-content/uploads/2017/10/3730.Picture12.png)](https://www.cloudyjourney.fr/wp-content/uploads/2017/10/3730.Picture12.png)

Choisissez quand effectuer la replication vers le cloud, si vous conservez sur le disque le fichier qui a été envoyé vers le cloud et enfin, quand vous souhaitez déplacer les fichiers de Amazon S3 vers le Glacier:

[![](https://www.cloudyjourney.fr/wp-content/uploads/2017/10/3730.Picture13.png)](https://www.cloudyjourney.fr/wp-content/uploads/2017/10/3730.Picture13.png)

Sur votre serveur Veeam, connectez en iSCSI le serveur Starwind VTL:

[![](https://www.cloudyjourney.fr/wp-content/uploads/2017/10/6443.Picture14.png)](https://www.cloudyjourney.fr/wp-content/uploads/2017/10/6443.Picture14.png)

Installez les drivers HP pour le Tape, pour Windows Server:

[https://h20566.www2.hpe.com/hpsc/swd/public/detail?swItemId=MTX\_7e9f343865d1445e92cfbaf0b1](https://h20566.www2.hpe.com/hpsc/swd/public/detail?swItemId=MTX_7e9f343865d1445e92cfbaf0b1)

[![](https://www.cloudyjourney.fr/wp-content/uploads/2017/10/8510.Picture15.png)](https://www.cloudyjourney.fr/wp-content/uploads/2017/10/8510.Picture15.png)

Après l’installation, si le driver **Medium Changer Devices** n’est pas à jour, mettez le à jour. Vous devriez avoir ceci:

[![](https://www.cloudyjourney.fr/wp-content/uploads/2017/10/2234.Picture16.png)](https://www.cloudyjourney.fr/wp-content/uploads/2017/10/2234.Picture16.png)

Ajoutez maintenant le serveur Tape dans Veeam:

[![](https://www.cloudyjourney.fr/wp-content/uploads/2017/10/0676.Picture17.png)](https://www.cloudyjourney.fr/wp-content/uploads/2017/10/0676.Picture17.png)

[![](https://www.cloudyjourney.fr/wp-content/uploads/2017/10/0676.Picture18.png)](https://www.cloudyjourney.fr/wp-content/uploads/2017/10/0676.Picture18.png)

[![](https://www.cloudyjourney.fr/wp-content/uploads/2017/10/4300.Picture19.png)](https://www.cloudyjourney.fr/wp-content/uploads/2017/10/4300.Picture19.png)

La tape est maintenant disponible dans Veeam:

[![](https://www.cloudyjourney.fr/wp-content/uploads/2017/10/4300.Picture20.png)](https://www.cloudyjourney.fr/wp-content/uploads/2017/10/4300.Picture20.png)

Choisissez ce que vous souhaitez mettre sur cette tape, des fichiers ou des backups:

[![](https://www.cloudyjourney.fr/wp-content/uploads/2017/10/2642.Picture21.png)](https://www.cloudyjourney.fr/wp-content/uploads/2017/10/2642.Picture21.png)

Dans mon cas, je vais backup les fichiers de backups, pour tester la fonctionnalité:

[![](https://www.cloudyjourney.fr/wp-content/uploads/2017/10/2642.Picture22.png)](https://www.cloudyjourney.fr/wp-content/uploads/2017/10/2642.Picture22.png)

Choisissez le dossier avec les fichiers à sauvegarder:

[![](https://www.cloudyjourney.fr/wp-content/uploads/2017/10/5466.Picture23.png)](https://www.cloudyjourney.fr/wp-content/uploads/2017/10/5466.Picture23.png)

Créez un nouveau **Media Pool** avec les tapes qui pourront être utilisées pour sauvegarder le contenu:

[![](https://www.cloudyjourney.fr/wp-content/uploads/2017/10/5466.Picture24.png)](https://www.cloudyjourney.fr/wp-content/uploads/2017/10/5466.Picture24.png)

[![](https://www.cloudyjourney.fr/wp-content/uploads/2017/10/0181.Picture25.png)](https://www.cloudyjourney.fr/wp-content/uploads/2017/10/0181.Picture25.png)

Utilisez ce pool pour faire votre sauvegarde full:

[![](https://www.cloudyjourney.fr/wp-content/uploads/2017/10/0181.Picture26.png)](https://www.cloudyjourney.fr/wp-content/uploads/2017/10/0181.Picture26.png)

Et le pool pour la partie incrémentale:

[![](https://www.cloudyjourney.fr/wp-content/uploads/2017/10/7532.Picture27.png)](https://www.cloudyjourney.fr/wp-content/uploads/2017/10/7532.Picture27.png)

Adaptez les options avec votre configuration:

[![](https://www.cloudyjourney.fr/wp-content/uploads/2017/10/5861.Picture29.png)](https://www.cloudyjourney.fr/wp-content/uploads/2017/10/5861.Picture29.png)

Une fois la configuration terminée, lancez le job:

[![](https://www.cloudyjourney.fr/wp-content/uploads/2017/10/5861.Picture30.png)](https://www.cloudyjourney.fr/wp-content/uploads/2017/10/5861.Picture30.png)

[![](https://www.cloudyjourney.fr/wp-content/uploads/2017/10/3323.Picture31.png)](https://www.cloudyjourney.fr/wp-content/uploads/2017/10/3323.Picture31.png)

A la fin du backup, la tape est directement sauvegardée vers Amazon S3:

[![](https://www.cloudyjourney.fr/wp-content/uploads/2017/10/3323.Picture32.png)](https://www.cloudyjourney.fr/wp-content/uploads/2017/10/3323.Picture32.png)

[![](https://www.cloudyjourney.fr/wp-content/uploads/2017/10/6036.Picture33.png)](https://www.cloudyjourney.fr/wp-content/uploads/2017/10/6036.Picture33.png)

Une fois la copie vers le Cloud terminée, le media passe **Offline:**

[![](https://www.cloudyjourney.fr/wp-content/uploads/2017/10/6036.Picture34.png)](https://www.cloudyjourney.fr/wp-content/uploads/2017/10/6036.Picture34.png)

Du côté de notre bucket Amazon, les fichiers sont disponibles:

[![](https://www.cloudyjourney.fr/wp-content/uploads/2017/10/5488.Picture35.png)](https://www.cloudyjourney.fr/wp-content/uploads/2017/10/5488.Picture35.png)

Comme vous pouvez le voir, la tape n’est plus disponible localement car c’est ce que l’on avait demandé. Pour la réstaurer, cliquez sur **Restore from Cloud…:**

[![](https://www.cloudyjourney.fr/wp-content/uploads/2017/10/5488.Picture36.png)](https://www.cloudyjourney.fr/wp-content/uploads/2017/10/5488.Picture36.png)

Choisissez la tape à restaurer:

[![](https://www.cloudyjourney.fr/wp-content/uploads/2017/10/8103.Picture37.png)](https://www.cloudyjourney.fr/wp-content/uploads/2017/10/8103.Picture37.png)

Le téléchargement commence:

[![](https://www.cloudyjourney.fr/wp-content/uploads/2017/10/1004.Picture38.png)](https://www.cloudyjourney.fr/wp-content/uploads/2017/10/1004.Picture38.png)

Une fois le téléchargement terminé, vous pouvez voir que la tape est de nouveau disponible localement. Cliquez sur **Insert Tape…** pour la monter:

[![](https://www.cloudyjourney.fr/wp-content/uploads/2017/10/1004.Picture39.png)](https://www.cloudyjourney.fr/wp-content/uploads/2017/10/1004.Picture39.png)

Choisissez la tape que vous venez de télécharger:

[![](https://www.cloudyjourney.fr/wp-content/uploads/2017/10/4540.Picture40.png)](https://www.cloudyjourney.fr/wp-content/uploads/2017/10/4540.Picture40.png)

Ainsi qu’un slot pour la monter:

[![](https://www.cloudyjourney.fr/wp-content/uploads/2017/10/7587.Picture41.png)](https://www.cloudyjourney.fr/wp-content/uploads/2017/10/7587.Picture41.png)

La tape est montée:

[![](https://www.cloudyjourney.fr/wp-content/uploads/2017/10/7587.Picture42.png)](https://www.cloudyjourney.fr/wp-content/uploads/2017/10/7587.Picture42.png)

Dans Veeam, cliquez sur **Catalog Library** pour scanner de nouveau les tapes sur le serveur VTL:

[![](https://www.cloudyjourney.fr/wp-content/uploads/2017/10/1212.Picture43.png)](https://www.cloudyjourney.fr/wp-content/uploads/2017/10/1212.Picture43.png)

Après quelques instants, la tape apparait, avec le statut **Online**, dans son Media Pool d’origine:

[![](https://www.cloudyjourney.fr/wp-content/uploads/2017/10/1212.Picture44.png)](https://www.cloudyjourney.fr/wp-content/uploads/2017/10/1212.Picture44.png)

Vous pouvez restaurer des fichiers, directement depuis la tape restaurée:

[![](https://www.cloudyjourney.fr/wp-content/uploads/2017/10/5826.Picture45.png)](https://www.cloudyjourney.fr/wp-content/uploads/2017/10/5826.Picture45.png)

Choisissez le fichier à restaurer:

[![](https://www.cloudyjourney.fr/wp-content/uploads/2017/10/5826.Picture46.png)](https://www.cloudyjourney.fr/wp-content/uploads/2017/10/5826.Picture46.png)

Et où vous souhaitez le restaurer:

[![](https://www.cloudyjourney.fr/wp-content/uploads/2017/10/8540.Picture47.png)](https://www.cloudyjourney.fr/wp-content/uploads/2017/10/8540.Picture47.png)

Après quelques instants, la restauration est terminée.

[![](https://www.cloudyjourney.fr/wp-content/uploads/2017/10/8540.Picture48.png)](https://www.cloudyjourney.fr/wp-content/uploads/2017/10/8540.Picture48.png)

Ce logiciel est très intéréssant pour les entreprises qui souhaitent se séparer des tapes physiques (qui prennent des ressources, de la place, etc.) tout en conservant l’aspect fonctionnel de ce dernier. Le transfert des tapes vers le Cloud est devenu un moyen de faire des économies en conservant toujours la même quantité de stockage avec le même matériel et la même place, tout en conservant les backups sur le long terme.

Encore un super produit fourni par les équipes de Starwind, et qui fonctionne très rapidement, sans bug.

En attendant la même version , mais compatible avec Azure cette fois-ci.
