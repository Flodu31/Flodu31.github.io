---
title: "[AWS] Déployer Amazon Connect"
date: "2018-01-22"
categories: 
  - "amazon-connect"
  - "aws"
tags: 
  - "amazon-connect"
  - "aws"
---

[![](https://cloudyjourney.fr/wp-content/uploads/2018/01/2000px-AmazonWebservices_Logo.svg_.png)](https://cloudyjourney.fr/wp-content/uploads/2018/01/2000px-AmazonWebservices_Logo.svg_.png)

 

Etant en train de déployer un call center pour la nouvelle société dans laquel je travaille, nous avons décider d'utiliser Amazon Connect pour sa simplicité (workflow, permissions, etc.) et son tarif plutôt abordable. Pour faire ceci, assurez vous d'avoir déployé la partie [Amazon AD Connector](https://cloudyjourney.fr/2018/01/18/aws-deployer-aws-ad-connector/).

Dans votre portail AWS, allez dans **Services > Customer Engagement > Amazon Connect** et cliquez sur **Add an instance:**

[![](https://cloudyjourney.fr/wp-content/uploads/2018/01/AWSConnect001.png)](https://cloudyjourney.fr/wp-content/uploads/2018/01/AWSConnect001.png)

Cliquez sur **Link to an existing directory** et choisissez le AWS AD Connector que vous avez créé précédemment:

[![](https://cloudyjourney.fr/wp-content/uploads/2018/01/AWSConnect01.png)](https://cloudyjourney.fr/wp-content/uploads/2018/01/AWSConnect01.png)

Vous pouvez ensuite ajouter un administrateur :

[![](https://cloudyjourney.fr/wp-content/uploads/2018/01/AWSConnect02.png)](https://cloudyjourney.fr/wp-content/uploads/2018/01/AWSConnect02.png)

Choisissez ensuite si vous souhaitez autoriser les appels entrant (ce qui devrait être le cas :) ) et si vous pouvez appeler via AWS Connect vers des numéros externes:

[![](https://cloudyjourney.fr/wp-content/uploads/2018/01/AWSConnect03.png)](https://cloudyjourney.fr/wp-content/uploads/2018/01/AWSConnect03.png)

Vous avez ensuite des informations concernant le stockage des logs, des workflows, etc. :

[![](https://cloudyjourney.fr/wp-content/uploads/2018/01/AWSConnect04.png)](https://cloudyjourney.fr/wp-content/uploads/2018/01/AWSConnect04.png)

Vérifiez les informations que vous avez rentré et lancez la création de l'instance. Vous pouvez copier l'adresse **Access URL** qui vous permettra d'accéder à la console Amazon Connect:

[![](https://cloudyjourney.fr/wp-content/uploads/2018/01/AWSConnect05.png)](https://cloudyjourney.fr/wp-content/uploads/2018/01/AWSConnect05.png)

L'instance est en cours de création:

[![](https://cloudyjourney.fr/wp-content/uploads/2018/01/AWSConnect06.png)](https://cloudyjourney.fr/wp-content/uploads/2018/01/AWSConnect06.png)

Quand la création est terminée, cliquez sur **Get started** pour lancer la console Amazon Connect:

[![](https://cloudyjourney.fr/wp-content/uploads/2018/01/AWSConnect07.png)](https://cloudyjourney.fr/wp-content/uploads/2018/01/AWSConnect07.png)

Vous voici maintenant sur la page d'accueil. cliquez sur **Let's go** pour acquérir un numéro sur lequel les utilisateurs pourront appeler:

[![](https://cloudyjourney.fr/wp-content/uploads/2018/01/AWSConnect08.png)](https://cloudyjourney.fr/wp-content/uploads/2018/01/AWSConnect08.png)

Choisissez le pays et un numéro, pré défini par AWS. Si vous souhaitez un numéro comme les téléphones fixes (DID (Direct Inward Dialing)), vous devez ouvrir un ticket auprès du support, et ils accepteront après leur avoir fourni l'adresse d'un bureau dans le pays concerné, plus votre identifiant ARN, que vous pouvez trouver dans **Amazon Connect > Votre Instance > Overview > Instance ARN:**

[![](https://cloudyjourney.fr/wp-content/uploads/2018/01/AWSConnect09.png)](https://cloudyjourney.fr/wp-content/uploads/2018/01/AWSConnect09.png)

Quand c'est terminé, vous pouvez appeler sur ce numéro, et vous serez redirigé vers un workflow déjà défini:

[![](https://cloudyjourney.fr/wp-content/uploads/2018/01/AWSConnect10.png)](https://cloudyjourney.fr/wp-content/uploads/2018/01/AWSConnect10.png)

C'est tout pour le moment, dans le prochain article, nous verrons comment créer notre premier workflow, et ainsi, recevoir des appels de nos clients :)
