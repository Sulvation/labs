targetScope = 'subscription'

@description('The name of the budget. The name must be unique within the subscription.')
param budgetName string

@description('The amount of the budget in the specified currency. The amount must be a positive number. Maximum value is 150.')
@maxValue(150)
param amount int

@allowed([
  'Monthly'
  'Quarterly'
  'Annually'
])
@description('The time grain of the budget. The time grain can be Monthly, Quarterly, or Annually.')
param timeGrain string

@description('The start date of the budget in ISO 8601 format (YYYY-MM-DD).')
param startDate string

@description('The end date of the budget in ISO 8601 format (YYYY-MM-DD).')
param endDate string

@description('The threshold for forecasted costs.')
param forecastedThreshold int

@description('The threshold for the first notification.')
param firstThreshold int

@description('The threshold for the second notification.')
param secondThreshold int

@description('The threshold for the third notification.')
param thirdThreshold int

@minLength(1)
@description('The email addresses of the contacts to notify.')
param contactEmail string[]

@description('The name of the tag to filter the budget by.')
param tagName string

@description('The values of the tag to filter the budget by.')
param tagValue string[]

resource budget 'Microsoft.Consumption/budgets@2024-08-01' = {
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
