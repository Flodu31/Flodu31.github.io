---
title: \[Azure\] Fixer une IP sur une VM
date: 2015-02-13 08:00:00 +0100
autho: Florent Appointaire
permalink: /2015/02/13/azure-fixer-une-ip-sur-une-vm/
summary:
categories:
  - Azure
tags:
  - Azure
  - Azure IP Fixe
  - Microsoft
---
En voulant fixer l’IP d’une VM sur Azure pour un client (sur un CentOS), je me suis apercu qu’apès avoir déployé le VHD avec l’ip donné par Azure, celle-ci ne pouvait pas accéder à internet et je ne pouvait donc me connecter en SSH dessus (la partie HostName dans Azure n’existait pas):

![](/wp-content/uploads/2018/01/SNAGHTML4c4549a_1D6260A4.png)

J’ai configure ma VM comme ceci:
Fichier /etc/sysconfig/network-scripts/ifcfg-eth0:

```
DHCP_HOSTNAME=FlorentVM
DEVICE=eth0
ONBOOT=yes
DHCP=yes
BOOTPROTO=dhcp
TYPE=Ethernet
USERCTL=no
PEERDNS=yes
IPV6INIT=no
```

Fichier /etc/sysconfig/network:
```
NETWORKING=yes
HOSTNAME=FlorentVM
```

J’ai regardé la documentation sur Azure, et j’ai vu qu’il existait une commandlet pour attribuer une IP spécifique à une VM. Cette commande est Set-AzureStaticVnetIP. Pour l’utiliser, j’ai fait ceci:

```
$VM = Get-AzureVM -ServiceName Florent -Name FlorentVM
Set-AzureStaticVNetIP -IPAddress 192.168.0.4 -VM $VM | Update-AzureVM
```
![](/wp-content/uploads/2018/01/SNAGHTML4c2b37c_03FA5D6A.png)

Après avoir fait ceci, attendait quelques minutes que la VM ce mette à jour:

![](/wp-content/uploads/2018/01/image_4D8C3C18.png)

Une  fois la mise à jour terminée, vous pouvez voir que maintenant la partie hostname est complétée, et que vous pouvez accéder à votre VM en SSH et que elle même peut accéder à l’extérieur (un reboot peut être nécessaire):

![](/wp-content/uploads/2018/01/SNAGHTML4d77034_41F67ED9.png)
![](/wp-content/uploads/2018/01/SNAGHTML4c7cce8_7AA128E6.png)

Ceci s’explique du fait que lorsque vous assignez l’IP de façon manuelle, du côté Azure, l’enregistrement DNS n’est pas créé et les règles firewall associées à ce nom DNS ne sont également pas créées.

Si vous souhaitez réserver directement l’IP au moment du déploiment de la VM, utilisez le script suivant:

```
$imageName = (Get-AzureVMImage | Where { $_.ImageFamily -eq "CoreOS Stable" } | Select -First 1).ImageName
New-AzureVMConfig -Name "FlorentTest" -InstanceSize "Small" -ImageName $imageName | Add-AzureProvisioningConfig -DisableGuestAgent -Linux -LinuxUser Florent -Password P@ssw0rd | Set-AzureSubnet -SubnetNames "PROD" | Set-AzureStaticVNetIP -IPAddress "192.168.0.200" | New-AzureVM -ServiceName "Florent"
```

Et pour supprimer une IP statique:

```
$VM = Get-AzureVM -ServiceName Florent -Name FlorentVM
Remove-AzureStaticVNetIP  -VM $VM | Update-AzureVM
```

Vous pouvez aussi effectuer cette manipulation via le nouveau portail de Azure:

![](/wp-content/uploads/2018/01/SNAGHTML4de1938_68586224.png)