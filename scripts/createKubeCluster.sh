#!/bin/bash
echo "name:"
read name
echo "resource group"
read rgroup
echo "location:"
read location

az group create --name $rgroup --location $location

az acs create --name $name --resource-group $rgroup --orchestrator-type=kubernetes --dns-prefix=$name --generate-ssh-keys

if [ -f ~/.kube/config ] 
then
   echo "backed up your current kube config file"
   mv ~/.kube/config ~/.kube/config.backup
fi
echo "now getting the kube config to your local drive"
az acs kubernetes get-credentials --resource-group=$rgroup --name=$name
