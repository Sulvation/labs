# Hyper-V using Internal Switch with NAT

# Status
Accepted

## Context and Problem Statement

What networking should Hyper-V use for the labs?

## Considered Options

Internal Switch with NAT
Default Switch
External Switch

## Decision Outcome

Chosen option: Internal Switch with NAT, because this doesn't bind to a fysical NIC on the host, and therefor cannot receive inbound connections from devices on the home network network, unless access is specified through the NAT. As all VM's will attach to the same Internal Switch, they can communicatie with eachother, Internet Access will go through the host via NAT.
Default switch isn't used, even though it's also an internal Switch with NAT preconfigured, but it includes an invisable DHCP server, making it possbible for Static IP Assignments to conflict with DHCP leases.

## Consequences
If any service from the home network needs to access a VM on the Internal Switch, a NAT rule / Port Forwarding is required.
The lab can still communicatie outbound to the home network, which is an accepted risk.
