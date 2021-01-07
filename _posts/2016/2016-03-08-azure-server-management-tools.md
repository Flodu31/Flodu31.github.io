---
title: "[Azure] Server Management Tools"
date: "2016-03-08"
author: "Florent Appointaire"
permalink: "/2016/03/08/azure-server-management-tools/"
summary: 
categories: 
  - "azure"
tags: 
  - "azure"
  - "microsoft"
  - "server-management-tools"
---
Il y a un mois, Microsoft a rendu disponible une nouvelle fonctionnalités dans Azure, **Server Management Tools**.

Cette fonctionnalité vous donne la possibilité de gérer, via votre navigateur web, vos serveurs Windows.

Je vais vous montrer comment déployer cette nouvelle fonctionnalité. J’ai pour cette démo, 2 serveurs sur Azure. Un serveur Nano et un serveur sur Windows Server 2016 Server TP4. Le serveur sur Windows Server 2016 TP4 sera le serveur passerelle, où la fonctionnalité Server Management Tools sera installée. Ces 2 serveurs sont dans le même réseau, donc si vous avez un VPN Site2Site, vous pouvez avoir votre serveur de passerelle dans votre centre de données. Vous pouvez avoir un aperçu rapide sur [Technet](http://blogs.technet.com/b/nanoserver/archive/2016/02/09/server-management-tools-is-now-live.aspx):

[![](https://cloudyjourney.fr/wp-content/uploads/2018/01/Microsoft-Azure-Server-Management-Tools-Topology.png)](https://cloudyjourney.fr/wp-content/uploads/2018/01/Microsoft-Azure-Server-Management-Tools-Topology.png)

Nous allons commencer par déployer une nouvelle instance de **Service Management Tools.** Allez dans le **Marketplace > Management > More > Server management tools**:

[![](https://cloudyjourney.fr/wp-content/uploads/2018/01/image_0D938FD1.png)](https://cloudyjourney.fr/wp-content/uploads/2018/01/image_0D938FD1.png)

Remplissez les informations avec le nom de l’ordinateur que vous souhaitez gérer (hostname), votre suscription, un groupe de ressource, une passerelle Service Management (dans mon cas, ce sera une nouvelle) et le lieu (seulement disponible aux Etats-Unis au moment où j’écris ce poste):

[![](https://cloudyjourney.fr/wp-content/uploads/2018/01/image_682C2D13.png)](https://cloudyjourney.fr/wp-content/uploads/2018/01/image_682C2D13.png)

Quand le déploiement est terminée, cliquez sur **Browse > Server management tools connections:**

[![](https://cloudyjourney.fr/wp-content/uploads/2018/01/image_254FE899.png)](https://cloudyjourney.fr/wp-content/uploads/2018/01/image_254FE899.png)

Si la passerelle n’est pas configurée, vous aurez un message de notification pour la configurer. Cliquez dessus pour démarrer la configuration:

[![](https://cloudyjourney.fr/wp-content/uploads/2018/01/image_4977D3D9.png)](https://cloudyjourney.fr/wp-content/uploads/2018/01/image_4977D3D9.png)

Choisissez si vous voulez mettre à jour automatiquement la passerelle et cliquez sur le bouton **Generate a package link** pour créer un lien où les sources de votre passerelle seront disponibles. Copiez ce lien dans un endroit sécurisé:

[![](https://cloudyjourney.fr/wp-content/uploads/2018/01/image_062F5C6A.png)](https://cloudyjourney.fr/wp-content/uploads/2018/01/image_062F5C6A.png)

Sur votre passerelle, téléchargez l’archive avec le lien généré précédemment et décompressez la:

[![](https://cloudyjourney.fr/wp-content/uploads/2018/01/image_5E8B70F0.png)](https://cloudyjourney.fr/wp-content/uploads/2018/01/image_5E8B70F0.png)

Vous avez 2 fichiers dans ce dossier. Un fichier json avec les paramètres de votre passerelle et le logiciel. Voici un aperçu rapide de votre fichier json:

[![](https://cloudyjourney.fr/wp-content/uploads/2018/01/SNAGHTML10fce0ae_5A14F029.png)](https://cloudyjourney.fr/wp-content/uploads/2018/01/SNAGHTML10fce0ae_5A14F029.png)

Exécutez le logiciel pour installer la passerelle:

[![](https://cloudyjourney.fr/wp-content/uploads/2018/01/image_59A8BD34.png)](https://cloudyjourney.fr/wp-content/uploads/2018/01/image_59A8BD34.png)

[![](https://cloudyjourney.fr/wp-content/uploads/2018/01/image_7DD0A874.png)](https://cloudyjourney.fr/wp-content/uploads/2018/01/image_7DD0A874.png)

[![](https://cloudyjourney.fr/wp-content/uploads/2018/01/image_327104B0.png)](https://cloudyjourney.fr/wp-content/uploads/2018/01/image_327104B0.png)

Vous avez un nouveau service sur votre serveur passerelle:

[![](https://cloudyjourney.fr/wp-content/uploads/2018/01/image_427FD367.png)](https://cloudyjourney.fr/wp-content/uploads/2018/01/image_427FD367.png)

Si vous retournez sur le portail Azure, dans **Server management tools gateway**, le statut est maintenant **OK** et vous avez les informations concernant votre serveur:

[![](https://cloudyjourney.fr/wp-content/uploads/2018/01/image_1ADBE7EE.png)](https://cloudyjourney.fr/wp-content/uploads/2018/01/image_1ADBE7EE.png)

Retournez dans **Server management tools connections**. Si votre passerelle est enregistrée correctement, le message de notification vous demandera le nom d’utilisateur/mot de passe d’un compte administrateur de la VM que vous souhaitez gérer:

[![](https://cloudyjourney.fr/wp-content/uploads/2018/01/image_158D013D.png)](https://cloudyjourney.fr/wp-content/uploads/2018/01/image_158D013D.png)

[![](https://cloudyjourney.fr/wp-content/uploads/2018/01/image_4C69E634.png)](https://cloudyjourney.fr/wp-content/uploads/2018/01/image_4C69E634.png)

La connexion est terminée:

[![](https://cloudyjourney.fr/wp-content/uploads/2018/01/image_4E3A3BFB.png)](https://cloudyjourney.fr/wp-content/uploads/2018/01/image_4E3A3BFB.png)

Vous pouvez utiliser les Tools disponibles dès maintenant, directement depuis le portail Azure:

- Device Manager: Vous pouvez voir le matériel connecté, les drivers, etc
- Event Viewer: Vous pouvez consulter les logs
- PowerShell: Vous pouvez gérer votre serveur directement en PowerShell
- Processes: Vous avez la liste des processus qui tournent sur le serveur
- Registry Editor: Vous pouvez gérer les clés de registre
- Roles and Features: Vous pouvez voir les fonctionnalités installées
- Services: Vous pouvez démarrer/arrêter/suspendre/reprendre un service

En dessous, quelques captures d’écran de ces fonctionnalités:

[![](https://cloudyjourney.fr/wp-content/uploads/2018/01/image_3E2DFDF5.png)](https://cloudyjourney.fr/wp-content/uploads/2018/01/image_3E2DFDF5.png)

[![](https://cloudyjourney.fr/wp-content/uploads/2018/01/image_38DF1744.png)](https://cloudyjourney.fr/wp-content/uploads/2018/01/image_38DF1744.png)

[![](https://cloudyjourney.fr/wp-content/uploads/2018/01/image_36A51F39.png)](https://cloudyjourney.fr/wp-content/uploads/2018/01/image_36A51F39.png)

[![](https://cloudyjourney.fr/wp-content/uploads/2018/01/image_38757500.png)](https://cloudyjourney.fr/wp-content/uploads/2018/01/image_38757500.png)

[![](https://cloudyjourney.fr/wp-content/uploads/2018/01/image_4ECB1A45.png)](https://cloudyjourney.fr/wp-content/uploads/2018/01/image_4ECB1A45.png)

Avant d’ajouter mon serveur Nano, parce que je suis en WorkGroup, j’ai besoin d’ajouter le nom de mon serveur Nano dans la liste de confiance de WinRM sur mon serveur passerelle. Exécutez la commande suivante, en remplaçant avec vos valeurs:

`Set-Item -Path WSMan:\localhost\client\TrustedHosts -Value 'NANO01' –Force`

[![](https://cloudyjourney.fr/wp-content/uploads/2018/01/image_39DC2883.png)](https://cloudyjourney.fr/wp-content/uploads/2018/01/image_39DC2883.png) 

Je vais maintenant ajouter mon serveur Nano et le lier à une passerelle existante:

[![](https://cloudyjourney.fr/wp-content/uploads/2018/01/image_598B024B.png)](https://cloudyjourney.fr/wp-content/uploads/2018/01/image_598B024B.png)

Je vais ajouter mon nom d’utilisateur/mot de passe qui a les droits administrateurs pour gérer mon serveur Nano, en cliquant sur **Manage as**:

[![](https://cloudyjourney.fr/wp-content/uploads/2018/01/image_1B91718D.png)](https://cloudyjourney.fr/wp-content/uploads/2018/01/image_1B91718D.png)
[![](https://cloudyjourney.fr/wp-content/uploads/2018/01/image_46D89945.png)](https://cloudyjourney.fr/wp-content/uploads/2018/01/image_46D89945.png) 

Je peux m’y connecter au travers de Azure:

[![](https://cloudyjourney.fr/wp-content/uploads/2018/01/image_61A4BF51.png)](https://cloudyjourney.fr/wp-content/uploads/2018/01/image_61A4BF51.png)

Si vous voulez vous connecter avec le compte **Administrator**, sur la machine cible, exécutez la commande suivante pour autoriser l’authentification avec le compte administrateur à distance:

`REG ADD HKLM\SOFTWARE\Microsoft\Windows\CurrentVersion\Policies\System /v LocalAccountTokenFilterPolicy /t REG_DWORD /d 1`

Et, si le serveur que vous souhaitez ajouter n’est pas dans le même réseau que la passerelle, exécutez la commande suivant pour ouvrir dans le parefeu le port 5985:

`NETSH advfirewall firewall add rule name="WinRM 5985" protocol=TCP dir=in localport=5985 action=allow`

J’espère que cet article vous aidera :)
