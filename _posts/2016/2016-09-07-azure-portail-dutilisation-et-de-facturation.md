---
title: "[Azure] Portail d’utilisation et de facturation"
date: "2016-09-07"
author: "Florent Appointaire"
permalink: "/2016/09/07/azure-portail-dutilisation-et-de-facturation/"
summary: 
categories: 
  - "azure"
tags: 
  - "azure"
  - "billing"
  - "microsoft"
---
Microsoft a rendu disponible le 14 Juillet un portail qui vous permet d’afficher, via des graphiques, l’utilisation et la facturation de votre suscription Azure (annonce: [https://azure.microsoft.com/en-us/blog/announcing-the-release-of-the-azure-usage-and-billing-portal/](https://azure.microsoft.com/en-us/blog/announcing-the-release-of-the-azure-usage-and-billing-portal/ "https://azure.microsoft.com/en-us/blog/announcing-the-release-of-the-azure-usage-and-billing-portal/")).

Après quelques jours de vacances, j’ai enfin décidé de tester cette platform.

Pour commencer, vous devez avoir les prérequis suivants installés:

- Azure PowerShell: [https://azure.microsoft.com/en-us/documentation/articles/powershell-install-configure/](https://azure.microsoft.com/en-us/documentation/articles/powershell-install-configure/ "https://azure.microsoft.com/en-us/documentation/articles/powershell-install-configure/")
- PowerBI Desktop: [https://powerbi.microsoft.com/en-us/desktop/](https://powerbi.microsoft.com/en-us/desktop/ "https://powerbi.microsoft.com/en-us/desktop/")
- Visual Studio 2015: [https://www.visualstudio.com/en-us/downloads/download-visual-studio-vs.aspx](https://www.visualstudio.com/en-us/downloads/download-visual-studio-vs.aspx "https://www.visualstudio.com/en-us/downloads/download-visual-studio-vs.aspx")

Nous allons maintenant télécharger les sources du projet qui se trouvent sur GitHub: [https://github.com/Microsoft/AzureUsageAndBillingPortal](https://github.com/Microsoft/AzureUsageAndBillingPortal "https://github.com/Microsoft/AzureUsageAndBillingPortal")

[![](https://cloudyjourney.fr/wp-content/uploads/2018/01/image_396E4A0D.png)](https://cloudyjourney.fr/wp-content/uploads/2018/01/image_396E4A0D.png)

Et, décompressez l’archive:

[![](https://cloudyjourney.fr/wp-content/uploads/2018/01/image_1D601BD3.png)](https://cloudyjourney.fr/wp-content/uploads/2018/01/image_1D601BD3.png)

Ouvrez maintenant ISE en tant qu’administrateur, et ouvrez le script PowerShell **CreateAzureServicesScript.ps1** qui se trouve dans **Folder\\AzureUsageAndBillingPortal-master\\Scripts**. Déplacez vous vers le chemin qui contient le script (et le fichier json qui servira au déploiement) (1). Renseignez ensuite le nom de votre suscription Azure où vous souhaitez déployer les ressources (2). Et enfin, choisissez un nom unique pour le suffixe de votre déploiement (3). Unique car il sera utilisé pour le nom de votre stockage:

[![](https://cloudyjourney.fr/wp-content/uploads/2018/01/image_3B413085.png)](https://cloudyjourney.fr/wp-content/uploads/2018/01/image_3B413085.png)

Si vous souhaitez modifier les différentes valeurs comme le nom d’utilisateur de SQL, etc, c’est tout à fait possible, les variables sont à la suite. Exécutez le script et connectez vous au service Azure. Une fois le script terminé, vous devriez avoir une page avec plein d’informations. Surtout, ne la fermez pas. Ces informations, nous allons les utiliser pour mettre à jour les fichiers **Web.config** et **App.config** de notre solution:

[![](https://cloudyjourney.fr/wp-content/uploads/2018/01/image_167A8528.png)](https://cloudyjourney.fr/wp-content/uploads/2018/01/image_167A8528.png)

Ouvrez maintenant Visual Studio 2015 et ouvrez le projet/solution que vous avez téléchargez:

[![](https://cloudyjourney.fr/wp-content/uploads/2018/01/image_69F3E5F2.png)](https://cloudyjourney.fr/wp-content/uploads/2018/01/image_69F3E5F2.png)

Ouvrez les fichiers **Web.config** qui se trouvent sous **Dashboard** et **Registration:**

[![](https://cloudyjourney.fr/wp-content/uploads/2018/01/image_4EBE1DA2.png)](https://cloudyjourney.fr/wp-content/uploads/2018/01/image_4EBE1DA2.png)

Faites de même pour le fichier **App.config** qui se trouve dans **WebJobBillingData** et **WebJobUsageDaily:**

[![](https://cloudyjourney.fr/wp-content/uploads/2018/01/image_08CF7B33.png)](https://cloudyjourney.fr/wp-content/uploads/2018/01/image_08CF7B33.png)

Nous allons mettre à jour ces fichiers avec les données que vous avez récupéré dans le script PowerShell. Copiez tout ce qui se trouve en rouge dans le script. Faites ceci sur les 4 fichiers:

- **AzureWebJobsDashboard** correspond à **AzureWebJobsDashboard** dans le script PowerShell
- **AzureWebJobsStorage** correspond à **AzureWebJobsStorage** dans le script PowerShell

[![](https://cloudyjourney.fr/wp-content/uploads/2018/01/image_6A8754ED.png)](https://cloudyjourney.fr/wp-content/uploads/2018/01/image_6A8754ED.png)

Pour la partie SQL, **ASQLConn** correspond à **ASQLConn ConnectionString** dans le script PowerShell. Modifiez les 4 fichiers en faisant bien attention à avoir la partie **providerName** à chaque fois:

[![](https://cloudyjourney.fr/wp-content/uploads/2018/01/SNAGHTML1434c30d_302E6FBD.png)](https://cloudyjourney.fr/wp-content/uploads/2018/01/SNAGHTML1434c30d_302E6FBD.png)

Faites de même pour les valeurs suivantes, dans chaque fichier, quand c’est nécessaire:

- **ida:ClientId** correspond à **ida:ClientID** dans la sortie du script PowerShell
- **ida:Password** correspond à **ida:Password** dans la sortie du script PowerShell
- **ida:TenantId** correspond à **ida:TenantId** dans la sortie du script PowerShell
- **ida:PostLogoutRedirectUri** correspond à **ida:PostLogoutRedirectUri** dans la sortie du script PowerShell

[![](https://cloudyjourney.fr/wp-content/uploads/2018/01/image_064DFB88.png)](https://cloudyjourney.fr/wp-content/uploads/2018/01/image_064DFB88.png)

[![](https://cloudyjourney.fr/wp-content/uploads/2018/01/image_5A9FC23C.png)](https://cloudyjourney.fr/wp-content/uploads/2018/01/image_5A9FC23C.png)

[![](https://cloudyjourney.fr/wp-content/uploads/2018/01/image_252990C8.png)](https://cloudyjourney.fr/wp-content/uploads/2018/01/image_252990C8.png)

[![](https://cloudyjourney.fr/wp-content/uploads/2018/01/image_5D6A9891.png)](https://cloudyjourney.fr/wp-content/uploads/2018/01/image_5D6A9891.png)

Nous allons reconstruire la solution, avec les modifications apportées. Sur le projet, faites un clique droit et sélectionnez **Rebuild Solution:**

[![](https://cloudyjourney.fr/wp-content/uploads/2018/01/image_52CC2A1A.png)](https://cloudyjourney.fr/wp-content/uploads/2018/01/image_52CC2A1A.png)

Après quelques secondes, la reconstruction doit être terminée, sans erreur. Si vous en avez, vérifiez bien que vous n’ayez pas modifier les fichiers de configuration ou qu’il ne manque pas de guillemet, slash, etc. :

[![](https://cloudyjourney.fr/wp-content/uploads/2018/01/image_22A4DF57.png)](https://cloudyjourney.fr/wp-content/uploads/2018/01/image_22A4DF57.png)

Nous allons publier chaque site (**Dashboard** et **Registration**) sur les 2 sites qui ont été crées lors de l’exécution du script PowerShell. Cliquez droit sur **Dashboard** et sélectionnez **Publish…:**

[![](https://cloudyjourney.fr/wp-content/uploads/2018/01/image_11C2CC18.png)](https://cloudyjourney.fr/wp-content/uploads/2018/01/image_11C2CC18.png)

Sélectionnez ensuite **Microsoft Azure Web Apps**:

[![](https://cloudyjourney.fr/wp-content/uploads/2018/01/image_612F4E5F.png)](https://cloudyjourney.fr/wp-content/uploads/2018/01/image_612F4E5F.png)

Etant donné que l’on souhaite publier le site **Dashboard,** sélectionnez le site qui contient le mot Dashboard:

[![](https://cloudyjourney.fr/wp-content/uploads/2018/01/image_15CFAA9B.png)](https://cloudyjourney.fr/wp-content/uploads/2018/01/image_15CFAA9B.png)

Validez la combinaison Login/Password:

[![](https://cloudyjourney.fr/wp-content/uploads/2018/01/image_1C82B41E.png)](https://cloudyjourney.fr/wp-content/uploads/2018/01/image_1C82B41E.png)

Sur la page suivante, cochez les 2 cases suivantes:

[![](https://cloudyjourney.fr/wp-content/uploads/2018/01/image_4BAFE2FA.png)](https://cloudyjourney.fr/wp-content/uploads/2018/01/image_4BAFE2FA.png)

Sélectionnez ensuite la chaine de connexion à SQL, pour la partie **DataAccess (ASQLConn):**

[![](https://cloudyjourney.fr/wp-content/uploads/2018/01/image_549F7539.png)](https://cloudyjourney.fr/wp-content/uploads/2018/01/image_549F7539.png)

Et décochez la case:

[![](https://cloudyjourney.fr/wp-content/uploads/2018/01/image_01B6F2B9.png)](https://cloudyjourney.fr/wp-content/uploads/2018/01/image_01B6F2B9.png)

Cliquez sur **Publish.** Une fois le déploiement terminé, IE devrait s’ouvrir avec la page suivante:

[![](https://cloudyjourney.fr/wp-content/uploads/2018/01/image_23A2553D.png)](https://cloudyjourney.fr/wp-content/uploads/2018/01/image_23A2553D.png)

Fermez la fenêtre. Faites de même pour le 2ème site, **Registration**. Sélectionnez le bon site sur lequel l’application doit être déployée:

[![](https://cloudyjourney.fr/wp-content/uploads/2018/01/image_713E81BD.png)](https://cloudyjourney.fr/wp-content/uploads/2018/01/image_713E81BD.png)

[![](https://cloudyjourney.fr/wp-content/uploads/2018/01/image_25DEDDF9.png)](https://cloudyjourney.fr/wp-content/uploads/2018/01/image_25DEDDF9.png)

[![](https://cloudyjourney.fr/wp-content/uploads/2018/01/image_39F7FA82.png)](https://cloudyjourney.fr/wp-content/uploads/2018/01/image_39F7FA82.png)

Le 2ème site est disponible:

[![](https://cloudyjourney.fr/wp-content/uploads/2018/01/image_2DF60A4E.png)](https://cloudyjourney.fr/wp-content/uploads/2018/01/image_2DF60A4E.png)

Fermez la fenêtre. Depuis Visual Studio, nous allons déployer le WebJob **BillingData**. Faites un clique droit dessus et sélectionnez **Publish as Azure WebJob…:**

[![](https://cloudyjourney.fr/wp-content/uploads/2018/01/image_352D4033.png)](https://cloudyjourney.fr/wp-content/uploads/2018/01/image_352D4033.png)

Déployez le sur le site Dashboard:

[![](https://cloudyjourney.fr/wp-content/uploads/2018/01/image_06D64B37.png)](https://cloudyjourney.fr/wp-content/uploads/2018/01/image_06D64B37.png)

[![](https://cloudyjourney.fr/wp-content/uploads/2018/01/image_3B76A772.png)](https://cloudyjourney.fr/wp-content/uploads/2018/01/image_3B76A772.png)

Faites de même pour **WebJobUsageDaily,** également sur le site Dashboard. Allez maintenant sur votre Azure AD, dans la partie **Applications** et sélectionnez **Azure Usage and Billing Portal** puis allez dans **Configurer.** Copiez l’URL de connexion**:**

[![](https://cloudyjourney.fr/wp-content/uploads/2018/01/image_10FF60A6.png)](https://cloudyjourney.fr/wp-content/uploads/2018/01/image_10FF60A6.png)

Activez l’hébergement mutualisée  et cliquez sur **Enregistrer:**

[![](https://cloudyjourney.fr/wp-content/uploads/2018/01/image_4BE6936F.png)](https://cloudyjourney.fr/wp-content/uploads/2018/01/image_4BE6936F.png)

Collez l’url du site dans l’URL de réponse puis cliquez sur **Ajouter une application:**

[![](https://cloudyjourney.fr/wp-content/uploads/2018/01/image_6DD1F5F3.png)](https://cloudyjourney.fr/wp-content/uploads/2018/01/image_6DD1F5F3.png)

Sélectionnez dans la nouvelle page **Windows Azure Service Management API**:

[![](https://cloudyjourney.fr/wp-content/uploads/2018/01/image_0FBD5878.png)](https://cloudyjourney.fr/wp-content/uploads/2018/01/image_0FBD5878.png)

Ajoutez une nouvelle application et sélectionnez **Windows Azure Active Directory**:

[![](https://cloudyjourney.fr/wp-content/uploads/2018/01/image_594F3726.png)](https://cloudyjourney.fr/wp-content/uploads/2018/01/image_594F3726.png)

Pour la partie **Windows Azure Service Management API,** sélectionnez comme autorisation déléguée, **Access Azure Service Management as organisation…:**

[![](https://cloudyjourney.fr/wp-content/uploads/2018/01/image_6AB9D682.png)](https://cloudyjourney.fr/wp-content/uploads/2018/01/image_6AB9D682.png)

Pour la partie **Windows Azure Active Directory,** sélectionnez **Sign in and read user profile:**

[![](https://cloudyjourney.fr/wp-content/uploads/2018/01/image_716CE005.png)](https://cloudyjourney.fr/wp-content/uploads/2018/01/image_716CE005.png)

Cliquez sur enregistrer. Retournez dans Visual Studio et ouvrez dans **Scripts, SqlScripts.sql:**

[![](https://cloudyjourney.fr/wp-content/uploads/2018/01/SNAGHTML145dc279_40EB02C6.png)](https://cloudyjourney.fr/wp-content/uploads/2018/01/SNAGHTML145dc279_40EB02C6.png)

Cliquez sur l’icone suivant pour vous connecter à un serveur SQL via Visual Studio:

[![](https://cloudyjourney.fr/wp-content/uploads/2018/01/image_02F17208.png)](https://cloudyjourney.fr/wp-content/uploads/2018/01/image_02F17208.png)

Choisissez Azure et sélectionnez le serveur SQL dans Azure, qui a été créé par le script. Remplissez le champ **Password** avec la valeur de **ida:Password** dans le script PowerShell:

[![](https://cloudyjourney.fr/wp-content/uploads/2018/01/image_19B34A42.png)](https://cloudyjourney.fr/wp-content/uploads/2018/01/image_19B34A42.png)

Exécutez la requête SQL:

[![](https://cloudyjourney.fr/wp-content/uploads/2018/01/image_502B5157.png)](https://cloudyjourney.fr/wp-content/uploads/2018/01/image_502B5157.png)

Elle a été exécutée correctement:

[![](https://cloudyjourney.fr/wp-content/uploads/2018/01/image_4BB4D090.png)](https://cloudyjourney.fr/wp-content/uploads/2018/01/image_4BB4D090.png)

Il est maintenant temps d’enregistrer notre suscription Azure, pour que l’on puisse remplir la base de données avec les valeurs. Allez sur le site web concernant l’enregistrement, dans mon cas [http://auiregistrationfa123.azurewebsites.net/](http://auiregistrationfa123.azurewebsites.net/ "http://auiregistrationfa123.azurewebsites.net/"). Choisissez l’option 2 et donnez le nom de votre domaine Azure AD, que vous souhaitez voir dans l’application:

[![](https://cloudyjourney.fr/wp-content/uploads/2018/01/image_7F7CC6E1.png)](https://cloudyjourney.fr/wp-content/uploads/2018/01/image_7F7CC6E1.png)

Donnez un nom qui permettra d’identifier plus facilement la suscription et cliquez sur **Allow Monitoring:**

[![](https://cloudyjourney.fr/wp-content/uploads/2018/01/image_5A7944EC.png)](https://cloudyjourney.fr/wp-content/uploads/2018/01/image_5A7944EC.png)

La suscription a bien été enregistrée:

[![](https://cloudyjourney.fr/wp-content/uploads/2018/01/image_2815716D.png)](https://cloudyjourney.fr/wp-content/uploads/2018/01/image_2815716D.png)

Il est maintenant temps d’ouvrir PowerBI pour afficher des jolies graphiques ![Sourire](http://microsofttouch.fr/cfs-file/__key/communityserver-blogs-components-weblogfiles/00-00-00-00-69-metablogapi/wlEmoticon_2D00_smile_5F00_0AA32061.png) Ouvrez la vue préconstruite qui se trouve dans le dossier que vous avez extrait, dans **PowerBI:**

[![](https://cloudyjourney.fr/wp-content/uploads/2018/01/image_3C9AC0EB.png)](https://cloudyjourney.fr/wp-content/uploads/2018/01/image_3C9AC0EB.png)

Vous n’avez rien pour le moment, et c’est normal. Le Template de base ne connait aucune information sur votre environnement. Cliquez sur **Edit Queries:**

[![](https://cloudyjourney.fr/wp-content/uploads/2018/01/image_4E43FE42.png)](https://cloudyjourney.fr/wp-content/uploads/2018/01/image_4E43FE42.png)

Dans la nouvelle page, cliquez sur **Data Source Settings > Clear permissions > Clear Permissions:**

[![](https://cloudyjourney.fr/wp-content/uploads/2018/01/image_5FB6EFCB.png)](https://cloudyjourney.fr/wp-content/uploads/2018/01/image_5FB6EFCB.png)

Cliquez ensuite sur **Change Source…** pour donner les informations concernant notre serveur SQL:

[![](https://cloudyjourney.fr/wp-content/uploads/2018/01/image_31CC2DC4.png)](https://cloudyjourney.fr/wp-content/uploads/2018/01/image_31CC2DC4.png)

Vous trouverez le nom du serveur et de la base de données directement dans le script PowerShell. Cliquez sur **OK**:

[![](https://cloudyjourney.fr/wp-content/uploads/2018/01/image_3CF848BF.png)](https://cloudyjourney.fr/wp-content/uploads/2018/01/image_3CF848BF.png)

Cliquez ensuite sur **Edit Permissions…** pour donner le nom d’utilisateur/mot de passe pour accéder à la base de données:

[![](https://cloudyjourney.fr/wp-content/uploads/2018/01/image_47866CEB.png)](https://cloudyjourney.fr/wp-content/uploads/2018/01/image_47866CEB.png)

Cliquez sur **Edit** et donnez le nom d’utilisateur et le mot de passe, que vous pouvez trouve dans le script PowerShell également et sauvegardez:

[![](https://cloudyjourney.fr/wp-content/uploads/2018/01/image_1522996C.png)](https://cloudyjourney.fr/wp-content/uploads/2018/01/image_1522996C.png)

Fermez la page **Data Source Settings.** Cliquez sur **Refresh Preview.** Des données devraient apparaître:

[![](https://cloudyjourney.fr/wp-content/uploads/2018/01/SNAGHTML146ff8a4_70910BE7.png)](https://cloudyjourney.fr/wp-content/uploads/2018/01/SNAGHTML146ff8a4_70910BE7.png)

[![](https://cloudyjourney.fr/wp-content/uploads/2018/01/image_7BBD26E2.png)](https://cloudyjourney.fr/wp-content/uploads/2018/01/image_7BBD26E2.png)

Cliquez droit sur **AzureUsageRecords** dans la colonne des **Queries** et cochez **Enable Load:**

[![](https://cloudyjourney.fr/wp-content/uploads/2018/01/image_0A1DBA77.png)](https://cloudyjourney.fr/wp-content/uploads/2018/01/image_0A1DBA77.png)

Sélectionnez **Close & Apply:**

[![](https://cloudyjourney.fr/wp-content/uploads/2018/01/image_57B9E6F7.png)](https://cloudyjourney.fr/wp-content/uploads/2018/01/image_57B9E6F7.png)

[![](https://cloudyjourney.fr/wp-content/uploads/2018/01/image_3A4795EB.png)](https://cloudyjourney.fr/wp-content/uploads/2018/01/image_3A4795EB.png)

Vous devriez avoir ceci:

[![](https://cloudyjourney.fr/wp-content/uploads/2018/01/image_130D4CB6.png)](https://cloudyjourney.fr/wp-content/uploads/2018/01/image_130D4CB6.png)

Vous pouvez compléter les 3 croix avec d’autres informations si vous le souhaitez. Cliquez sur le cadre de gauche (1) puis dans les **Fields (2),** cliquez droit sur **AzureUsageRecords** et sélectionnez **New measure (3):**

[![](https://cloudyjourney.fr/wp-content/uploads/2018/01/image_52015E02.png)](https://cloudyjourney.fr/wp-content/uploads/2018/01/image_52015E02.png)

Ecrivez la requête suivante dans la barre du haut (1):

> NumberOfSubscriptions = DISTINCTION(AzureUsageRecords\[DisaplyTag\])

Puis, sélectionnez **NumberOfSubscriptions (2)** et déplacez le dans **Fields (3):**

[![](https://cloudyjourney.fr/wp-content/uploads/2018/01/image_2186712F.png)](https://cloudyjourney.fr/wp-content/uploads/2018/01/image_2186712F.png)

Voici un Dashboard complet:

[![](https://cloudyjourney.fr/wp-content/uploads/2018/01/image_211CCEEB.png)](https://cloudyjourney.fr/wp-content/uploads/2018/01/image_211CCEEB.png)

[![](https://cloudyjourney.fr/wp-content/uploads/2018/01/image_70895132.png)](https://cloudyjourney.fr/wp-content/uploads/2018/01/image_70895132.png)

Cette nouvelle fonctionnalité est très intéressante, pour avoir un aperçu rapide des consommations pour une ou plusieurs suscriptions. C’est également très intéressant pour les managers qui doivent faire des rapports :)
