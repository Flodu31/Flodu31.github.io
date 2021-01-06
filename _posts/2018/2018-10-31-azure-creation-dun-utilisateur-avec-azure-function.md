---
title: "[Azure] Création d'un utilisateur avec Azure Function"
date: "2018-10-31"
categories: 
  - "azure-web-apps"
tags: 
  - "azure"
  - "azure-function"
  - "flow"
  - "list"
  - "microsoft"
  - "powerapps"
  - "sharepoint"
  - "web-app"
---

[![](https://cloudyjourney.fr/wp-content/uploads/2018/10/AzureFunction_Logo.png)](https://cloudyjourney.fr/wp-content/uploads/2018/10/AzureFunction_Logo.png)

Dans les 3 prochains articles, nous allons voir comment automatiser la création d'un utilisateur, via Azure Function, [avec une interface dans SharePoint Online](https://cloudyjourney.fr/2018/11/05/azure-appel-dun-webhook-azure-function-via-une-liste-sharepoint-et-automatise-avec-flow/) et [une application créée avec PowerApps](https://cloudyjourney.fr/2018/11/06/azure-creation-dune-application-powerapps-pour-une-liste-sharepoint/).

Pour commencer ce premier article, voyons comment créer notre utilisateur avec une Azure Function.

Nous allons utiliser le script PowerShell ci-dessous pour cette démonstration:

\# POST method: $req
$requestBody = Get-Content $req -Raw | ConvertFrom-Json
$password = $env:Password
$automationAccount = $env:AutomationAccount
$secpasswd = ConvertTo-SecureString $password -AsPlainText -Force
$mycreds = New-Object System.Management.Automation.PSCredential ($automationAccount, $secpasswd)
$lastname = $requestBody.lastname
$firstname = $requestBody.firstname
$PasswordProfile = New-Object -TypeName Microsoft.Open.AzureAD.Model.PasswordProfile
$PasswordProfile.Password = "A\_Password"

Connect-AzureAd -Credential $mycreds

New-AzureADUser -AccountEnabled $true -DisplayName "$firstname $lastname" -UserPrincipalName "$firstname.$lastname@florentappointaire.cloud" -PasswordProfile $PasswordProfile -MailNickName "$firstname.$lastname"

Out-File -Encoding Ascii -FilePath $res -inputObject "Hello $firstname $lastname"

Vous l'aurez compris, vous aurez besoin:

- D'une Azure Function
- De créer une application settings **AutomationAccount** avec un compte qui a les droits sur l'Azure AD pour créer des nouveaux utilisateurs
- De créer une application settings **Password** avec le mot de passe du compte précédent
- De passer la Web App de votre Azure Function en 64-bit (dans Application Settings)
- De downgrader votre Azure Function de la version 2 à la version 1 pour pouvoir utiliser PowerShell car PowerShell n'est pas encore dans la version 2 : [https://docs.microsoft.com/en-us/azure/azure-functions/functions-versions](https://docs.microsoft.com/en-us/azure/azure-functions/functions-versions)

[![](https://cloudyjourney.fr/wp-content/uploads/2018/10/FunctionApp01.png)](https://cloudyjourney.fr/wp-content/uploads/2018/10/FunctionApp01.png)

- De créer une nouvelle Function, nommé **cloudyjourney** dans mon cas, de language **PowerShell** et de type **HTTP trigger:**

[![](https://cloudyjourney.fr/wp-content/uploads/2018/10/FunctionApp02.png)](https://cloudyjourney.fr/wp-content/uploads/2018/10/FunctionApp02.png)

[![](https://cloudyjourney.fr/wp-content/uploads/2018/10/FunctionApp03.png)](https://cloudyjourney.fr/wp-content/uploads/2018/10/FunctionApp03.png)

- D'importer le module Azure AD dans votre Function  cloudyjourney: [https://blogs.msdn.microsoft.com/powershell/2017/02/24/using-powershell-modules-in-azure-functions/](https://blogs.msdn.microsoft.com/powershell/2017/02/24/using-powershell-modules-in-azure-functions/)

Une fois que vous avez ces prérequis, allez dans la partie **Integrate** de votre function, et selectionnez juste la méthode **POST** qui sera autorisée à recevoir des call via le webhook (Mode):

[![](https://cloudyjourney.fr/wp-content/uploads/2018/10/FunctionApp04.png)](https://cloudyjourney.fr/wp-content/uploads/2018/10/FunctionApp04.png)

Vous pouvez tester votre fonction, en cliquant sur **Run** et en utilisant le code JSON suivant dans la partie **Request body**:

{
    "firstname": "Test",
    "lastname": "Cloudyjourney"
}

[![](https://cloudyjourney.fr/wp-content/uploads/2018/10/FunctionApp05.png)](https://cloudyjourney.fr/wp-content/uploads/2018/10/FunctionApp05.png)

La création s'est bien déroulée:

[![](https://cloudyjourney.fr/wp-content/uploads/2018/10/FunctionApp06.png)](https://cloudyjourney.fr/wp-content/uploads/2018/10/FunctionApp06.png)

Et je peux maintenant me connecter avec mon utilisateur:

[![](https://cloudyjourney.fr/wp-content/uploads/2018/10/FunctionApp07.png)](https://cloudyjourney.fr/wp-content/uploads/2018/10/FunctionApp07.png)

Mon script est donc fonctionnel. Dernier point, dans votre function, cliquez sur **Get function URL** et récupérez l'URL que l'on utilisera pour appeler notre Webhook depuis Sharepoint:

[![](https://cloudyjourney.fr/wp-content/uploads/2018/10/FunctionApp08.png)](https://cloudyjourney.fr/wp-content/uploads/2018/10/FunctionApp08.png)

Dans le prochain article, nous verrons comment utiliser une liste SharePoint, pour déclancher automatiquement notre webhook Azure Function depuis SharePoint :)
