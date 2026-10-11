# Use Bicep to deploy budget to subscription

## Context and Problem Statement

Which method to deploy budget to subscription


## Considered Options

Azure CLI
Bicep

## Decision Outcome

Chosen option: "Bicep", because it's easier to alter the parameters later and run the bicep again if budgets ever change later down the project. 
For this deployment Cost Management Contributor is the least privilege role, as ready won't allow us to create a budget.

## Consequences

Any resource not tagged with purpose=lab, or that were automatically created by Azure resources without a tag, will not be caught by this budget. A seperate budget that is created outside of this repo exists on the entire subscription it alerts on all spend in the subscription. This budget belongs to a seperate project in the same subscription and will not be documented here, but it serves the purpose of the catch in this repo.
The risk of this seperate budget not being managed by this repo and the fact that accidental deletion of the budget cannot be tracked is accepted.
Nothing on the subscription caps spending. So manual action on alerts is required.