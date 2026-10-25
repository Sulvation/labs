# Goal

Setup the WSL terminal as a permanent workstation for the remainder of the labs.

# Acceptance

## 1. [x] WSL2 runs current Ubuntu LTS
Confirming WSL is V2: "wsl -l -v" Shows output: Ubuntu Version 2.
Confirming WSL is current Ubuntu LTS: "cat /etc/os-release" Shows output: Ubuntu 26.04 LTS

## 2. [x] Powershell 7 is installed in both Windows and WSL
1. sudo apt-get update
2. sudo apt-get install -y wget
3. wget https://github.com/PowerShell/PowerShell/releases/download/v7.6.6/powershell_7.6.6-1.deb_amd64.deb
4. sudo dpkg -i powershell_7.6.6-1.deb_amd64.deb
5. sudo apt-get install -f
6. rm powershell_7.6.6-1.deb_amd64.deb
7. Starting powershell with pwsh shows: Powershell 7.6.6

On windows "$PSversiontable.psversion" shows: Major 7, minor 6, patch 7.
Microsoft Learn doc lists this as the preferred method of installed Powershell 7 on Linux.

## 3. [x] Repos on Linux
1. Renamed the old repo's
2. Used "git clone" for each repo while in ~/src
3. Ran "pre-commit install" and verified with "pre-commit run --all-files" in both repo's
4. Ran gitleaks detect in both repo's
5. Reconfigured the following git configs that were lost:
git config core.filemode false
git config branch.main.vscode-merge-base origin/main
git config --global user.email 96924497+Sulvation@users.noreply.github.com
6. Created "secrettest.md" with a fake API key and secret on labs repo
7. Got the error on commit:
Finding:     API_KEY: REDACTED
Secret:      REDACTED
RuleID:      generic-api-key
Entropy:     3.932138
File:        secrettest.md
Line:        1
Fingerprint: secrettest.md:generic-api-key:1
8. Ran "rm secrettest.md"
9. Same thing on meridiaan-platform repo:
Finding:     API_KEY: REDACTED
Secret:      REDACTED
RuleID:      generic-api-key
Entropy:     3.932138
File:        secrettest.md
Line:        1
Fingerprint: secrettest.md:generic-api-key:1

12:43AM INF 0 commits scanned.
12:43AM INF scanned ~29 bytes (29 bytes) in 34.9ms
12:43AM WRN leaks found: 1
10. Ran "rm secrettest.md"
11. jeroen@DESKTOP-DRRD1T6:~/src/labs$ ls -l
total 36
-rw-r--r-- 1 jeroen jeroen 1066 Oct 26 00:30 LICENSE
-rw-r--r-- 1 jeroen jeroen  663 Oct 26 00:30 README.md
drwxr-xr-x 3 jeroen jeroen 4096 Oct 26 00:30 docs
drwxr-xr-x 2 jeroen jeroen 4096 Oct 26 00:30 drills
drwxr-xr-x 2 jeroen jeroen 4096 Oct 26 00:30 kql
drwxr-xr-x 2 jeroen jeroen 4096 Oct 26 00:30 phase-01-git
drwxr-xr-x 4 jeroen jeroen 4096 Oct 26 00:30 phase-01-setup
drwxr-xr-x 2 jeroen jeroen 4096 Oct 26 00:41 phase-01-workstation
drwxr-xr-x 2 jeroen jeroen 4096 Oct 26 00:30 rebuilds

jeroen@DESKTOP-DRRD1T6:~/src/meridiaan-platform$ ls -l
total 28
-rw-r--r-- 1 jeroen jeroen 1066 Oct 26 00:30 LICENSE
-rw-r--r-- 1 jeroen jeroen  598 Oct 26 00:30 README.md
drwxr-xr-x 2 jeroen jeroen 4096 Oct 26 00:30 ansible
drwxr-xr-x 2 jeroen jeroen 4096 Oct 26 00:30 app
drwxr-xr-x 4 jeroen jeroen 4096 Oct 26 00:30 docs
drwxr-xr-x 2 jeroen jeroen 4096 Oct 26 00:30 infra
drwxr-xr-x 2 jeroen jeroen 4096 Oct 26 00:30 k8s
jeroen@DESKTOP-DRRD1T6:~/src/meridiaan-platform$

Doing everything from the Linux terminal to prevent I/O performance issues across Windows / WSL.


## 4. [x] WSL Commits show "verified" on Github
1. Created a throwaway.md file with a random text on branch throwaway
2. git add throwaway.md
3. git commit -m "Test: Signed commit test"
4. "git log --format='%h %G? %an  %s' HEAD" shows: "5d6bc47 G Jeroen  Test: Signed commit test"
5. git push -u origin throwaway
6. GitHub web shows the branch with the commit as verified.

## 5. [x] Pre-commit and Gitleaks work in WSL
1. Created a file with API_KEY and a random fake secret
2. git add throwaway.md
3. git commit -m "Test: Fake API key for Gitleaks"
Finding:     API_KEY: REDACTED
Secret:      REDACTED
RuleID:      generic-api-key
Entropy:     3.584184
File:        throwaway.md
Line:        1
Fingerprint: throwaway.md:generic-api-key:1

11:05PM INF 0 commits scanned.
11:05PM INF scanned ~29 bytes (29 bytes) in 35.4ms
11:05PM WRN leaks found: 1

## 6. [x] Line endings are deliberate: the repos have a .gitattributes policy. Opening and saving a file from the Windows side and from the WSL side doesn’t produce phantom diffs
1. Both repo's have a .gitattributes, which was already created in previous sessions.
2. As per ADR-0005, all labs will only be run from WSL. Opening and saving a file from Windows won't happen, and therefor won't be tested.

## 7. [x] VS Code opens the repos through the WSL remote and all extensions are installed
1. Installed the WSL Extension on Visual Studio Code.
2. From WSL, ran "code ." from ~/src/labs and ~/src/meridiaan-platform
3. Visual Studio Code opened connected to the repos through the WSL remote automatically, and shows: 'labs [WSL: Ubuntu]'and 'meridiaan-platform [WSL: Ubuntu]' in the file explorers

1. Python 3.14.4 was already installed prior to starting the module. Checked with: python3 --version

1. Installed Terraform by following the wiki;
2. sudo apt-get update && sudo apt-get install -y gnupg software-properties-common
3. wget -O- https://apt.releases.hashicorp.com/gpg | \
gpg --dearmor | \
sudo tee /usr/share/keyrings/hashicorp-archive-keyring.gpg > /dev/null
4. gpg --no-default-keyring \
--keyring /usr/share/keyrings/hashicorp-archive-keyring.gpg \
--fingerprint
5. echo "deb [arch=$(dpkg --print-architecture) signed-by=/usr/share/keyrings/hashicorp-archive-keyring.gpg] https://apt.releases.hashicorp.com $(grep -oP '(?<=UBUNTU_CODENAME=).*' /etc/os-release || lsb_release -cs) main" | sudo tee /etc/apt/sources.list.d/hashicorp.list
6. sudo apt update
7. sudo apt-get install terraform
8. Terraform 1.17.0 confirmed installed with: terraform --version

1. Installed Azure CLI by following the learn page;
2. sudo apt-get update
sudo apt-get install apt-transport-https ca-certificates curl gnupg lsb-release
3. sudo mkdir -p /etc/apt/keyrings
curl -sLS https://packages.microsoft.com/keys/microsoft.asc |
  gpg --dearmor | sudo tee /etc/apt/keyrings/microsoft.gpg > /dev/null
sudo chmod go+r /etc/apt/keyrings/microsoft.gpg
4. AZ_DIST=$(lsb_release -cs)
echo "Types: deb
URIs: https://packages.microsoft.com/repos/azure-cli/
Suites: ${AZ_DIST}
Components: main
Architectures: $(dpkg --print-architecture)
Signed-by: /etc/apt/keyrings/microsoft.gpg" | sudo tee /etc/apt/sources.list.d/azure-cli.sources
5. sudo apt-get update
sudo apt-get install azure-cli
6. az version insalled 2.91.0 confirmed with; az --version

1. Installed bicep using: az bicep install
2. Version 0.48.1 confirmed using; az bicep version

1. Installed Kubernetes CLI using;
2. curl -fsSL https://pkgs.k8s.io/core:/stable:/v1.37/deb/Release.key | sudo gpg --dearmor -o /etc/apt/keyrings/kubernetes-apt-keyring.gpg
sudo chmod 644 /etc/apt/keyrings/kubernetes-apt-keyring.gpg
3. echo 'deb [signed-by=/etc/apt/keyrings/kubernetes-apt-keyring.gpg] https://pkgs.k8s.io/core:/stable:/v1.37/deb/ /' | sudo tee /etc/apt/sources.list.d/kubernetes.list
sudo chmod 644 /etc/apt/sources.list.d/kubernetes.list
4. sudo apt-get update
sudo apt-get install -y kubectl
5. Version 1.37.1 installed confirmed with; kubectl version

1. Installed Docker Engine following wiki;
2. sudo apt update
sudo apt install ca-certificates curl
sudo install -m 0755 -d /etc/apt/keyrings
sudo curl -fsSL https://download.docker.com/linux/ubuntu/gpg -o /etc/apt/keyrings/docker.asc
sudo chmod a+r /etc/apt/keyrings/docker.asc
3. sudo tee /etc/apt/sources.list.d/docker.sources <<EOF
Types: deb
URIs: https://download.docker.com/linux/ubuntu
Suites: $(. /etc/os-release && echo "${UBUNTU_CODENAME:-$VERSION_CODENAME}")
Components: stable
Architectures: $(dpkg --print-architecture)
Signed-By: /etc/apt/keyrings/docker.asc
EOF

sudo apt update
4. sudo apt install docker-ce docker-ce-cli containerd.io docker-buildx-plugin docker-compose-plugin
5. Docker confirmed installed and running with:  sudo systemctl status docker

Installed ansible using;
1. sudo apt install ansible
2. Installed version 2.20.1 confirmed with "ansible --version"

Installed the following Visual Studio Code extensions in the WSL workspace;
1. Powershell
2. Bicep
3. Remote - SSH
4. YAML
5. ShellCheck
6. Python
7. HashiCorp Terraform
8. Kubernetes
9. Docker
10. EditorConfig
11. Ansible

## 8. [X] AI Completions are off in two levels
1. Opened settings with CNTRL+, - searched for editor.inlinesuggest.enabled
2. Ensured the setting was off for User, WSL: Ubuntu, and Workspace
3. Created test.bicep and typed" resource vNet 'Microsoft.networks/virtualnetwor" - intellisense finished the command and added suggestions for the API version. But after using "= {" no gray text apeared.
4. Re-enabled the settings and tried again, multiple gray lines appeared suggesting parameters for the module.
5. Disabled the settings again.
6. The setting is also comitted in settings.json within the .vscode folder for future clones.


## 9. [x] Docker works from WSL terminal

1. Added my user to the docker group using sudo usermod -aG docker jeroen
2. Restarted the WSL session
3. docker run hello-world
4. Container visable in VS Code Extension

## 10. [x] WSL's memory and CPU use is limited on purpose
1. Created .wslconfig in C:\Users\Jeroen
2. With the following settings:
[wsl2]
memory=8GB
processors=4
swap=2GB
3. The lab itself will use 36GB of memory. WSL will bring it to a maximum of 44GB, leaving 20GB for Windows OS and headroom. Entire system has 64GB.
4. Added networkingMode=mirrored to the .wslconfig file for setting the network mode to mirrored as per ADR15.
5. WSL was restarted using "wsl --shutdown" and "wsl" in powershell.
6. wslinfo --networking-mode shows "mirrored" as the output

## 11. [x] Readme complete, ADR's present, PR to main and clean gitleaks was run


# Decisions

ADR-0013: phase1-docker-runs-where
ADR-0014: phase1-wsl-auth-keys
ADR-0015: phase1-wsl-limits-and-networking
