targetScope = 'subscription'

@description('The name of the resource group to create')
param rgName string

@description('The module name to tag the resource group with')
param moduleTag string

@description('The expiry date of the resource group in YYYY-MM-DD format')
param expiryTag string

resource rg 'Microsoft.Resources/resourceGroups@2025-04-01' = {
  name: rgName
  location: deployment().location
  tags: {
    purpose: 'lab'
    module: moduleTag
    expires: expiryTag
  }
}

output rgName string = rg.name
