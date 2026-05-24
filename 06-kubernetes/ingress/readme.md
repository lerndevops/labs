# Ingress

> An API object that manages external access to the services in a cluster, typically HTTP, Ingress can also provide load balancing, SSL termination and name-based virtual hosting

> Ingress exposes HTTP and HTTPS routes from outside the cluster to services within the cluster. Traffic routing is controlled by rules defined on the Ingress resource


## Deploy three different Apps on k8s cluster

`kubectl apply -f https://raw.githubusercontent.com/lerndevops/kubernetes/master/6-networking/ingress/apps.yaml`


## Deploy Ingress Controller 

`kubectl apply -f https://raw.githubusercontent.com/kubernetes/ingress-nginx/controller-v1.3.0/deploy/static/provider/baremetal/deploy.yaml`



## Deploy Ingress Resource(rules)

`kubectl apply -f https://raw.githubusercontent.com/lerndevops/kubernetes/master/6-networking/ingress/app-ingress-rules.yaml`


## Get Ingress Controller Service NodePort 

``` 
get Ingress Controller Pod NodeIP & Ingress Controller Service NodePort

    kubectl get pods -n ingress-nginx -o wide  ## Note the Node IP in which the Ingress Controller Pod is Running
    kubectl get services -n ingress-nginx      ## Note the Ingress Servcie NodePort
```

## validate 

``` 
   From the above details noted in your browser hit as below
   
   masterNodeIp:NodePort/unapp
   worker1NodeIp:NodePort/petclinic
   worker2NodeIp:NodePort/pyapp
   
   Example: 192.168.198.129:30528/pyapp, 192.168.198.129:30528/petclinic, 192.168.198.129:30528/unapp
   
```
