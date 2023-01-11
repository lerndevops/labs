## Replication Controller 

> A ReplicationController ensures that a specified number of pod replicas are running at any one time. In other words, a ReplicationController makes sure that a pod or a homogeneous set of pods is always up and available.


### Lab

```
create a manifest file with Kind ReplicationController & use kubectl to create the object in k8s API Server.

kubectl create -f rc-ex1.yml                # create replication Controller
kubectl apply -f rc-ex1.yml                 # udpate the replication Controller

kubectl get rc                              # List all replication Controllers in current active namespace
kubectl get rc -n <namespace>               # List the replication controllers in <namespace>
kubectl get rc --show-labels                # list the labels for rc
kubectl get rc -l rc=myapprc -o wide        # list replication controllers with matching labels
kubectl get pods | grep tomcatrc            # list the pods associated with rc
kubectl get rc tomcatrc -o yaml             # detailed object config
 
kubectl describe rc <rcname>                # inspect the replication controller
kubectl label rc <rcname> key=value         # label the replication controller
kubectl scale --replicas=x rc <rcname>      # Scale replication controller
kubectl expose rc <rcname> --port=<external> --target-port=<internal> # expose rc as service & assign port on the cluster
kubectl expose rc <rcname> --port=<external> --type=NodePort # expose rc as service & assign port on the Node
kubectl rolling-update tomcatrc -f rc-ex2.yml # roll update rc
kubectl delete rc <rcname>                  # delete rc & pod under it
```
