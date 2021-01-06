---
title: "[Intune] Comment tester Windows Autopilot"
date: "2018-03-15"
author: "Florent Appointaire"
permalink: "/2018/03/15/intune-comment-tester-windows-autopilot"
summary:
categories: 
  - "azure"
  - "intune"
tags: 
  - "autopilot"
  - "intune"
  - "microsoft"
  - "windows-10"
---
Microsoft a dévoilé il y a quelques mois maintenant une nouvelle fonctionnalité dans Intune, Windows Autopilot. Ceci vous permet de déployer des ordinateurs, sans qu’il passe par votre Service Desk. En effet, c’est le constructeur qui livre le PC au client, et qui vous envoie sont numéros de série ainsi que d’autres informations. Vous intégrez ceci à Windows Autopilot et l’utilisateur a juste à se connecter avec son compte Azure AD/O365 pour récupérer toutes les informations de la société, ainsi que ses applications, etc. sans que votre Service Desk ne se déplace, plutôt cool non ? ?

Ici, je vais vous montrer comment essayer Windows Autopilot, sans pour autant investir dans du matériel, mais seulement avec une ou plusieurs VMs Hyper-V. La documentation de Microsoft est disponible [ici](https://demos.microsoft.com/materials/195).

Pour commencer, allez sur [https://demos.microsoft.com/](https://demos.microsoft.com/) et cliquez sur **Microsoft User Login**, puis connectez-vous avec votre compte Microsoft. Une fois connecté, cliquez sur **Create a tenant.** Si vous avez une erreur, comme quoi vous ne pouvez pas créer de tenant, ouvrez un ticket au support, pour qu’ils vous autorisent l’accès. Attention, ils sont localisés aux USA et il y a donc un délai de réponse (4 heures pour ma part) :

[![](https://cloudyjourney.fr/wp-content/uploads/2018/03/Autopilot01.png)](https://cloudyjourney.fr/wp-content/uploads/2018/03/Autopilot01.png)

[![](https://cloudyjourney.fr/wp-content/uploads/2018/03/Autopilot02.png)](https://cloudyjourney.fr/wp-content/uploads/2018/03/Autopilot02.png)

Une fois la requête acceptée, créez un nouveau tenant, où vous le souhaitez, et sélectionnez **Microsoft 365 Enterprise Demo Content :**

[![](https://cloudyjourney.fr/wp-content/uploads/2018/03/Autopilot03.png)](https://cloudyjourney.fr/wp-content/uploads/2018/03/Autopilot03.png)

Quelques secondes après, votre environnement est prêt à être utilisé. Vous allez pouvoir utiliser Office 365, EMS, etc ? pendant 90 jours, de façon gratuite. Il y a également des groupes, des utilisateurs, etc. qui sont créés par défaut :

[![](https://cloudyjourney.fr/wp-content/uploads/2018/03/Autopilot04.png)](https://cloudyjourney.fr/wp-content/uploads/2018/03/Autopilot04.png)

Créez ensuite le/les VMs Windows 10, avec la version 1709 minimum. Ces VMs doivent être activées, sinon la connexion ne se fera pas. Une fois les VMs installées, allez jusqu’à la partie connexion à un compte d’entreprise, et cliquez sur **SHIFT+F10** pour ouvrir une nouvelle fenêtre PowerShell. Si **SHIFT+F10** ne fonctionne pas, ouvrez un explorer (Windows + E) et allez dans C:\\Windows\\System32\\WindowsPowerShell\\v1.0. Ouvrez PowerShell en tant qu’administrateur et exécutez les commandes suivantes :

`Set-ExecutionPolicy Bypass Install-Script Get-WindowsAutoPilotInfo`

[![](https://cloudyjourney.fr/wp-content/uploads/2018/03/Autopilot05.png)](https://cloudyjourney.fr/wp-content/uploads/2018/03/Autopilot05.png)

Nous allons maintenant récupérer le numéro de série de la ou les VMs, avec la commande suivante :

`Get-WindowsAutoPilotInfo.ps1 -OutputFile C:\FLOAPP-PC02.csv`

[![](https://cloudyjourney.fr/wp-content/uploads/2018/03/Autopilot06.png)](https://cloudyjourney.fr/wp-content/uploads/2018/03/Autopilot06.png)

Récupérez le/les fichiers générés sur un ordinateur :

[![](https://cloudyjourney.fr/wp-content/uploads/2018/03/Autopilot07.png)](https://cloudyjourney.fr/wp-content/uploads/2018/03/Autopilot07.png)

Vous pouvez configure si vous le souhaitez, votre Azure AD, en vous rendant sur [https://portal.azure.com](https://portal.azure.com) dans la partie Azure Active Directory, notamment la partie branding. Allez vérifier également que la partie MDM, avec Microsoft Intune, a bien été activée dans Azure AD :

[![](https://cloudyjourney.fr/wp-content/uploads/2018/03/Autopilot007.png)](https://cloudyjourney.fr/wp-content/uploads/2018/03/Autopilot007.png)

Maintenant, rendez-vous sur [https://businessstore.microsoft.com](https://businessstore.microsoft.com) en utilisant l’utilisateur créé lors de notre tenant de démo et acceptez les termes du contrat :

[![](https://cloudyjourney.fr/wp-content/uploads/2018/03/Autopilot08.png)](https://cloudyjourney.fr/wp-content/uploads/2018/03/Autopilot08.png)

Configurons maintenant la partie Intune, qui va nous permettre d’intégrer Windows Autopilot, de gérer nos devices mais aussi de déployer des applications, etc.

Allez dans **Intune > Device enrollment > Windows enrollment** et cliquez sur **Deployment Profiles**. Cliquez sur **\+ Create Profile** :

[![](https://cloudyjourney.fr/wp-content/uploads/2018/03/Autopilot09.png)](https://cloudyjourney.fr/wp-content/uploads/2018/03/Autopilot09.png)

Donnez un nom à votre profil et choisissez **Azure AD Join** pour le type de join. Cliquez sur **Defaults configured** et configuez les paramètres que vous souhaitez. Je vais dans mon cas créer 2 profils, un pour que l’utilisateur soit Administrateur de son poste et l’autre non :

[![](https://cloudyjourney.fr/wp-content/uploads/2018/03/Autopilot10.png)](https://cloudyjourney.fr/wp-content/uploads/2018/03/Autopilot10.png)

Cliquez sur **Save** et **Create** :

[![](https://cloudyjourney.fr/wp-content/uploads/2018/03/Autopilot11.png)](https://cloudyjourney.fr/wp-content/uploads/2018/03/Autopilot11.png)

[![](https://cloudyjourney.fr/wp-content/uploads/2018/03/Autopilot12.png)](https://cloudyjourney.fr/wp-content/uploads/2018/03/Autopilot12.png)

Ajoutez maintenant des applications dans votre Intune, en suivant [cet article](https://www.starwindsoftware.com/blog/enroll-your-devices-in-intune-and-deploy-a-new-app-in-the-azure-portal). Vous pouvez également créer l’application Office 365 Pro Plus pour déployer automatiquement Office sur le PC de la personne qui se connecte. Je vais en plus déployer mRemoteNG pour les utilisateurs du groupe IT. Donnez les permissions de déploiement à un groupe pour déployer ces applications, dans mon cas **IT** :

[![](https://cloudyjourney.fr/wp-content/uploads/2018/03/Autopilot13.png)](https://cloudyjourney.fr/wp-content/uploads/2018/03/Autopilot13.png)

Assurez-vous bien que les applications que vous souhaitez déployer soient bien marquées comme **Required :**

[![](https://cloudyjourney.fr/wp-content/uploads/2018/03/Autopilot14.png)](https://cloudyjourney.fr/wp-content/uploads/2018/03/Autopilot14.png)

Une fois terminé, récupérez un ou plusieurs utilisateurs qui se trouvent dans l’Azure AD pour faire les tests. Attention de bien vérifier que ces utilisateurs soient dans les groupes qui ont les permissions pour déployer des applications ? Le mot de passe de tous les utilisateurs est le même que celui de votre compte admin Azure AD.

Nous allons maintenant envoyer notre fichier CSV vers le business store de Microsoft (il n’est pas encore possible de le faire via la console Intune de Azure). Allez sur [https://businessstore.microsoft.com](https://businessstore.microsoft.com) et cliquez sur **Manage > Devices** :

[![](https://cloudyjourney.fr/wp-content/uploads/2018/03/Autopilot15.png)](https://cloudyjourney.fr/wp-content/uploads/2018/03/Autopilot15.png)

Cliquez sur **\+ Add Devices** et sélectionnez votre fichier CSV :

[![](https://cloudyjourney.fr/wp-content/uploads/2018/03/Autopilot16.png)](https://cloudyjourney.fr/wp-content/uploads/2018/03/Autopilot16.png)

Cliquez sur **Refresh** jusqu’à voir apparaître la liste des ordinateurs qui vont pouvoir rejoindre le domaine Azure AD :

[![](https://cloudyjourney.fr/wp-content/uploads/2018/03/Autopilot17.png)](https://cloudyjourney.fr/wp-content/uploads/2018/03/Autopilot17.png)

Directement depuis ici, vous pouvez associer les profils créés auparavant :

[![](https://cloudyjourney.fr/wp-content/uploads/2018/03/Autopilot18.png)](https://cloudyjourney.fr/wp-content/uploads/2018/03/Autopilot18.png)

Mais vous pouvez également le faire depuis l’interface Intune. Lancez une synchronisation entre Intune et Windows Autopilot en allant dans **Intune > Device Enrollment > Windows Enrollment** et lancez une synchronisation entre le Business Store et Windows Autopilot dans Intune en cliquant sur **Devices** puis sur **Sync :**

[![](https://cloudyjourney.fr/wp-content/uploads/2018/03/Autopilot19.png)](https://cloudyjourney.fr/wp-content/uploads/2018/03/Autopilot19.png)

[![](https://cloudyjourney.fr/wp-content/uploads/2018/03/Autopilot20.png)](https://cloudyjourney.fr/wp-content/uploads/2018/03/Autopilot20.png)

Assignez le bon profil à la deuxième machine, en la sélectionnant dans Intune puis **Assign profile :**

[![](https://cloudyjourney.fr/wp-content/uploads/2018/03/Autopilot21.png)](https://cloudyjourney.fr/wp-content/uploads/2018/03/Autopilot21.png)

Le statut de la VM passe an **Assigning** et après quelques instants, elle passe en **Assigned :**

[![](https://cloudyjourney.fr/wp-content/uploads/2018/03/Autopilot22.png)](https://cloudyjourney.fr/wp-content/uploads/2018/03/Autopilot22.png)

Allez maintenant sur les VMs que vous avez créé précédemment et connectez-vous avez les 2 utilisateurs différents, sur les 2 machines :

[![](https://cloudyjourney.fr/wp-content/uploads/2018/03/Autopilot23.png)](https://cloudyjourney.fr/wp-content/uploads/2018/03/Autopilot23.png)

[![](https://cloudyjourney.fr/wp-content/uploads/2018/03/Autopilot24.png)](https://cloudyjourney.fr/wp-content/uploads/2018/03/Autopilot24.png)

[![](https://cloudyjourney.fr/wp-content/uploads/2018/03/Autopilot25.png)](https://cloudyjourney.fr/wp-content/uploads/2018/03/Autopilot25.png)

Windows va vérifier les mises à jour et mettre en place votre ordinateur. Suivant les paramètre de la société, il peut vous demander de configurer Windows Hello :

[![](https://cloudyjourney.fr/wp-content/uploads/2018/03/Autopilot26.png)](https://cloudyjourney.fr/wp-content/uploads/2018/03/Autopilot26.png)

[![](https://cloudyjourney.fr/wp-content/uploads/2018/03/Autopilot27.png)](https://cloudyjourney.fr/wp-content/uploads/2018/03/Autopilot27.png)

Après quelques instants, vous allez être connecté à votre machine :

[![](https://cloudyjourney.fr/wp-content/uploads/2018/03/Autopilot28.png)](https://cloudyjourney.fr/wp-content/uploads/2018/03/Autopilot28.png)

Après quelques minutes, les applications sont déployées en fonction des droits :

[![](https://cloudyjourney.fr/wp-content/uploads/2018/03/Autopilot29.png)](https://cloudyjourney.fr/wp-content/uploads/2018/03/Autopilot29.png)

Et du côté Intune, j’ai bien les ordinateurs enregistrés :

[![](https://cloudyjourney.fr/wp-content/uploads/2018/03/Autopilot30.png)](https://cloudyjourney.fr/wp-content/uploads/2018/03/Autopilot30.png)

 

[![](https://cloudyjourney.fr/wp-content/uploads/2018/03/Autopilot31.png)](https://cloudyjourney.fr/wp-content/uploads/2018/03/Autopilot31.png)

Et les applications installées :

[![](https://cloudyjourney.fr/wp-content/uploads/2018/03/Autopilot32.png)](https://cloudyjourney.fr/wp-content/uploads/2018/03/Autopilot32.png) [![](https://cloudyjourney.fr/wp-content/uploads/2018/03/Autopilot33.png)](https://cloudyjourney.fr/wp-content/uploads/2018/03/Autopilot33.png)

En attendant les nouvelles fonctionnalités qui vont améliorer le produit, ceci va enlever un casse-tête à pas mal de société, notamment pour la partie images des Windows. En effet, plus besoin de créer des images par défaut. Une seule et même image pour tout le monde, et les applications se déploieront en fonction des groupes, directement depuis Internet ?
