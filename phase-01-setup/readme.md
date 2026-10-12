# Goal
- Document which Entra tenant your labs live in. Deploy a tag-filtered budget from code. Write a naming and tagging convention that every lab from S2 onward follows.

# Acceptance Criteria:

## 1. [x] Tenant Identification:

## 2. [x] Budget deployed from code

## 3. [] Proof that it works

## 4. [x] Know the blind spots

## 5. [x] Written convention

## 6. [x] Public-repo Hygiene

## 7. [x] Short readme


# How to run or verify
1. Check current subscription: get-azcontext
2. If it displays a different subscription to which the budget needs to be applied, check which other subscriptions exist: get-azcontext -listavailable
3. Copy the name of the subscription the budget needs to be attached to, then run: set-azcontext -Subscriptionname "name of the subscription" to change the context.
4. Check if current subscription changed with: get-azcontext
5. Set the Powershell variable for $env:CONTACT_EMAIL
6. Deploy the bicep with Powershell: new-azsubscriptiondeployment -location westeurope -TemplateParameterFile sub-budget.bicepparam -contactEmail $contactEmail
7. Verify existance of the budget with: az consumption budget list
8. Create a resource which consumes credits: /bash/simplevm.sh deploys a Linux Virtual Machine within a test resourcegroup.
9. Remove the resources to prevent overspend: /bash/removesimplevm.sh removes the resourcegroup and all it's resources.

## Notes
The variable $env:CONTACT_EMAIL is a environment variable, which ensures user data isn't available in the code.
If the $env:CONTACT_EMAIL is empty, Azure will fail the deployment loudly.
The default budget amount is 20, and can be changed in the \bicep\params\sub-budget.bicepparam file by editing "param amount ##"

## Proof

After the usage data refreshed for the previous day, the Azure Portal shows the budget is 0,02% progressed. Alternatively, setting Cost Analysis filtered on the tag purpose=lab, the same usage is shown. More specifically €0,01 for the rg-lab-budget-compute-euw-test-01 showing <€0,01 for: Virtual Networks, Virtual Machines, Storage. Forecast is unavailable as the resources have since been deleted.

# Decisions
- ADR-0001: phase1-tenant-identification
- ADR-0002: phase1-budget-alert
- ADR-0003: phase1-rg-conventions
- ADR-0004: lab-owner tag

# What to do differently
Figure out how to run the variable in Azure CLi from windows powershell window without getting errors. Only got it working with a powershell variable and command instead of Azure CLI. -- This was due to a WSL / Windows issue where due to system depencies it simply couldn't work.