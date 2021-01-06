---
title: "[Azure] Envoyer des SMS avec Log Analytics"
date: "2018-06-01"
author: "Florent Appointaire"
permalink: "/2018/06/01/azure-envoyer-des-sms-avec-log-analytics/"
summary:
categories: 
  - "oms"
tags: 
  - "azure"
  - "log-analytics"
  - "microsoft"
  - "oms"
  - "sms"
---
Vivant en Belgique et souhaitant envoyer des SMS lorsque quelque chose ne va pas sur mon infrastructure, je n'ai d'autre choix que de passer par un provider tier pour envoyer ces SMS, Microsoft ne supportant pas encore la Belgique comme pays pour envoyer des SMS: [https://azure.microsoft.com/en-us/pricing/details/monitor/](https://azure.microsoft.com/en-us/pricing/details/monitor/)

J'ai donc utilisé le service de Twilio pour faire ceci. Pour commencer, créez votre compte sur Twilio, offrez vous un numéro de téléphone (France pour moi) un peu de crédit et c'est parti :)

Sur le Dashboard, récupérez le SID et le token ainsi que le numéro qui vous a été attribué:

[![](https://cloudyjourney.fr/wp-content/uploads/2018/05/Twilio01.png)](https://cloudyjourney.fr/wp-content/uploa+33644606648g)

Adaptez le script suivant avec les informations que vous avez récupéré et importez le dans Azure Automation:

param
(
\[Parameter (Mandatory=$false)\]
\[object\] $WebhookData
)

function Send-SmsViaTwilio
{
param($RecipientNumber,
$SMSText )

$TwilioSID = "YourTwilioSID"
$TwilioToken = "YourTwilioToken"
$TwilioNumber = "YourSourceTwilioNumber"

$secureAuthToken = ConvertTo-SecureString $TwilioToken -AsPlainText -force
$TwilioCredential = New-Object System.Management.Automation.PSCredential($TwilioSID,$secureAuthToken)

$TwilioMessageBody = @{
From = $TwilioNumber
To = $RecipientNumber
Body = $SMSText
}

$ApiEndpoint= "https://api.twilio.com/2010-04-01/Accounts/$TwilioSID/Messages.json"
$Result = Invoke-RestMethod -Uri $TwilioApiEndpoint -Body $TwilioMessageBody -Credential $TwilioCredential -Method "POST" -ContentType "application/x-www-form-urlencoded"

return $Result
}

if ($WebhookData)
{

$WebhookBody = (ConvertFrom-Json -InputObject $WebhookData.RequestBody)
$Result = Send-SmsViaTwilio -RecipientNumber "YourNumber" -SMSText $WebhookBody.data.Description
write-host $Result

}

[![](https://cloudyjourney.fr/wp-content/uploads/2018/05/Twilio02.png)](https://cloudyjourney.fr/wp-content/uploads/2018/05/Twilio02.png)

Créez votre alerte dans votre workspace Log Analytics, et adaptez votre action groupe en fonction, pour déclancher le runbook Azure Automation, si l'alerte est trigger:

[![](https://cloudyjourney.fr/wp-content/uploads/2018/05/Twilio03.png)](https://cloudyjourney.fr/wp-content/uploads/2018/05/Twilio03.png)

Mon alerte est basée sur l'extinction du service Hyper-V Management. Je vais éteindre ce dernier. Après quelques minutes, j'ai bien reçu le mail de mon action group, mais surtout, le SMS :)

[![](https://cloudyjourney.fr/wp-content/uploads/2018/06/Twilio04.png)](https://cloudyjourney.fr/wp-content/uploads/2018/06/Twilio04.png) [![](https://cloudyjourney.fr/wp-content/uploads/2018/06/Twilio05.png)](https://cloudyjourney.fr/wp-content/uploads/2018/06/Twilio05.png)

Voici donc un workaround, en attendant que l'envoie de SMS soit disponible vers plus de pays :)
