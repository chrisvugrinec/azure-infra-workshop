#!/bin/bash
echo "name:"
read name
echo "page:"
page="http://$name.com"
echo "password:"
read password

appId=$(az ad app create --output json \
  --display-name $name \
  --homepage $page \
  --identifier-uris $page \
  --key-type Password \
  --password $password | jq -r '.appId')


# Create service principal
objectId=$(az ad sp create --id $appId | jq -r '.objectId')

subscriptionid=$(az account show  --output json | jq -r '.id')
tenantid=$(az account show  --output json | jq -r '.tenantId')

echo "objectId: $objectId"
echo "subId: $subscriptionid"
echo "tenantId: $tenantid"

echo "role assignment"

# Assign role to SP (can only be done to SP and not APP)
azure role assignment create \
  --objectId $objectId\
  --roleName Contributor \
  --scope "/subscriptions/$subscriptionid"

echo "export AZURE_CLIENT_ID=$appId"
echo "export AZURE_CLIENT_SECRET='$password'"
echo "export AZURE_RESOURCEGROUP="
echo "export AZURE_SUBSCRIPTIONID=$subscriptionid"
echo "export AZURE_TENANTID=$tenantid"

