$location = "westeurope"
$resourceGroup = "FALA-Network"
$pipName = "FALA-Vnet-GW-IP"
$vnetName = "FALA-VNet"
$gwName = "FALA-VNetGW"
$lnGw = "FALA-LNGW"
$connName = "FALA-Connection"


# Create the Basic PIP with Allocation Method Dynamic
$vngwPIP = New-AzPublicIpAddress -Name $pipName -ResourceGroupName $resourceGroup -Location $location -Sku Basic -AllocationMethod Dynamic
#Get VNet information
$vnet = Get-AzVirtualNetwork -Name $vnetName -ResourceGroupName $resourceGroup
# Get Gateway Subnet
$subnet = Get-AzVirtualNetworkSubnetConfig -Name GatewaySubnet -VirtualNetwork $vnet
# Create the config
$vngwIpConfig = New-AzVirtualNetworkGatewayIpConfig -Name $pipName -SubnetId $subnet.Id -PublicIpAddressId $vngwPIP.Id
# Create the VNet Gateway with Basic Sku
New-AzVirtualNetworkGateway -Name $gwName -ResourceGroupName $resourceGroup -Location $location -IpConfigurations $vngwIpConfig -GatewayType Vpn -VpnType RouteBased -GatewaySku Basic
# Get VNet Gateway information
$gateway1 = Get-AzVirtualNetworkGateway -Name $gwName -ResourceGroupName $resourceGroup
# Get Local Network gateway information
$local = Get-AzLocalNetworkGateway -Name $lnGw -ResourceGroupName $resourceGroup
# Create the connection
New-AzVirtualNetworkGatewayConnection -Name $connName -ResourceGroupName $resourceGroup -Location $location -VirtualNetworkGateway1 $gateway1 -LocalNetworkGateway2 $local -ConnectionType IPsec -SharedKey 'KEY'