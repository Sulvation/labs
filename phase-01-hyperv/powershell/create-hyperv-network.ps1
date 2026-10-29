## This script deploys the an Internally switched NAT network to be used within a Hyper-V lab. Script should be run from the Hyper-V host.

## Variables -- edit values here

$SwitchName = "intSwitch"
$NatName = "OutNat"
$GatewayIP = "10.10.10.1"
$NatNetwork = "10.10.10.0/24"

## Script -- No more edits

#Requires -RunAsAdministrator
#Requires -Modules Hyper-V

$ErrorActionPreference = 'Stop'

# Create the Internal Switch

Try {
    $existingSwitches = @(Get-VMSwitch | Where-Object {$_.Name -eq $SwitchName})

    if ($existingSwitches.Count -eq 0) {
        New-VMSwitch -SwitchName $SwitchName -SwitchType Internal | Out-Null
        Write-Output "Virtual Switch '$SwitchName' created."
    }
    elseif ($existingSwitches.Count -gt 1) {
        throw "Multiple virtual switches named '$SwitchName' were found. Please resolve the duplicate manually."
    }
    elseif ($existingSwitches[0].SwitchType -ne 'Internal') {
        throw "Virtual Switch '$SwitchName' exists, but is type '$($existingSwitches[0].SwitchType)' instead of 'Internal'."
    }
    else {
        Write-Output "Virtual Switch '$SwitchName' already exists and is Internal."
    }

# Grab the new switch index #

    $existingInterfaceindex = @(Get-NetAdapter | Where-Object {$_.Name -eq "vEthernet ($SwitchName)"})

    if ($existingInterfaceindex.Count -eq 0) {
        throw "Network adapter doesn't exist or can't be found."
    }
    elseif ($existingInterfaceindex.Count -gt 1) {
        throw "Multiple network adapters were found. Please resolve the duplicate manually"
    }
    else {
    $InterfaceIndex = $existingInterfaceindex.ifIndex
    Write-Output "Interface index is $interfaceIndex"
    }

# Configure NAT Gateway

    $NetworkPrefix = $NatNetwork.Split('/')[1]
    $existingNATIps = @(Get-NetIPAddress | Where-Object {$_.IPAddress -eq $GatewayIP})

    if ($existingNATIps.Count -eq 0) {
        New-NetIPAddress -IPAddress $GatewayIP -PrefixLength $NetworkPrefix -InterfaceIndex $InterfaceIndex | Out-Null
        Write-Output "NAT Gateway $GatewayIP created"
    }
    elseif ($existingNATIps.Count -gt 1) {
        throw "Multiple NAT Gateways with $GatewayIP were found. Please resolve duplicate manually."
    }
    elseif ($existingNATIps.PrefixLength -ne $NetworkPrefix) {
        throw "NAT Gateway $GatewayIP exists, but with the wrong Prefix: $existingNATIPs.PrefixLength . Please resolve manually"
    }
    elseif ($existingNATIps.InterfaceIndex -ne $InterfaceIndex) {
        throw "NAT Gateway $GatewayIP exists, but is assigned to the wrong interface index: $existingNATIPs.InterfaceIndex . Please resolve manually."
    }
    else {
        Write-Output "NAT Gateway $GatewayIP already exists and is correct."
    }

# Configure NAT network

    $ExistingNATs = @(Get-NetNat | Where-Object {$_.Name -eq $NatName})

    if ($ExistingNATs.Count -eq 0) {
        New-NetNat -Name $NatName -InternalIPInterfaceAddressPrefix $NatNetwork | Out-Null
        Write-Output "NAT Network $NatName : $NatNetwork created."
    }
    elseif ($ExistingNATs.Count -gt 1) {
        throw "Multiple NAT Networks were found. Please resolve the duplicate(s) manually."
    }
    elseif ($ExistingNATs[0].InternalIPInterfaceAddressPrefix -ne $NatNetwork) {
        throw "NAT Network $NatName exists, but with the wrong address prefix: $ExistingNATs[0].InternalIPInterfaceAddressPrefix"
    }
    else {
        Write-Output "NAT Network $NatName : $NatNetwork already exists and is correct."
    }

} catch {
    throw $_
}
