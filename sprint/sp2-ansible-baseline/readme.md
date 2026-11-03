# Purpose

This ansible playbook will configure lnx-lab01 to a desired state with:
- Installed packages from a variable
- Creates a local user and it's home directory
- Deploys /etc/motd
- Installs nginx and which is enabled and running at boot
- Installs nginx config snippet

# How to run

Prerequisites:
1. Asnible and Ansible-List installed in WSL
2. SSH Key access to the lnx-lab01 VM

Command to run:
ansible-playbook baseline.yaml -K

(-K is a shortcut for --ask-become-pass , to let Ansible ask for a sudo password on the managed node)

# Decisions

1. Ubuntu 26.04's sudo-rs breaks the ansible "become" prompt. Workaround via "become_exe" in ansible.cfg, which is reversable once fixed upstream.
2. "Become" is set at the task level as it follows the principle of least privilege.

# Idempotency evidence

1.
jeroen@DESKTOP-DRRD1T6:~/src/labs/sprint/sp2-ansible-baseline$ ansible-playbook baseline.yaml -K
BECOME password:

PLAY [Install a package] *******************************************************************************************************************************

TASK [Gathering Facts] *********************************************************************************************************************************
ok: [lnx-web01]

TASK [Install nginx] ***********************************************************************************************************************************
changed: [lnx-web01]

PLAY RECAP *********************************************************************************************************************************************
lnx-web01                  : ok=2    changed=1    unreachable=0    failed=0    skipped=0    rescued=0    ignored=0

jeroen@DESKTOP-DRRD1T6:~/src/labs/sprint/sp2-ansible-baseline$ ansible-playbook baseline.yaml -K
BECOME password:

PLAY [Install a package] *******************************************************************************************************************************

TASK [Gathering Facts] *********************************************************************************************************************************
ok: [lnx-web01]

TASK [Install nginx] ***********************************************************************************************************************************
ok: [lnx-web01]

PLAY RECAP *********************************************************************************************************************************************
lnx-web01                  : ok=2    changed=0    unreachable=0    failed=0    skipped=0    rescued=0    ignored=0

jeroen@DESKTOP-DRRD1T6:~/src/labs/sprint/sp2-ansible-baseline$

2.


# What to do different next time
1. Resolve the sudo-rs upstream to not rely on a workaround in the ansible.cfg file.
