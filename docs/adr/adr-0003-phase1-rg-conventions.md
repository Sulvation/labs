# Follow CAF Naming conventions and Lifecycle Grouping

## Context and Problem Statement

How should the Resource Groups be named and handled?


## Considered Options

Should the Resource Groups be driven by the modules and phases of the plan?
Should the Resource Groups follow the CAF for naming conventions and Lifecycle Grouping


## Decision Outcome

Chosen option: Follow the CAF, by following the CAF naming conventions and Lifecycle Grouping  it ensures habit is created for production best practices. Debating what shares a lifecycle will result in long-term familiarity of deploying resources.

## Consequences

Multiple Resource Groups might be created for the same module, which means the clean-up scripts need to ensure that all resources of the module are destroyed to prevent accidental cost occurance.