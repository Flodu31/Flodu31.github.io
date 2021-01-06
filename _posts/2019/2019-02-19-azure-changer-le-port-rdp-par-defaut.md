---
title: "[Azure] Changer le port RDP par défaut"
date: "2019-02-19"
categories: 
  - "azure"
tags: 
  - "azure"
  - "microsoft"
  - "port"
  - "powershell"
  - "rdp"
---

![](https://cloudyjourney.fr/wp-content/uploads/2018/01/Azure.png)

Une des grosses problématiques de sécurité quand vous déployez une machine sur Azure est le fait de pouvoir attribuer une IP publique à une machine, ce qui en fait une potentiel cible d'attaque.

Si vous déployez une machine Windows, pour y accéder directement, sans VPN, vous devez autoriser l'ouverture du port 3389, sur l'IP Publique, dans le NSG. Le souci est que se port sera surement l'un des premiers port scannés par des hackers.

Pour résoudre se problème, il suffit simplement de changer le port sur le serveur, avec le script suivant:

```
$RDPPort="14257"
Set-ItemProperty -Path "HKLM:\SYSTEM\CurrentControlSet\Control\Terminal Server\WinStations\RDP-TCP\" -Name PortNumber -Value $RDPPort
New-NetFirewallRule -DisplayName "RDP HighPort" -Direction Inbound –LocalPort $RDPPort -Protocol TCP -Action Allow
Restart-Computer
```

Puis dans le NSG, à la place du port 3389 (ce qui fera disparaitre le petit logo warning devant la règle):

![](https://i0.wp.com/cloudyjourney.fr/wp-content/uploads/2019/02/Azure_RDP_Port.png?fit=762%2C329&ssl=1)

N'oubliez donc pas de changer ce port, il en va de la sécurité de vos machines :)
