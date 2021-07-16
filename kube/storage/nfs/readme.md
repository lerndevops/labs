## Kubernetes Volumes and NFS

> ***Kubernetes Volumes are abstracted storage units that allow nodes within a cluster to write, read and share data between them.***

> ***Kubernetes offers many storage plugins that provide access to storage services and platforms. One of these is the NFS plugin***

> ***`Network File System (NFS)` is a standard protocol that lets you mount a storage device as a local drive. Kubernetes allows you to mount a Volume as a local drive on a container.*** 

> ***The NFS integration is very useful for migrating legacy workloads to Kubernetes, because very often legacy code accesses data via NFS.***

## There are two ways to access data via NFS in Kubernetes:

  * `Ephemeral NFS Volume` - this lets you connect to existing NFS storage you already possess.
  * `Persistent Volume with NFS` - this lets you set up a managed resource within the cluster which is accessed via NFS.

## Advantages of Using NFS with Kubernetes

> ***Here are a few reasons you should consider using NFS in Kubernetes:***

* `Use existing storage` - you can mount existing data volumes you are currently using, on-premises or in the cloud, with a standard interface.

* `Persistency` - a regular Kubernetes Volume is ephemeral, meaning it is torn down when its parent pod shuts down. However, an NFS Volume, which you define within pod definitions, gives you persistency without having to define a Persistent Volume. Any data saved via NFS will be stored in the connected storage device, even after the pod shuts down. You also have the option of defining a Kubernetes Persistent Volume that exposes its data via an NFS interface.

* `Share data` - because of its persistent nature, NFS Volumes can be used to share data between containers, whether in the same pod or different pods.

* `Simultaneous mounting` - NFS Volumes can be mounted by multiple nodes at the same time, and multiple nodes can write to the same NFS Volume at the same time.

> ***One important caveat is that for an NFS Volume to work, you must set up a server that exposes storage via NFS. Kubernetes will not manage your existing NFS Volumes for you.***


