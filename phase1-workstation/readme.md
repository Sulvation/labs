# Goal


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

## 3. [x] Repos on Linux
Labs and Meridiaan-platform repo's were located on /mnt/c/learninglabs/. These have been moved to ~/src/ by;
1. shopt -s dotgob (ensure that patterns include hidden names)
2. cd /mnt/c/learning/labs
3. mkdir ~/src/labs
4. mkdir ~/src/meridiaan-platform
5. mv labs/* ~/src/labs
6. mv meridiaan-platform/* ~/src/meridiaan-platform

Then each location was checked to see if .git was present and if git pull said "Already up to date", which both repos did.

Having the repos within Linux instead of on Windows in "/mnt/c" ensures that LF line endings are default instead of CRLF.

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

## 6. [] Line endings are deliberate: the repos have a .gitattributes policy. Opening and saving a file from the Windows side and from the WSL side doesn’t produce phantom diffs

## 7. [] VS Code opens the repos through the WSL remote and all extensions are installed
1. Installed the WSL Extension on Visual Studio Code.
2. From WSL, ran "code ." from ~/src/
3. Visual Studio Code opened connected to the repos through the WSL remote automatically, and shows: src [WSL: Ubuntu] in the file explorer.

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

1. Installed Bicep by following the learn page;
2. sudo apt-get update
sudo apt-get install apt-transport-https ca-certificates curl gnupg lsb-release
3. sudo mkdir -p /etc/apt/keyrings
curl -sLS https://packages.microsoft.com/keys/microsoft.asc |
  gpg --dearmor | sudo tee /etc/apt/keyrings/microsoft.gpg > /dev/null
sudo chmod go+r /etc/apt/keyrings/microsoft.gpg
4. sudo apt-get update
sudo apt-get install azure-cli
5. az version insalled 2.91.0 confirmed with; az --version

1. Installed bicep using: az bicep install
2. Version 0.48.1 confirmed using; az bicep version

1. Installed YAML for Python3
2. sudo apt install python3-pip
3. sudo pip3 install PyYAML
4. Verified version 6.0.3 using; python3 -m pip show PyYAML

1. Installed ansible using sudo apt install ansible
2. Version 2.20.1 confirmed with; ansible --version

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

Installed the following Visual Studio Code extensions in the WSL workspace;
1. Powershell
2. Bicep
3. Remote - SSH
4. YAML
5. ShellCheck
6. Pyhton
7. HashiCorp Terraform
8. Kubernetes
9. Docker

## 8. [] AI Completions are off in two levels
1. Opened settings with CNTRL+, - searched for editor.inlinesuggest.enabled
2. Ensured the setting was off for User, WSL: Ubuntu, and Workspace
3. The same was done with: github.copilot.enable
4. Created test.bicep and typed" resource vNet 'Microsoft.networks/virtualnetwor" - intellisense finished the command and added suggestions for the API version. But after using "= {" no gray text apeared.
5. Re-enabled the settings and tried again, multiple gray lines appeared suggesting parameters for the module.
6. Disabled the settings again.

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
3. The lab itself will use 36GB of memory. WSL will bring it to a maximum of 44GB, leaving 12GB for Windows OS and headroom.
4. WSL was restarted using "wsl --shutdown" and "wsl" in powershell.

## 11. [X] Readme complete, ADR's present, PR to main and clean gitleaks was run


# Decisions

ADR-0013: phase1-docker-runs-where
ADR-0014: phase1-wsl-auth-keys
ADR-0015: phase1-wsl-limits-and-networking
