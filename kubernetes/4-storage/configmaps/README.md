## ConfigMpas

> Many applications rely on configuration which is used during either application initialization or runtime. 

> Most of the times there is a requirement to adjust values assigned to configuration parameters. 

> `ConfigMaps is the kubernetes way to inject application pods with configuration data`. 

> ConfigMaps allow you to decouple configuration artifacts from image content to keep containerized applications portable. 

#### `A ConfigMap is an API object` used to store non-confidential data in key-value pairs in the cluster store (ETCD). 

#### `Pods can consume ConfigMaps` as 

* environment variables, 
* command-line arguments, 
* or as configuration files in a volume.

### [MORE INFO](https://kubernetes.io/docs/tasks/configure-pod-container/configure-pod-configmap/)
