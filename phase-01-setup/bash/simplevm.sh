#!/bin/bash

az group create --name 'rg-lab-budget-compute-euw-test-01' --location 'WestEurope' --tags 'purpose=lab' 'module=s1' 'expires=2026-10-11'

az vm create \
    --resource-group 'rg-lab-budget-compute-euw-test-01' \
    --name 'vm-lab-budget-euw-test-01' \
    --image "Canonical:0001-com-ubuntu-minimal-jammy:minimal-22_04-lts-gen2:latest" \
    --size 'Standard_B1s' \
    --admin-username 'azureuser' \
    --assign-identity \
    --generate-ssh-keys \
    --public-ip-address "" \
    --tags 'purpose=lab' 'module=s1' 'expires=2026-10-11'