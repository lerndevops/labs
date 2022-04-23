## Deployments

> A Deployment provides declarative(rolling) updates for Pods and ReplicaSets.

> You describe a desired state in a Deployment, and the Deployment Controller changes the actual state to the desired state at a controlled rate. 

> You can define Deployments to create new ReplicaSets, or to remove existing Deployments and adopt all their resources with new Deployments.

### Use Case

> **The following are typical use cases for Deployments:**

1. Create a Deployment to rollout a ReplicaSet. The ReplicaSet creates Pods in the background. Check the status of the rollout to see if it succeeds or not.

2. Declare the new state of the Pods by updating the PodTemplateSpec of the Deployment. A new ReplicaSet is created and the Deployment manages moving the Pods from the old ReplicaSet to the new one at a controlled rate. Each new ReplicaSet updates the revision of the Deployment.

3. Rollback to an earlier Deployment revision if the current state of the Deployment is not stable. Each rollback updates the revision of the Deployment.

4. Scale up the Deployment to facilitate more load.

5. Pause the rollout of a Deployment to apply multiple fixes to its PodTemplateSpec and then resume it to start a new rollout.

6. Use the status of the Deployment as an indicator that a rollout has stuck.

7. Clean up older ReplicaSets that you don't need anymore.


#### [Click Here for More Info](https://kubernetes.io/docs/concepts/workloads/controllers/deployment/)

### Lab

```
create a manifest file with Kind ReplicaSet & use kubectl to create the object in k8s API Server.

kubectl create -f deployment-ex1.yml --record      # create deployment
kubectl apply -f deployment-ex1.yml  --record      # update the deployment 

kubectl get deploy                              # List all deployments in current active namespace
kubectl get deploy -n <namespace>               # List the deployments in <namespace>
kubectl get deploy --show-labels                # list the labels for deploy
kubectl get deploy -l deploy=myapprs -o wide    # list deployments with matching labels
kubectl get pods | grep mydeploy                # list the pods associated with deployment
kubectl get deploy mydeploy -o yaml             # detailed object config

kubectl describe deploy <deployment>                # inspect the deployment
kubectl label deploy <deployment> key=value         # label the deployment
kubectl scale --replicas=x deploy <deployment>      # Scale up/down deployment
kubectl expose deploy <deploy> --port=<external> --target-port=<internal> # expose deployment as service & assign port on the cluster
kubectl delete deploy <deployment>                  # delete deployment & pod under it
```
```
kubectl rollout history deploy <deployname>      # check the revisions of a Deployment
kubectl rollout history deploy <deployname> --revision=2   # see the details of each revision
kubectl rollout status deploy <deployname>       # get status of rollout 
kubectl rollout undo deploy <deployname>         # rollback to the previous revision
kubectl rollout undo deploy <deployname>  --revision=2     # rollback to a specific revision
kubectl rollout pause deploy <deployname>        # pause a Deployment before triggering one or more updates
kubectl rollout resume deploy <deployname>       
```
