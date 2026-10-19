# Gitignore will keep only .env for now

# Status
Superseded by ADR-0012: phase1-labs-env-ignore2.md

## Context and Problem Statement

During testing I've found that `*.env` and `.env.*` are still allowed. Should this be the case?


## Considered Options

Include `*.env` and `.env.*`
Keep only .env

## Decision Outcome

Chosen option: Keep only .env, as I've not had to deal with .env files in these repo's yet, I can't confidently say wether or not including more .env options with wildcards is a good or a bad idea

## Consequences

The risk is accepted that this might need reiteration and supersedence at a later point in time.
