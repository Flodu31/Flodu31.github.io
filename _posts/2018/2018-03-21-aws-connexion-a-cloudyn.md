---
title: "[AWS] Connexion à Cloudyn"
date: "2018-03-21"
author: "Florent Appointaire"
permalink: "/2018/03/21/aws-connexion-a-cloudyn"
summary:
categories: 
  - "aws"
tags: 
  - "amazon"
  - "aws"
  - "cloudyn"
---
Après avoir vu [comment déployer Cloudyn pour Azure](https://cloudyjourney.fr/2018/03/07/azure-deploiement-de-cloudyn/), nous allons voir comment connecter notre subscription AWS à Cloudyn. Ce service est gratuit pour Azure mais vous en coûtera 1% de vos dépenses AWS/Google Cloud par an.

Pour commencer, allez dans Cloudyn, dans la partie **Accounts Management** et choisissez **AWS Accounts**. Cliquez sur **Add new** pour ajouter une nouvelle subscription:

[![](https://cloudyjourney.fr/wp-content/uploads/2018/03/CloudynAWS01.png)](https://cloudyjourney.fr/wp-content/uploads/2018/03/CloudynAWS01.png)

Une fenêtre apparait, avec des informations importantes, comme l'**Account ID** et l'**External ID**. Gardez ces informations pour la création du role IAM:

[![](https://cloudyjourney.fr/wp-content/uploads/2018/03/CloudynAWS02.png)](https://cloudyjourney.fr/wp-content/uploads/2018/03/CloudynAWS02.png)

Allez dans votre console AWS, dans la partie **IAM > Roles** et cliquez sur **Create role:**

[![](https://cloudyjourney.fr/wp-content/uploads/2018/03/CloudynAWS03.png)](https://cloudyjourney.fr/wp-content/uploads/2018/03/CloudynAWS03.png)

Choisissez **Another AWS account** et renseignez l'**Account ID** et l'**External ID** que vous avez récupéré auparavant sur Cloudyn:

[![](https://cloudyjourney.fr/wp-content/uploads/2018/03/CloudynAWS04.png)](https://cloudyjourney.fr/wp-content/uploads/2018/03/CloudynAWS04.png)

Sélectionnez le rôle **ReadOnlyAccess**:

[![](https://cloudyjourney.fr/wp-content/uploads/2018/03/CloudynAWS05.png)](https://cloudyjourney.fr/wp-content/uploads/2018/03/CloudynAWS05.png)

Donnez un nom à votre nouveau rôle:

[![](https://cloudyjourney.fr/wp-content/uploads/2018/03/CloudynAWS06.png)](https://cloudyjourney.fr/wp-content/uploads/2018/03/CloudynAWS06.png)

Le rôle a été créé correctement. Cliquez dessus pour l'ouvrir:

[![](https://cloudyjourney.fr/wp-content/uploads/2018/03/CloudynAWS07.png)](https://cloudyjourney.fr/wp-content/uploads/2018/03/CloudynAWS07.png)

Récupérez l'**ARN** que nous allons renseigner dans Cloudyn:

[![](https://cloudyjourney.fr/wp-content/uploads/2018/03/CloudynAWS08.png)](https://cloudyjourney.fr/wp-content/uploads/2018/03/CloudynAWS08.png)

Retournez sur Cloudyn et donnez un nom au compte. Renseignez l'**ARN** que vous avez récupéré juste avant:

[![](https://cloudyjourney.fr/wp-content/uploads/2018/03/CloudynAWS09.png)](https://cloudyjourney.fr/wp-content/uploads/2018/03/CloudynAWS09.png)

Le compte est maintenant enregistré:

[![](https://cloudyjourney.fr/wp-content/uploads/2018/03/CloudynAWS10.png)](https://cloudyjourney.fr/wp-content/uploads/2018/03/CloudynAWS10.png)

Retournez sur Amazon. Vous devez créer un nouveau bucket pour stocker les informations de billing:

[![](https://cloudyjourney.fr/wp-content/uploads/2018/03/CloudynAWS11.png)](https://cloudyjourney.fr/wp-content/uploads/2018/03/CloudynAWS11.png)

Donnez lui un nom et choisissez une région:

[![](https://cloudyjourney.fr/wp-content/uploads/2018/03/CloudynAWS12.png)](https://cloudyjourney.fr/wp-content/uploads/2018/03/CloudynAWS12.png)

Modifiez la police pour votre bucket:

[![](https://cloudyjourney.fr/wp-content/uploads/2018/03/CloudynAWS13.png)](https://cloudyjourney.fr/wp-content/uploads/2018/03/CloudynAWS13.png)

Renseignez les valeurs correspondantes pour les ARN et le nom de compte de votre bucket (6 modifications au total):

```
{ "Version": "2008-10-17", "Id": "Policy1335892530063", "Statement": [ { "Sid": "Stmt1371369161819", "Effect": "Allow", "Principal": { "AWS": "Votre ARN que vous avez créé précédemment" }, "Action": [ "s3:List*", "s3:Get*" ], "Resource": "arn:aws:s3:::Le nom de votre bucket/*" }, { "Sid": "Stmt1335892150622", "Effect": "Allow", "Principal": { "AWS": "l'ARN du compte root qui a accès aux informations de billing" }, "Action": [ "s3:GetBucketAcl", "s3:GetBucketPolicy" ], "Resource": "arn:aws:s3:::Le nom de votre bucket" }, { "Sid": "Stmt1335892526596", "Effect": "Allow", "Principal": { "AWS": "l'ARN du compte root qui a accès aux informations de billing" }, "Action": "s3:PutObject", "Resource": "arn:aws:s3:::Le nom de votre bucket/*" } ] }
```

[![](https://cloudyjourney.fr/wp-content/uploads/2018/03/CloudynAWS14.png)](https://cloudyjourney.fr/wp-content/uploads/2018/03/CloudynAWS14.png)

Une fois terminé, allez dans les préférences du compte, et cochez la case **Receive Billing Reports**. Choisissez le S3 bucket où les rapports seront envoyés. Cliquez sur **Verify** pour vérifier les permissions du compte root sur ce bucket. Si les permissions ne sont pas bonnes, la console vous le fera savoir. Cochez les 4 cases pour envoyer les rapports sur le bucket de façon détaillé, toutes les heures:

[![](https://cloudyjourney.fr/wp-content/uploads/2018/03/CloudynAWS15.png)](https://cloudyjourney.fr/wp-content/uploads/2018/03/CloudynAWS15.png)

Après un certain temps, le statut doit être **Completed**:

[![](https://cloudyjourney.fr/wp-content/uploads/2018/03/CloudynAWS16.png)](https://cloudyjourney.fr/wp-content/uploads/2018/03/CloudynAWS16.png)

Retournez sur votre console Cloudyn 24 heures après, vous devriez avoir des données:

[![](https://cloudyjourney.fr/wp-content/uploads/2018/03/CloudynAWS17.png)](https://cloudyjourney.fr/wp-content/uploads/2018/03/CloudynAWS17.png)

Sélectionnez la partie AWS pour avoir un meilleur filtrage:

[![](https://cloudyjourney.fr/wp-content/uploads/2018/03/CloudynAWS18.png)](https://cloudyjourney.fr/wp-content/uploads/2018/03/CloudynAWS18.png)

Vous devriez maintenant avoir une vue sur le coût et l'utilisation des services:

[![](https://cloudyjourney.fr/wp-content/uploads/2018/03/CloudynAWS19.png)](https://cloudyjourney.fr/wp-content/uploads/2018/03/CloudynAWS19.png)

Super service que nous offre Cloudyn pour avoir une meilleur vue que sur l'interface AWS pour la gestion des coûts :)
