## Dynamic NFS Volume Provisioner

> NFS subdir external provisioner is an automatic provisioner that use your existing and `already configured NFS server` to support dynamic provisioning of Kubernetes `Persistent Volumes` via `Persistent Volume Claims`.


### Create NFS Server 
```
step1:  
Create a Ubuntu Instance/server with 1CPU 2gb RAM & Login to Server

setp2: 
wget https://raw.githubusercontent.com/lerndevops/educka/master/storage/persistent-volumes/nfs/setupNFSServer.sh -P /tmp
chmod 755 /tmp/setupNFSServer.sh
bash /tmp/setupNFSServer.sh
```

### Deploy the NFS Provisioner

##### setup authorization 
```
kubectl apply -f https://raw.githubusercontent.com/lerndevops/educka/master/storage/storageclass/nfs/rbac.yaml
```

##### deploy the storage class
```
kubectl apply -f https://raw.githubusercontent.com/lerndevops/educka/master/storage/storageclass/nfs/class.yaml
```

##### deploy the nfs-provisioner 
```

modify deploy-nfs-provisioner.yaml & PLACE your NFS Server IP / DNS 

wget https://raw.githubusercontent.com/lerndevops/educka/master/storage/storageclass/nfs/deploy-nfs-provisioner.yaml
vi deploy-nfs-provisioner.yaml

kubectl apply -f deploy-nfs-provisioner.yaml
``` 

##### create pvc & check the pv created successfully 
```
kubectl apply -f https://raw.githubusercontent.com/lerndevops/educka/master/storage/storageclass/nfs/pvc.yaml
```

##### deploy app & check if app able write & read the data to NFS
```
kubectl apply -f https://raw.githubusercontent.com/lerndevops/educka/master/storage/storageclass/nfs/deploy-app.yaml
```

### [Click here for More Info](https://github.com/kubernetes-sigs/nfs-subdir-external-provisioner)
