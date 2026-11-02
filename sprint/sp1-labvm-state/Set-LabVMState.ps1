function Set-LabVMState {
    <#
    .SYNOPSIS
        Manages the state of one or more Virtual Machines idempotently.
    .DESCRIPTION
        Takes Virtual Machine names via parameter or pipeline, checks their current state, and transitions them to Running or Off with support for -WhatIf and -Confirm.
    .PARAMETER VMName
        The name(s) of the Virtual Machines to manage. Accepts pipeline input.
    .PARAMETER State
        The target state of the Virtual Machine. Valid values: Running, Off.
    .PARAMETER Force
        Forces the TurnOff of the Virtual Machine using the -TurnOff parameter.
    .EXAMPLE
        Set-LabVMState -Name "lnx-lab01" -State Running
    .EXAMPLE
        Get-VM | Set-LabVMState -State Off -WhatIf
    #>

    [Cmdletbinding(SupportsShouldProcess = $true, ConfirmImpact = 'Medium')]

    Param(
        [Parameter(Mandatory = $true, ValueFromPipeline = $true, ValueFromPipelineByPropertyName = $true)]
        [Alias('Name')]
        [string[]]$VMName,

        [Parameter(Mandatory = $true)]
        [ValidateSet('Running', 'Off')]
        [string]$State,

        [Parameter()]
        [switch]$Force
    )

    process {
        foreach ($vm in $VMName) {
            try {
                Write-Verbose "Checking status for vm: $vm"
                $vmObj = Get-VM -Name $vm -ErrorAction Stop
                $previousState = $vmObj.State

                if ($previousState -eq $State) {
                    Write-Verbose "VM '$vm' is already in state '$state'. Skipping"
                    $wasForced = $false
                    [PSCustomObject]@{
                        Name = $vm
                        PreviousState = $previousState
                        State = $State
                        Changed = $false
                        Forced = $wasForced

                    }
                    continue
                }

                if ($PSCmdlet.ShouldProcess("$vm", "Change state from $previousState to $State")) {
                    write-verbose "Executing state change for '$vm' to $State"
                    if ($State -eq 'Running') {
                        Start-VM -Name $vm -ErrorAction Stop
                        $wasForced = $false
                    } elseif ($State -eq 'Off') {
                        if (-not $Force) {
                            Write-Verbose "Attempting graceful shutdown for VM '$vm'..."
                            Stop-VM -Name $vm -Confirm:$false -ErrorAction Stop
                            $wasForced = $false
                        } else {
                        Write-Verbose "Forcefully turning off VM '$vm' via -Force..."
                            Stop-VM -Name $vm -TurnOff -Confirm:$false -ErrorAction Stop
                            $wasForced = $true
                        }
                    }

                    $finalVmObj = Get-VM -Name $vm -ErrorAction Stop
                    $finalState = $finalVmObj.State

                    $actualChanged = ($previousState -ne $finalState)

                    [PSCustomObject]@{
                        Name = $vm
                        PreviousState = $previousState
                        State = $finalState
                        Changed = $actualChanged
                        Forced = $wasForced
                    }
                }
            }
            catch {
                Write-Error "Failed to process '$vm': $_"
            }
        }
    }
}
