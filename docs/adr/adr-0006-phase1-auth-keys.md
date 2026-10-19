# Authentication and signing use the same SSH key

## Context and Problem Statement

Should Signing and Authenticating use seperate or the same SSH-keys? Which key type and algorithm to use? Should they use passphrases?

## Considered Options

One key for both
One key for each
rsa 4096 algorithm
ed25519 algorithm
Passphrase
No passphrase

## Decision Outcome

Chosen option(s): One SSH ed25519 passphrase enabled key for both Signing and Authentication, as managing multiple keys would become cumbersome and add no real benefit in a single maintainer repo.


## Consequences
Legacy systems might not support ed25519 SSH-Keys, and would require rsa 4096, but as this lab creates everything based on recent releases, this should not be an issue and is an accepted risk.
Any commit now uses to use the -S parameter to sign the commit.
As the SSH key is located on WSL and accesable through Windows, the passphrase is an additional security measure - as WSL itself won't need the passphrase after the Key has been added to the ssh agent.
