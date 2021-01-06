---
title: "[Azure] Récupérer une valeur dans un keyvault pour Terraform"
date: "2019-05-22"
categories: 
  - "azure"
  - "terraform"
tags: 
  - "azure"
  - "keyvault"
  - "microsoft"
  - "terraform"
---

![](https://cloudyjourney.fr/wp-content/uploads/2019/05/terraform_logo.jpg)

Par défaut, si vous souhaitez déployer une VM sur Azure avec Terraform, vous devez donner le nom d'utilisateur et le mot de passe en claire dans le fichier de variables ([voir mon article précédent](https://cloudyjourney.fr/2019/05/15/azure-deployer-des-ressources-avec-terraform/)). Mais une solution existe, pour sécuriser tout ça :) Il suffit d'utiliser un Azure Keyvault, et de stocker votre mot de passe dedans:

![](https://i0.wp.com/cloudyjourney.fr/wp-content/uploads/2019/05/Terraform_Keyvault01.png?fit=762%2C236&ssl=1)

Ensuite, il faut rajouter ces lignes, au début de votre code:

```
// Get Keyvault Data
data "azurerm_resource_group" "rg_keyvault" {
  name                = "${var.rg_keyvault}"
}
data "azurerm_key_vault" "keyvault" {
  name                = "${var.keyvault_name}"
  resource_group_name = "${data.azurerm_resource_group.rg_keyvault.name}"
}
data "azurerm_key_vault_secret" "secret_Default-Admin-Windows-Linux-VM" {
  name      = "Default-Admin-Windows-Linux-VM"
  vault_uri = "${data.azurerm_key_vault.keyvault.vault_uri}"
}
```

Ici on va récupérer le RG, le Keyvault, et le secret qui a le nom **Default-Admin-Windows-Linux-VM** dans mon keyvault et qui contient mon mot de passe par défaut pour mes VMs. Il faut ensuite adapter le code, pour que notre variable **admin\_password** prenne la valeur qui se trouve dans le keyvault:

```
admin_password            = "${data.azurerm_key_vault_secret.secret_Default-Admin-Windows-Linux-VM.value}"
```

Vous pouvez maintenant faire un **terraform init** et **terraform plan**. Vous devriez avoir l'erreur suivante:

![](https://i2.wp.com/cloudyjourney.fr/wp-content/uploads/2019/05/Terraform_Keyvault02.png?fit=762%2C104&ssl=1)

Ceci est normal. En effet, vous devez donner les droits **Get** et **List** sur les **secret** à l'application qui est utilisé pour déployer les ressources dans Azure via Terraform, dans le keyvault:

![](https://i2.wp.com/cloudyjourney.fr/wp-content/uploads/2019/05/Terraform_Keyvault03-1.png?fit=762%2C426&ssl=1)

Vous pouvez refaire un **terraform plan** et **terraform** **apply** pour déployer vos ressources, de façon sécurisé. Notez ce message d'erreur, qui disparaitra lors de la mise à jour vers la version 2 du provider, mais où vous devrez adapter le code:

![](https://i2.wp.com/cloudyjourney.fr/wp-content/uploads/2019/05/Terraform_Keyvault03.png?fit=762%2C78&ssl=1)

Tout ce code est disponible sur mon Github: [https://github.com/Flodu31/Terraform/tree/master/Deploy\_New\_Environment](https://github.com/Flodu31/Terraform/tree/master/Deploy_New_Environment_Keyvault)[\_Keyvault](https://github.com/Flodu31/Terraform/tree/master/Deploy_New_Environment_Keyvault)
