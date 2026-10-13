# Goal

Create a personal GitHub account and two repos, labs and meridiaan-platform, that meet the standards in the plan’s “Git and repository standards” section. Prove that each control actually works, rather than just showing that it is switched on.

# Acceptance

## Account
### 1. [] The account is personal

### 2. [] Email privacy enabled

### 3. [] Commits are signed with SSH and show verified, vigilent mode is on

### 4. [] Signatures also verify locally, not just on Github

## Repo's

### 5. [] Each repo contains readme, mit license, .gitignore, .gitattributes and .editorconfig

### 6. [] Each repo has the folder skeleton from the plan, empty folders exist in the repo.

### 7. [] Shell scripts are stored with LF endings

### 8. [] .env files are ignored

## Secrets

### 9. [] Gitleaks hook blocks a commmit containing a fake secret in both repo's. Fake value must not appear in any commit, on any branch

### 10. [] Secret scanning and push protection enabled on both repo's

## Workflow

### 11. [] A ruleset exists in both repo's to reject direct push to main

### 12. [] At least one change in "main" done through a pull request

### 13. [] Git log across both repo's show no-reply identifier and only verified commits

### 14. [] At least 4 ADR's exist for this phase



# Decisions
ADR-0005: phase2-where-git-runs
ADR-0006: phase2-auth-keys
ADR-0007: phase2-hook-mechanism-gitleaks
ADR-0008: phase2-solo-maintainer-ruleset
ADR-0009: phase2-labs-adr