## Variables

$SwitchName = "intSwitch"
$NatName = "OutNat"
$GatewayIP = "10.10.10.1"
$NatNetwork = "10.10.10.0/24"

## Script

# Create the Internal Switch
if (-not(get-netadapter | where-object {$_.Name -eq "vEthernet ($SwitchName)"})) {
    New-VMSwitch -Switchname $SwitchName -SwitchType Internal
} else {
Write-Output "Virtual Switch #SwitchName already exists"
}

# Grab the new switch index #
$InterfaceIndex = (Get-NetAdapter | Where-Object {$_.Name -eq "vEthernet ($SwitchName)"}).ifIndex
Write-Output "Interface index is $interfaceIndex"

# Configure NAT Gateway
if (-not(Get-NetIPAddress | where-object {$_.IPAddress -eq $GatewayIP})){
    New-NetIPAddress -IPAddress $GatewayIP -PrefixLength 24 -InterfaceIndex $InterfaceIndex
} else {
Write-Output "NAT Gateway $GatewayIP already exists"
}

# Configure NAT network
if (-not (Get-NetNat | where-object {$_.Name -eq $NatName})){
New-NetNat -Name $NatName -InternalIPInterfaceAddressPrefix $NatNetwork
} else {
Write-Output "NAT Network $NatName already exists"
}
