---
title: "[Azure] Découverte de KeyVault"
date: "2017-05-29"
categories: 
  - "keyvault"
tags: 
  - "azure"
  - "keyvault"
  - "microsoft"
---

[![](https://cloudyjourney.fr/wp-content/uploads/2018/01/Keyvault.png)](https://cloudyjourney.fr/wp-content/uploads/2018/01/Keyvault.png)

Depuis quelques mois déjà, Microsoft a déployé sur la plateforme Azure, **Key Vault.** Cette solution vous permet de stocker, directement sur Azure, vos mots de passes, certificats, et même, de gérer/utiliser directement ces valeurs, via des APIs. Les ressources que vous mettez à disposition dans un Key Vault, peuvent être accèder depuis Azure Automation, Azure AD, etc. mais aussi depuis vos applications personnalisées.

Vous trouverez la documentation ici: [https://docs.microsoft.com/en-us/azure/key-vault/](https://docs.microsoft.com/en-us/azure/key-vault/)

Concernant le tarif de ce service, ceci dépend de l’utilisation. Les différents tarifs sont détaillés ici: [https://azure.microsoft.com/en-us/pricing/details/key-vault/](https://azure.microsoft.com/en-us/pricing/details/key-vault/)

## Création du premier vault

Pour créer votre vault, allez dans le Market place et cherchez **Key Vault**. Créez en un nouveau:

[![](https://cloudyjourney.fr/wp-content/uploads/2018/01/0167.KeyVault01.png)](https://cloudyjourney.fr/wp-content/uploads/2018/01/0167.KeyVault01.png)

Ceci prend quelques secondes pour déployer le vault. Quand c’est terminé, vous devriez avoir ceci:

[![](https://cloudyjourney.fr/wp-content/uploads/2018/01/3782.KeyVault02.png)](https://cloudyjourney.fr/wp-content/uploads/2018/01/3782.KeyVault02.png)

## Les **Secrets** dans Key Vault

Commençons par utiliser la partie **Secrets,** qui vous permet de stocker des certificats, mais aussi des mots de passes. Pour enregistrer un nouveau mot de passe, allez dans **Secrets > Add** et choisissez comme option d’envoie **Manual**. Fournissez un nom (les espaces ne sont pas autorisés) et la valeur de ce mot de passe. Vous pouvez également dire de quand à quand ce mot de passe est disponible:

[![](https://cloudyjourney.fr/wp-content/uploads/2018/01/2234.KeyVault03.png)](https://cloudyjourney.fr/wp-content/uploads/2018/01/2234.KeyVault03.png)

Faites de même pour un certificat de type PFX et renseignez le mot de passe pour ouvrir ce certificate. Si le mot de passe n’est pas bon, vous aurez un message d’erreur:

[![](https://cloudyjourney.fr/wp-content/uploads/2018/01/2234.KeyVault04.png)](https://cloudyjourney.fr/wp-content/uploads/2018/01/2234.KeyVault04.png)

Et avec le bon mot de passe:

[![](https://cloudyjourney.fr/wp-content/uploads/2018/01/5857.KeyVault05.png)](https://cloudyjourney.fr/wp-content/uploads/2018/01/5857.KeyVault05.png)

Vos 2 ressources sont maintenant déployées:

[![](https://cloudyjourney.fr/wp-content/uploads/2018/01/5857.KeyVault06.png)](https://cloudyjourney.fr/wp-content/uploads/2018/01/5857.KeyVault06.png)

Si vous souhaitez voir le contenu des services, il vous suffit d’aller sur le service en question, et de cliquer sur **Show secret value** et la valeur sera disponible:

[![](https://cloudyjourney.fr/wp-content/uploads/2018/01/4300.KeyVault07.png)](https://cloudyjourney.fr/wp-content/uploads/2018/01/4300.KeyVault07.png)

Vous pouvez également avoir un historique avec les différentes versions:

[![](https://cloudyjourney.fr/wp-content/uploads/2018/01/4300.KeyVault08.png)](https://cloudyjourney.fr/wp-content/uploads/2018/01/4300.KeyVault08.png)

## Les **Keys** dans Key Vault

Pour la partie **Key**, vous pouvez créer une key qui vous permettra de:

- Encrypt
- Sign
- Wrap Key
- Decrypt
- Verify
- Unwrap Key

Une fois cette clé généré, elle vous permettra de faire les operations précédentes, en utilisant son **Key identifier**:

[![](https://cloudyjourney.fr/wp-content/uploads/2018/01/3386.KeyVault09.png)](https://cloudyjourney.fr/wp-content/uploads/2018/01/3386.KeyVault09.png)

Vous pouvez utiliser cette clé depuis des applications, via des calls REST API, ou en PowerShell par exemple.

Vous pouvez également sauvegarder ces clés, directement depuis le portail Azure:

[![](https://cloudyjourney.fr/wp-content/uploads/2018/01/3386.KeyVault10.png)](https://cloudyjourney.fr/wp-content/uploads/2018/01/3386.KeyVault10.png)

Cette clé peut être restaurée depuis le portail Azure.

## Les permissions

Parce que certains mots de passes peuvent être critique, il ne faut pas les mettre entre toutes les mains :) C’est pourquoi vous pouvez gérer les permissions.

Cliquez sur **Add new:**

[![](https://cloudyjourney.fr/wp-content/uploads/2018/01/1638.KeyVault11.png)](https://cloudyjourney.fr/wp-content/uploads/2018/01/1638.KeyVault11.png)

Sélectionnez un utilisateur pour appliquer certaines permissions. Attention, vous donnez l’accès à toute une section, et pas seulement à une seule **Keys** ou **Secrets**. Mon utilisateur aura seulement accès aux **Keys:**

[![](https://cloudyjourney.fr/wp-content/uploads/2018/01/1638.KeyVault12.png)](https://cloudyjourney.fr/wp-content/uploads/2018/01/1638.KeyVault12.png)

Cliquez sur **Save** et connectez-vous au portail Azure avec l’utilisateur en question. Attention de bien donner les permissions **Read** sur le groupe de ressource où est déployé le Key Vault, sinon l’utilisateur ne le verra pas.

Ouvrez le Keyvault. Vous devriez avoir accès seulement à la partie **Keys** en Read/Write:

[![](https://cloudyjourney.fr/wp-content/uploads/2018/01/4452.KeyVault13.png)](https://cloudyjourney.fr/wp-content/uploads/2018/01/4452.KeyVault13.png)

C’est bien le cas. N’ayant pas les autorisations nécessaires pour la partie **Secrets,** j’ai le message d’erreur suivant:

[![](https://cloudyjourney.fr/wp-content/uploads/2018/01/4452.KeyVault14.png)](https://cloudyjourney.fr/wp-content/uploads/2018/01/4452.KeyVault14.png)

Et, j’ai un accès en **Read** sur les policies:

[![](https://cloudyjourney.fr/wp-content/uploads/2018/01/8176.KeyVault15.png)](https://cloudyjourney.fr/wp-content/uploads/2018/01/8176.KeyVault15.png)

## Conclusion

Pour conclure, ce service est la pour concurrencer des logiciels comme KeyPass, 1Password, etc. mais avec bien plus de fonctionnalité. En effet, vous pouvez appeler des mots de passes dans vos scripts PowerShell qui se trouvent dans le KeyVault, mais aussi dans vos applications .Net, Java, etc. Ce qui est très pratique pour les mises à jour régulières de mot de passe dans les entreprises (pour la sécurité) sans modifier le code des applications. Et le fait de pouvoir gérer les autorisations est un très gros atout. Et au prix du service, il ne faut surtout pas s’en priver :)
