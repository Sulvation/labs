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
                    [PSCustomObject]@{
                        Name = $vm
                        PreviousState = $previousState
                        State = $State
                        Chagned = $false

                    }
                    continue
                }

                if ($PSCmdlet.ShouldProcess("$vm", "Change state from $previousState to $State")) {
                    write-verbose "Executing state change for '$vm' to $State"
                    if ($State -eq 'Running') {
                        Start-VM -Name $vm
                        $wasForced = $false
                    } elseif ($State -eq 'Off') {
                        if (-not $Force) {
                            Write-Verbose "Attempting graceful shutdown for VM '$vm'..."
                            Stop-VM -Name $vm -Confirm:$false
                            $wasForced = $false
                        } else {
                        Write-Verbose "Forcefully turning off VM '$vm' via -Force..."
                            Stop-VM -Name $vm -Force -Confirm:$false
                            $wasForced = $true
                        }
                    }

                    [PSCustomObject]@{
                        Name = $vm
                        PreviousState = $previousState
                        State = $State
                        Changed = $true
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
