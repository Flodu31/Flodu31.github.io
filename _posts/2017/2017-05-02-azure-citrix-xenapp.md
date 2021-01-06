---
title: "[Azure] Citrix XenApp"
date: "2017-05-02"
author: "Florent Appointaire"
permalink: "/2017/05/02/azure-citrix-xenapp/"
summary: 
categories: 
  - "azure"
  - "citrix"
tags: 
  - "azure"
  - "citrix"
  - "microsoft"
  - "xenapp"
---
Aujourd'hui nous allons voir comment déployer une ferme Citrix XenApp sur Azure. Nous allons utiliser le déploiement de type Citrix Cloud Service. Ce modèle fait tourner votre workload sur Azure, mais il est géré par Citrix.

Ceci a été rendu disponible en Mars 2017.

Les prérequis sont les suivants pour déployer l'environnement:

- Une suscription Azure
- Un compte sur le Citrix Cloud: [https://onboarding.cloud.com](https://onboarding.cloud.com/)
- Un VPN S2S ou un Express Route pour contacter votre infrastructure Active Directory
- Un groupe de ressource avec:
    - Virtual Network
    - Compte de stockage
    - Une VM Image avec les applications installées
        - Avec l'agent Server VDA déployé [https://xenapp.cloud.com/downloads](https://xenapp.cloud.com/downloads)
        - La VM éteinte et pas sysprep

Toutes les ressources doivent être dans le même groupe de ressource.

La VM Image est la VM avec vos applications personnalisées installées que vous souhaitez fournir à vos utilisateurs. Vous pouvez avoir un nombre illimité d'image sur Azure que vous allez déployer pour votre ferme Citrix.

## Déploiement de l'environnement Citrix sur Azure

Pour commencer, ouvrez le Marketplace et cherchez **Citrix XenApp Essentials**. Cliquez sur **Create:**

[![](https://cloudyjourney.fr/wp-content/uploads/2018/01/Citrix01.png)](https://cloudyjourney.fr/wp-content/uploads/2018/01/Citrix01.png)

Donnez un nom à ce déploiement, la suscription où vous souhaitez déployer l'environnement et le groupe de ressource où vous avez déjà déployez votre VM, le réseau et le stockage: [![](https://cloudyjourney.fr/wp-content/uploads/2018/01/Citrix02.png)](https://cloudyjourney.fr/wp-content/uploads/2018/01/Citrix02.png)

Cliquez sur **Connect** pour vous connecter au Citrix Cloud:

[![](https://cloudyjourney.fr/wp-content/uploads/2018/01/Citrix03.png)](https://cloudyjourney.fr/wp-content/uploads/2018/01/Citrix03.png)

Quand la connexion est terminée, vous devez renseigner le nombre d'utilisateur pour lesquels vous voulez une licence (minimum 25). Ce chiffre peut être changé plus tard, via le portail Azure. Ca prendra maximum 4 heures pour déployer l'environnement sur le Citrix Cloud:

[![](https://cloudyjourney.fr/wp-content/uploads/2018/01/Citrix04.png)](https://cloudyjourney.fr/wp-content/uploads/2018/01/Citrix04.png)

Quand c'est terminé (vous recevrez un email), cliquez sur **Manage through Citrix Cloud:**

[![](https://cloudyjourney.fr/wp-content/uploads/2018/01/Citrix05.png)](https://cloudyjourney.fr/wp-content/uploads/2018/01/Citrix05.png)

## Deployez votre image personnalisée

Vous allez arriver sur une nouvelle interface. C'est ici que nous allons déployer les nouvelles images, les gérer, etc. Cliquez sur **I’m ready to start:**

[![](https://cloudyjourney.fr/wp-content/uploads/2018/01/Citrix06.png)](https://cloudyjourney.fr/wp-content/uploads/2018/01/Citrix06.png)

Cliquez sur **Subscriptions** pour vous connecter à votre suscription Azure avec le compte qui est propriétaire et localisé sur l'Azure AD:

[![](https://cloudyjourney.fr/wp-content/uploads/2018/01/Citrix07.png)](https://cloudyjourney.fr/wp-content/uploads/2018/01/Citrix07.png)

Acceptez les permissions que Citrix a besoin:

[![](https://cloudyjourney.fr/wp-content/uploads/2018/01/Citrix08.png)](https://cloudyjourney.fr/wp-content/uploads/2018/01/Citrix08.png)

Choisissez la suscription où l'infrastructure Citrix sera déployée (doit être la même suscription qu'où vous avez déployé le Citrix XenApp du marketplace) et cliquez sur **Link**:

[![](https://cloudyjourney.fr/wp-content/uploads/2018/01/Citrix09.png)](https://cloudyjourney.fr/wp-content/uploads/2018/01/Citrix09.png)

Nous allons créer un nouvel objet dans le catalogue Citrix. Cliquez sur **Create a catalog:**

[![](https://cloudyjourney.fr/wp-content/uploads/2018/01/Citrix10.png)](https://cloudyjourney.fr/wp-content/uploads/2018/01/Citrix10.png)

Donnez un nom à ce catalogue et si les machines seront jointes au domaine ou pas:

[![](https://cloudyjourney.fr/wp-content/uploads/2018/01/Citrix11.png)](https://cloudyjourney.fr/wp-content/uploads/2018/01/Citrix11.png)

Sélectionnez la suscription Azure, le groupe de ressource où le réseau a été déployé (doit être le même qu'où vous avez déployé votre infrastructure sur Azure), choisissez le virtual network et le sous réseau qui sera utilisé (doit pouvoir contacter un domain controller):

[![](https://cloudyjourney.fr/wp-content/uploads/2018/01/Citrix12.png)](https://cloudyjourney.fr/wp-content/uploads/2018/01/Citrix12.png)

Fournissez le nom de votre domaine, l'OU où stocker les objets ordinateurs, un compte qui a les droit pour joindre les serveurs au domaine (format UPN) et le mot de passe associé:

[![](https://cloudyjourney.fr/wp-content/uploads/2018/01/Citrix13.png)](https://cloudyjourney.fr/wp-content/uploads/2018/01/Citrix13.png)

Choisissez si vous souhaitez lier votre image à cette collection (pas possible pour le moment car on n'a pas encore d'image sur notre Citrix Cloud) ou si vous voulez importer une nouvelle image (ce que l'on va faire) ou si vous voulez utiliser l'image par défaut fourni par Citrix (pour les tests).

Choisissez la suscription, le groupe de ressource, le compte de stockage et le VHD de la VM où les applications sont installées. Donnez un nom à cette image et cliquez sur **Save:**

[![](https://cloudyjourney.fr/wp-content/uploads/2018/01/Citrix14.png)](https://cloudyjourney.fr/wp-content/uploads/2018/01/Citrix14.png)

Pour le déploiement des VMs sur Azure, choisissez si vous souhaitez utiliser un stocke de type HDD ou SSD. Choisissez la taille des VM si vous le souhaitez (Custom) ou utilisez une taille prédéfinie:

[![](https://cloudyjourney.fr/wp-content/uploads/2018/01/Citrix15.png)](https://cloudyjourney.fr/wp-content/uploads/2018/01/Citrix15.png)

Choisissez le nombre minimum d'instance qui doivent tourner et le maximum. J'ai 25 utilisateurs, et avec la taille que j'ai choisis (utilisation de Notepad++), je peux faire tourner 16 utilisateurs de façon simultané. Donc, je peux potentiellement accueillir 32 utilisateurs maximum avec mes 2 instances. Vous pouvez choisisr d'arrêter/démarrer les VMs, etc.

[![](https://cloudyjourney.fr/wp-content/uploads/2018/01/Citrix16.png)](https://cloudyjourney.fr/wp-content/uploads/2018/01/Citrix16.png)

En haut, cliquez sur **Start Deployment** pour démarrer le déploiement de la ferme Citrix avec votre image personnalisée:

[![](https://cloudyjourney.fr/wp-content/uploads/2018/01/Citrix17.png)](https://cloudyjourney.fr/wp-content/uploads/2018/01/Citrix17.png)

Le déploiement peut prendre entre 1 et 2 heures:

[![](https://cloudyjourney.fr/wp-content/uploads/2018/01/Citrix18.png)](https://cloudyjourney.fr/wp-content/uploads/2018/01/Citrix18.png)

Après quelques instants, les premières ressources apparaissent dans Azure:

[![](https://cloudyjourney.fr/wp-content/uploads/2018/01/Citrix19.png)](https://cloudyjourney.fr/wp-content/uploads/2018/01/Citrix19.png)

Et les VMs sont jointes au domaine:

[![](https://cloudyjourney.fr/wp-content/uploads/2018/01/Citrix20.png)](https://cloudyjourney.fr/wp-content/uploads/2018/01/Citrix20.png)

## Deployez les applications et donnez les droits

Quand le déploiement est terminé, vous devez publier vos applications et ajouter un ou plusieurs utilisateurs/groupes:

[![](https://cloudyjourney.fr/wp-content/uploads/2018/01/Citrix21.png)](https://cloudyjourney.fr/wp-content/uploads/2018/01/Citrix21.png)

Sélectionnez les applications que vous voulez publier:

[![](https://cloudyjourney.fr/wp-content/uploads/2018/01/Citrix22.png)](https://cloudyjourney.fr/wp-content/uploads/2018/01/Citrix22.png)

[![](https://cloudyjourney.fr/wp-content/uploads/2018/01/Citrix23.png)](https://cloudyjourney.fr/wp-content/uploads/2018/01/Citrix23.png)

Et ajouter des utilisateurs/groupes. Quand c'est terminé, allez dans **More Settings** et renseignez le chemin vers un File Server pour stocker les profils. Renseignez le serveur de licence RDS pour valider les CAL:

[![](https://cloudyjourney.fr/wp-content/uploads/2018/01/7673.Citrix24.png)](https://cloudyjourney.fr/wp-content/uploads/2018/01/7673.Citrix24.png)

Une URL pour accéder à votre déploiement sera disponible après quelques minutes dans la section **Test and Share StoreFront Link**:

[![](https://cloudyjourney.fr/wp-content/uploads/2018/01/1307.Citrix25.png)](https://cloudyjourney.fr/wp-content/uploads/2018/01/1307.Citrix25.png)

[![](https://cloudyjourney.fr/wp-content/uploads/2018/01/1307.Citrix26.png)](https://cloudyjourney.fr/wp-content/uploads/2018/01/1307.Citrix26.png)

Si vous allez dans **Master Image**, vous verrez votre image que vous pouvez déployer dans un autre catalogue:

[![](https://cloudyjourney.fr/wp-content/uploads/2018/01/Citrix26.png)](https://cloudyjourney.fr/wp-content/uploads/2018/01/Citrix26.png)

## Connectez vous à votre environnement

Allez sur votre URL et téléchargez le client Citrix Receiver. Quand le client est installé, connectez vous à votre URL:

[![](https://cloudyjourney.fr/wp-content/uploads/2018/01/Citrix28.png)](https://cloudyjourney.fr/wp-content/uploads/2018/01/Citrix28.png)

Fournissez un nom d'utilisateur/mot de passe que vous utilisez pour vous connecter aux ressources de l'entreprise, votre PC par exemple et qui a accès à la collection Citrix:

[![](https://cloudyjourney.fr/wp-content/uploads/2018/01/Citrix29.png)](https://cloudyjourney.fr/wp-content/uploads/2018/01/Citrix29.png)

Si le nom d'utilisateur/mot de passe sont corrects, et que vous avez les autorisations nécessaires, vous allez voir les applications qui sont disponibles dans cette galerie:

[![](https://cloudyjourney.fr/wp-content/uploads/2018/01/Citrix30.png)](https://cloudyjourney.fr/wp-content/uploads/2018/01/Citrix30.png)

Cliquez sur l'une d'elle pour l'ouvrir:

[![](https://cloudyjourney.fr/wp-content/uploads/2018/01/Citrix31.png)](https://cloudyjourney.fr/wp-content/uploads/2018/01/Citrix31.png)

Grâce à ce nouveau type de déploiement, vous n'aurez plus besoin d'un environnement Citrix OnPrem. Attention au coût que cela peut engendrer, parce que vous devez payer la consommation Azure, la licence Citrix par utilisateur et les CAL RDS.

Citrix calculator: [https://costcalculator.azurewebsites.net/costCalculator](https://costcalculator.azurewebsites.net/costCalculator)
