---
title: "[Azure DevOps] Terraform et Azure DevOps CI/CD - Part 2"
date: "2019-02-28"
author: "Florent Appointaire"
permalink: "/2019/02/28/azure-devops-terraform-et-azure-devops-ci-cd-part-2/"
summary:
categories: 
  - "azure-devops"
tags: 
  - "azure-devops"
  - "ci-cd"
  - "microsoft"
  - "terraform"
---
Après avoir vu dans la première partie comment mettre vos sources et les builds avec Azure DevOps, nous allons maintenant voir comment exécuter ces sources Terraform.

Dans votre portail DevOps, sélectionnez **Pipelines > Releases** et cliquez sur **New pipeline**:

![](https://cloudyjourney.fr/wp-content/uploads/2019/02/Azure_devops_part2_01.png)

Sélectionnez ensuite **Empty job**:

![](https://cloudyjourney.fr/wp-content/uploads/2019/02/Azure_devops_part2_02.png)

Renommez votre pipeline, choisissez la source build pipeline et comme version, sélectionnez la dernière, pour notre intégration CI/CD:

![](https://cloudyjourney.fr/wp-content/uploads/2019/02/Azure_devops_part2_03.png)

Cliquez sur l'éclair et activez le **CD (Continuous Deployment)**:

![](https://cloudyjourney.fr/wp-content/uploads/2019/02/Azure_devops_part2_04.png)

N'oubliez pas de sauvegarder. Ouvrez maintenant votre **Stage 1** et ajoutez les tâches suivantes, en cliquant sur le plus:

- Azure CLI
- Azure PowerShell
- Replace Tokens
- Run Terraform
- Run Terraform
- Run Terraform

Attention, **Replace Tokens** et **Run Terraform** doivent être installés depuis le store (gratuit) avant de pouvoir être utilisé.

![](https://cloudyjourney.fr/wp-content/uploads/2019/02/Azure_devops_part2_05.png)

Nous allons maintenant configurer les étapes. Pour la première étape, Azure CLI, vous pouvez la renommer, et ensuite, ajouter une subscription, avec un compte de type service principal, qui a les droits de faire des déploiements sur la subscription:

![](https://cloudyjourney.fr/wp-content/uploads/2019/02/Azure_devops_part2_06.png)

Choisissez **Inline script** et utilisez le script suivant, pour créer le groupe de ressource et le compte de stockage que l'on utilisera pour stocker notre fichier tfstate, qui donne une vue sur le déploiement:

```
call az group create --location westeurope --name $(terraformstoragerg)

call az storage account create --name $(terraformstorageaccount) --resource-group $(terraformstoragerg) --location westeurope --sku Standard_LRS

call az storage container create --name terraform --account-name $(terraformstorageaccount)
```

Vous devriez avoir ceci:

![](https://cloudyjourney.fr/wp-content/uploads/2019/02/Azure_devops_part2_07.png)

Ouvrez la deuxième étape, Azure PowerShell, et donnez lui un nom. Choisissez dans Azure Connection Type => Azure Resource Manager et choisissez la subscription que vous avez créé précédemment. Choisissez ensuite **Inline Script** et insérez le script suivant, pour récupérer la clé d'accès au compte de stockage:

```
$key=(Get-AzureRmStorageAccountKey -ResourceGroupName $(terraformstoragerg) -AccountName $(terraformstorageaccount)).Value[0]

Write-Host "##vso[task.setvariable variable=storagekey]$key"
```

Choisissez la dernière version disponible de PowerShell et sauvegardez. Vous devriez avoir ceci:

![](https://cloudyjourney.fr/wp-content/uploads/2019/02/Azure_devops_part2_08.png)

Pour la troisème étape, **Replace Tokens**, modifiez **Target files** en incluant tous les fichiers .tf, et dans **Advanced,** modifiez le **Token prefix** et **Token suffix** par les **\_\_** que l'on avait mis dans notre fichier **main.tf** ce qui va permettre d'aller récupérer les valeur des variables de la release plutôt que les valeurs du fichier **variables.tf**. Vous devriez avoir ceci:

![](https://cloudyjourney.fr/wp-content/uploads/2019/02/Azure_devops_part2_09.png)

Dans la 4ème étape, **Run Terraform**, fournissez un nom, choisissez le chemin vers le template (l'artifact, créé pendant le build) en cliquant sur ... et fournissez ensuite l'argument **init**. Cochez la case **Install terraform** avec comme version la dernière disponible et cochez la case pour utiliser le service principal Azure, et choisissez la subscription que l'on a créé précédemment:

![](https://cloudyjourney.fr/wp-content/uploads/2019/02/Azure_devops_part2_10.png)

Pour la cinquième étape, **Run Terraform**, c'est la même chose qu'à la quatrième étape, sauf que l'argument est **plan** au lieu de **init:**

![](https://cloudyjourney.fr/wp-content/uploads/2019/02/Azure_devops_part2_11.png)

Pour la dernière étape, c'est pareil que pour l'étape 5, sauf pour l'argument, qui doit être remplacé par **\-auto-approve**:

![](https://cloudyjourney.fr/wp-content/uploads/2019/02/Azure_devops_part2_12.png)

Sauvegardez. Allez dans l'onglet **Variables** et cliquez sur **Add**:

![](https://cloudyjourney.fr/wp-content/uploads/2019/02/Azure_devops_part2_13.png)

Ajoutez les variables suivantes, avec les valeurs de votre choix:

- location
- resource\_group
- terraformstorageaccount
- terraformstoragerg

![](https://cloudyjourney.fr/wp-content/uploads/2019/02/Azure_devops_part2_14.png)

Ma subscription est vide, comme vous pouvez le voir ci-dessous:

![](https://cloudyjourney.fr/wp-content/uploads/2019/02/Azure_devops_part2_15.png)

Pour lancer le déploiement, il suffit par exemple, de modifier le fichier de variable, dans le répertoire. Une fois que vous aurez commit, la build va se lancer (CI) et une fois la build terminé, la release va être créée (CD):

![](https://cloudyjourney.fr/wp-content/uploads/2019/02/Azure_devops_part2_16.png)

![](https://cloudyjourney.fr/wp-content/uploads/2019/02/Azure_devops_part2_17.png)

![](https://cloudyjourney.fr/wp-content/uploads/2019/02/Azure_devops_part2_18.png)

![](https://cloudyjourney.fr/wp-content/uploads/2019/02/Azure_devops_part2_19.png)

![](https://cloudyjourney.fr/wp-content/uploads/2019/02/Azure_devops_part2_20.png)

![](https://cloudyjourney.fr/wp-content/uploads/2019/02/Azure_devops_part2_21.png)

![](https://cloudyjourney.fr/wp-content/uploads/2019/02/Azure_devops_part2_22.png)

![](https://cloudyjourney.fr/wp-content/uploads/2019/02/Azure_devops_part2_25.png)

Comme vous pouvez le voir, tout s'est déroulé sans souci. Et sur Azure, j'ai maintenant mes ressources crées:

![](https://cloudyjourney.fr/wp-content/uploads/2019/02/Azure_devops_part2_23.png)

![](https://cloudyjourney.fr/wp-content/uploads/2019/02/Azure_devops_part2_24.png)

COmme vous avez pu le remarquer, l'intégration entre Terraform est Azure DevOps est assez simple et fonctionne à merveille. En modifiant un seul fichier dans un répertoire, vous pouvez automatiser toute la chaine de déploiement.
