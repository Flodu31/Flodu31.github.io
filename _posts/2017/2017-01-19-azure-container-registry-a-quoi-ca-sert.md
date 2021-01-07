---
title: "[Azure] Container Registry, à quoi ça sert ?"
date: "2017-01-19"
author: "Florent Appointaire"
permalink: "/2017/01/19/azure-container-registry-a-quoi-ca-sert/"
categories: 
  - "azure-container-registry"
tags: 
  - "acr"
  - "acs"
  - "azure"
  - "azure-container-registry"
  - "microsoft"
---
Azure Container Registry est un service Azure, qui permet de créer votre propre Registry, pour stocker vos images de façon privée. Ceci à l’avantage de pouvoir déployer bien plus rapidement, car dans le même réseau, vos différentes images. Par défaut, la plateforme Docker propose d’héberger vos images gratuitement de façon publique, sur [https://hub.docker.com](https://hub.docker.com/) mais aussi de façon privée, si vous prenez un abonnement.

Cette registry est disponible avec les clusters de type Docker Swarm, DC/OS, et Kubernetes.

La documentation complète est disponible ici : [https://docs.microsoft.com/en-us/azure/container-registry/container-registry-intro](https://docs.microsoft.com/en-us/azure/container-registry/container-registry-intro)

Pour créer votre propre registry, allez sur le portail Azure puis recherchez **Azure Container Registry** :

[![](https://cloudyjourney.fr/wp-content/uploads/2018/01/pastedimage1484733728652v2.png)](https://cloudyjourney.fr/wp-content/uploads/2018/01/pastedimage1484733728652v2.png)

Cliquez dessus pour commencer la création puis donnez-lui un nom, un groupe de ressource, la location, si vous souhaitez authoriser les admins à push/pull les images sur ce registry (l’authentification Azure AD peut également être utilisé pour l’authentification à votre registry) et définissez un compte de stockage, où les images seront stockées :

[![](https://cloudyjourney.fr/wp-content/uploads/2018/01/pastedimage1484733743470v3.png)](https://cloudyjourney.fr/wp-content/uploads/2018/01/pastedimage1484733743470v3.png)

Si vous allez dans le menu **Container Registry**, vous verrez que votre registry a bien été créée :

[![](https://cloudyjourney.fr/wp-content/uploads/2018/01/pastedimage1484733762021v4.png)](https://cloudyjourney.fr/wp-content/uploads/2018/01/pastedimage1484733762021v4.png)

Dans la partie **Access Key,** vous avez les informations pour vous connecter à votre registry :

[![](https://cloudyjourney.fr/wp-content/uploads/2018/01/pastedimage1484733773833v5.png)](https://cloudyjourney.fr/wp-content/uploads/2018/01/pastedimage1484733773833v5.png)

Allons tester ceci de suite. Basé sur [mon précédent article](https://cloudyjourney.fr/2017/01/18/azure-container-service-comment-bien-debuter/), je vais déployer une nouvelle image sur ma registry, et ensuite, je déploierai cette image sur un autre environnement Docker.

Sur mon ACS, je vais créer un Dockerfile et un index.html :

**Dockerfile:**

```
FROM nginx
MAINTAINER Florent APPOINTAIRE [florent.appointaire@gmail.com]
COPY index.html /usr/share/nginx/html/
```

**Index.html**

```
<html>
<head>
<link href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.5/css/bootstrap.min.css" rel="stylesheet" integrity="sha256-MfvZlkHCEqatNoGiOXveE8FIwMzZg4W85qfrfIFBfYc= sha512-dTfge/zgoMYpP7QbHy4gWMEGsbsdZeCXz7irItjcC3sPUFtf0kuFbDz/ixG7ArTxmDjLXDmezHubeNikyKGVyQ==" crossorigin="anonymous">
<title>FlorentAppointaire.cloud</title>
</head>
<body>
<div class="container">
<h1>Hello from ACS & Docker Registry</h1>
<p>You are running this container on Azure Container Service and this image has been deployed from Azure Container Registry:)</p>
</div>
</body>
</html>
```

La première étape va être de se connecter à notre docker registry. Pour effectuer ceci, récupérer l’URL de connexion, que vous avez récupéré dans la partie **Access key**. Pour ma part, c’est **floappregistry-on.azurecr.io**.

Utilisez donc la commande **docker login** pour vous connecter à cette registry et renseignez le nom d’utilisateur/mot de passe que vous avez également récupéré dans la partie **Access key** :

`docker login floappregistry-on.azurecr.io`

Si tout s’est bien déroulé, vous devriez avoir **Login Succedeed :**

[![](https://cloudyjourney.fr/wp-content/uploads/2018/01/pastedimage1484733865545v7.png)](https://cloudyjourney.fr/wp-content/uploads/2018/01/pastedimage1484733865545v7.png)

Nous allons maintenant compiler ce Dockerfile et ensuite, l’envoyer sur notre registry. Je vais donc utiliser la commande suivante, en faisant attention à bien créer des sous dossier dans mon compte de stockage, pour ne pas avoir toutes les images au même endroit. Je vais créer un sous dossier par utilisateur :

`docker -H 172.16.0.5:2375 build -t floappregistry-on.azurecr.io/floappregistry/floappwebsite .`

[![](https://cloudyjourney.fr/wp-content/uploads/2018/01/pastedimage1484733904475v8.png)](https://cloudyjourney.fr/wp-content/uploads/2018/01/pastedimage1484733904475v8.png)

`docker -H 172.16.0.5:2375 images`

[![](https://cloudyjourney.fr/wp-content/uploads/2018/01/pastedimage1484733913365v9.png)](https://cloudyjourney.fr/wp-content/uploads/2018/01/pastedimage1484733913365v9.png)

Pour envoyer votre image sur votre registry, utilisez la commande suivante :

`docker -H 172.16.0.5:2375 push floappregistry-on.azurecr.io/floappregistry/floappwebsite`

Quand l’envoie est terminé, vous devriez avoir ceci :

[![](https://cloudyjourney.fr/wp-content/uploads/2018/01/pastedimage1484733936340v10.png)](https://cloudyjourney.fr/wp-content/uploads/2018/01/pastedimage1484733936340v10.png)

Et la vue depuis mon compte de stockage sur Azure :

[![](https://cloudyjourney.fr/wp-content/uploads/2018/01/pastedimage1484733941459v11.png)](https://cloudyjourney.fr/wp-content/uploads/2018/01/pastedimage1484733941459v11.png)

Depuis un autre serveur docker, qui se trouve chez moi, je vais utiliser cette image. Pour commencer, vérifions que cette image n’existe pas sur mon serveur :

[![](https://cloudyjourney.fr/wp-content/uploads/2018/01/pastedimage1484733947192v12.png)](https://cloudyjourney.fr/wp-content/uploads/2018/01/pastedimage1484733947192v12.png)

Pour télécharger l’image, utilisez la commande suivante :

`docker login floappregistry-on.azurecr.io`

`docker pull floappregistry-on.azurecr.io/floappregistry/floappwebsite`

[![](https://cloudyjourney.fr/wp-content/uploads/2018/01/pastedimage1484733964342v13.png)](https://cloudyjourney.fr/wp-content/uploads/2018/01/pastedimage1484733964342v13.png)

L’image est bien maintenant sur notre serveur Docker :

[![](https://cloudyjourney.fr/wp-content/uploads/2018/01/pastedimage1484733969339v14.png)](https://cloudyjourney.fr/wp-content/uploads/2018/01/pastedimage1484733969339v14.png)

Déployez maintenant cette image :

`docker run –-name floappregistrywebsite -d -p 8080:8080 floappregistry-on.azurecr.io/floappregistry/floappwebsite`

[![](https://cloudyjourney.fr/wp-content/uploads/2018/01/pastedimage1484733982840v15.png)](https://cloudyjourney.fr/wp-content/uploads/2018/01/pastedimage1484733982840v15.png)

Et si je tente d’y accéder :

[![](https://cloudyjourney.fr/wp-content/uploads/2018/01/pastedimage1484733999578v17.png)](https://cloudyjourney.fr/wp-content/uploads/2018/01/pastedimage1484733999578v17.png)

Vous pouvez très bien faire l’inverse. Vos développeurs créent leur image en local sur leur serveur/machine puis pousse l’image sur votre registry, que vous déployez en production sur vos ACS :)

Voyons maintenant comment activer l’authentification Azure Active Directory sur votre registry.

Pour commencer, vous devez avoir un Azure AD fonctionnel. Il faut ensuite créer une application, de type WebApp/API :

[![](https://cloudyjourney.fr/wp-content/uploads/2018/01/pastedimage1484734024898v18.png)](https://cloudyjourney.fr/wp-content/uploads/2018/01/pastedimage1484734024898v18.png)

Quand ceci est terminé, vous devez récupérer l’application ID de votre application :

[![](https://cloudyjourney.fr/wp-content/uploads/2018/01/pastedimage1484734029874v19.png)](https://cloudyjourney.fr/wp-content/uploads/2018/01/pastedimage1484734029874v19.png)

Puis créer une clé :

[![](https://cloudyjourney.fr/wp-content/uploads/2018/01/pastedimage1484734034721v20.png)](https://cloudyjourney.fr/wp-content/uploads/2018/01/pastedimage1484734034721v20.png)

Et enfin, il faut récupérer le tenant ID de votre Azure AD :

[![](https://cloudyjourney.fr/wp-content/uploads/2018/01/pastedimage1484734038732v21.png)](https://cloudyjourney.fr/wp-content/uploads/2018/01/pastedimage1484734038732v21.png)

Pour terminer, il faut donner accès en Read, à votre groupe de ressource où est la registry, à votre application :

[![](https://cloudyjourney.fr/wp-content/uploads/2018/01/pastedimage1484734046793v22.png)](https://cloudyjourney.fr/wp-content/uploads/2018/01/pastedimage1484734046793v22.png)

Pour vous connecter, vous pouvez maintenant utiliser cette application (-u et le mot de passe que vous avez récupéré auparavant), et non plus la combinaison utilisateur/mot de passe :

`docker login floappregistry-on.azurecr.io -u bb1d5b4c-3556-44ff-adc2-ecf4d4e9ffd2`

[![](https://cloudyjourney.fr/wp-content/uploads/2018/01/pastedimage1484734056906v23.png)](https://cloudyjourney.fr/wp-content/uploads/2018/01/pastedimage1484734056906v23.png)

La seule fonction qui manque pour avoir un service parfait est l’authentification avec son propre compte Azure AD, sous la forme [florent.appointaire@mail.cloud](mailto:florent.appointaire@mail.cloud) .
