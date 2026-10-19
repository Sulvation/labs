# Goal

Create a personal GitHub account and two repos, labs and meridiaan-platform, that meet the standards in the plan’s “Git and repository standards” section. Prove that each control actually works, rather than just showing that it is switched on.

# Acceptance

## Account
### 1. [x] The account is personal
Account belongs to a personal email with no ties to any company. 2FA uses a passkey and recovery codes are saved outside of Github.
This can be verified by going into Github > Settings > Password and Authentication > it says 1 passkey configured.

### 2. [x] Email privacy enabled
Email privacy is enabled. git config user.email was set using the Github no reply address in the Linux (WSL).
In Github > Settings > Email > "Keep my email addresses private" is ticked, as well as "Block command line pushes that expose my email".

### 3. [x] Commits are signed with SSH and show verified, vigilant mode is on
1. SSH key has been generated and saved on the WSL and added to the SSH-agent.
2. Public ssh key has been uploaded to Github for both Authentication and as a Signing key in Github > Settings > SSH and GPG keys
3. In Github > Settings > SSH and GPG keys > Vigilant mode has been enabled.
4. Ran the commands: git config --global gpg.format ssh and git config --global user.signingkey ~/.ssh/id_ed25519
5. Checked what the remote url is set to: git remote -v
6. If origin is set to https, change this to ssh: git remote set-url origin git@github.com:USERNAME/REPOSITORY.git
7. git config --global commit.gpgSign true

### 4. [x] Signatures also verify locally, not just on Github
To ensure signatures are also verified locally:
1. git verify-commit HEAD
2. If error, ls -l ~/.ssh/*.pub
3. cat ~/.ssh/id_ed25519.pub (or different name if present)
4. mkdir -p ~/.ssh
5. nano ~/.ssh/allowed_signers
6. Edit the nano file so it has 1 line: your-email@example.com namespaces="git" ssh-ed25519 "copied public key from step 3"
7. Verify again with git verify-commit HEAD
8. Return message should start with Good "git" signature

## Repo's

### 5. [X] Each repo contains readme, mit license, .gitignore, .gitattributes and .editorconfig

### 6. [X] Each repo has the folder skeleton from the plan, empty folders exist in the repo.
1. All folders have been created in the appropriate repos according to the plan.

### 7. [x] Shell scripts are stored with LF endings
PS C:\learninglab\meridiaan-platform> git ls-files --eol
i/lf    w/crlf  attr/text=auto          .editorconfig
i/lf    w/crlf  attr/text=auto          .gitattributes
i/lf    w/lf    attr/text eol=lf        .github/workflows/placeholder.md
i/lf    w/crlf  attr/text=auto          .gitignore
i/lf    w/lf    attr/text=auto          .pre-commit-config.yaml
i/lf    w/crlf  attr/text=auto          LICENSE
i/lf    w/lf    attr/text eol=lf        README.md
i/lf    w/lf    attr/text eol=lf        ansible/placeholder.md
i/lf    w/lf    attr/text eol=lf        app/placeholder.md
i/lf    w/lf    attr/text eol=lf        docs/adr/placeholder.md
i/lf    w/lf    attr/text eol=lf        docs/postmortems/placeholder.md
i/lf    w/lf    attr/text eol=lf        infra/placeholder.md
i/lf    w/lf    attr/text eol=lf        k8s/placeholder.md
PS C:\learninglab\meridiaan-platform>

PS C:\learninglab\labs> git ls-files --eol
i/lf    w/mixed attr/text=auto          .editorconfig
i/lf    w/mixed attr/text=auto          .gitattributes
i/lf    w/lf    attr/text=auto          .gitignore
i/lf    w/lf    attr/text=auto          .pre-commit-config.yaml
i/lf    w/lf    attr/text=auto          LICENSE
i/lf    w/lf    attr/text eol=lf        README.md
i/lf    w/crlf  attr/text eol=lf        docs/adr/adr-0000-template.md
i/lf    w/mixed attr/text eol=lf        docs/adr/adr-0001-phase1-tenant-identification.md
i/lf    w/mixed attr/text eol=lf        docs/adr/adr-0002-phase1-budget-alert.md
i/lf    w/mixed attr/text eol=lf        docs/adr/adr-0003-phase1-rg-conventions.md
i/lf    w/crlf  attr/text eol=lf        docs/adr/adr-0004-phase1-lab-owner-tag.md
i/lf    w/crlf  attr/text eol=lf        docs/adr/adr-0005-phase1-where-git-runs.md
i/lf    w/crlf  attr/text eol=lf        docs/adr/adr-0006-phase1-auth-keys.md
i/lf    w/crlf  attr/text eol=lf        docs/adr/adr-0007-phase1-hook-mechanism-gitleaks.md
i/lf    w/crlf  attr/text eol=lf        docs/adr/adr-0008-phase1-solo-maintainer-ruleset.md
i/lf    w/mixed attr/text eol=lf        docs/adr/adr-0009-phase1-labs-adr.md
i/lf    w/crlf  attr/text eol=lf        docs/conventions.md
i/lf    w/crlf  attr/text eol=lf        phase-01-git/readme.md
i/lf    w/lf    attr/text eol=lf        phase-01-setup/bash/removesimplevmrg.sh
i/lf    w/lf    attr/text eol=lf        phase-01-setup/bash/simplevm.sh
i/lf    w/crlf  attr/text eol=lf        phase-01-setup/bicep/modules/budget.bicep
i/lf    w/crlf  attr/text=auto          phase-01-setup/bicep/params/sub-budget.bicepparam
i/lf    w/mixed attr/text eol=lf        phase-01-setup/readme.md
PS C:\learninglab\labs>

### 8. [x] .env files are ignored
1. .gitignore contains .env
2. Confirmed by cat .gitignore | grep .env
3. and: git check-ignore -v .env
.gitignore:149:.env     .env
4. and: git check-ignore -v app/.env
.gitignore:149:.env     app/.env

## Secrets

### 9. [X] Gitleaks hook blocks a commit containing a fake secret in both repo's. Fake value must not appear in any commit, on any branch
1. Gitleaks was added to the pre-commit configuration on both repo's.

1. sudo apt install pre-commit
2. in each repo root: nano .pre-commit-config.yaml >
repos:
-   repo: https://github.com/pre-commit/pre-commit-hooks
    rev: v6.0.0
    hooks:
    -   id: check-yaml
    -   id: end-of-file-fixer
    -   id: trailing-whitespace
-   repo: https://github.com/gitleaks/gitleaks
    rev: v8.30.0
    hooks:
    -   id: gitleaks
3. pre-commit autoupdate
4. pre-commit install
5. check with pre-commit run --all-files

Lab repo test:
Finding:     # Secrets:
API KEY: REDACTED
Secret:      REDACTED
RuleID:      generic-api-key
Entropy:     3.897587
File:        phase-01-git/readme.md
Line:        104
Fingerprint: phase-01-git/readme.md:generic-api-key:104

1:10PM INF 0 commits scanned.
1:10PM INF scanned ~53 bytes (53 bytes) in 87.1ms
1:10PM WRN leaks found: 1

Meridiaan repo test:
API_KEY: REDACTED
Secret:      REDACTED
RuleID:      generic-api-key
Entropy:     4.037401
File:        README.md
Line:        19
Fingerprint: README.md:generic-api-key:19

10:14PM INF 0 commits scanned.
10:14PM INF scanned ~40 bytes (40 bytes) in 83.7ms
10:14PM WRN leaks found: 1

jeroen@DESKTOP-DRRD1T6:/mnt/c/learninglab/meridiaan-platform$

### 10. [X] Secret scanning and push protection enabled on both repo's
1. Within the settings of each repo: "Secret Protection" and "Push Protection" have been enabled.

## Workflow

### 11. [X] A ruleset exists in both repo's to reject direct push to main
1. In each repo's settings a ruleset has been created with the following settings;
- Name: Deny-push-to-main
- Target branches: include "main"
- Rules: Require a pull request before merging
         Block force pushes (adr-0008)
         Restrict deletions (adr-0008)
         Require linear history (adr-0008)
         Require signed commits (adr-0008)
2. First push-test failed, as the push went through. The ruleset was not yet enforced.
3. Enforced the ruleset on each repo.
4. Enumerating objects: 6, done.
Counting objects: 100% (6/6), done.
Delta compression using up to 16 threads
Compressing objects: 100% (4/4), done.
Writing objects: 100% (5/5), 827 bytes | 91.00 KiB/s, done.
Total 5 (delta 3), reused 0 (delta 0), pack-reused 0 (from 0)
remote: Resolving deltas: 100% (3/3), completed with 1 local object.
remote: error: GH013: Repository rule violations found for refs/heads/main.
remote: Review all repository rules at https://github.com/Sulvation/labs/rules?ref=refs%2Fheads%2Fmain
remote:
remote: - Changes must be made through a pull request.
remote:
To github.com:Sulvation/labs.git
 ! [remote rejected] main -> main (push declined due to repository rule violations)
error: failed to push some refs to 'github.com:Sulvation/labs.git'

5. Test result on meridiaan repo:
Enumerating objects: 4, done.
Counting objects: 100% (4/4), done.
Delta compression using up to 16 threads
Compressing objects: 100% (2/2), done.
Writing objects: 100% (3/3), 560 bytes | 70.00 KiB/s, done.
Total 3 (delta 1), reused 0 (delta 0), pack-reused 0 (from 0)
remote: Resolving deltas: 100% (1/1), completed with 1 local object.
remote: error: GH013: Repository rule violations found for refs/heads/main.
remote: Review all repository rules at https://github.com/Sulvation/meridiaan-platform/rules?ref=refs%2Fheads%2Fmain
remote:
remote: - Changes must be made through a pull request.
remote:
To github.com:Sulvation/meridiaan-platform.git
 ! [remote rejected] main -> main (push declined due to repository rule violations)
error: failed to push some refs to 'github.com:Sulvation/meridiaan-platform.git'

### 12. [X] At least one change in "main" done through a pull request

### 13. [X] Git log across both repo's show no-reply identifier and only verified commits
Commits from S1 are not signed, as that was before signing was setup. 7b8795d is not either due to a mistake.
Commits 761818c and 48dbfce contain override-code. Marker is in the commit body.

### 14. [X] At least 4 ADR's exist for this phase

# Decisions
ADR-0005: phase1-where-git-runs
ADR-0006: phase1-auth-keys
ADR-0007: phase1-hook-mechanism-gitleaks
ADR-0008: phase1-solo-maintainer-ruleset
ADR-0009: phase1-labs-adr
ADR-0010: phase1-labs-env-ignore
ADR-0011: phase1-labs-merge-method
