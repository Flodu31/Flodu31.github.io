---
title: "[StarWind] Déployer Virtual SAN Free sur Azure"
date: "2017-04-27"
categories: 
  - "starwind"
tags: 
  - "azure"
  - "microsoft"
  - "starwind"
---

[![](https://cloudyjourney.fr/wp-content/uploads/2017/10/StarWind_Software.png)](https://cloudyjourney.fr/wp-content/uploads/2017/10/StarWind_Software.png)

Aujourd'hui, je vais vous montrer comment utiliser StarWind Virtual SAN Free sur Azure. Ceci vous permet de présenter des LUNs, à des VMs. vous utiliserez donc moins de disque que pour du Storage Space Direct par exemple, si vous n'utilisez pas le produit en HA bien sur.

Vous pouvez télécharger le produit et la licence ici: [https://www.starwindsoftware.com/starwind-virtual-san-free](https://www.starwindsoftware.com/starwind-virtual-san-free)

Le Quick Start guide se trouve ici: [https://www.starwindsoftware.com/technical\_papers/quick-start-guide-creating-ha-device-with-starwind-virtual-san-free.pdf](https://www.starwindsoftware.com/technical_papers/quick-start-guide-creating-ha-device-with-starwind-virtual-san-free.pdf)

Pour commencer, j'ai déployé l'infrastructure suivante sur Azure:

- Un groupe de ressource **StarWind**
- Un réseau virtuel **StarWindNetwork**
- 4 machines virtuelles:
    - Une machine VirtualSan avec 4 disques de 500GB
    - Une machine Node01 (jointe au domaine, avec le rôle File Server et la feature Failover Clustering)
    - Une machine Node02 (jointe au domaine, avec le rôle File Server et la feature Failover Clustering)
    - Une machine FLOAPP-DC02

Je fais une configuration de base. Il faudrait bien entendu séparer les réseaux (Stockage, Cluster, Management).

J'utilise des Managed Disks, comme ça, je n'ai pas besoin de me préoccuper de la localisation des disques (plus de LRS, GRS, ZRS, etc.).

Pour commencer, initialisez les disques sur la machines qui va accueillir le logiciel StarWind Virtual SAN Free et créez un volume. J'ai pour ma part fait un miroir, sur 2 volumes différents, F: et G:.

Démarrez l'installation du logiciel Starwind, après l'avoir téléchargé sur le serveur ainsi que la licence:

[![](https://cloudyjourney.fr/wp-content/uploads/2018/01/2017-04-11_17-50-51.png)](https://cloudyjourney.fr/wp-content/uploads/2018/01/2017-04-11_17-50-51.png)

Acceptez la licence:

[![](https://cloudyjourney.fr/wp-content/uploads/2018/01/2017-04-11_17-51-01.png)](https://cloudyjourney.fr/wp-content/uploads/2018/01/2017-04-11_17-51-01.png)

Relisez les informations concernant l'utilisation du produit:

[![](https://cloudyjourney.fr/wp-content/uploads/2018/01/2017-04-11_17-52-01.png)](https://cloudyjourney.fr/wp-content/uploads/2018/01/2017-04-11_17-52-01.png)

Choisissez où installer StarWind Virtual SAN:

[![](https://cloudyjourney.fr/wp-content/uploads/2018/01/2017-04-11_17-52-20.png)](https://cloudyjourney.fr/wp-content/uploads/2018/01/2017-04-11_17-52-20.png)

Ici, je vais choisir l'installation Full (avec le connecteur SMI-S, pour le connecter par la suite avec SCVMM):

[![](https://cloudyjourney.fr/wp-content/uploads/2018/01/2017-04-11_17-52-44.png)](https://cloudyjourney.fr/wp-content/uploads/2018/01/2017-04-11_17-52-44.png)

Choisissez où stocker le raccourci:

[![](https://cloudyjourney.fr/wp-content/uploads/2018/01/2017-04-11_17-52-55.png)](https://cloudyjourney.fr/wp-content/uploads/2018/01/2017-04-11_17-52-55.png)

Créez ou non un icône sur le bureau:

[![](https://cloudyjourney.fr/wp-content/uploads/2018/01/2017-04-11_17-53-11.png)](https://cloudyjourney.fr/wp-content/uploads/2018/01/2017-04-11_17-53-11.png)

Si vous vous êtes enregistré avec le lien au début de l'article, vous devez avoir une licence:

[![](https://cloudyjourney.fr/wp-content/uploads/2018/01/2017-04-11_17-53-28.png)](https://cloudyjourney.fr/wp-content/uploads/2018/01/2017-04-11_17-53-28.png)

Choisissez la licence que vous avez reçu:

[![](https://cloudyjourney.fr/wp-content/uploads/2018/01/2017-04-11_17-53-51.png)](https://cloudyjourney.fr/wp-content/uploads/2018/01/2017-04-11_17-53-51.png)

Les informations sur la licence sont disponibles:

[![](https://cloudyjourney.fr/wp-content/uploads/2018/01/2017-04-11_17-54-06.png)](https://cloudyjourney.fr/wp-content/uploads/2018/01/2017-04-11_17-54-06.png)

Voici le résumé de l'installation:

[![](https://cloudyjourney.fr/wp-content/uploads/2018/01/2017-04-11_17-54-22.png)](https://cloudyjourney.fr/wp-content/uploads/2018/01/2017-04-11_17-54-22.png)

L'installation est terminée, vous pouvez ouvrir la console:

[![](https://cloudyjourney.fr/wp-content/uploads/2018/01/2017-04-11_18-19-08.png)](https://cloudyjourney.fr/wp-content/uploads/2018/01/2017-04-11_18-19-08.png)

Au premier lancement, il va vous demander où stocker par défaut le storage pool. Dans mon cas, sur mon volume G: qui est en miroir:

[![](https://cloudyjourney.fr/wp-content/uploads/2018/01/2017-04-12_08-41-09.png)](https://cloudyjourney.fr/wp-content/uploads/2018/01/2017-04-12_08-41-09.png)

Cliquez droit sur le serveur, et choisissez **Add Device (advanced):**

[![](https://cloudyjourney.fr/wp-content/uploads/2018/01/2017-04-12_08-42-07.png)](https://cloudyjourney.fr/wp-content/uploads/2018/01/2017-04-12_08-42-07.png)

Choisissez d'ajouter un **Hard Disk Device:**

[![](https://cloudyjourney.fr/wp-content/uploads/2018/01/2017-04-12_08-42-40.png)](https://cloudyjourney.fr/wp-content/uploads/2018/01/2017-04-12_08-42-40.png)

Et choisissez le type **Virtual Disk**, car nous allons stocker ceci sur des disques virtuels:

[![](https://cloudyjourney.fr/wp-content/uploads/2018/01/2017-04-12_08-42-58.png)](https://cloudyjourney.fr/wp-content/uploads/2018/01/2017-04-12_08-42-58.png)

Choisissez où stocker votre virtual disk, ainsi que son nom et sa taille:

[![](https://cloudyjourney.fr/wp-content/uploads/2018/01/2017-04-12_08-43-13.png)](https://cloudyjourney.fr/wp-content/uploads/2018/01/2017-04-12_08-43-13.png)

Choisissez le type de provisionnement:

[![](https://cloudyjourney.fr/wp-content/uploads/2018/01/2017-04-12_08-43-27.png)](https://cloudyjourney.fr/wp-content/uploads/2018/01/2017-04-12_08-43-27.png)

Choisissez le paramètre de cache RAM:

[![](https://cloudyjourney.fr/wp-content/uploads/2018/01/2017-04-12_08-43-37.png)](https://cloudyjourney.fr/wp-content/uploads/2018/01/2017-04-12_08-43-37.png)

Et si vous avez un **Flash Cache** ou pas:

[![](https://cloudyjourney.fr/wp-content/uploads/2018/01/2017-04-12_08-43-47.png)](https://cloudyjourney.fr/wp-content/uploads/2018/01/2017-04-12_08-43-47.png)

Créez une nouvelle iSCSI target pour pouvoir vous connecter à ce serveur, depuis d'autres serveurs:

[![](https://cloudyjourney.fr/wp-content/uploads/2018/01/2017-04-12_08-44-05.png)](https://cloudyjourney.fr/wp-content/uploads/2018/01/2017-04-12_08-44-05.png)

Cliquez sur **Create** pour créer votre premier disque:

[![](https://cloudyjourney.fr/wp-content/uploads/2018/01/2017-04-12_08-44-15.png)](https://cloudyjourney.fr/wp-content/uploads/2018/01/2017-04-12_08-44-15.png)

Le disque a été créé avec succès:

[![](https://cloudyjourney.fr/wp-content/uploads/2018/01/2017-04-12_08-44-24.png)](https://cloudyjourney.fr/wp-content/uploads/2018/01/2017-04-12_08-44-24.png)

La vue depuis la console StarWind:

[![](https://cloudyjourney.fr/wp-content/uploads/2018/01/2017-04-12_08-44-39.png)](https://cloudyjourney.fr/wp-content/uploads/2018/01/2017-04-12_08-44-39.png)

Et depuis l'explorer:

[![](https://cloudyjourney.fr/wp-content/uploads/2018/01/2017-04-12_08-44-58.png)](https://cloudyjourney.fr/wp-content/uploads/2018/01/2017-04-12_08-44-58.png)

Sur chaque serveur du Cluster (Node01 et Node02 pour moi), lancez le logiciel **iSCSI Initiator** et cliquez sur **Yes:**

[![](https://cloudyjourney.fr/wp-content/uploads/2018/01/2017-04-12_09-00-11.png)](https://cloudyjourney.fr/wp-content/uploads/2018/01/2017-04-12_09-00-11.png)

Renseignez l'IP de votre serveur StarWind et cliquez sur **Quick Connect:**

[![](https://cloudyjourney.fr/wp-content/uploads/2018/01/2017-04-12_09-01-00.png)](https://cloudyjourney.fr/wp-content/uploads/2018/01/2017-04-12_09-01-00.png)

Une fois la connexion établie, vous devriez voir le statut **Connected:**

[![](https://cloudyjourney.fr/wp-content/uploads/2018/01/2017-04-12_09-01-13.png)](https://cloudyjourney.fr/wp-content/uploads/2018/01/2017-04-12_09-01-13.png)

[![](https://cloudyjourney.fr/wp-content/uploads/2018/01/2017-04-12_09-01-22.png)](https://cloudyjourney.fr/wp-content/uploads/2018/01/2017-04-12_09-01-22.png)

Si vous ouvrez l'explorer de management de disque, un nouveau disque est apparu:

[![](https://cloudyjourney.fr/wp-content/uploads/2018/01/2017-04-12_09-01-54.png)](https://cloudyjourney.fr/wp-content/uploads/2018/01/2017-04-12_09-01-54.png)

Initialisez le et créez un nouveau volume:

[![](https://cloudyjourney.fr/wp-content/uploads/2018/01/2017-04-12_09-02-06.png)](https://cloudyjourney.fr/wp-content/uploads/2018/01/2017-04-12_09-02-06.png)

Une fois terminé, que vous avez les 2 serveurs connectés, vous devriez voir les 2 iSCSI connectés dans la console StarWind:

[![](https://cloudyjourney.fr/wp-content/uploads/2018/01/2017-04-12_09-02-34.png)](https://cloudyjourney.fr/wp-content/uploads/2018/01/2017-04-12_09-02-34.png)

Ajoutez le disque au Cluster.

Si vous créez un SOFS, vous pouvez créer un nouveau partage, en stockant les données sur le disque:

[![](https://cloudyjourney.fr/wp-content/uploads/2018/01/2017-04-12_09-58-08.png)](https://cloudyjourney.fr/wp-content/uploads/2018/01/2017-04-12_09-58-08.png)

Vous pouvez vous connecter au share du SOFS et copier des données dedans:

[![](https://cloudyjourney.fr/wp-content/uploads/2018/01/2017-04-12_09-59-17.png)](https://cloudyjourney.fr/wp-content/uploads/2018/01/2017-04-12_09-59-17.png)

Vous avez la même vu depuis le CSV ou depuis le Share:

[![](https://cloudyjourney.fr/wp-content/uploads/2018/01/2017-04-12_10-00-15.png)](https://cloudyjourney.fr/wp-content/uploads/2018/01/2017-04-12_10-00-15.png)

Pour conclure, ce logiciel peut vous êtes utile si vous souhaitez faire des économies sur Azure, même si le stockage n'est pas la ressource la plus cher dans le cloud.
