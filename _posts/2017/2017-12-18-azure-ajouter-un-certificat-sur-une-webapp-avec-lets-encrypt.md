---
title: "[Azure] Ajouter un certificat sur une WebApp avec Let's Encrypt"
date: "2017-12-18"
author: "Florent Appointaire"
permalink: "/2017/12/18/azure-ajouter-un-certificat-sur-une-webapp-avec-lets-encrypt/"
summary:
categories: 
  - "azure"
  - "azure-web-apps"
tags: 
  - "app-service-plan"
  - "lets-encrypt"
  - "microsoft"
  - "web-app"
---
Aujourd'hui, j'ai voulu passer mon site qui est hébergé sur une WebApp Azure, en HTTPS. Le seul souci, le prix d'un certificat. Je vous ai déjà parlé de Let's Encrypt plusieurs fois, mais aujourd'hui, j'ai découvert qu'il était possible d'intégrer Let'S Encrypt avec votre site web et de renouveler le certificat automatiquement, car, avec Let's Encrypt, les certificats ne sont valables que 3 mois.

Pour commencer, assurez vous d'avoir un App Service Plan qui support le SSL:

[![](https://cloudyjourney.fr/wp-content/uploads/2018/01/3823.pastedimage1513244517637v2.png)](https://cloudyjourney.fr/wp-content/uploads/2018/01/3823.pastedimage1513244517637v2.png)

Un nom DNS personnalisé doit également être enregistré.

Pour automatiser la création des certificats, nous allons avoir besoin d'un compte de stockage. Créez en un, puis récupérez la connection string. Dans votre WebApp, dans **Application Settings,** ajoutez dans la partie **App Settings**, les 2 noms suivants, avec comme valeur, la connection string que vous avez récupéré auparavant:

- AzureWebJobsStorage
- AzureWebJobsDashboard

[![](https://cloudyjourney.fr/wp-content/uploads/2018/01/1374.pastedimage1513244660385v3.png)](https://cloudyjourney.fr/wp-content/uploads/2018/01/1374.pastedimage1513244660385v3.png)

Il faut ensuite enregistrer une application dans notre Azure AD, qui aura les droits pour modifier la WebApp. Pour faire ceci, dans votre Azure AD, allez dans la partie **App Registrations** et cliquez sur **New application registration:**

[![](https://cloudyjourney.fr/wp-content/uploads/2018/01/1374.pastedimage1513244861924v4.png)](https://cloudyjourney.fr/wp-content/uploads/2018/01/1374.pastedimage1513244861924v4.png)

Donnez lui un nom, choisissez le type **Web app / API** et donnez une URL, qui existe ou pas:

[![](https://cloudyjourney.fr/wp-content/uploads/2018/01/5008.pastedimage1513244940752v5.png)](https://cloudyjourney.fr/wp-content/uploads/2018/01/5008.pastedimage1513244940752v5.png)

Récupérez l'**Application ID,** nous en aurons besoin par la suite:

[![](https://cloudyjourney.fr/wp-content/uploads/2018/01/5008.pastedimage1513245001681v6.png)](https://cloudyjourney.fr/wp-content/uploads/2018/01/5008.pastedimage1513245001681v6.png)

Cliquez maintenant sur la partie **Keys** et générez une nouvelle clé. Cliquez sur **Save** et copiez bien la clé qui va apparaître. Il ne sera pas possible de la récupérer par la suite:

[![](https://cloudyjourney.fr/wp-content/uploads/2018/01/8713.pastedimage1513245057274v7.png)](https://cloudyjourney.fr/wp-content/uploads/2018/01/8713.pastedimage1513245057274v7.png)

Allez maintenant sur votre suscription, dans la partie **Access control (IAM)** et ajoutez l'application que vous avez créé comme **Contributor** de la suscription:

[![](https://cloudyjourney.fr/wp-content/uploads/2018/01/6165.pastedimage1513245196508v8.png)](https://cloudyjourney.fr/wp-content/uploads/2018/01/6165.pastedimage1513245196508v8.png)

Vous pouvez également créer l'application avec le script PowerShell suivant:

`$uri = 'http://falaconsulting.be'` `$password = 'UnMotDeP@ss€'` `$app = New-AzureRmADApplication -DisplayName "FALAConsulting" -HomePage $uri -IdentifierUris $uri -Password $password` `New-AzureRmADServicePrincipal -ApplicationId $app.ApplicationId` `New-AzureRmRoleAssignment -RoleDefinitionName Contributor -ServicePrincipalName $app.ApplicationId`

Maintenant, allez sur [https://votresiteweb.scm.azurewebsites.net](https://votresiteweb.scm.azurewebsites.net/) puis cliquez sur **Site extensions > Gallery** et faites une recherche **Azure Let's Encrypt**. Vous allez avoir 2 résultats. Installez le version qui correspond à l'architecture de votre site. Vous pouvez vérifier ceci dans la partie **Application settings** de votre site:

[![](https://cloudyjourney.fr/wp-content/uploads/2018/01/1778.pastedimage1513245451691v10.png)](https://cloudyjourney.fr/wp-content/uploads/2018/01/1778.pastedimage1513245451691v10.png)

Etant en 64 bits, je vais installer la version x64 du plugin Let's Encrypt:

[![](https://cloudyjourney.fr/wp-content/uploads/2018/01/4503.pastedimage1513245374894v9.png)](https://cloudyjourney.fr/wp-content/uploads/2018/01/4503.pastedimage1513245374894v9.png)

Cliquez sur le logo **Play**. Si vous arrivez sur une page avec le message d'erreur suivant:

[![](https://cloudyjourney.fr/wp-content/uploads/2018/01/4503.pastedimage1513245567953v11.png)](https://cloudyjourney.fr/wp-content/uploads/2018/01/4503.pastedimage1513245567953v11.png)

Allez sur votre WebApp et cliquez sur **Stop/Start:**

[![](https://cloudyjourney.fr/wp-content/uploads/2018/01/2845.pastedimage1513245610243v12.png)](https://cloudyjourney.fr/wp-content/uploads/2018/01/2845.pastedimage1513245610243v12.png)

Relancez la page. Vous arrivez sur une page qui va vous demander plusieurs informations:

- Tenant : le nom de votre Azure AD
- Subscription Id : le numéro de votre suscription où se trouve votre WebApp
- ClientId : le numéro de l'application id que vous avez récupéré précédemment
- ClientSecret : le mot de passe que vous avez récupéré lors de la création de votre application
- ResourceGroupName : le nom du groupe de ressource où la WebApp est hébergé
- ServicePlanResourceGroupName : le nom du groupe de ressource où le Service Plan est hébergé

[![](https://cloudyjourney.fr/wp-content/uploads/2018/01/2845.pastedimage1513245774453v13.png)](https://cloudyjourney.fr/wp-content/uploads/2018/01/2845.pastedimage1513245774453v13.png)

Validez. Une fois terminé, vous devriez être redirigé vers une nouvelle page, qui recense les différents domaines attachés à la WebApp:

[![](https://cloudyjourney.fr/wp-content/uploads/2018/01/6560.pastedimage1513246063826v14.png)](https://cloudyjourney.fr/wp-content/uploads/2018/01/6560.pastedimage1513246063826v14.png)

Cliquez sur **Next.** Choisissez le domaine pour lequel vous souhaitez créer le certificat. Attention, si vous avez plusieurs domaines, vous allez devoir répeter cette opération plusieurs fois. Renseignez votre mail et cliquez sur **Request and Install the Certificate:**

[![](https://cloudyjourney.fr/wp-content/uploads/2018/01/6560.pastedimage1513246092285v15.png)](https://cloudyjourney.fr/wp-content/uploads/2018/01/6560.pastedimage1513246092285v15.png)

Le certificat a bien été créé et associé au site:

[![](https://cloudyjourney.fr/wp-content/uploads/2018/01/4011.pastedimage1513246213739v17.png)](https://cloudyjourney.fr/wp-content/uploads/2018/01/4011.pastedimage1513246213739v17.png)

Si je vais sur mon site, je vois que mon certificat est bien associé:

[![](https://cloudyjourney.fr/wp-content/uploads/2018/01/4011.pastedimage1513246233525v18.png)](https://cloudyjourney.fr/wp-content/uploads/2018/01/4011.pastedimage1513246233525v18.png)

Pour que le renouvellement automatique du certificat se fasse, nous devons, dans la partie **Application settings**, activer la partie **Always On:**

[![](https://cloudyjourney.fr/wp-content/uploads/2018/01/7635.pastedimage1513246729299v19.png)](https://cloudyjourney.fr/wp-content/uploads/2018/01/7635.pastedimage1513246729299v19.png)

Allez ensuite dans la partie **Web Jobs**. Le status du job Let's Encrypt devrait être sur **Running:**

[![](https://cloudyjourney.fr/wp-content/uploads/2018/01/7635.pastedimage1513246801830v20.png)](https://cloudyjourney.fr/wp-content/uploads/2018/01/7635.pastedimage1513246801830v20.png)

Si vous cliquez sur le bouton **Logs**, vous allez être redirigé vers une page, qui contiendra tous les logs de votre WebApp. Ceci est pratique pour suivre le status du renouvellement de vos certificats:

[![](https://cloudyjourney.fr/wp-content/uploads/2018/01/2450.pastedimage1513246904851v21.png)](https://cloudyjourney.fr/wp-content/uploads/2018/01/2450.pastedimage1513246904851v21.png)

Voici donc une manière de protéger les communications entre le client et le site web, de façon simple et pas cher :)
