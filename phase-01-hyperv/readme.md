# Goal

Creating the virtual machines and networks needed for the future labs.

IP Plan:

Subnet: 10.10.10.0/24
Gateway: 10.10.10.1
lnx-lab01: 10.10.10.10
win-lab01: 10.10.10.11
mgmt01: 10.10.10.5
dc01: 10.10.10.20
win-app01: 10.10.10.30
lnx-app01: 10.10.10.31
lnx-db01: 10.10.10.40
k8s-cp01: 10.10.10.50
k8s-w01: 10.10.10.51
k8s-w02: 10.10.10.52

# Acceptance

## 1. [X] Networking as Code
\powershell\create-hyperv-network.ps1 - creates an internal switch, grabs the interface index and uses this to create a NAT gateway, after which it creates the NAT network itself.
Run the script on the Host PC, not WSL, as WSL doesn't have Hyper-V installed.

## 2. [x] Isolation
From my workstation (both WSL and Windows) ping and ssh (with password) to lnx-lab01 work as intended. From a different PC in the home network, ping and ssh to lnx-lab01 do not work.

## 3. [x] lnx-lab01
lnx-lab01 is a generation2 vm with static IP: 10.10.10.10, gateway 10.10.10.1 and DNS 1.1.1.1,1.0.0.1 Named admin user is "jeroen".
jeroen@lnx-lab01:~$ nslookup google.nl
Server:         127.0.0.53
Address:        127.0.0.53#53

Non-authoritative answer:
Name:   google.nl
Address: 142.251.39.131
Name:   google.nl
Address: 2a00:1450:400e:809::2003

jeroen@lnx-lab01:~$ sudo apt update
[sudo: authenticate] Password:
Hit:1 http://nl.archive.ubuntu.com/ubuntu resolute InRelease
Hit:2 http://security.ubuntu.com/ubuntu resolute-security InRelease
Get:3 http://nl.archive.ubuntu.com/ubuntu resolute-updates InRelease [137 kB]
Get:4 http://nl.archive.ubuntu.com/ubuntu resolute-backports InRelease [137 kB]
Get:5 http://nl.archive.ubuntu.com/ubuntu resolute-updates/main amd64 Packages [803 kB]
Get:6 http://nl.archive.ubuntu.com/ubuntu resolute-updates/main Translation-en [184 kB]
Get:7 http://nl.archive.ubuntu.com/ubuntu resolute-updates/main amd64 Components [110 kB]
Get:8 http://nl.archive.ubuntu.com/ubuntu resolute-updates/universe amd64 Packages [374 kB]
Get:9 http://nl.archive.ubuntu.com/ubuntu resolute-updates/universe Translation-en [118 kB]
Get:10 http://nl.archive.ubuntu.com/ubuntu resolute-updates/universe amd64 Components [201 kB]
Get:11 http://nl.archive.ubuntu.com/ubuntu resolute-backports/universe amd64 Components [1,056 B]
Fetched 2,066 kB in 0s (6,211 kB/s)
40 packages can be upgraded. Run 'apt list --upgradable' to see them.
jeroen@lnx-lab01:~$

## 4. [x] win-lab01
win-lab01 is a generation2 vm with static ip: 10.10.10.11, gateway 10.10.10.1 and DNS 1.1.1.1,1.0.0.1, named admin user is "jeroen"
Timezone is correct on CET and all updates are installed.
From my workstation (both WSL and Windows) ping and ssh (with password) is currently blocked due to port 22 not being opened.
From Windows > Powershell > Enter-PSSession -VMName win-lab01:
PS C:\learninglab\labs> Enter-PSSession -vmname win-lab01

cmdlet Enter-PSSession at command pipeline position 1
Supply values for the following parameters:
Credential
User: jeroen
Password for user jeroen: *************

[win-lab01]: PS C:\Users\jeroen\Documents>

From WSL due to powershell.exe handleing interop and interactive TTY, a full connection doesn't seem to be possible. But we can run scriptblocks through Powershell Direct:

jeroen@DESKTOP-DRRD1T6:~/src/labs/phase-01-hyperv$ powershell.exe -Command "Invoke-Command -VMName 'win-lab01' -ScriptBlock { Get-Process | select-object -last 5 }"

cmdlet Invoke-Command at command pipeline position 1
Supply values for the following parameters:
Credential

Handles  NPM(K)    PM(K)      WS(K)     CPU(s)     Id  SI ProcessName                         PSComputerName
-------  ------    -----      -----     ------     --  -- -----------                         --------------
    165      12     1672      10212       0.02    664   0 wininit                             win-lab01
    220      12     2464      12476       0.05    720   1 winlogon                            win-lab01
    264      12     2596      15444       0.03   3304   2 winlogon                            win-lab01
    188      12     6836      16876       0.64   3908   0 WmiPrvSE                            win-lab01
    348      14     3688      25440       0.06   3468   0 WUDFHost                            win-lab01


jeroen@DESKTOP-DRRD1T6:~/src/labs/phase-01-hyperv$

## 5. [x] ssh
1. Generated a ed25519 ssh key using: ssh-keygen -t ed25519
2. Saved the key as: server_auth
3. Copied the key to lnx-lab01: ssh-copy-id -i ~/.ssh/server_auth.pub jeroen@10.10.10.10
4. Created config inside ~/.ssh as follows:
jeroen@DESKTOP-DRRD1T6:~/.ssh$ cat config
Host lnx-lab01
HostName 10.10.10.10
User jeroen
IdentityFile ~/.ssh/server_auth
5. Added the following lines to ~/.bashcr:
eval $(ssh-agent)
ssh-add
ssh-add ~/.ssh/server_auth
6. Added the following lines to ~/.bash_logout:
kill $SSH_AGENT_PID
7. Testing:
PS C:\Windows\System32> wsl
Agent pid 70774
Enter passphrase for /home/jeroen/.ssh/id_ed25519:
Identity added: /home/jeroen/.ssh/id_ed25519 (jeroen.vanderaar1@gmail.com)
Enter passphrase for /home/jeroen/.ssh/server_auth:
Identity added: /home/jeroen/.ssh/server_auth (jeroen@DESKTOP-DRRD1T6)
jeroen@DESKTOP-DRRD1T6:/mnt/c/Windows/System32$ cd ~/
jeroen@DESKTOP-DRRD1T6:~$ ssh lnx-lab01
Welcome to Ubuntu 26.04.1 LTS (GNU/Linux 7.0.0-42-generic x86_64)

 * Documentation:  https://docs.ubuntu.com
 * Management:     https://landscape.canonical.com
 * Support:        https://ubuntu.com/pro

 System information as of Thu Oct 29 09:21:35 AM UTC 2026

  System load:  0.06               Processes:             117
  Usage of /:   11.3% of 61.66GB   Users logged in:       0
  Memory usage: 10%                IPv4 address for eth0: 10.10.10.10
  Swap usage:   0%

 * Canonical Workshop gives developers fast, composable, reproducible, and
   secure developer environments that are perfect for agentic workflows.

   https://ubuntu.com/workshop

Expanded Security Maintenance for Applications is not enabled.

40 updates can be applied immediately.
To see these additional updates run: apt list --upgradable

Enable ESM Apps to receive additional future security updates.
See https://ubuntu.com/esm or run: sudo pro status


Last login: Thu Oct 29 09:20:24 2026 from 10.10.10.1
jeroen@lnx-lab01:~$

## 6. [x] Checkpoints
1. Each VM has a "baseline checkpoint" at the current state of configuration. Which for the Windows VM includes networking, data/time, updates. For Linux Vm is includes all the SSH config.
2. Both VM's use a "standard" checkpoints, as neither VM will require Application Consistency. Reverting to a standard checkpoint won't require a fresh boot, where Production Checkpoints do.
3. On lnx-lab01 created a testfile:

jeroen@lnx-lab01:~$ echo "Test message for checkpoint" > test.txt
jeroen@lnx-lab01:~$ cat test.txt
Test message for checkpoint
jeroen@lnx-lab01:~$

4. Apply Baseline checkpoint
5. Check if test.txt exists
jeroen@lnx-lab01:~$ ls
jeroen@lnx-lab01:~$ cat test.txt
cat: test.txt: No such file or directory
jeroen@lnx-lab01:~$

6. On win-lab01 created test.txt
PS C:\Users\Administrator> notepad test.txt

7. Apply checkpoint
8. Check if test.txt exists
PS C:\Users\Administrator> ls | where-object {$_.name -eq "test.txt"}
PS C:\Users\Administrator>

## 7. [x] Repo


# Decisions
ADR-0016: phase1-hyperv-networking
