# Ingress

> An API object that manages external access to the services in a cluster, typically HTTP, Ingress can also provide load balancing, SSL termination and name-based virtual hosting

> Ingress exposes HTTP and HTTPS routes from outside the cluster to services within the cluster. Traffic routing is controlled by rules defined on the Ingress resource


## Deploy three different Apps on k8s cluster

`kubectl apply -f https://raw.githubusercontent.com/lerndevops/educka/master/ingress/app1.yml`

`kubectl apply -f https://raw.githubusercontent.com/lerndevops/educka/master/ingress/app2.yml`

`kubectl apply -f https://raw.githubusercontent.com/lerndevops/educka/master/ingress/app3.yml`

## Deploy Ingress Controller 

`kubectl apply -f https://raw.githubusercontent.com/lerndevops/educka/master/ingress/nginx-ing-controller.yaml`

`kubectl apply -f https://raw.githubusercontent.com/lerndevops/educka/master/ingress/service-nodeport.yaml`

## Deploy Ingress Rule

`kubectl apply -f https://raw.githubusercontent.com/lerndevops/educka/master/ingress/ingress-rule.yml`

## Get Ingress Controller Service NodePort 

``` 
get Ingress Controller Pod NodeIP & Ingress Controller Service NodePort

    kubectl get pods -n ingress-nginx -o wide  ## Note the Node IP in which the Ingress Controller Pod is Running
    kubectl get svc -n ingress-nginx  ## Note the Ingress Servcie NodePort
```

## validate 

``` 
   From the above details noted in your browser hit as below
   
   NodeIp:NodePort/app1
   NodeIp:NodePort/app2
   NodeIp:NodePort/app3
   
   Example: 192.168.198.129:30528/app1, 192.168.198.129:30528/app2, 192.168.198.129:30528/app3
   
```
