targetScope = 'subscription'

param budgetName string
@description('The amount of the budget in the specified currency. The amount must be a positive number. Maximum value is 150.')
@maxValue(150)
param amount int

@allowed([
  'Monthly'
  'Quarterly'
  'Annually'
])
param timeGrain string
param startDate string
param endDate string
param forecastedThreshold int
param firstThreshold int
param secondThreshold int
param thirdThreshold int
@minLength(1)
param contactEmail string[]
param tagName string
param tagValue string[]

resource budget 'Microsoft.Consumption/budgets@2026-06-01' = {
  name: budgetName
  properties: {
    timePeriod: {
      startDate: startDate
      endDate: endDate
    }
      filter: {
      tags: {
        name: tagName
        values: tagValue
        operator: 'In'
      }
    }
    timeGrain: timeGrain
    amount: amount
    category: 'Cost'
    notifications: {
      forecasted: {
        enabled: true
        operator: 'GreaterThan'
        threshold: forecastedThreshold
        contactEmails: contactEmail
        thresholdType: 'Forecasted'
      }
      firstThreshold: {
        enabled: true
        operator: 'GreaterThan'
        threshold: firstThreshold
        contactEmails: contactEmail
        thresholdType: 'Actual'
      }
      secondThreshold: {
        enabled: true
        operator: 'GreaterThan'
        threshold: secondThreshold
        contactEmails: contactEmail
        thresholdType: 'Actual'
      }
      thirdThreshold: {
        enabled: true
        operator: 'GreaterThanOrEqualTo'
        threshold: thirdThreshold
        contactEmails: contactEmail
        thresholdType: 'Actual'
      }
  }    
  }
}
