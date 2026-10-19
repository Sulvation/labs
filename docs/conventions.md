# Conventions

# Naming Conventions
This project will follow CAF naming conventions: resource type, workload or application, region, environment, instance number.
To further clarify the resource I'm adding a "function" to the list, as well as a "prefix". Function will specify what the rg containts of the project/app, like compute or storage. Prefix for easy identification which project is belongs to.

Each resource created will use the abbreviation as listed in the following learn article: https://learn.microsoft.com/en-us/azure/cloud-adoption-framework/ready/azure-best-practices/resource-abbreviations

## Environments

The Lab will only include the "test" environment.
Meridiaan will only use "prod" and "dev", where "dev" is only used if the workload has a second instance for development purposes.

## Naming examples
Example; a resource group which holds the compute for a app server in my lab; rg-lab-app-compute-euw-test-01
The vm inside would be: vm-lab-app-euw-test-01

For Meridiaan, a resource group containing a storage account would be; rg-meri-app-storage-euw-prod-01

<!-- Partly adopted from AI-generated override text -->
## Naming Risk

The labs here are ephemeral, which incurs these 2 naming problems:

1. Globally unique names: The name becomes part of a public DNS name, so it must be unique across all of Azure. It is released when the resource is deleted.
2. Names reserved after deletion: Soft-delete or a cooldown keeps the name taken for a retention period after you delete the resource. A rebuild with the same name fails until that period ends, or until the resource is purged. These resources include:
    - Key Vault (7–90 days)
    - API Management (48 hours)
    - Azure AI services accounts (48 hours)
    - App Configuration (up to 7 days)
    - and any other type with soft-delete enabled. Check the type's docs before you use it.

### Rules

A name must be deterministic per instance:

- Rerun: The same deployment without teardown, resources have the same name so the deployment is a no-op.
- Rebuild: The same deploment after a teardown, new names so there's no conflict with reserved names.

Inputs to a name come only from values committed in the repo, and never from a random value, to prevent reruns from creating duplicates.

### How

- The suffix is "uniqueString(resourceGroup().id)": A 13-charachter hash that always returns the same output with the same input.
- The resource group name carries the instance number (`-01`, `-02`, ...), so the resource group id, and with it the suffix, changes only when the instance number changes.
- A rebuild means bumping the instance number in the committed parameter file. I bump it when I tear down and rebuild a lab; a plain rerun never bumps it.
- Names are shortened with `take()` to the type's maximum length. Keep at least 6 characters of the suffix.
- Scripts that need one of these names read it from the deployment outputs. They never reconstruct it.

### Example

var suffix = uniqueString(resourceGroup().id)
var stName = take('stlabapp${suffix}', 24)

### Purge as the alternative

Purge can be used to immediately free a reserved name, but only when purge protection is off, and the deleted data can no longer be recovered.
To ensure good habits we won't resort to purging any resources.

<!-- Partly adopted AI-generated override end -->

# Tagging

To ensure simplification, all tag names and values will be only lowercase to prevent case sensitivity issues.
Each resource and resource group created will have the following required tag(s):
- Name: purpose
- Value: lab

- Name: module
- Value: (the module for which the resource was created)

- Name: expires
- value: (date in YYYY-MM-DD format)
Expiry tag date is set by me, end date is determined on when I think this session is done and recources can be deleted. In most cases same day.

## Tagging Additional

Any resources that can not be tagged need to be placed inside a tagged Resource Group, the expiry tag on the Resource Group is required.
