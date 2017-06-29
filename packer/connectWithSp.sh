#!/bin/bash
echo "password:"
read password
az login --service-principal -u http://test6.com -p $password --tenant microsoft.onmirosoft.com 
