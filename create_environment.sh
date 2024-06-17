myResourceGroup="wus-3-configuration"
myVM="ansible"

az group create --name $myResourceGroup --location germanywestcentral

#az disk create --resource-group $myResourceGroup \
#--name "ansibledisk" \
#--os-type Linux \
#--size-gb 30

az vm create \
--resource-group $myResourceGroup \
--name ansible \
--location northeurope \
--image Canonical:0001-com-ubuntu-server-jammy:22_04-lts-gen2:latest \
--size Standard_B1s \
--admin-username azureuser \
--admin-password Losowehaslo123! \
--private-ip-address 10.0.0.100 \
--os-disk-name ansibleDisk \
--public-ip-address ansiblePublicIp \
--generate-ssh-keys

#az vm disk detach --resource-group $myResourceGroup --vm-name $myVM --name ansibleDisk
