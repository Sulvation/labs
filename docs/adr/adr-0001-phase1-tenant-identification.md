# Determine which directory the subscription belongs to

## Context and Problem statement

If the subscription belong to the work tenant, lab identities, groups, management groups, policies and federation credentials would be created in a production environment.
Having to move the subscription to a different directory would delete things as Role Assignements and Custom Roles. Resources like Managed Identities would have to be disabled and re-attached, or deleted and re-created.

## Considered Options

Work tenant: Migrate subscription to seperate lab or personal tenant.
Personal tenant: no action needed.

## Decision Outcome

Chosen option: "Personal tenant, no action needed". verified with "az account show" and "az account list" which both display my personal tenant name and id and no other tenants.
Seperate lab tenant is not a viable option as the JAA - Study Subscription is linked to this tenant already, and existing running resources need to stay in place. The migration to a different tenant is too destructive to the existing resources in the subscription.

## Consequences

Personal tenant does not interfere with work-resources, but personal projects run on the same subscription. Shared cost management and care is required when deploying and deleting resources.
