myResourceGroup="wus-3-configuration"
myVM="ansible"

az group create --name $myResourceGroup --location germanywestcentral

az vm create \
--resource-group $myResourceGroup \
--name ansible --location northeurope \
--image Canonical:0001-com-ubuntu-server-jammy:22_04-lts-gen2:latest \
--size Standard_B2ms \
--admin-username azureuser \
--admin-password Losowehaslo123! \
--private-ip-address 10.0.0.100 \
--public-ip-address ansiblePublicIp \
--generate-ssh-keys

ansible_public_ip=$(az network public-ip show --name ansiblePublicIp \
--resource-group $myResourceGroup \
--query ipAddress \
--output tsv) 

az vm run-command invoke --resource-group $myResourceGroup \
--name ansible \
--command-id RunShellScript \
--scripts @ansible_installation.sh

az vm run-command invoke --resource-group $myResourceGroup \
--name ansible \
--command-id RunShellScript \
--scripts @backend_installation.sh

scp -o "StrictHostKeyChecking no" install-docker.yaml inventory azureuser@$ansible_public_ip:/home/azureuser/
