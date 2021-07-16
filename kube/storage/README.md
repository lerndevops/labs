# StorageClass

StorageClass is a mechanism of defining different classes of storages in kubernetes. Your Kubernetes administrator along with your storage administrator might classify different types of storages available in your organization and make a reference of it in kubernetes. These storageclasses can then be directly referenced in a Persistent Volume Claim which can later be assigned to a pod. 

StorageClass definition requires the below information - 

* Provisioners - AWSElasticBlockStore, AzureFile, AzureDisk, GCEPersistentDisk, Glusterfs, iSCSI, NFS, VsphereVolume etc.
* Parameters - type of storage (pd,ssd,magnetic), diskformat, datastore etc. 
* Reclaim Polcy - Retain or Delete

Kubernetes ships some provisioners which are also called as internal provisioners. Some examples are EBS, Azure Disk, GCE PD etc. These internal provisioners are usually referred with a prefix of `kubernetes.io`. The kubernetes incubator repository also has a variety of external provisioners which can be used with storage types that dont have an internal provisioners. Few examples of external provisioners are - AWS EFS provisioner, CephFS, iSCSI, FlexVolumes, etc. 

Storage classes helps in dynamic provisioning of PV. Which means that your developers/devops need not worry about PV provisioning before hand. Your kubernetes administrator can set a default storage class for your cluster. If a PVC doesnt specify a PV or a storage class name, the default storage class is used. This PVC then automatically creates a new PV and the corresponding storage is then assigned. 

Managed kubernetes services like AKS, EKS and GKE provides a default storage class which points to their respective disk storage. 

## Creating a dynamic PVC on top of GKE 

**PRE-REQUISITE** - A provisioned GKE cluster 

Create a basic PVC yaml - 

```
vi pvc.yaml

apiVersion: v1
kind: PersistentVolumeClaim
metadata:
  name: storageclassdemo
spec:
  accessModes:
    - ReadWriteOnce
  resources:
    requests:
      storage: 30Gi

```

We are not defining any storageclass in above PVC, which means it will point to the default storage class. 

Now lets check the default storage class in gke - 

```
kubectl get storageclass

NAME                 PROVISIONER            AGE
standard (default)   kubernetes.io/gce-pd   120m

```

We will now view the yaml of this storage class 

```
kubectl get storageclass standard -o yaml

allowVolumeExpansion: true
apiVersion: storage.k8s.io/v1
kind: StorageClass
metadata:
  annotations:
    storageclass.kubernetes.io/is-default-class: "true"
  creationTimestamp: "2019-11-27T17:22:58Z"
  labels:
    addonmanager.kubernetes.io/mode: EnsureExists
    kubernetes.io/cluster-service: "true"
  name: standard
  resourceVersion: "298"
  selfLink: /apis/storage.k8s.io/v1/storageclasses/standard
  uid: 8e8b089a-113a-11ea-8807-42010a8e0194
parameters:
  type: pd-standard
provisioner: kubernetes.io/gce-pd
reclaimPolicy: Delete
volumeBindingMode: Immediate

```

Below are some important details - 

provisioner: kubernetes.io/gce-pd
reclaimPolicy: Delete
parameters: type: pd-standard


Lets now create the pvc and see what happens - 

```
kubectl create -f pvc.yaml 

NAME                                                        CAPACITY   ACCESS MODES   RECLAIM POLICY   STATUS   CLAIM                      STORAGECLASS   REASON   AGE
persistentvolume/pvc-a0afb7ee-114b-11ea-8807-42010a8e0194   30Gi       RWO            Delete           Bound    default/storageclassdemo   standard                2s

NAME                                     STATUS   VOLUME                                     CAPACITY   ACCESS MODES   STORAGECLASS   AGE
persistentvolumeclaim/storageclassdemo   Bound    pvc-a0afb7ee-114b-11ea-8807-42010a8e0194   30Gi       RWO            standard       6s

```

A dynamic PV is now provisioned. 

Verify on your GCP account -> Compute Engine -> Disks to see if a new disk is dynamically created of 15GB.

