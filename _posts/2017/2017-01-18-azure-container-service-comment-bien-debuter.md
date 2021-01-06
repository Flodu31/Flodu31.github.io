---
title: "[Azure] Container Service, comment bien débuter ?"
date: "2017-01-18"
categories: 
  - "azure-container-service"
tags: 
  - "acs"
  - "azure"
  - "azure-acontainer-service"
  - "docker"
  - "microsoft"
---

[![](https://cloudyjourney.fr/wp-content/uploads/2018/01/ACSLogo.png)](https://cloudyjourney.fr/wp-content/uploads/2018/01/ACSLogo.png)

Azure Container Service est une nouvelle technologie, introduite par Microsoft Azure, et qui vous permet de monter rapidement, avec la technologie ARM, un cluster Docker, orchestré en utilisant Marathon et DC/OS, Docker Swarm, ou Kubernetes pour rendre vos applications hautement disponibles, mais aussi pouvoir déployer des dizaines de nœuds supplémentaire rapidement et sans souci. La documentation Microsoft est disponible ici : [https://docs.microsoft.com/en-us/azure/container-service/container-service-intro](https://docs.microsoft.com/en-us/azure/container-service/container-service-intro)

Dans cet article, j’utiliserai la solution Docker Swarm :

[![](https://cloudyjourney.fr/wp-content/uploads/2018/01/pastedimage1484654354116v2.png)](https://cloudyjourney.fr/wp-content/uploads/2018/01/pastedimage1484654354116v2.png)

Pour commencer, recherchez **Azure Container Service** dans Azure :

[![](https://cloudyjourney.fr/wp-content/uploads/2018/01/pastedimage1484654359854v3.png)](https://cloudyjourney.fr/wp-content/uploads/2018/01/pastedimage1484654359854v3.png)

Pour commencer le déploiement, il vous faut la clé publique de l’ordinateur/serveur où vous allez vous connecter la première fois. Pour récupérer votre clé publique sur Windows, vous devez télécharger **PuttyGen :**[http://www.chiark.greenend.org.uk/~sgtatham/putty/download.html](http://www.chiark.greenend.org.uk/~sgtatham/putty/download.html)

Cliquez sur **Generate** et bougez la souris jusqu’à que la barre verte soit remplie :

[![](https://cloudyjourney.fr/wp-content/uploads/2018/01/pastedimage1484654753518v4.png)](https://cloudyjourney.fr/wp-content/uploads/2018/01/pastedimage1484654753518v4.png)

Vous devriez avoir ceci :

[![](https://cloudyjourney.fr/wp-content/uploads/2018/01/pastedimage1484654761352v5.png)](https://cloudyjourney.fr/wp-content/uploads/2018/01/pastedimage1484654761352v5.png)

Cliquez sur **Save public key** et sauvegardez la clé. Faites de même avec la clé privée. Ouvrez la clé publique et collez la dans Azure :

[![](https://cloudyjourney.fr/wp-content/uploads/2018/01/pastedimage1484654774094v6.png)](https://cloudyjourney.fr/wp-content/uploads/2018/01/pastedimage1484654774094v6.png)

Choisissez le type d’orchestrateur que vous souhaitez utiliser, dans mon cas, Docker Swarm :

[![](https://cloudyjourney.fr/wp-content/uploads/2018/01/pastedimage1484654779961v7.png)](https://cloudyjourney.fr/wp-content/uploads/2018/01/pastedimage1484654779961v7.png)

Choisissez ensuite le nombre de nœuds/master pour votre cluster, ainsi qu’un nom DNS publique et la taille des machines :

[![](https://cloudyjourney.fr/wp-content/uploads/2018/01/pastedimage1484654784390v8.png)](https://cloudyjourney.fr/wp-content/uploads/2018/01/pastedimage1484654784390v8.png)

Si la validation est OK, vous pouvez continuer. Vous pouvez également télécharger le template si vous souhaitez déployer plus facilement et rapidement le même cluster la prochaine fois :

[![](https://cloudyjourney.fr/wp-content/uploads/2018/01/pastedimage1484654790879v9.png)](https://cloudyjourney.fr/wp-content/uploads/2018/01/pastedimage1484654790879v9.png)

Acceptez la licence pour que le déploiement commence :

[![](https://cloudyjourney.fr/wp-content/uploads/2018/01/pastedimage1484654796307v10.png)](https://cloudyjourney.fr/wp-content/uploads/2018/01/pastedimage1484654796307v10.png)

[![](https://cloudyjourney.fr/wp-content/uploads/2018/01/pastedimage1484654826295v13.png)](https://cloudyjourney.fr/wp-content/uploads/2018/01/pastedimage1484654826295v13.png)

Le déploiement est maintenant terminé :

[![](https://cloudyjourney.fr/wp-content/uploads/2018/01/pastedimage1484654818806v12.png)](https://cloudyjourney.fr/wp-content/uploads/2018/01/pastedimage1484654818806v12.png)

Par défaut, vous ne pouvez pas vous connecter depuis l’extérieur en direct à votre cluster. Vous devez pour cela créer un tunnel SSH. Sur Windows, avec putty, connectez-vous avez les paramètres suivants :

- Host Name : utilisateur@nomdnspublique
- Port : 2200
- Connection > Auth > SSH : Sélectionnez votre clé privée

[![](https://cloudyjourney.fr/wp-content/uploads/2018/01/pastedimage1484654871404v14.png)](https://cloudyjourney.fr/wp-content/uploads/2018/01/pastedimage1484654871404v14.png) [![](https://cloudyjourney.fr/wp-content/uploads/2018/01/pastedimage1484654879964v15.png)](https://cloudyjourney.fr/wp-content/uploads/2018/01/pastedimage1484654879964v15.png)

Parce que j’utilise Swarm, je vais associer le port 2375 en source à la destination localhost sur le port 2375 dans Connection > Auth > Tunnels, et cliquez sur **Add :**

[![](https://cloudyjourney.fr/wp-content/uploads/2018/01/pastedimage1484654887452v16.png)](https://cloudyjourney.fr/wp-content/uploads/2018/01/pastedimage1484654887452v16.png)

Sauvegardez la configuration et cliquez sur **Open** pour ouvrir le tunnel SSH.

Récupérez l’adresse IP privée de votre Master (172.16.0.5 par défaut) et regardez les nœuds qui composent votre cluster :

`docker -H 172.16.0.5:2375 info`

J’ai ici 3 nœuds :

[![](https://cloudyjourney.fr/wp-content/uploads/2018/01/pastedimage1484654927608v17.png)](https://cloudyjourney.fr/wp-content/uploads/2018/01/pastedimage1484654927608v17.png)

Je vais déployer un simple site web customisé, sur le port 80. Ce port est exposé sur le load-balancer, tout comme le port 8080 et 443. J’ai donc créé un fichier Dockerfile et index.html :

**Dockerfile :**

`FROM nginx`

`MAINTAINER Florent APPOINTAIRE <florent.appointaire@gmail.com>`

`COPY index.html /usr/share/nginx/html/`

**index.html :**

`<html>`

 `<head>`

 `<link href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.5/css/bootstrap.min.css" rel="stylesheet" integrity="sha256-MfvZlkHCEqatNoGiOXveE8FIwMzZg4W85qfrfIFBfYc= sha512-dTfge/zgoMYpP7QbHy4gWMEGsbsdZeCXz7irItjcC3sPUFtf0kuFbDz/ixG7ArTxmDjLXDmezHubeNikyKGVyQ==" crossorigin="anonymous">`

 `<title>FlorentAppointaire.cloud</title>`

 `</head>`

 `<body>`

 `<div class="container">`

 `<h1>Hello from ACS</h1>`

 `<p>You are running this container on Azure Container Service :)</p>`

 `</div>`

 `</body>`

`</html>`

Exécutez la commande suivante pour construire l’image :

`docker -H 172.16.0.5:2375 build -t floappwebsite .`

`docker -H 172.16.0.5:2375 images`

[![](https://cloudyjourney.fr/wp-content/uploads/2018/01/pastedimage1484655013140v18.png)](https://cloudyjourney.fr/wp-content/uploads/2018/01/pastedimage1484655013140v18.png)

Et pour la déployer :

`docker -H 172.16.0.5:2375 run --name floappwebsite -d -p 80:80 floappwebsite`

`docker -H 172.16.0.5:2375 ps`

[![](https://cloudyjourney.fr/wp-content/uploads/2018/01/pastedimage1484655036910v19.png)](https://cloudyjourney.fr/wp-content/uploads/2018/01/pastedimage1484655036910v19.png)

Vous pouvez voir également sur quel nœud tourne le container.

Pour accéder à votre site web de façon publique, allez dans votre interface Azure, dans la partie ACS, votre ACS puis Agents. Ici, sélectionnez l’URL qui se trouve sous **FQDN**:

[![](https://cloudyjourney.fr/wp-content/uploads/2018/01/pastedimage1484655051991v20.png)](https://cloudyjourney.fr/wp-content/uploads/2018/01/pastedimage1484655051991v20.png)

Ouvrez la dans un navigateur. Vous devriez arriver sur votre page web customisée :

[![](https://cloudyjourney.fr/wp-content/uploads/2018/01/pastedimage1484655075325v21.png)](https://cloudyjourney.fr/wp-content/uploads/2018/01/pastedimage1484655075325v21.png)

Si vous souhaitez rajouter des nœuds, rien de plus simple. Sur votre ACS, allez dans **Agents** et changez la valeur de **VM Count**, puis cliquez sur **Save** (je suis passé de 2 à 3 agents). Une nouvelle VM avec le nouvel agent sera déployée :

[![](https://cloudyjourney.fr/wp-content/uploads/2018/01/pastedimage1484655081050v22.png)](https://cloudyjourney.fr/wp-content/uploads/2018/01/pastedimage1484655081050v22.png)

Dans le prochain article, nous verrons la partie Azure Container Registry (Preview) :)
