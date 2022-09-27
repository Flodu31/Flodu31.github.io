Connect-AzAccount
$csvFile = "Keyvault.csv"
if (Test-Path $csvFile){
	Remove-Item $csvFile -Force
	New-Item -ItemType File -Name $csvFile 
} else {
	New-Item -ItemType File -Name $csvFile
}

$response = Get-AzManagementGroup -GroupId UAZC -Expand -Recurse -WarningAction:SilentlyContinue

foreach ($sub in $response.Children){

	if ($sub.Type -eq "Microsoft.Management/managementGroups"){
		$mgmtGroups = Get-AzManagementGroup -GroupId $sub.Name -Expand -Recurse -WarningAction:SilentlyContinue
		foreach ($subSub in $mgmtGroups.Children){
			Select-AzSubscription -SubscriptionId $subSub.Name
			$keyvault = Get-AzKeyVault
			foreach ($kv in $keyvault) {
        			Get-AzKeyVault -VaultName $kv.VaultName | Select vaultName, enablePurgeProtection, enableSoftDelete, softDeleteRetentionInDays | Export-CSV $csvFile -Append
    			}
		}
	} else {
		Select-AzSubscription -SubscriptionId $sub.Name
		$keyvault = Get-AzKeyVault
		foreach ($kv in $keyvault) {
			Get-AzKeyVault -VaultName $kv.VaultName | Select vaultName, enablePurgeProtection, enableSoftDelete, softDeleteRetentionInDays | Export-CSV $csvFile -Append
    		}
	}
}