param ([Parameter(Mandatory)]$subId)
Connect-AzAccount -Subscription $subId
$path = (Get-Location).Path
$resource = (Get-AzResource | Select-Object ResourceId).ResourceId 

foreach($item in $resource){
    $role += Get-AzRoleAssignment -Scope $item 
}

$role | Export-CSV $path\$subId.csv