# Title with shorthanded decision

# Status
Supersedes ADR0010: phase1-labs-env-ignore

## Context and Problem Statement

Should gitignore include broader ignores for .env variations?

## Considered Options

Yes
No

## Decision Outcome

Chosen option: Yes, ignoring a bit too much has virtually zero cost, whereas leaking a secret is catastrophic

## Consequences

Explicit exception rules need to be added to gitignore to allow needed .env variations.
