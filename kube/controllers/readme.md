# Lab:

### ReplicaSets:

```
create a manifest file with Kind ReplicaSet & use kubectl to create the object in k8s API Server.

kubectl create -f rs-ex1.yml                # create replica set
kubectl apply -f rs-ex1.yml                 # update replica set

kubectl get rs                              # List all replica sets in current active namespace
kubectl get rs -n <namespace>               # List the replica sets in <namespace>
kubectl get pods | grep tomcatrs            # list the pods associated with rs
kubectl get rs tomcatrs -o yaml             # detailed object config

kubectl describe rs <rsname>                # inspect the replica set
kubectl scale --replicas=x rs <rsname>      # Scale up/down replica set
kubectl expose rs <rsname> --port=<external> --target-port=<internal> # expose rs as service & assign port on the cluster
kubectl expose rs <rsname> --port=<external> --type=NodePort # expose rs as service & assign port on the Node
kubectl delete rs <rsname>                  # delete rs & pod under it
```

### Deployments:

```
create a manifest file with Kind Deployment & use kubectl to create the object in k8s API Server.

kubectl create -f deployment-ex1.yml --record      # create deployment
kubectl apply -f deployment-ex1.yml  --record      # update the deployment 

kubectl get deploy                              # List all deployments in current active namespace
kubectl get deploy -n <namespace>               # List the deployments in <namespace>
kubectl get pods | grep mydeploy                # list the pods associated with deployment
kubectl get deploy mydeploy -o yaml             # detailed object config

kubectl describe deploy <deployment>                # inspect the deployment
kubectl scale --replicas=x deploy <deployment>      # Scale up/down deployment
kubectl expose deploy <deploy> --port=<external> --target-port=<internal> # expose deployment as service & assign port on the cluster
kubectl delete deploy <deployment>                  # delete deployment & pod under it

kubectl rollout history deploy <deployname>      # check the revisions of a Deployment
kubectl rollout history deploy <deployname> --revision=2   # see the details of each revision
kubectl rollout status deploy <deployname>       # get status of rollout 
kubectl rollout undo deploy <deployname>         # rollback to the previous revision
kubectl rollout undo deploy <deployname>  --revision=2     # rollback to a specific revision
```
