# Drop the Owner Tag from resources as no one else is present within the environment

## Context and Problem Statement

Should resources within the Labs repo be tagged with an owner, even though there's no one else present in the environment?

## Considered Options

Tag Owner
Don't tag Owner

## Decision Outcome

Chosen option: Don't tag Owner, as there is no other depency within the tenant, creating a tag that always has the same value may result in a bad habit of defaulting a value in scenarios where ownership does matter.
Other production representative repo's should use the owner tag.

## Consequences

Practice without the inclusion of a subjectively required tag in most production environments might create a habit of laziness for future production environments.
As this is a consious decision with the downside aware of, the consequence is accepted.
