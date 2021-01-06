---
title: "[Azure] Exécutez des commandes dans une VM via Terraform"
date: "2019-07-16"
categories: 
  - "azure"
  - "terraform"
tags: 
  - "azure"
  - "microsoft"
  - "provider"
  - "terraform"
---

![](https://cloudyjourney.fr/wp-content/uploads/2019/05/terraform_logo.jpg)

Après mes 2 premiers articles sur [le déploiement de ressources dans Azure](https://cloudyjourney.fr/2019/05/15/azure-deployer-des-ressources-avec-terraform/) et [l'utilisation d'un keyvault](https://cloudyjourney.fr/2019/05/22/azure-recuperer-une-valeur-dans-un-keyvault-pour-terraform/) pour stocker les mots de passes, nous allons voir comment exécuter des commandes directement au moment du déploiement de la ressource.

Pour faire de la configuration de VM, vous pouvez par exemple utiliser des outils comme Ansible, DSC, etc. Avec Terraform, vous pouvez utiliser des **Provisioners**: [https://www.terraform.io/docs/provisioners/index.html](https://www.terraform.io/docs/provisioners/index.html)

Des exemples sont disponibles ici: [https://github.com/terraform-providers/terraform-provider-azurerm/tree/master/examples/virtual-machines/provisioners/windows](https://github.com/terraform-providers/terraform-provider-azurerm/tree/master/examples/virtual-machines/provisioners/windows)

Pour commencer, créez un dossier **Files** avec 2 fichiers à l'intérieur, **[FirstLogonCommands.xml](https://github.com/Flodu31/Terraform/blob/master/Deploy_New_Environment_Provisioners/files/FirstLogonCommands.xml)** et **[winrm.ps1](https://github.com/Flodu31/Terraform/blob/master/Deploy_New_Environment_Provisioners/files/winrm.ps1)**. Ces 2 fichiers vont s'exécuter lors du premier lancement de la machine, pour configurer le WinRM, pour pouvoir s'y connecter à distance, via le Provider.

Il faut ensuite modifier le fichier **1-virtual-machine.tf** et modifier la section **os\_profile\_windows\_config** en ajoutant la partie winrm:

```
winrm {
      protocol = "http"
    }
    # Auto-Login's required to configure WinRM
    additional_unattend_config {
      pass         = "oobeSystem"
      component    = "Microsoft-Windows-Shell-Setup"
      setting_name = "AutoLogon"
      content      = "<AutoLogon><Password><Value>${var.admin_password}</Value></Password><Enabled>true</Enabled><LogonCount>1</LogonCount><Username>${var.admin_username}</Username></AutoLogon>"
    }
    additional_unattend_config {
      pass         = "oobeSystem"
      component    = "Microsoft-Windows-Shell-Setup"
      setting_name = "FirstLogonCommands"
      content      = "${file("./files/FirstLogonCommands.xml")}"
    }
```

Il faut ensuite ajouter le provisioner **remote-exec** pour exécuter à distance un script ou des commandes. Ici, en PowerShell, je vais installer le rôle Server Web:

```
provisioner "remote-exec" {
    connection {
      host     = "${azurerm_public_ip.windows_pip.ip_address}"
      type     = "winrm"
      port     = 5985
      https    = false
      timeout  = "5m"
      user     = "${var.admin_username}"
      password = "${var.admin_password}"
    }
    inline = [
      "powershell.exe -ExecutionPolicy Unrestricted -Command {Install-WindowsFeature -name Web-Server -IncludeManagementTools}",
    ]
}
```

Exécutez votre Terraform, et une fois que la VM est déployée, les scripts de démarrage exécutés, le provider réussi à se connecter et à exécuter la commande PowerShell:

![](https://i0.wp.com/cloudyjourney.fr/wp-content/uploads/2019/07/Terraform_Provisionners01.png?fit=762%2C983&ssl=1)

Si vous accédez à l'IP de l'output de Terraform, vous devriez voir votre serveur Web IIS:

![](https://i1.wp.com/cloudyjourney.fr/wp-content/uploads/2019/07/Terraform_Provisionners02.png?fit=762%2C481&ssl=1)

Le code complet se trouve ici:

[https://github.com/Flodu31/Terraform/tree/master/Deploy\_New\_Environment\_Provisioners](https://github.com/Flodu31/Terraform/tree/master/Deploy_New_Environment_Provisioners)

C'est ainsi que se termine ces quelques articles sur Terraform, si vous avez des questions, n'hésitez pas :)
