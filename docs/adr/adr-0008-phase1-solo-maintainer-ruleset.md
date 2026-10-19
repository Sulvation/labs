# Solo maintainer ruleset

## Context and Problem Statement

What ruleset to create


## Considered Options

Just preventions
Code reviews
Bypass


## Decision Outcome

Chosen option: Just preventions. Deny-push-to-main ruleset in each repo will be adding the following rules: "restrict deletion, "Block force pushes", "Require linear history", "require signed commits", along the already existing "Require a pull request before merging".
No one is on the bypass list, as it's a single maintainer repo and I also need to follow it's rules.

## Consequences
By not having code reviews, all files need to be double checked before pushing to the branch.
