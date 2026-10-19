# Using the pre-commit gitleaks hook framework

## Context and Problem Statement

Which hook mechanism for gitleaks should be implemented?


## Considered Options

1. A .git/hooks script
2. core.hooksPath
3. the Pre-commit framework


## Decision Outcome

Chosen option: 3. the Pre-Commit framework, as it's pre-made to work with any langauge and any other commonly used hooks, like Gitleaks, is easily added.


## Consequences
While editable, it is pre-made so some thing might function different than expected.
Pre-commit and the .pre-commit.config.yaml needs to be installed on each device using git. In this lab, only 1 person and 1 device is using it, so the risk is accepted.
When development transfers to the Linux workstation, steps will have to be repeated.
