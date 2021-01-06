---
title: "[AWS] Déployer AWS AD Connector"
date: "2018-01-18"
categories: 
  - "ad-connector"
  - "aws"
tags: 
  - "active-directory"
  - "ad-connector"
  - "aws"
---

[![](https://cloudyjourney.fr/wp-content/uploads/2018/01/2000px-AmazonWebservices_Logo.svg_.png)](https://cloudyjourney.fr/wp-content/uploads/2018/01/2000px-AmazonWebservices_Logo.svg_.png)

Aujourd'hui je vais vous montrer comment intégrer votre Active Directory avec AWS. Ceci est très utile si vous devez gérer des ressources sur Azure et sur AWS. En effet, avec un seul et même compte, vous allez pouvoir vous logguer sur votre ordinateur, sur AWS et sur Azure/Office 365 (avec Azure AD Connect).

Vous devez donc avoir, pour commencer:

- Un Active Directory (sur AWS dans mon cas, mais ceci marche avec un AD OnPrem avec un VPN)
- Un compte de service pour la connexion de AWS
- Un groupe qui contiendra le compte de service précédent
    - Ce groupe doit avoir les permissions **Read (Users and Groups), Create computer objects, Join computer to the domain** sur votre domaine. Plus d'informations [ici](https://docs.aws.amazon.com/directoryservice/latest/admin-guide/prereq_connector.html#connect_delegate_privileges).
- Un groupe qui contiendra les administrateurs de la suscriptions AWS (pour l'exemple)

Assurez vous si votre AD est sur une instance sur AWS, de bien ouvrir les ports suivants sur votre Security group, avec les réseaux que vous allez utiliser pour votre AWS AD Connector:

- TCP/UDP 53 - DNS
- TCP/UDP 88 - Kerberos authentication
- TCP/UDP 389 - LDAP

Dans mon cas, j'ai tout ouvert entre mes 3 sous réseaux:

[![](https://cloudyjourney.fr/wp-content/uploads/2018/01/AWSADConnector01.png)](https://cloudyjourney.fr/wp-content/uploads/2018/01/AWSADConnector01.png)

Vous devez ensuite mettre à jour votre VPC, pour le faire pointer vers vos DNS pour pouvoir intérroger vos contrôleurs de domaines. Ceci ce fait dans la partie **DHCP Options Set** [l'erreur suivante](https://cloudyjourney.fr/2018/01/15/aws-erreur-lors-de-la-creation-dun-ad-connector/) de votre VPC. Si vous ne le faites pas, vous aurez lors de la création de l'AD Connector:

[![](https://cloudyjourney.fr/wp-content/uploads/2018/01/AWSADConnector02.png)](https://cloudyjourney.fr/wp-content/uploads/2018/01/AWSADConnector02.png)

Quand tout est prêt, allez sur [https://console.aws.amazon.com/directoryservice/](https://console.aws.amazon.com/directoryservice/) et cliquez sur **Set up directory > AD Connector:**

[![](https://cloudyjourney.fr/wp-content/uploads/2018/01/AWSADConnector03.png)](https://cloudyjourney.fr/wp-content/uploads/2018/01/AWSADConnector03.png)

Fournissez les détailes suivants:

- Connected directory DNS: Le nom de votre AD
- Connected directory NetBIOS name: Le nom NETBIOS que vous utilisez
- Connector account username: Le compte créé au début, svc-awsadconnector pour moi
- Connector account password: Le mot de passe du compte de service
- Confirm password: Le mot de passe du compte de service
- DNS address: une ou deux adresses DNS qui contiennent les enregistrements des contrôleurs de domaine
- Description: Une description
- Size: La taille de votre organisation, Small est utilisé pour moins de 30000 objects dans l'AD
- VPC: Le VPC où l'AWS AD Connector sera connecté (le même que la VM AWS ou que le VPN)
- Subnets: Les 2 subnets dans 2 availability zones, pour connecter les 2 AD qui seront déployés

[![](https://cloudyjourney.fr/wp-content/uploads/2018/01/AWSADConnector04.png)](https://cloudyjourney.fr/wp-content/uploads/2018/01/AWSADConnector04.png)

Quand c'est terminé, la création démarre:

[![](https://cloudyjourney.fr/wp-content/uploads/2018/01/AWSADConnector05.png)](https://cloudyjourney.fr/wp-content/uploads/2018/01/AWSADConnector05.png)

Après quelques minutes, la connexion est **Active:**

[![](https://cloudyjourney.fr/wp-content/uploads/2018/01/AWSADConnector06.png)](https://cloudyjourney.fr/wp-content/uploads/2018/01/AWSADConnector06.png)

Quand c'est terminé, cliquez sur le **Directory ID**. Créez une URL d'accès pour votre AD Connector pour accéder à AWS avec votre AD Connector et activez la **AWS Management Console:**

[![](https://cloudyjourney.fr/wp-content/uploads/2018/01/AWSADConnector07.png)](https://cloudyjourney.fr/wp-content/uploads/2018/01/AWSADConnector07.png)

Cliquez ensuite sur **AWS Management Console** et cliquez sur **Continue:**

[![](https://cloudyjourney.fr/wp-content/uploads/2018/01/AWSADConnector08.png)](https://cloudyjourney.fr/wp-content/uploads/2018/01/AWSADConnector08.png)

Vous allez être redirigé vers une nouvelle page. Depuis celle ci, vous pouvez change le temps avec l'expiration des sessions. Cliquez sur **click here:**

[![](https://cloudyjourney.fr/wp-content/uploads/2018/01/AWSADConnector09.png)](https://cloudyjourney.fr/wp-content/uploads/2018/01/AWSADConnector09.png)

C'est ici que nous allons créer les rôles qui permettront de donner les droits à des utilisateurs/groupes dans AWS. Dans cet exemple, on va créer un nouveau rôle qui aura pour but d'être administrateur de la suscription AWS. Cliquez sur **Create role:**

[![](https://cloudyjourney.fr/wp-content/uploads/2018/01/AWSADConnector10.png)](https://cloudyjourney.fr/wp-content/uploads/2018/01/AWSADConnector10.png)

Choisissez **AWS service > Directory Service > Next: Permissions:**

[![](https://cloudyjourney.fr/wp-content/uploads/2018/01/AWSADConnector11.png)](https://cloudyjourney.fr/wp-content/uploads/2018/01/AWSADConnector11.png)

Sélectionnez la police **AdministratorAccess:**

[![](https://cloudyjourney.fr/wp-content/uploads/2018/01/AWSADConnector12.png)](https://cloudyjourney.fr/wp-content/uploads/2018/01/AWSADConnector12.png)

Donnez un nom au rôle ainsi qu'une description:

[![](https://cloudyjourney.fr/wp-content/uploads/2018/01/AWSADConnector13.png)](https://cloudyjourney.fr/wp-content/uploads/2018/01/AWSADConnector13.png)

Le nouveau rôle a été créé. cliquez dessus pour assigner un groupe ou un utilisateur:

[![](https://cloudyjourney.fr/wp-content/uploads/2018/01/AWSADConnector14.png)](https://cloudyjourney.fr/wp-content/uploads/2018/01/AWSADConnector14.png)

Cliquez sur **Add** pour rechercher dans l'AD:

[![](https://cloudyjourney.fr/wp-content/uploads/2018/01/AWSADConnector15.png)](https://cloudyjourney.fr/wp-content/uploads/2018/01/AWSADConnector15.png)

Choisissez le groupe/utilisateur que vous souhaitez ajouter au rôle:

[![](https://cloudyjourney.fr/wp-content/uploads/2018/01/AWSADConnector16.png)](https://cloudyjourney.fr/wp-content/uploads/2018/01/AWSADConnector16.png)

J'ai pour ma part ajouté le groupe de mon AD qui contiendra tous les administrateurs de la suscription AWS:

[![](https://cloudyjourney.fr/wp-content/uploads/2018/01/AWSADConnector17.png)](https://cloudyjourney.fr/wp-content/uploads/2018/01/AWSADConnector17.png)

Allez maintenant sur l'URL d'accès que vous avez configuré dans votre AD Connector. Vous devez rentrer votre nom d'utilisateur / mot de passe de votre compte AD qui est dans le groupe qui a été ajouté au role:

[![](https://cloudyjourney.fr/wp-content/uploads/2018/01/AWSADConnector18.png)](https://cloudyjourney.fr/wp-content/uploads/2018/01/AWSADConnector18.png)

Si vous avez les bons droits, vous devriez être logué avec le rôle **AWS\_Admin:**

[![](https://cloudyjourney.fr/wp-content/uploads/2018/01/AWSADConnector19.png)](https://cloudyjourney.fr/wp-content/uploads/2018/01/AWSADConnector19.png)

[![](https://cloudyjourney.fr/wp-content/uploads/2018/01/AWSADConnector20.png)](https://cloudyjourney.fr/wp-content/uploads/2018/01/AWSADConnector20.png)

Cette fonctionnalité est très intéréssante pour limiter le nombre de compte que chaque utilisateur possède.

Ici, avec un seul et même compte, vous pouvez accèder à une multitude de plateforme, à condition d'avoir les droits :)
