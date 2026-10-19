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

### 3. [x] Commits are signed with SSH and show verified, vigilent mode is on
1. SSH key has been generated and saved on the WSL and added to the SSH-agent.
2. Public ssh key has been uploaded to Github for both Authentication and as a Signing key in Github > Settings > SSH and GPG keys
3. In Github > Settings > SSH and GPG keys > Vigilent mode has been enabled.
4. Ran the commands: git config --global gpg.format ssh and git config --global user.signingkey ~/.ssh/id_ed25519
5. Checked what the remote url is set to: git remote -v
6. If origin is set to https, change this to ssh: git remote set-url origin git@github.com:USERNAME/REPOSITORY.git
7. Any local commit now needs to include the -S parameter to sign the commit.

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
1. All folders have been created in the appropriate repos according to the plan. Empty folders are also present

### 7. [x] Shell scripts are stored with LF endings
1. .gitattributes contains the line: *.sh text eol=lf
2. git check-attr -a -- phase-01-setup/bash/simplevm.sh shows: text:set and eol:lf

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

### 12. [X] At least one change in "main" done through a pull request

### 13. [X] Git log across both repo's show no-reply identifier and only verified commits
Commits from S1 are not signed, as that was before signing was setup.

### 14. [X] At least 4 ADR's exist for this phase

# Decisions
ADR-0005: phase1-where-git-runs
ADR-0006: phase1-auth-keys
ADR-0007: phase1-hook-mechanism-gitleaks
ADR-0008: phase1-solo-maintainer-ruleset
ADR-0009: phase1-labs-adr
