# Only commit method will be squash

## Context and Problem Statement

linear history plus signed commits, and the rule 8 trailer are required for the repo's. How do we ensure this during PRs?

## Considered Options

Squash
Rebase
Merge

## Decision Outcome

Chosen option: Squash, with the trailer in the message. Rebase merging has been disabled in both repo's.

## Consequences

One commit per PR on main
Branch history lives only in the PR
signatures on main come from GitHub's key rather than mine
Override code goes in seperate PRs
