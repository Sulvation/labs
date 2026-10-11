using '../modules/budget.bicep'

param budgetName = 'lab-budget'
param amount = 20
param timeGrain = 'Monthly'
param firstThreshold = 50
param secondThreshold = 80
param thirdThreshold = 100
param contactEmail = split(readEnvironmentVariable('CONTACT_EMAIL'), ',')
param startDate = '2026-10-01'
param endDate = '2030-10-31'
param forecastedThreshold = 100
param tagName = 'purpose'
param tagValue = ['lab']
