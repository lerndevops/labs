## Step1: Deploy Version 1

```
## Create a deployment with a record (for rollbacks):

	kubectl create -f deployment.yml --record

## Check the status of the rollout:

	kubectl rollout status deployments kubeserve

## validate deployment & Service 

	kubectl get deploy kubeserve -o wide 
	kubectl get pods -o wide 
	kubectl get svc kubeserve-svc -o wide 
	kubectl get ep kubeserve-svc 
```

## Step2: edit the deployment yml file & Update the version 'v2' to perform rolling update

```
## before we apply v2, lets access the application & check the output

	kubectl get svc kubeserve-svc   ## copy service IP

	Run this curl look while the update happens:

		while true; do curl http://serviceIP; done    # Run this on Node -- DO NOT ON MASTER

## Use kubectl apply to update a deployment:

	kubectl apply -f deployment.yml --record
	  
## validate: deployment to see the updated image

	kubectl roullout status deploy kubeserve
	kubectl get deploy kubeserve -o wide 
      
```

## Step3: Now, edit the version of image back to ‘v1’ in yml file & apply

```
   kubectl apply -f deployment.yml --record
   
   cotinue to watch the application output node 
```


## Step4: Apply the rolling update to version 3 (buggy)

```
kubectl set image deployment kubeserve app=leaddevops/kubeserve:v3

continue to watch the output of application throwing errors with buggy app

undo the deployment 
	kubectl rollout undo deployment kubeserve
	

To Roll back to a certain revision:	

check the rollout history to go back to version 

	kubectl rollout history deployment kubeserve
	kubectl rollout undo deployment kubeserve --to-revision=2
```
