#!/bin/bash

echo "storage account:"
read storage_account
echo "resource group"
read rgroup
echo "container name"
read containername
az storage account create --name $storage_account --resource-group $rgroup --sku Standard_LRS --location="westeurope"
connectionString=$(az storage account show-connection-string --resource-group $rgroup --name $storage_account | jq -r '.connectionString')
az storage container create --name $containername --connection-string $connectionString
