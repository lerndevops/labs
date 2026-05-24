## Daemonset

> **A DaemonSet ensures that all (or some) Nodes run a copy of a Pod.** 

> **As nodes are added to the cluster, Pods are added to them. As nodes are removed from the cluster, those Pods are garbage collected.** 

> **Deleting a DaemonSet will clean up the Pods it created.**

#### Some typical uses of a DaemonSet are:

1. running a cluster storage daemon on every node
2. running a logs collection daemon on every node
3. running a node monitoring daemon on every node

### Lab 

```
create a manifest file with Kind ReplicaSet & use kubectl to create the object in k8s API Server.

kubectl create -f ds-ex1.yml --record       # create daemonset
kubectl apply -f ds-ex1.yml  --record       # update the daemonset 

kubectl get ds                              # List all daemonsets in current active namespace
kubectl get ds -n <namespace>               # List the daemonsets in <namespace>
kubectl get ds --show-labels                # list the labels for daemonset
kubectl get ds -l ds=myds -o wide           # list daemonset with matching labels
kubectl get pods | grep myds                # list the pods associated with daemonset
kubectl get ds myds -o yaml                 # detailed object config

kubectl describe ds <myds>                  # inspect the daemonset
kubectl label ds <myds> key=value           # label the daemonset
kubectl expose ds <myds> --port=<external> --target-port=<internal> # expose daemonset as service & assign port on the cluster
kubectl delete ds <myds>                    # delete daemonset & pod under it
```
