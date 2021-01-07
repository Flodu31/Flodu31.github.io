---
title: "[Docker] Docker Datacenter dans Azure"
date: "2016-06-24"
author: "Florent Appointaire"
permalink: "/2016/06/24/docker-docker-datacenter-dans-azure/"
summary: 
categories: 
  - "azure"
  - "container"
tags: 
  - "azure"
  - "docker-datacenter"
  - "microsoft"
---
Docker Datacenter sur Azure et AWS a été annoncé ce Mardi 21 Juin 2016 à la [DockerCon](http://2016.dockercon.com/).

## Docker Datacenter, c’est quoi?

Docker Datacenter vous permet d'avoir, dans votre datacenter ou maintenant sur le Cloud, votre environnement Docker, comme la version officiel. C'est à dire, avec les interfaces de gestions, un repository, etc.

L’architecture qui va être déployée sur Azure est la suivante:

[![](https://cloudyjourney.fr/wp-content/uploads/2018/01/imgdockerdc01.png)](https://cloudyjourney.fr/wp-content/uploads/2018/01/imgdockerdc01.png)

## Installation

Avant de commencer, assurez-vous d’avoir une licence pour Docker Datacenter: [https://www.docker.com/products/docker-datacenter](https://www.docker.com/products/docker-datacenter "https://www.docker.com/products/docker-datacenter")

Sur Azure, il est très simple de déployer cette solution, via un Template ARM. Regardons comment faire. Connectez vous sur [https://portal.azure.com](https://portal.azure.com/) et cliquez sur **New**. Recherchez **Docker** dans le Marketplace et sélectionnez **Docker Datacenter:**

[![](https://cloudyjourney.fr/wp-content/uploads/2018/01/image_0D4FEA54.png)](https://cloudyjourney.fr/wp-content/uploads/2018/01/image_0D4FEA54.png)

Choisissez un nom d’utilisateur, un mot de passe ou une clé SSH qui sera utilisé pour toutes les VMs et un nouveau groupe de ressource:

[![](https://cloudyjourney.fr/wp-content/uploads/2018/01/image_05C70B98.png)](https://cloudyjourney.fr/wp-content/uploads/2018/01/image_05C70B98.png)

Choisissez un nom préfixe pour chaque ressource et ensuite, sélectionnez la taille des VMs qui seront crées. Créez un nouveau réseau ainsi que 2 sous réseaux, pour les contrôleurs et pour les nœuds et le docker trusted registry (DTR):

[![](https://cloudyjourney.fr/wp-content/uploads/2018/01/image_3CA3F08F.png)](https://cloudyjourney.fr/wp-content/uploads/2018/01/image_3CA3F08F.png)

Créez une IP publique pour le load-balancer des nœuds et pour le load-balancer du DTR. Associez un nom DNS publique à chacun d’entre eux. Enfin, choisissez un mot de passe pour l’administrateur du Universal Control Plane (UCP) et choisissez la clé que vous avez téléchargé précédemment:

[![](https://cloudyjourney.fr/wp-content/uploads/2018/01/image_0C1072D7.png)](https://cloudyjourney.fr/wp-content/uploads/2018/01/image_0C1072D7.png)

Vérifiez les informations que vous avez renseignez:

[![](https://cloudyjourney.fr/wp-content/uploads/2018/01/image_000E82A3.png)](https://cloudyjourney.fr/wp-content/uploads/2018/01/image_000E82A3.png)

En cliquant sur **Purchase,** vous acceptez les différentes licence  et le déploiement commence:

[![](https://cloudyjourney.fr/wp-content/uploads/2018/01/image_7DD48A97.png)](https://cloudyjourney.fr/wp-content/uploads/2018/01/image_7DD48A97.png)

Le déploiement a pris une vingtaine de minutes chez moi:

[![](https://cloudyjourney.fr/wp-content/uploads/2018/01/image_6CEFE6A7.png)](https://cloudyjourney.fr/wp-content/uploads/2018/01/image_6CEFE6A7.png)

## Découverte et configuration

Ouvrez un navigateur et allez sur votre URL ucp, dans mon cas, [https://dockerucp.florentappointaire.cloud](https://dockerucp.florentappointaire.cloud/):

[![](https://cloudyjourney.fr/wp-content/uploads/2018/01/image_05B6F41E.png)](https://cloudyjourney.fr/wp-content/uploads/2018/01/image_05B6F41E.png)

Connectez vous avez le nom d’utilisateur **admin** et utilisez le mot de passe que vous avez renseigné plus tôt, lors du déploiement. Si l’authentification est réussi, vous devriez arriver sur le Dashboard:

[![](https://cloudyjourney.fr/wp-content/uploads/2018/01/image_333813E1.png)](https://cloudyjourney.fr/wp-content/uploads/2018/01/image_333813E1.png)

De cette interface, vous allez pouvoir:

- Gérer les applications
- Gérer les conteurs
- Gérer les nœuds
- Gérer les volumes
- Gérer les réseaux
- Gérer les images

Mais aussi, gérer les utilisateurs et quelques paramètres.

## Sécurisation de la registry

Avant de commencer à remplir notre registry et de déployer des conteneurs, il va falloir sécuriser l’environnement pour que la communication entre l’UCP et la DTR soit sans faille.

Pour commencer, connectez vous en SSH sur votre nœud UCP:

[![](https://cloudyjourney.fr/wp-content/uploads/2018/01/image_131F7712.png)](https://cloudyjourney.fr/wp-content/uploads/2018/01/image_131F7712.png)

[![](https://cloudyjourney.fr/wp-content/uploads/2018/01/image_676EAD15.png)](https://cloudyjourney.fr/wp-content/uploads/2018/01/image_676EAD15.png)

Exécutez la commande suivante:

```
sudo docker run --rm --name ucp -v /var/run/docker.sock:/var/run/docker.sock docker/ucp dump-certs --cluster --ca
```

Après avoir téléchargé l’image **uc-dump-certs** et créé un nouveau conteneur, vous devriez avoir un résultat comme ceci:

[![](https://cloudyjourney.fr/wp-content/uploads/2018/01/image_1D8466FA.png)](https://cloudyjourney.fr/wp-content/uploads/2018/01/image_1D8466FA.png)

Copiez le résultat dans un fichier sur votre ordinateur et nommez le **ucp-cluster-ca.pem.** Connectez vous ensuite à votre DTR, dans mon cas [https://dockerdatacenter.florentappointaire.cloud](https://dockerdatacenter.florentappointaire.cloud/):

[![](https://cloudyjourney.fr/wp-content/uploads/2018/01/image_468F05F6.png)](https://cloudyjourney.fr/wp-content/uploads/2018/01/image_468F05F6.png)

Connectez vous avec le nom d’utilisateur **admin** et le mot de passe que vous avez renseigné lors de l’installation. Allez dans **Settings** et dans la partie **Domain,** cliquez sur **Show TLS Settings.** Copiez le contenu de la partie **TLS CA** dans un fichier sur votre ordinateur, qui se nommera **dtr-ca.pem:**

[![](https://cloudyjourney.fr/wp-content/uploads/2018/01/image_68E69B6F.png)](https://cloudyjourney.fr/wp-content/uploads/2018/01/image_68E69B6F.png)

Allez sur  votre interface UCP, dans **Settings > DTR** et renseignez l’URL de votre registry. Sélectionnez également le certificat **dtr-ca.pem** et cliquez sur **Update Registry:**

[![](https://cloudyjourney.fr/wp-content/uploads/2018/01/image_4B08176E.png)](https://cloudyjourney.fr/wp-content/uploads/2018/01/image_4B08176E.png)

Il faut maintenant truster l’UCP depuis le DTR. Dans l’interface du DTR, dans **Settings**, collez le contenu du certificat **ucp-cluster-ca.pem** dans **Auth ByPass TLS Root CA** et sauvegardez:

[![](https://cloudyjourney.fr/wp-content/uploads/2018/01/image_693B6B74.png)](https://cloudyjourney.fr/wp-content/uploads/2018/01/image_693B6B74.png)

Nous devons maintenant copier le fichier **dtr-ca.pem** sur chaque nœud de l’UCP (il y en a 7 par défaut). J’ai utilisé un serveur pour me connecter aux autres serveurs en ssh. J’ai alors exécuté les commandes suivantes:

```
sudo su - 
mkdir /etc/docker/certs.d/ 
mkdir /etc/docker/certs.d/dlbpiplabel.westeurope.cloudapp.azure.com/ 
vi /etc/docker/certs.d/dlbpiplabel.westeurope.cloudapp.azure.com/ca.crt
```

Collez le résultat du fichier **dtr-ca.pem.** Redémarrez le service docker avec la commande suivante:

`service docker restart`

[![](https://cloudyjourney.fr/wp-content/uploads/2018/01/image_6E86C138.png)](https://cloudyjourney.fr/wp-content/uploads/2018/01/image_6E86C138.png)

## Mise à jour du stockage des images dans DTR

Pour stocker les images Docker dans le repository, vous aurez besoin d’un compte de stockage. Je vais continuer sur Azure, et donc créer mon compte de stockage dessus:

[![](https://cloudyjourney.fr/wp-content/uploads/2018/01/image_1550B849.png)](https://cloudyjourney.fr/wp-content/uploads/2018/01/image_1550B849.png)

Récupérez ensuite les informations avec le nom du compte de stockage que vous avez choisi mais surtout la clé primaire pour y accéder:

[![](https://cloudyjourney.fr/wp-content/uploads/2018/01/image_7E253DCA.png)](https://cloudyjourney.fr/wp-content/uploads/2018/01/image_7E253DCA.png)

Dans l’interface DTR, allez dans **Settings > Storage** et choisissez **Azure**. Renseignez les informations que vous avez récupéré plus tôt:

##  [![](https://cloudyjourney.fr/wp-content/uploads/2018/01/image_5E0CC1BE.png)](https://cloudyjourney.fr/wp-content/uploads/2018/01/image_5E0CC1BE.png) Nouvelle image dans DTR

Nous allons maintenant pousser une image dans notre DTR, pour pouvoir déployer des conteneurs avec cette image. Connectez vous à DTR si ce n’est déjà fait et cliquez sur **New repository** pour créer un nouveau repository:

[![](https://cloudyjourney.fr/wp-content/uploads/2018/01/image_7BA06FB3.png)](https://cloudyjourney.fr/wp-content/uploads/2018/01/image_7BA06FB3.png)

Renseignez les champs et cliquez sur **Save**:

[![](https://cloudyjourney.fr/wp-content/uploads/2018/01/image_0DB25AA6.png)](https://cloudyjourney.fr/wp-content/uploads/2018/01/image_0DB25AA6.png)

Nous allons maintenant pousser une image sur ce repository. J’ai créé une image qui va faire tourner un site web (sous nginx) avec une page HTML, avec le Dockerfile suivant (les sources sont ici: [https://github.com/Flodu31/Floapp-Cloud](https://github.com/Flodu31/Floapp-Cloud "https://github.com/Flodu31/Floapp-Cloud")):

```
FROM nginx MAINTAINER Florent APPOINTAIRE <florent.appointaire@gmail.com> 
COPY index.html /usr/share/nginx/html/
```

Exécutez les commandes suivantes pour "construire" l’image:

`docker build –t floapp-website .`

[![](https://cloudyjourney.fr/wp-content/uploads/2018/01/image_0FEEE362.png)](https://cloudyjourney.fr/wp-content/uploads/2018/01/image_0FEEE362.png)

Copiez votre certificat **drt-ca.pem** sur votre machine où vous allez vous connecter avec les commandes Docker. Sur ma Debian, j’ai fait ceci:

[![](https://cloudyjourney.fr/wp-content/uploads/2018/01/image_30453320.png)](https://cloudyjourney.fr/wp-content/uploads/2018/01/image_30453320.png)

Il faut maintenant se connecter à ce hub pour pouvoir pusher notre image Docker. Ici, je vais me connecter avec le compte admin, compte avec lequel j’ai créé mon repository:

`docker login dlbpiplabel.westeurope.cloudapp.azure.com`

Bien sur, remplacez l’url par la votre.

Si vous avez l’erreur suivante, effectuez la manipulation suivante:

[![](https://cloudyjourney.fr/wp-content/uploads/2018/01/image_6B9898DE.png)](https://cloudyjourney.fr/wp-content/uploads/2018/01/image_6B9898DE.png)

```
vi /lib/systemd/system/docker.service 
#Remplacez ExecStart=/usr/bin/docker daemon -H fd:// par la ligne suivante ExecStart=/usr/bin/docker daemon -H fd:// --insecure-registry dlbpiplabel.westeurope.cloudapp.azure.com #Sauvegardez 
systemctl daemon-reload service docker restart 
ps aux | grep docker
```

[![](https://cloudyjourney.fr/wp-content/uploads/2018/01/image_26EBFE9D.png)](https://cloudyjourney.fr/wp-content/uploads/2018/01/image_26EBFE9D.png)

Il faut maintenant tagger l’image. Utilisez la commande suivante:

`docker tag floapp-website:latest dlbpiplabel.westeurope.cloudapp.azure.com/admin/floappwebsite:latest`

[![](https://cloudyjourney.fr/wp-content/uploads/2018/01/image_2563A630.png)](https://cloudyjourney.fr/wp-content/uploads/2018/01/image_2563A630.png)

On peut l’envoyer maintenant sur notre repository que l’on a créé précédemment:

`docker push dlbpiplabel.westeurope.cloudapp.azure.com/admin/floappwebsite:latest`

[![](https://cloudyjourney.fr/wp-content/uploads/2018/01/image_5E0E503D.png)](https://cloudyjourney.fr/wp-content/uploads/2018/01/image_5E0E503D.png)

L’envoi est terminé:

[![](https://cloudyjourney.fr/wp-content/uploads/2018/01/image_397CC2B9.png)](https://cloudyjourney.fr/wp-content/uploads/2018/01/image_397CC2B9.png)

## Déployer l’image FloAppWebsite

Nous allons maintenant créer un conteneur depuis cette image. Pour commencer, il faut télécharger l’image sur notre compte. Dans l’UCP, allez dans **Images** et cliquez sur **Pull image****:**

[![](https://cloudyjourney.fr/wp-content/uploads/2018/01/image_46E2D5BF.png)](https://cloudyjourney.fr/wp-content/uploads/2018/01/image_46E2D5BF.png)

Fournissez le nom de votre image, dans mon cas **dlbpiplabel.westeurope.cloudapp.azure.com/admin/floappwebsite,** et cliquez sur **Pull**:

[![](https://cloudyjourney.fr/wp-content/uploads/2018/01/image_30238E36.png)](https://cloudyjourney.fr/wp-content/uploads/2018/01/image_30238E36.png)

Après quelques secondes (ceci dépend de la taille de l’image), vous la verrez apparaître dans la liste des images disponibles:

[![](https://cloudyjourney.fr/wp-content/uploads/2018/01/image_16BB8AFC.png)](https://cloudyjourney.fr/wp-content/uploads/2018/01/image_16BB8AFC.png)

Allez maintenant dans **Containers** et cliquez sur **Deploy Container.** Donnez le nom de l’image, et adaptez les paramètres au besoin:

[![](https://cloudyjourney.fr/wp-content/uploads/2018/01/image_3FC629F8.png)](https://cloudyjourney.fr/wp-content/uploads/2018/01/image_3FC629F8.png)

[![](https://cloudyjourney.fr/wp-content/uploads/2018/01/image_06431A01.png)](https://cloudyjourney.fr/wp-content/uploads/2018/01/image_06431A01.png)

Cliquez sur **Run Container** à droite:

[![](https://cloudyjourney.fr/wp-content/uploads/2018/01/image_0F9EDF35.png)](https://cloudyjourney.fr/wp-content/uploads/2018/01/image_0F9EDF35.png)

Après quelques secondes, vous avez le nouveau conteneur:

[![](https://cloudyjourney.fr/wp-content/uploads/2018/01/image_18223E7F.png)](https://cloudyjourney.fr/wp-content/uploads/2018/01/image_18223E7F.png)

Si vous cliquez sur le conteneur, vous aurez la possibilité de voir le port qui est exposé, dans la partie **Network:**

[![](https://cloudyjourney.fr/wp-content/uploads/2018/01/image_133F8AC3.png)](https://cloudyjourney.fr/wp-content/uploads/2018/01/image_133F8AC3.png)

Pour pouvoir tester que tout fonctionne, j’ai déployé un VM dans le même réseau que les nœuds Docker UCP:

[![](https://cloudyjourney.fr/wp-content/uploads/2018/01/image_62433414.png)](https://cloudyjourney.fr/wp-content/uploads/2018/01/image_62433414.png)

Cette nouveauté est plutôt agréable, même si quelques bugs sont toujours présents, ceci va certainement résoudre certains casse-tête de certaines entreprises :)
