# WSL Limits

# Status
Accepted

## Context and Problem Statement

Default Windows runs Dynamic Memory to a max of 50% available physical memory and CPU equal to 100% available phyiscal cores. On a system that will run multiple VM's in the future and resources might be limited, WSL should be limited - but to what?
What networking should WSL use to ensure it functions with the rest of the lab?

## Considered Options

Static limits
Leave the default
Networking NAT mode (default)
Networking Mirror mode


## Decision Outcome

Chosen option: Static limits, 8GB Memory and 4 cores with 2 GB swap file. The labs will use a total of 36GB out of the 64GB available. Using 8 more for WSL leaves 20GB for OS and overhead. The swap file is storage based and does not increase the memory budget.

Chosen option: Mirrored Mode, this makes it so that WSL acts as if it was plugged into the network, just like the Windows machine is. This way future NAT's created for labs won't conflict as they're baseline available through the host.

## Consequences
WSL performance, namely later with Docker containers might be less than ideal. Potential adjustment in the future might be necessary.

The risk is accepted that WSL and the VM's have access to the local network.
