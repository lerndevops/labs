## ReplicaSet

> A ReplicaSet's purpose is to maintain a stable set of replica Pods running at any given time. 

> As such, it is often used to guarantee the availability of a specified number of identical Pods.

> **A ReplicaSet is defined with fields, including** 

* a selector that specifies how to identify Pods it can acquire, 
* a number of replicas indicating how many Pods it should be maintaining, 
* and a pod template specifying the data of new Pods it should create to meet the number of replicas criteria. 

> A ReplicaSet then fulfills its purpose by creating and deleting Pods as needed to reach the desired number. When a ReplicaSet needs to create new Pods, it uses its Pod template.


## Lab

```
create a manifest file with Kind ReplicaSet & use kubectl to create the object in k8s API Server.

kubectl create -f rs-ex1.yml                # create replica set
kubectl apply -f rs-ex1.yml                 # update replica set

kubectl get rs                              # List all replica sets in current active namespace
kubectl get rs -n <namespace>               # List the replica sets in <namespace>
kubectl get rs --show-labels                # list the labels for rs
kubectl get rs -l rs=myapprs -o wide        # list replica sets with matching labels
kubectl get pods | grep tomcatrs            # list the pods associated with rs
kubectl get rs tomcatrs -o yaml             # detailed object config

kubectl describe rs <rsname>                # inspect the replica set
kubectl label rs <rsname> key=value         # label the replica set
kubectl scale --replicas=x rs <rsname>      # Scale up/down replica set
kubectl expose rs <rsname> --port=<external> --target-port=<internal> # expose rs as service & assign port on the cluster
kubectl expose rs <rsname> --port=<external> --type=NodePort # expose rs as service & assign port on the Node
kubectl delete rs <rsname>                  # delete rs & pod under it
```
