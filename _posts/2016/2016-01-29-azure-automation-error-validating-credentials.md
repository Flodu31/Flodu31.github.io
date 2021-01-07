---
title: "[Azure Automation] Error Validating Credentials"
date: "2016-01-29"
author: "Florent Appointaire"
permalink: "/2016/01/29/azure-automation-error-validating-credentials/"
summary: 
categories: 
  - "azure-automation"
tags: 
  - "azure"
  - "azure-automation"
  - "microsoft"
---
Aujourd’hui, un de mes clients a rencontré l’erreur suivante dans Azure Automation:

[![](https://cloudyjourney.fr/wp-content/uploads/2018/01/SNAGHTML290be6c4_13B591DB.png)](https://cloudyjourney.fr/wp-content/uploads/2018/01/SNAGHTML290be6c4_13B591DB.png)

Après avoir réfléchi, je me suis dit que, dans Azure AD, les mots de passes doivent expirer. Je suis tombé sur ce lien: [https://msdn.microsoft.com/en-us/library/azure/jj943764.aspx?f=255&MSPPError=-2147217396](https://msdn.microsoft.com/en-us/library/azure/jj943764.aspx?f=255&MSPPError=-2147217396 "https://msdn.microsoft.com/en-us/library/azure/jj943764.aspx?f=255&MSPPError=-2147217396") En effet, le mot de passe expire bien au bout de 90 jours par défaut et je n’ai pas été prévenu par mail car mon compte de “service” n’avait pas d’adresse mail.

Je me suis alors connecté avec un utilisateur de cet AD avec les commandes suivantes (j’ai du mettre à jour le mot de passe car l’ancien ne fonctionnait plus):

```
$credentials = Get-Credential automation@domain.onmicrosoft.com 
Connect-MsolService -Credential $credentials
```

[![](https://cloudyjourney.fr/wp-content/uploads/2018/01/SNAGHTML291611da_033D20E0.png)](https://cloudyjourney.fr/wp-content/uploads/2018/01/SNAGHTML291611da_033D20E0.png)

Exécutez ensuite la commande suivante pour avoir les polices des mots de passe:

`Get-MsolPasswordPolicy –DomainName domain.onmicrosoft.com`

[![](https://cloudyjourney.fr/wp-content/uploads/2018/01/SNAGHTML2919eb63_50D94D60.png)](https://cloudyjourney.fr/wp-content/uploads/2018/01/SNAGHTML2919eb63_50D94D60.png)

Si vous avez l’erreur ci-dessus, assurez-vous que le compte que vous utilisez est bien Global Admin de l’active directory:

[![](https://cloudyjourney.fr/wp-content/uploads/2018/01/SNAGHTML291ad17d_211E3592.png)](https://cloudyjourney.fr/wp-content/uploads/2018/01/SNAGHTML291ad17d_211E3592.png)

Vous pouvez maintenant mettre à jour la période de validité sur votre Azure AD ainsi que la partie notification, avec la commande suivante:

`Set-MsolPasswordPolicy –DomainName domain.onmicrosoft.com –ValidityPeriod 180 –NotificationDays 30`

[![](https://cloudyjourney.fr/wp-content/uploads/2018/01/SNAGHTML291d42ac_07B63258.png)](https://cloudyjourney.fr/wp-content/uploads/2018/01/SNAGHTML291d42ac_07B63258.png)

Remplacez bien entendu par le nombre de jours que vous souhaitez. Mes nouvelles données sont maintenant à jour:

[![](https://cloudyjourney.fr/wp-content/uploads/2018/01/SNAGHTML291f8624_6E4E2F1D.png)](https://cloudyjourney.fr/wp-content/uploads/2018/01/SNAGHTML291f8624_6E4E2F1D.png)

Si vous souhaitez que le mot de passe n’expire jamais (comme dans mon cas avec le compte d’automatisation), vous pouvez le faire avec la commande suivante:

`Set-MsolUser -UserPrincipalName automation@domain.onmicrosoft.com -PasswordNeverExpires $True`

[![](https://cloudyjourney.fr/wp-content/uploads/2018/01/SNAGHTML2920b935_49BCA199.png)](https://cloudyjourney.fr/wp-content/uploads/2018/01/SNAGHTML2920b935_49BCA199.png)

Le résultat est le suivant, avec la commande suivante:

`Get-MsolUser | Where {$_.PasswordNeverExpires -eq $True}`

[![](https://cloudyjourney.fr/wp-content/uploads/2018/01/SNAGHTML2921f985_1758CE1A.png)](https://cloudyjourney.fr/wp-content/uploads/2018/01/SNAGHTML2921f985_1758CE1A.png)

En espérant que ceci vous sera utile :)
