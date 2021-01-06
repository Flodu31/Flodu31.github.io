---
title: "[Azure] Intégration continue / Déploiement continue avec Docker (ACS et ACR), Visual Studio Code, Visual Studio Team Services et GitHub"
date: "2017-01-21"
categories: 
  - "azure"
  - "azure-container-registry"
  - "azure-container-service"
tags: 
  - "azure"
  - "azure-container-registry"
  - "azure-container-service"
  - "ci-cd"
  - "continuous-integration"
  - "github"
  - "microsoft"
  - "visual-studio-team-service"
  - "vsts"
---

[![](https://cloudyjourney.fr/wp-content/uploads/2018/01/pastedimage1485183036978v1.png)](https://cloudyjourney.fr/wp-content/uploads/2018/01/pastedimage1485183036978v1.png)

Une des grandes forces des infrastructures de nos jours, est le fait de pouvoir réaliser, du CI/CD. Comprenez, Continous Integration et Continus Deployment.

En résumé, ces techniques, permettent à vos développeurs, de créer/modifier leur code, de l’envoyer sur Github par exemple, de le compiler avec Visual Studio Team Services (VSTS), de l’enregistrer sur votre registry (Azure Container Registry dans mon cas), de gérer les versions, toujours avec VSTS, de l’envoyer comme container sur votre Docker Swarm et pour finir, d’y accéder par une simple interface web.

Nous allons donc voir comment faire ceci (la documentation Microsoft est disponible [ici](https://docs.microsoft.com/en-us/azure/container-service/container-service-docker-swarm-setup-ci-cd)). Pour commencer, vous devez être sûr d’avoir ceci :

- [Azure Container Service](https://cloudyjourney.fr/2017/01/18/azure-container-service-comment-bien-debuter/)
- [Azure Container Registry](https://cloudyjourney.fr/2017/01/19/azure-container-registry-a-quoi-ca-sert/)
- [Un compte Github](https://github.com/)
    - Votre application dans un repository
    - Votre Dockerfile dans un repository
- [Un compte VSTS](https://www.visualstudio.com/en-us/docs/setup-admin/team-services/sign-up-for-visual-studio-team-services)
- Un serveur avec Docker installé

Avant de commencer, vous devez déployer sur votre ACS, le container Docker qui permettra d’installer l’agent VSTS. Le container et sa documentation sont disponibles ici : [https://hub.docker.com/r/microsoft/vsts-agent/](https://hub.docker.com/r/microsoft/vsts-agent/)

Il faut un token pour pouvoir installer cet agent. Allez dans votre **VSTS > Votre Compte > Security :**

[![](https://cloudyjourney.fr/wp-content/uploads/2018/01/pastedimage1485183053145v2.png)](https://cloudyjourney.fr/wp-content/uploads/2018/01/pastedimage1485183053145v2.png)

Cliquez sur **Add** pour créer un nouveau Token :

[![](https://cloudyjourney.fr/wp-content/uploads/2018/01/pastedimage1485183067117v4.png)](https://cloudyjourney.fr/wp-content/uploads/2018/01/pastedimage1485183067117v4.png)

Sélectionnez bien **Agent Pools (read, manage)** comme permission et créez le token :

[![](https://cloudyjourney.fr/wp-content/uploads/2018/01/pastedimage1485183080278v5.png)](https://cloudyjourney.fr/wp-content/uploads/2018/01/pastedimage1485183080278v5.png)

Sauvegardez bien la clé qu’il va vous donner car vous ne pourrez pas la récupérer ultérieurement. Connectez-vous sur un serveur qui a Docker pour installer l’agent VSTS (il est également possible de déployer cet agent sur [un container Docker](https://hub.docker.com/r/microsoft/vsts-agent/)). Mon serveur tourne avec Ubuntu 16.04. Dans l’interface VSTS, cliquez sur **Settings > Agent queues > Download Agent** et sélectionnez votre OS :

[![](https://cloudyjourney.fr/wp-content/uploads/2018/01/pastedimage1485183092890v6.png)](https://cloudyjourney.fr/wp-content/uploads/2018/01/pastedimage1485183092890v6.png)

Téléchargez l’agent sur le serveur et exécutez la commande de configuration en remplaçant par l’URL de votre VSTS. Fournissez la clé que vous avez créé juste avant pour l’authentification :

`wget [https://github.com/Microsoft/vsts-agent/releases/download/v2.111.1/vsts-agent-ubuntu.16.04-x64-2.111.1.tar.gz](https://github.com/Microsoft/vsts-agent/releases/download/v2.111.1/vsts-agent-ubuntu.16.04-x64-2.111.1.tar.gz)`

`mkdir myagent && cd myagent`

`tar zxvf /home/florent/vsts-agent-ubuntu.16.04-x64-2.111.1.tar.gz`

`./config.sh –url [https://floapp.visualstudio.com](https://floapp.visualstudio.com/) –auth PAT`

[![](https://cloudyjourney.fr/wp-content/uploads/2018/01/pastedimage1485183127742v7.png)](https://cloudyjourney.fr/wp-content/uploads/2018/01/pastedimage1485183127742v7.png)

L’agent est maintenant configurer. Pour le lancer, exécutez la commande **./run.sh** :

[![](https://cloudyjourney.fr/wp-content/uploads/2018/01/pastedimage1485183262733v8.png)](https://cloudyjourney.fr/wp-content/uploads/2018/01/pastedimage1485183262733v8.png)

Pour que tout ce petit monde parle ensemble, il faut dans un premier temps, installer le composant docker, qui va permettre d’interagir entre VSTS et Docker. Sur le marketplace de Visual Studio ( [https://marketplace.visualstudio.com/items?itemName=ms-vscs-rm.docker](https://marketplace.visualstudio.com/items?itemName=ms-vscs-rm.docker) ) cliquez sur **Install** :

[![](https://cloudyjourney.fr/wp-content/uploads/2018/01/pastedimage1485183295823v9.png)](https://cloudyjourney.fr/wp-content/uploads/2018/01/pastedimage1485183295823v9.png)

Puis choisissez sur quel compte VSTS l’installer :

[![](https://cloudyjourney.fr/wp-content/uploads/2018/01/pastedimage1485183307736v10.png)](https://cloudyjourney.fr/wp-content/uploads/2018/01/pastedimage1485183307736v10.png)

[![](https://cloudyjourney.fr/wp-content/uploads/2018/01/pastedimage1485183313529v11.png)](https://cloudyjourney.fr/wp-content/uploads/2018/01/pastedimage1485183313529v11.png)

Pour continuer, récupérez un token sur votre compte GitHub, qui a les permissions **repo, user, admin:repo\_hook** :

[![](https://cloudyjourney.fr/wp-content/uploads/2018/01/pastedimage1485183337281v12.png)](https://cloudyjourney.fr/wp-content/uploads/2018/01/pastedimage1485183337281v12.png)

Il faut maintenant associer votre compte GitHub avec notre VSTS. Ouvrez votre projet, puis cliquez sur **Settings > Services** :

[![](https://cloudyjourney.fr/wp-content/uploads/2018/01/pastedimage1485183426353v13.png)](https://cloudyjourney.fr/wp-content/uploads/2018/01/pastedimage1485183426353v13.png)

Ici, cliquez sur **New Service Endpoint > Github** :

[![](https://cloudyjourney.fr/wp-content/uploads/2018/01/pastedimage1485183441214v14.png)](https://cloudyjourney.fr/wp-content/uploads/2018/01/pastedimage1485183441214v14.png)

Dans la nouvelle fenêtre, renseignez le token que vous avez généré avant, ainsi que le nom de votre compte associé à ce token :

[![](https://cloudyjourney.fr/wp-content/uploads/2018/01/pastedimage1485183450417v15.png)](https://cloudyjourney.fr/wp-content/uploads/2018/01/pastedimage1485183450417v15.png)

[![](https://cloudyjourney.fr/wp-content/uploads/2018/01/pastedimage1485183456531v16.png)](https://cloudyjourney.fr/wp-content/uploads/2018/01/pastedimage1485183456531v16.png)

Il faut maintenant enregistrer la registry Docker, en cliquant sur **New Service Endpoint > Docker Registry** :

[![](https://cloudyjourney.fr/wp-content/uploads/2018/01/pastedimage1485183476807v17.png)](https://cloudyjourney.fr/wp-content/uploads/2018/01/pastedimage1485183476807v17.png)

Renseignez les informations de votre registry, que vous pouvez trouver sur Azure, dans la partie **Container Registry > Access Key** :

[![](https://cloudyjourney.fr/wp-content/uploads/2018/01/pastedimage1485183496075v18.png)](https://cloudyjourney.fr/wp-content/uploads/2018/01/pastedimage1485183496075v18.png)

[![](https://cloudyjourney.fr/wp-content/uploads/2018/01/pastedimage1485183502226v19.png)](https://cloudyjourney.fr/wp-content/uploads/2018/01/pastedimage1485183502226v19.png)

Pour terminer cette partie-là, il faut ajouter un service de type SSH. Donnez un nom, l’URL de connexion que vous retrouvez sur Azure, dans la partie Container Service, le port (2200 par défaut), le nom d’utilisateur que vous avez renseigné lors de la création de ACS et enfin, la clé privée utilisé à la création :

[![](https://cloudyjourney.fr/wp-content/uploads/2018/01/pastedimage1485183515099v20.png)](https://cloudyjourney.fr/wp-content/uploads/2018/01/pastedimage1485183515099v20.png)

[![](https://cloudyjourney.fr/wp-content/uploads/2018/01/pastedimage1485183522944v21.png)](https://cloudyjourney.fr/wp-content/uploads/2018/01/pastedimage1485183522944v21.png)

La partie configuration est maintenant terminée. Passons à la suite. Nous allons commencer par créer une build de base. Allez sur votre VSTS, puis dans **Build & Release**. Cliquez sur **New > Empty** :

[![](https://cloudyjourney.fr/wp-content/uploads/2018/01/pastedimage1485183543241v22.png)](https://cloudyjourney.fr/wp-content/uploads/2018/01/pastedimage1485183543241v22.png)

Cliquez ensuite sur **Github**, puis sélectionnez **Continuous integration** et enfin, choisissez l’agent de type **Default** :

[![](https://cloudyjourney.fr/wp-content/uploads/2018/01/pastedimage1485183559069v23.png)](https://cloudyjourney.fr/wp-content/uploads/2018/01/pastedimage1485183559069v23.png)

Sur votre nouvelle définition, cliquez sur **Repository** et sélectionnez le compte Github que vous avez configuré avant, ainsi que le repository que vous souhaitez utiliser pour le CD:

[![](https://cloudyjourney.fr/wp-content/uploads/2018/01/pastedimage1485183577462v24.png)](https://cloudyjourney.fr/wp-content/uploads/2018/01/pastedimage1485183577462v24.png)

Allez maintenant dans **Triggers** et sélectionnez **Continuous Integration**. Ceci aura pour effet de déclancher le trigger à chaque Commit de l’application :

[![](https://cloudyjourney.fr/wp-content/uploads/2018/01/pastedimage1485183595458v25.png)](https://cloudyjourney.fr/wp-content/uploads/2018/01/pastedimage1485183595458v25.png)

Puis cliquez sur **Save** :

[![](https://cloudyjourney.fr/wp-content/uploads/2018/01/pastedimage1485183606393v26.png)](https://cloudyjourney.fr/wp-content/uploads/2018/01/pastedimage1485183606393v26.png)

Mon application, que je souhaite déployer, contient une seule image, nginx. Je vais donc créer 2 Docker steps, une pour envoyer l’image sur ACS et l’autre sur ACR. Cliquez sur **Add build step…** dans **Build** :

[![](https://cloudyjourney.fr/wp-content/uploads/2018/01/pastedimage1485183629703v27.png)](https://cloudyjourney.fr/wp-content/uploads/2018/01/pastedimage1485183629703v27.png)

Choisissez **Docker** et cliquez sur **Add** 2 fois (pour ACS et ACR):

[![](https://cloudyjourney.fr/wp-content/uploads/2018/01/pastedimage1485183641860v28.png)](https://cloudyjourney.fr/wp-content/uploads/2018/01/pastedimage1485183641860v28.png)

Pour le premier build, sélectionnez la connexion vers votre registry, l’action **Build an image**, le chemin vers votre **Dockerfile** qui est sur Github, le chemin avec les sources et votre Dockerfile et pour finir, le nom de votre image, avec le chemin complet vers votre registry :

[![](https://cloudyjourney.fr/wp-content/uploads/2018/01/pastedimage1485245056754v1.png)](https://cloudyjourney.fr/wp-content/uploads/2018/01/pastedimage1485245056754v1.png)

Pour la partie push sur votre Registry, sélectionnez la connexion vers votre registry, l’action **Push an image** et enfin, le nom de votre image complète vers votre registry :

[![](https://cloudyjourney.fr/wp-content/uploads/2018/01/pastedimage1485245071906v2.png)](https://cloudyjourney.fr/wp-content/uploads/2018/01/pastedimage1485245071906v2.png)

Pour terminer, il faut ajouter la step suivante, uniquement si vous avez un docker-compose.yml, pour les applications multi-tiers. Sinon, passez à l’étape suivante :

- Command Line ()
    - Tool : bash
    - Arguments: -c "sed -i 's/BuildNumber/$(Build.BuildId)/g' sources/docker-compose.yml"

Et pour tout le monde, vous devez ajouter l’étape de publication de l’artifact, avec les sources :

- Publish Build Artifacts
    - Path to publish: sources
    - Artifact Name: FloAppWebsite2
    - Artifact Type: Server

[![](https://cloudyjourney.fr/wp-content/uploads/2018/01/pastedimage1485245087713v3.png)](https://cloudyjourney.fr/wp-content/uploads/2018/01/pastedimage1485245087713v3.png)

Cliquez sur **Save** pour sauvegarder la configuration.

Créez ensuite une nouvelle configuration pour la release, pour pousser le container sur votre ACS. Dans **Releases,** cliquez sur le **+** puis choisissez **Empty** et enfin, cliquez sur **Next** :

[![](https://cloudyjourney.fr/wp-content/uploads/2018/01/pastedimage1485245098989v4.png)](https://cloudyjourney.fr/wp-content/uploads/2018/01/pastedimage1485245098989v4.png)

Voici à quoi devrait ressembler votre release definition :

[![](https://cloudyjourney.fr/wp-content/uploads/2018/01/pastedimage1485245109770v5.png)](https://cloudyjourney.fr/wp-content/uploads/2018/01/pastedimage1485245109770v5.png)

Nous allons maintenant créer un articfact. Dans votre release, cliquez sur **Artifacts, Link an artifact source** et donnez un autre nom. Cliquez sur **Link :**

[![](https://cloudyjourney.fr/wp-content/uploads/2018/01/pastedimage1485245120699v6.png)](https://cloudyjourney.fr/wp-content/uploads/2018/01/pastedimage1485245120699v6.png)

Puis, passez le en tant que primaire :

[![](https://cloudyjourney.fr/wp-content/uploads/2018/01/pastedimage1485245130676v7.png)](https://cloudyjourney.fr/wp-content/uploads/2018/01/pastedimage1485245130676v7.png)

Cliquez maintenant sur **Triggers** et cochez la case **Continuous Deployment**, puis sélectionnez le nouvel artifact que vous avez créé juste avant :

[![](https://cloudyjourney.fr/wp-content/uploads/2018/01/pastedimage1485245144907v8.png)](https://cloudyjourney.fr/wp-content/uploads/2018/01/pastedimage1485245144907v8.png)

Sauvegardez. Cliquez sur **Add tasks** dans **Environments** dans votre nouvelle release, puis ajoutez une tache de type **SSH** avec la commande suivante et en décochant la case **Fail on STDERR :**

`docker login $(docker.registry) -u $(docker.username) -p $(docker.password) && export DOCKER_HOST=10.0.0.4:2375 && if docker inspect --format="{{ .State.Running }}" floappcicdwebsite >/dev/null 2>&1; then echo "Container floappcicdwebsite exist."; docker rm -f floappcicdwebsite; docker run --name floappcicdwebsite -d -p 80:80 floappregistry-on.azurecr.io/floappregistry/websitefloapp2:$(Build.BuildId); else echo "floappcicdwebsite does not exist, creation"; docker run --name floappcicdwebsite -d -p 80:80 floappregistry-on.azurecr.io/floappregistry/websitefloapp2:$(Build.BuildId); fi;`

La commande va se connecter à la registry, télécharger l’image et la déployer si elle n’existe pas déjà, ou la remplacer si elle est déjà existante, avec la dernière version publiée :

[![](https://cloudyjourney.fr/wp-content/uploads/2018/01/pastedimage1485245174238v9.png)](https://cloudyjourney.fr/wp-content/uploads/2018/01/pastedimage1485245174238v9.png)

Il faut ajouter 3 variables :

- username : contient le nom d’utilisateur pour se connecter à la registry
- password : contient le mot de passe associé à l’utilisateur pour se connecter à la registry
- registry : contient l’url pour se connecter à la registry

[![](https://cloudyjourney.fr/wp-content/uploads/2018/01/pastedimage1485245187535v10.png)](https://cloudyjourney.fr/wp-content/uploads/2018/01/pastedimage1485245187535v10.png)

N’oubliez pas de sauvegarder.

Il est maintenant temps de tester notre configuration. Pour commencer, modifiez votre code source, et envoyez-le sur Github. Après quelques secondes, sur votre VM où l’agent VSTS tourne, vous devriez voir ceci :

[![](https://cloudyjourney.fr/wp-content/uploads/2018/01/pastedimage1485245206749v11.png)](https://cloudyjourney.fr/wp-content/uploads/2018/01/pastedimage1485245206749v11.png)

Et depuis la console VSTS, je peux voir que l’étape de Build s’est bien déroulée :

[![](https://cloudyjourney.fr/wp-content/uploads/2018/01/pastedimage1485245222082v12.png)](https://cloudyjourney.fr/wp-content/uploads/2018/01/pastedimage1485245222082v12.png)

Tout comme la release :

[![](https://cloudyjourney.fr/wp-content/uploads/2018/01/pastedimage1485245231136v13.png)](https://cloudyjourney.fr/wp-content/uploads/2018/01/pastedimage1485245231136v13.png)

Et si j’essaye donc d’accéder à mon URL qui redistribue vers les agents Docker, j’ai ceci :

[![](https://cloudyjourney.fr/wp-content/uploads/2018/01/pastedimage1485245240192v14.png)](https://cloudyjourney.fr/wp-content/uploads/2018/01/pastedimage1485245240192v14.png)

Je vais maintenant modifier mon index.html, et l’envoyer sur mon GitHub. Voici du coté de l’agent VSTS ce qu’il se passe :

[![](https://cloudyjourney.fr/wp-content/uploads/2018/01/pastedimage1485245262423v15.png)](https://cloudyjourney.fr/wp-content/uploads/2018/01/pastedimage1485245262423v15.png)

Et du coté de VSTS, une nouvelle build, 35 (contre 34 avant), est disponible :

[![](https://cloudyjourney.fr/wp-content/uploads/2018/01/pastedimage1485245269906v16.png)](https://cloudyjourney.fr/wp-content/uploads/2018/01/pastedimage1485245269906v16.png)

Et la release :

[![](https://cloudyjourney.fr/wp-content/uploads/2018/01/pastedimage1485245278409v17.png)](https://cloudyjourney.fr/wp-content/uploads/2018/01/pastedimage1485245278409v17.png)

Voici ce que ça donne du côté de ma WebApp :

[![](https://cloudyjourney.fr/wp-content/uploads/2018/01/pastedimage1485245286172v18.png)](https://cloudyjourney.fr/wp-content/uploads/2018/01/pastedimage1485245286172v18.png)

Et en vidéo:

https://www.youtube.com/watch?v=3h0rXjt1emg

Pour conclure, cette nouvelle méthode va ravir vos développeurs mais aussi les admins. Les développeurs car ils seront autonomes, et auront juste à pousser leurs changements au niveau du code sur une un Git pour pouvoir le déployer en production. Et côté admin, fini les tâches répétitives qui ne sont pas toujours les plus intéressantes :)
