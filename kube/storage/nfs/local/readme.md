## Step1: Create a Ubuntu Instance/server with 1CPU 2gb RAM & Login to Server

## Step 2: Install NFS Kernel Server
```
sudo apt-get update
sudo apt install nfs-kernel-server
```

# Step 3: Create the Export Directory

> The directory that we want to share with the client system is called an export directory. You can name it according to your choice; here, we are creating an export directory by the name of “sharedfolder” in our system’s mnt(mount) directory.

> Use the following command, by specifying a mount folder name according to your need, through the following command as root:
```
sudo mkdir -p /mnt/sharedfolder
```

> As we want all clients to access the directory, we will remove restrictive permissions of the export folder through the following commands:
```
sudo chown nobody:nogroup /mnt/sharedfolder
sudo chmod 777 /mnt/sharedfolder

Now all users from all groups on the client system will be able to access our “sharedfolder”.

You can create as many sub-folders in the export folder as you want, for the client to access.
```

## Step 4: Assign server access to client(s) through NFS export file

> After creating the export folder, we will need to provide the clients the permission to access the host server machine. This permission is defined through the exports file located in your system’s /etc folder. Please use the following command in order to open this file through the Nano editor:

```
sudo vi /etc/exports

Once you have opened the file, you can allow access to:

A single client by adding the following line in the file:

	/mnt/sharedfolder clientIP(rw,sync,no_subtree_check)

Multiple clients by adding the following lines in the file:
	/mnt/sharedfolder client1IP(rw,sync,no_subtree_check)
	/mnt/sharedfolder client2IP(rw,sync,no_subtree_check)
	
Multiple clients, by specifying an entire subnet that the clients belong to:
	/mnt/sharedfolder subnetIP/24(rw,sync,no_subtree_check)
```
	
> The permissions “rw,sync,no_subtree_check” permissions defined in this file mean that the client(s) can perform:
```
rw: read and write operations
sync: write any change to the disc before applying it
no_subtree_check: prevent subtree checking
```
## Step 5: Export the shared directory

> After making all the above configurations in the host system, now is the time to export the shared directory through the following command as sudo:
```
sudo exportfs -a
```

> Finally, in order to make all the configurations take effect, restart the NFS Kernel server as follows:
```
sudo systemctl restart nfs-kernel-server
```
	
## Step 6: Open firewall for the client (s)

#### Important this step may not be required if you using GCP / AWS Instances 

> An important step is to verify that the server’s firewall is open to the clients so that they can access the shared content. The following command will configure the firewall to give access to clients through NFS:

```
sudo ufw allow from 192.168.100/24 to any port nfs	

Now when you check the status of your Ubuntu firewall through the following command, you will be able to view the Action status as “Allow” for the client’s IP.

sudo ufw status
```

## Step7: On all Kubernetes Nodes (Master & all Workers) 

> ***Ensure to install nfs-common service***

```
sudo apt-get install -y nfs-common
```
