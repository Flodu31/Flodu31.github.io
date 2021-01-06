---
title: "[Azure] Application  Gateway - Fonctionnement"
date: "2019-07-30"
categories: 
  - "azure"
tags: 
  - "application-gateway"
  - "azure"
  - "microsoft"
  - "waf"
---

![](https://cloudyjourney.fr/wp-content/uploads/2018/01/Azure.png)

Si vous souhaitez migrer des serveurs IIS/Apache vers Azure, et exposer les sites de façon publique, il va bien entendu falloir protéger ces sites, comme vous le faites On-Premises. Pour faire ceci, Microsoft a fourni un service PaaS, l'Application Gateway, qui permet de load-balancer le trafic sur les ports Web que sont 80 et 443, directement vers un ou plusieurs serveurs. Basé sur une URL, qui pointera vers l'IP publique de l'App Gateway, le listener qui sera configuré, permettra de rediriger le trafic, en fonction d'une règle définie, vers une VM, un serveur On-Premises ou un VMSS:

![Application Gateway conceptual](https://docs.microsoft.com/en-us/azure/application-gateway/media/overview/figure1-720.png)

Ce service peut également faire office de Web Application Firewall (WAF) pour protéger contre les attaques, mais aussi de SSL Offloading, pour fournir uniquement du trafic sur le port 443, avec un certificat SSL, ett ensuite, rediriger le trafic interne vers un port autre, par exemple 8081.

![imageURLroute](https://docs.microsoft.com/en-us/azure/application-gateway/media/application-gateway-url-route-overview/figure1-720.png)

L'avantage de cette solution est que c'est simple à mettre en place,e t simple à gérer. Vous trouverez toutes les informations nécessaires à l'App Gateway ici: [https://docs.microsoft.com/en-us/azure/application-gateway/overview](https://docs.microsoft.com/en-us/azure/application-gateway/overview)

Ici, on va juste déployer un App Gateway + WAF. Dans l'article suivant, on verra la configuration de ce dernier. J'ai déjà déployé un serveur IIS, qui écoute sur le port 8081, en HTTP:

![](https://i1.wp.com/cloudyjourney.fr/wp-content/uploads/2019/07/AppGW11.png?fit=762%2C493&ssl=1)

Dans le portail Azure, chercher Application Gateway dans les service, et créez un nouvel App Gateway. Ici, je vais choisir le tier **WAF V2** car ce dernier présente le fait d'appliquer les changements beaucoup plus rapidement que la v1, entre autre. Je désactive ici l'auto scaling, et je renseigne 2 noeuds, ce qui est le minimum. Choisissez ensuite un réseau virtuel où sera lié votre App Gateway :

![](https://i1.wp.com/cloudyjourney.fr/wp-content/uploads/2019/07/AppGW01.png?fit=762%2C621&ssl=1)

Il faut ensuite créer une publique IP si le site doit être exposé publiquement, mais vous pouvez aussi utiliser une IP privée:

![](https://i0.wp.com/cloudyjourney.fr/wp-content/uploads/2019/07/AppGW02.png?fit=762%2C419&ssl=1)

Créez ensuite votre premier Backend pool qui contiendra un ou plusieurs serveurs où le site web est hébergé:

![](https://i2.wp.com/cloudyjourney.fr/wp-content/uploads/2019/07/AppGW03.png?fit=762%2C334&ssl=1)

Il faut ensuite ajouter une règle de routage. Donnez lui un nom (j'ai pour habitude de donner le nom du site qui va être utilisé par cette règle). Dans cette règle, il y aura un listener, sur le port 443 en HTTPS, avec un certificat (PFX obligatoire), de type multi site:

![](https://i1.wp.com/cloudyjourney.fr/wp-content/uploads/2019/07/AppGW04.png?fit=762%2C1006&ssl=1)

Dans la partie Backend target, je créais un nouveau HTTP setting, vers le port 8081, en HTTP. Ce sera ce port qui discutera avec le site web:

![](https://i2.wp.com/cloudyjourney.fr/wp-content/uploads/2019/07/AppGW05.png?fit=762%2C995&ssl=1)

Enfin, pour terminer, choisissez le backend que vous avez créé auparavant ainsi que le HTTP Setting créé juste avant:

![](https://i0.wp.com/cloudyjourney.fr/wp-content/uploads/2019/07/AppGW07.png?fit=762%2C897&ssl=1)

Vous avez maintenant tout ce qu'il vous faut pour passer à la suite du déploiement:

![](https://i0.wp.com/cloudyjourney.fr/wp-content/uploads/2019/07/AppGW08.png?fit=762%2C218&ssl=1)

Vous pouvez déployer votre App Gateway/WAF:

![](https://i1.wp.com/cloudyjourney.fr/wp-content/uploads/2019/07/AppGW09.png?fit=762%2C733&ssl=1)

Pour résumer, voici les éléments importants ici:

- Backend pool: contient un ou plusieurs serveurs, sur le même VNet que l'App Gateway, vers une IP On-Premises, etc.
- HTTP Settings: défini comment discuter avec le site qui est en backend
- Listeners: c'est ici que l'on va dire sur quelle URL on écoute, ainsi que le port et le certificat, si il y en a un
- Rules: la règle quant à elle permet d'orchestrer le tout, en prenant le trafic du listener, et l'associant avec un HTTP setting, et en le faisant pointer vers un backend pool
- Health probe (optionnel): permet de tester si un site, dans un backend pool, est fonctionnel ou non et si c'est donc un candidat pour afficher le site demandé

L'App Gateway est déployé et configuré. J'ai créé mon enregistrement **azure.florentappointaire.cloud** dans mon DNS, en le faisant pointer sur l'IP publique du WAF.

![](https://i1.wp.com/cloudyjourney.fr/wp-content/uploads/2019/07/AppGW10.png?fit=762%2C515&ssl=1)

Si je navigue maintenant sur https://azure.florentappointaire.cloud je devrais être redirigé sur mon serveur IIS:

![](https://i2.wp.com/cloudyjourney.fr/wp-content/uploads/2019/07/AppGW12.png?fit=762%2C422&ssl=1)

Ici, je suis bien en HTTPS, alors que mon site est configuré en HTTP. À noter que si vous avez des NSGs qui sont appliqués sur vos subnets/cartes réseaux, vous devrez ouvrir le port 8081 par exemple dans le NSG du serveur IIS et 443 dans celui de l'App Gateway.

Vous pouvez également tester la sécurité de votre WAF, en utilisant l'outil **Microsoft Security Risk Detection** : [https://www.microsoft.com/en-us/security-risk-detection/](https://www.microsoft.com/en-us/security-risk-detection/)

Si vous avez des questions, n'hésitez pas :) bonne implémentation et sécurisation de vos sites Web.
