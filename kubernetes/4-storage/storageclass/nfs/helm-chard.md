## Deploy NFS Provisioner Using Helm Chart

#### [Click Here for More Info](https://kubernetes-sigs.github.io/nfs-subdir-external-provisioner/)

### Pre Requiste 
- a working kubernetes cluster 
- NFS Server details 
- helm client installed 

#### Add Helm Repo
```
helm repo add nfs-subdir-external-provisioner https://kubernetes-sigs.github.io/nfs-subdir-external-provisioner/
```
#### update Helm Repo 
```
helm repo update
```
#### Deploy the NFS Provisioner with Helm Chart 
```
Note: replace <nfs-server-ip> & </path/to/nfs/storage> in below command accordingly before installing the nfs-provisioner
```
```
helm install nfs-provisioner \
  nfs-subdir-external-provisioner/nfs-subdir-external-provisioner \
  --set nfs.server=<nfs-server-ip> \
  --set nfs.path=</path/to/nfs/storage> \
  --set storageClass.name=nfs-provisioner
```
