# Git runs from  Linux (WSL)

## Context and Problem Statement

Does Git run from WSL or Windows?


## Considered Options

Linux (WSL)
Windows
Both

## Decision Outcome

Chosen option: Linux (WSL), to get more familiar with Linux CLI.

## Consequences

Repo's live on '/mnt/c/' and so will have some Windows definitions active - untill the lab moves to the Linux workstation entirely.
By only using Git from WSL, SSH authentication is required and needs to be properly setup and tested.
Windows should no longer be used for Git, to familiarize more with Linux CLI.
