#!/bin/bash 

# Install NFS Kernel Server
sudo apt-get update
sudo apt install -y nfs-kernel-server

# Create the Export Directory
sudo mkdir -p /mnt/sharedfolder

# set all clients access to the directory
sudo chown nobody:nogroup /mnt/sharedfolder
sudo chmod 777 /mnt/sharedfolder

echo ' '
echo "nfs server setup complete" 
echo ' '
echo "you will need to  setup server access to client(s) through NFS export file /etc/exports"
echo ' '
echo "Ex: A single client by adding the following line in the file: 
             
          /mnt/sharedfolder clientIP(rw,sync,no_subtree_check)"
echo ' '
echo "    Multiple clients, by specifying an entire subnet that the clients belong to:

          /mnt/sharedfolder subnetIP/24(rw,sync,no_subtree_check)"
exit 0
