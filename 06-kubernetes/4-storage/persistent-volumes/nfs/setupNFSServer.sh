#!/bin/bash

# Install NFS Kernel Server
sudo apt-get update
sudo apt-get install -y nfs-kernel-server

# Create the Export Directory
sudo mkdir -p /mnt/appdata

# set all clients access to the directory
sudo chown nobody:nogroup /mnt/appdata
sudo chmod 777 /mnt/appdata

echo ' '
echo "nfs server setup complete"
echo ' '
echo "setting the client access"
pe=`grep /mnt/appdata /etc/exports | wc -l`
if [ $pe -eq 0 ]; then
   echo "/mnt/appdata *(rw,sync,no_subtree_check,no_root_squash,insecure)" >> /etc/exports
   sudo exportfs -rv
   sudo showmount -e
   sudo systemctl restart nfs-kernel-server
else
   echo "/mnt/appdata is already exported"
fi

#echo "you will need to  setup server access to client(s) through NFS export file /etc/exports"
#echo ' '
#echo "Ex: A single client by adding the following line in the file:
#
#          /mnt/sharedfolder clientIP(rw,sync,no_subtree_check)"
#echo ' '
#echo "    Multiple clients, by specifying an entire subnet that the clients belong to:
#
#          /mnt/sharedfolder subnetIP/24(rw,sync,no_subtree_check)"
exit 0
