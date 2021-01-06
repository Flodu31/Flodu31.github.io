---
title: "[OMS] Déployer la solution Azure Backup / Azure Site Recovery"
date: "2017-01-20"
categories: 
  - "azure"
  - "oms"
tags: 
  - "arm"
  - "asr"
  - "azure-backup"
  - "azure-site-recovery"
  - "microsoft"
  - "oms"
---

[![](https://cloudyjourney.fr/wp-content/uploads/2018/01/6712.pastedimage1505371792894v1.png)](https://cloudyjourney.fr/wp-content/uploads/2018/01/6712.pastedimage1505371792894v1.png)

Par défaut, si vous souhaitez avoir une rapide vue de votre Azure Backup / Azure Site Recovery qui fonctionne avec ARM, avec OMS, ce n’est pas possible parce que la solution proposée par Microsoft est pour la version classic. Suite à un PGI (Product Group Information, en tant que MVP), il nous a été présenté la solution **Recovery Services**, disponible sur GitHub ([https://github.com/krnese/AzureDeploy/tree/master/OMS/MSOMS/Solutions/recoveryservices](https://github.com/krnese/AzureDeploy/tree/master/OMS/MSOMS/Solutions/recoveryservices)) et qui supervise la partir ARM de Azure Site Recovery et Azure Backup. Je vous propose donc de voir comment mettre en place cette solution.

Pour déployer cette solution, vous avez besoin de savoir dans quel groupe de ressource tourne votre workspace OMS, le nom du workspace and sa localisation :

[![](https://cloudyjourney.fr/wp-content/uploads/2018/01/pastedimage1484812022201v2.png)](https://cloudyjourney.fr/wp-content/uploads/2018/01/pastedimage1484812022201v2.png)

Une fois ceci terminé, il faut créer un compte Azure Automation, dans la même région et le même groupe de ressource que votre OMS Workspace. N’oubliez pas d’activer la partie qui créait automatiquement les comptes RunAs :

[![](https://cloudyjourney.fr/wp-content/uploads/2018/01/pastedimage1484812030083v3.png)](https://cloudyjourney.fr/wp-content/uploads/2018/01/pastedimage1484812030083v3.png)

[![](https://cloudyjourney.fr/wp-content/uploads/2018/01/pastedimage1484812048549v5.png)](https://cloudyjourney.fr/wp-content/uploads/2018/01/pastedimage1484812048549v5.png)

Une fois que vous avez créé ce compte d’automatisation, cliquez sur le bouton **Deploy** dans la ressource GitHub ([https://github.com/krnese/AzureDeploy/tree/master/OMS/MSOMS/Solutions/recoveryservices](https://github.com/krnese/AzureDeploy/tree/master/OMS/MSOMS/Solutions/recoveryservices) ). Vous allez être redirigé sur Azure, pour un déploiement customisé. Renseignez les informations demandées et que vous avez récupéré auparavant. Générez également 2 GUID en PowerShell, avec la commande **New-Guid** et mettez les valeurs dans **Asr Ingest Schedule Guid** et **Ab Ingest Schedule Guid**. Puis, cliquez sur **Purchase** pour commencer le déploiement :

[![](https://cloudyjourney.fr/wp-content/uploads/2018/01/pastedimage1484812053184v6.png)](https://cloudyjourney.fr/wp-content/uploads/2018/01/pastedimage1484812053184v6.png)

[![](https://cloudyjourney.fr/wp-content/uploads/2018/01/pastedimage1484812059224v7.png)](https://cloudyjourney.fr/wp-content/uploads/2018/01/pastedimage1484812059224v7.png)

Une fois le déploiement terminé, vous devriez avoir ceci :

[![](https://cloudyjourney.fr/wp-content/uploads/2018/01/pastedimage1484812092885v9.png)](https://cloudyjourney.fr/wp-content/uploads/2018/01/pastedimage1484812092885v9.png)

[![](https://cloudyjourney.fr/wp-content/uploads/2018/01/pastedimage1484812101191v10.png)](https://cloudyjourney.fr/wp-content/uploads/2018/01/pastedimage1484812101191v10.png)

Et dans l’interface OMS :

[![](https://cloudyjourney.fr/wp-content/uploads/2018/01/pastedimage1484812117571v12.png)](https://cloudyjourney.fr/wp-content/uploads/2018/01/pastedimage1484812117571v12.png)

[![](https://cloudyjourney.fr/wp-content/uploads/2018/01/pastedimage1484812125348v13.png)](https://cloudyjourney.fr/wp-content/uploads/2018/01/pastedimage1484812125348v13.png)

[![](https://cloudyjourney.fr/wp-content/uploads/2018/01/pastedimage1484812133373v14.png)](https://cloudyjourney.fr/wp-content/uploads/2018/01/pastedimage1484812133373v14.png)

Si vous souhaitez monitorer plusieurs Azure Vault, il suffit, après avoir déployé une première fois la solution, d’effectuer la même opération, mais avec ce template : [https://portal.azure.com/#create/Microsoft.Template/uri/https%3A%2F%2Fraw.githubusercontent.com%2Fkrnese%2Fazuredeploy%2Fmaster%2FOMS%2FMSOMS%2FSolutions%2Frecoveryservices%2FaddRecoveryServices.json](https://portal.azure.com/#create/Microsoft.Template/uri/https%3A%2F%2Fraw.githubusercontent.com%2Fkrnese%2Fazuredeploy%2Fmaster%2FOMS%2FMSOMS%2FSolutions%2Frecoveryservices%2FaddRecoveryServices.json)

Ici, vous pourrez superviser des Vault de plusieurs suscriptions, de régions différentes.

Cette nouvelle solution est très intéressante parce qu’elle supporte la partie ARM, ce qui n’était pas le cas avec la solution proposé par défaut par Microsoft.

Un immense merci à Kristian Nese (Senior PM chez Microsoft) pour cette solution : [https://twitter.com/kristiannese](https://twitter.com/kristiannese)
