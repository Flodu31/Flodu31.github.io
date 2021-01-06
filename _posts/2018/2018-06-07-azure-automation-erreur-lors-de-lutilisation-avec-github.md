---
title: "[Azure Automation] Erreur lors de l'utilisation avec GitHub"
date: "2018-06-07"
categories: 
  - "azure"
  - "azure-automation"
  - "azure-web-apps"
  - "github"
tags: 
  - "azure"
  - "azure-automation"
  - "github"
  - "microsoft"
---

[![](https://cloudyjourney.fr/wp-content/uploads/2018/06/github-azure_logo.png)](https://cloudyjourney.fr/wp-content/uploads/2018/06/github-azure_logo.png)

Aujourd'hui, en voulant déployer une WebApp avec Azure Automation et qui déploye automatiquement un projet qui est sur GitHub, je me suis retrouvé avec l'erreur suivante:

Set-AzureRmResource : {"Code":"NotFound","Message":"Cannot find User with name 
1003BFFDAXXXX.","Target":null,"Details":\[{"Message":"Cannot find User with name 
1003BFFDAXXXX."},{"Code":"NotFound"},{"ErrorEntity":{"ExtendedCode":"51004","MessageTemplate":"Cannot find {0} with 
name {1}.","Parameters":\["User","1003BFFDAXXXX"\],"Code":"NotFound","Message":"Cannot find User with name 
1003BFFDAXXXX."}}\],"Innererror":null}
At line:39 char:5
+     Set-AzureRmResource -PropertyObject $PropertiesObject -ResourceGr ...
+     ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
    + CategoryInfo          : CloseError: (:) \[Set-AzureRmResource\], ErrorResponseMessageException
    + FullyQualifiedErrorId : 
NotFound,Microsoft.Azure.Commands.ResourceManager.Cmdlets.Implementation.SetAzureResourceCmdlet

[![](https://cloudyjourney.fr/wp-content/uploads/2018/06/AAGithubError01.png)](https://cloudyjourney.fr/wp-content/uploads/2018/06/AAGithubError01.png)

En fait, il s'avère que je n'ai jamais créé de token sur mon Github, pour le compte Azure Automation que j'utilise pour créer la WebApp. Ce qu'il suffit de faire pour résoudre ce souci est de se connecter avec le compte qui va être utilisé dans Azure Automation pour déployer automatiquement la WebApp et de créer une nouvelle WebApp temporaire. Une fois terminé, ajoutez Github comme source de déploiement:

[![](https://cloudyjourney.fr/wp-content/uploads/2018/06/AAGithubError02.png)](https://cloudyjourney.fr/wp-content/uploads/2018/06/AAGithubError02.png)

Choisissez d'authoriser Azure pour accéder à Github. Ceci va générer un token dans Github pour notre compte:

[![](https://cloudyjourney.fr/wp-content/uploads/2018/06/AAGithubError03.png)](https://cloudyjourney.fr/wp-content/uploads/2018/06/AAGithubError03.png) [![](https://cloudyjourney.fr/wp-content/uploads/2018/06/AAGithubError04.png)](https://cloudyjourney.fr/wp-content/uploads/2018/06/AAGithubError04.png) [![](https://cloudyjourney.fr/wp-content/uploads/2018/06/AAGithubError05.png)](https://cloudyjourney.fr/wp-content/uploads/2018/06/AAGithubError05.png)

Une fois terminé, relancez votre job Azure Automation. Le déploiement devrait s'effectuer sans souci:

[![](https://cloudyjourney.fr/wp-content/uploads/2018/06/AAGithubError06.png)](https://cloudyjourney.fr/wp-content/uploads/2018/06/AAGithubError06.png)
