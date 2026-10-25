# WSL Limits

# Status

## Context and Problem Statement

Default Windows runs Dynamic Memory and CPU. On a system that will run multiple VM's in the future and resources might be limited, WSL should be limited - but to what?
What networking should WSL use to ensure it functions with the rest of the lab?

## Considered Options

Static limits
Leave the default
Networking NAT mode (default)
Networking Mirror mode


## Decision Outcome

Chosen option: Static limits, 8GB Memory and 4 cores with 2 GB swap file. The labs will use a total of 36GB out of the 64GB available. Using 8 more for WSL leaves 12GB for OS and overhead. The swap file is storage based and does not increase the memory budget.

Chosen option: NAT Mode, because the WSL can't find other devices on the network in later labs by default, we'll need to Bridge the networks later in the Hyper-V config. AllVM's will need an internal adapter which access the WSL interace, and a 2nd network interface connecting to a Hyper-V external switch for internet access.

## Consequences
WSL performance, namely later with Docker containers might be less than ideal. Potential adjustment in the future might be necessary.

The consequence of complexity is accepted, as the with Mirrored Mode it would mean all systems have full access to the rest of the internal network, which could be dangerous with running scripts in a lab/dev environment and/or create unwanted results.
