# Docker Engine runs in WSL

# Status

## Context and Problem Statement

Where does docker run?

## Considered Options

Docker Desktop Linux or Windows
Docker Engine Linux or Windows


## Decision Outcome

Chosen option: Docker Engine in Linux, as the point of the lab is to primarly use Linux, running it on Windows wouldn't make sense. The choice for Docker Engine over Desktop is due to the fact that Desktop uses more resources than Engine, on a WSL terminal where resources are already sparse.

## Consequences
Any membership in the Docker group means effectively root access to that machine. Risk is accepted in a solo-maintainer repo.
