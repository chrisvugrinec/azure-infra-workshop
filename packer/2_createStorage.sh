#!/bin/bash

echo "storage account:"
read storage_account

rgroup="packerdemo"
#echo "resource group"
#read rgroup
containername="images"
#echo "container name"
#read containername
az storage account create --name $storage_account --resource-group $rgroup --sku Standard_LRS --location="westeurope"
connectionString=$(az storage account show-connection-string --resource-group $rgroup --name $storage_account | jq -r '.connectionString')
az storage container create --name $containername --connection-string $connectionString

echo "export AZURE_STORAGEACCOUNT='$storage_account'"
