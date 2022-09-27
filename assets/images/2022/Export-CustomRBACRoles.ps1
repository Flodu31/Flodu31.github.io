Connect-AzAccount
$subscriptions = Get-AzSubscription
foreach ($sub in $subscriptions){

	$subId = $sub.Id
	$subName = $sub.Name

	if (Test-Path $subName){
		Remove-Item "$subName\*" 
	} else {
		New-Item -ItemType Directory -Name $subName
	}
	

	Select-AzSubscription -SubscriptionId $subId 
	$roles = Get-AzRoleDefinition -Custom | Where {$_.IsCustom -eq $true}

	foreach ($role in $roles){

		$roleName = $role.Name
		$role | ConvertTo-Json | Out-File "$subName\$roleName.json"
	
	}

}