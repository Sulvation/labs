function Set-LabVMState {

    [Cmdletbinding(SupportsShouldProcess = $true, ConfirmImpact = 'Medium')]

    Param(
        [Parameter(Mandatory = $true, ValueFromPipeline = $true, ValueFromPipelineByPropertyName = $true)]
        [Alias('Name')]
        [string[]]$VMName,

        [Parameter(Mandatory = $true)]
        [ValidateSet('Running', 'Off')]
        [string]$State
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
                    } else {
                        Stop-VM -Name $vm -Force
                    }

                    [PSCustomObject]@{
                        Name = $vm
                        PreviousState = $previousState
                        State = $State
                        Changed = $true
                    }
                }
            }
            catch {
                Write-Error "Failed to process '$vm': $_"
            }
        }
    }
}
