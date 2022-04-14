## Kubernetes Services 

> Helps to Access application running inside a single / group of pods 

> a service is responsible for exposing an interface to a sinlge / group of pods, which enables network access from either within the cluster or between external processes and the service.

> Kubernetes services connect a set of pods to an abstracted service name and IP address. 

> Services provide discovery and routing between pods. For example, services connect an application front-end to its backend, each of which running in separate deployments in a cluster. 

> Services use labels and selectors to match pods with other applications.

### types of Kubernetes services

1. **`ClusterIP`** -- Exposes a service which is only accessible from within the cluster.
2. **`NodePort`** -- Exposes a service via a static port on each node’s IP.
3. **`LoadBalancer`** -- Exposes the service via the cloud provider’s load balancer.
4. **`ExternalName`** -- Maps a service to a predefined externalName field by returning a value for the CNAME record.

### The core attributes of a Kubernetes service are:

1. A `label selector` that locates pods
2. The `type` of service to create
3. `Port` definitions
4. Optional mapping of incoming ports(nodeport) to a `targetPort`

### [Click Here for More Info](https://kubernetes.io/docs/concepts/services-networking/service/)

## Lab:

#### Note: svc is short name for service
```
kubectl get svc                         # list all running services in current active namespace
kubectl get svc -n kube-system          # list all running services in specified namespace
kubectl get svc --all-namespaces        # list all running services in all namespaces available
kubectl get svc -o wide                 # list all running services in current active namespace wider output
kubectl get svc --show-labels           # list services with labels
kubectl get svc -l env=prod             # list services with matching labels


kubectl describe svc <svcname>              # detailed output about a service in current namespace
kubectl describe svc <svcname> -n namespace # detailed output about a service in current namespace
kubectl describe svc <svcname> -o wide      # detailed output about a service wider output
kubectl describe svc <svcname> -o yaml      # detailed manifest file from apiserver yaml format
kubectl describe svc <svcname> -o json      # detailed manifest file from apiserver json format

kubectl label svc <svcname> env=prod        # add label to svc
kubectl label svc <svcname> env-            # remove a label

kubectl delete svc <svcname>                    # delete a svc in current active namespace
kubectl delete svc <svcname> -n <my-namespace>  # delete a svc in specified namespace
kubectl delete svc -l env=test                  # delete svc matching labels
kubectl delete svc --all                        # delete all svc
```
