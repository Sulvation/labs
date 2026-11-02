# Purpose

An advanced Powershell function to manage the state of VM's within the Lab.


# Decisions

1. What happens to a VM that is Saved or Paused?
A saved or paused VM is treated as a running VM. The cmdlets for Start-VM will resume the VM's. Stop-VM will attempt a graceful shutdown, or force it with -Force.

2. When a guest ignores a graceful shutdown, is a hard power-off allowed, and only behind a switch?
Only behind the -Force switch is this allowed.

3. Which ConfirmImpact level fits, and does stopping deserve more caution than starting?
Medium, no, as it's a lab environment anyway.
