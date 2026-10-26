# Commits signed from WSL

# Status
Accepted

## Context and Problem Statement

Where do commits get signed from

## Considered Options

WSL
Windows

## Decision Outcome

Chosen option: WSL, the entire point of the lab is to use more Linux, using Windows for this makes no sense. Private key lives in ~/.ssh on the WSL machine.

## Consequences
If previous phases were created and signed through Windows, new keys would have to be generated and configured.
Revoking the key means a new one has to be generated on a machine, and added to the GitHub signing and SSH access settings.
