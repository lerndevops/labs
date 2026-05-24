## headless service?

> A headless service is a service with a service IP but instead of load-balancing it will return the IPs of our associated Pods. This allows us to interact directly with the Pods instead of a proxy. 

> It's as simple as specifying None for `.spec.clusterIP` and can be utilized with or without selectors


## Demo

#### step1: Create a deployment with five pods
```
apiVersion: apps/v1
kind: Deployment
metadata:
  name: api-deployment
  labels:
    app: api
spec:
  replicas: 5
  selector:
    matchLabels:
      app: api
  template:
    metadata:
      labels:
        app: api
    spec:
      containers:
      - name: api
        image: eddiehale/hellonodeapi
        ports:
        - containerPort: 3000
```        

#### step2: Create a regular service

```
apiVersion: v1
kind: Service
metadata:
  name: normal-service
spec:
  selector:
    app: api
  ports:
    - protocol: TCP
      port: 80
      targetPort: 3000
 ```     
      
#### step3: create a headless service
```
apiVersion: v1
kind: Service
metadata:
  name: headless-service
spec:
  clusterIP: None # <-- Don't forget!!
  selector:
    app: api
  ports:
    - protocol: TCP
      port: 80
      targetPort: 3000
```      
      
#### step4: Apply the yaml and verify everything deployed correctly
```
$ kubectl get pods 

NAME                                 READY   STATUS    RESTARTS   AGE
pod/api-deployment-f457fbcf6-6j8f9   1/1     Running   0          5s
pod/api-deployment-f457fbcf6-9gvbp   1/1     Running   0          5s
pod/api-deployment-f457fbcf6-kqbds   1/1     Running   0          5s
pod/api-deployment-f457fbcf6-m76l9   1/1     Running   0          5s
pod/api-deployment-f457fbcf6-qzhxw   1/1     Running   0          5s
```
```
$ kubectl get services 

NAME                       TYPE        CLUSTER-IP       EXTERNAL-IP   PORT(S)   AGE
service/headless-service   ClusterIP   None             <none>        80/TCP    5s
service/kubernetes         ClusterIP   10.96.0.1        <none>        443/TCP   45h
service/normal-service     ClusterIP   10.109.192.226   <none>        80/TCP    5s
```

#### step5: Validate: Now that its all running, deploy a Pod and execute a few commands to test.

```
Deploy a test pod

$ kubectl run testpod --image lerndevops/samples:netshoot

get inside the cont, Lets run nslookup on each service to see what DNS entries exist

$ kubectl exec -it testpod -- /bin/bash 

root@testpod:/# 
```
```
If we nslookup normal-service one DNS entry and IP is returned, 

root@testpod:/# nslookup normal-service
Server:         10.96.0.10
Address:        10.96.0.10#53

Name:   normal-service.default.svc.cluster.local
Address: 10.109.192.226
```
```
## if we nslookup headless-service returns the list of associated Pod IPs with the service DNS:

root@testpod:/# nslookup headless-service
Server:         10.96.0.10
Address:        10.96.0.10#53

Name:   headless-service.default.svc.cluster.local
Address: 10.1.0.41
Name:   headless-service.default.svc.cluster.local
Address: 10.1.0.39
Name:   headless-service.default.svc.cluster.local
Address: 10.1.0.38
Name:   headless-service.default.svc.cluster.local
Address: 10.1.0.40
Name:   headless-service.default.svc.cluster.local
Address: 10.1.0.37
```
