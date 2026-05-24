## Dynamic Volume Provisioning

> Dynamic volume provisioning allows storage volumes to be created on-demand. Without dynamic provisioning, cluster administrators have to manually make calls to their cloud or storage provider to create new storage volumes, and then create PersistentVolume objects to represent them in Kubernetes. 

> The dynamic provisioning feature eliminates the need for cluster administrators to pre-provision storage. Instead, it automatically provisions storage when it is requested by users.

## StorageClass

> StorageClass is a mechanism of defining different `classes of storages in kubernetes`. Your Kubernetes administrator along with your storage administrator might classify different types of storages available in your organization and make a reference of it in kubernetes. These storageclasses can then be directly referenced in a Persistent Volume Claim which can later be assigned to a pod. 

StorageClass definition requires the below information - 

* Provisioners - AWSElasticBlockStore, AzureFile, AzureDisk, GCEPersistentDisk, Glusterfs, iSCSI, NFS, VsphereVolume etc.
* Parameters - type of storage (pd,ssd,magnetic), diskformat, datastore etc. 
* Reclaim Polcy - Retain or Delete

> Kubernetes ships some provisioners which are also called as internal provisioners. Some examples are EBS, Azure Disk, GCE PD etc. These internal provisioners are usually referred with a prefix of `kubernetes.io`. The kubernetes incubator repository also has a variety of external provisioners which can be used with storage types that dont have an internal provisioners. Few examples of external provisioners are - AWS EFS provisioner, CephFS, iSCSI, FlexVolumes, etc. 

> Storage classes helps in dynamic provisioning of PV. Which means that your developers/devops need not worry about PV provisioning before hand. Your kubernetes administrator can set a default storage class for your cluster. If a PVC doesnt specify a PV or a storage class name, the default storage class is used. This PVC then automatically creates a new PV and the corresponding storage is then assigned. 

Managed kubernetes services like AKS, EKS and GKE provides a default storage class which points to their respective disk storage. 

## Enabling Dynamic Provisioning

> To enable dynamic provisioning, a cluster administrator needs to pre-create one or more StorageClass objects for users. 

> StorageClass objects define which provisioner should be used and what parameters should be passed to that provisioner when dynamic provisioning is invoked.

### [More Info](https://kubernetes.io/docs/concepts/storage/storage-classes/)

