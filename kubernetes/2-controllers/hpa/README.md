# Horizontal Pod autoscaler

Install Metrics server
---------------------------
```
kubectl apply -f https://raw.githubusercontent.com/lerndevops/educka/master/9-monitoring/metrics-server/metrics-server.yaml
```

### [More Info](https://github.com/kubernetes-incubator/metrics-server) 


Create nginx deployment, service & hpa 
-------------------------------------------
> It is mandatory to set requests on cpu utilization for this demo

`kubectl apply -f https://raw.githubusercontent.com/lerndevops/educka/master/3-controllers/hpa/hpa-cpu.yml` 

~~~
kubectl get hpa 
NAME    REFERENCE          TARGETS   MINPODS   MAXPODS   REPLICAS   AGE
nginx   Deployment/nginx   0%/40%    3         5         3          55s
~~~

Test the HPA using apache bench 
-----------------------------------
> Apache Bench (ab) is a load testing and benchmarking tool for Hypertext Transfer Protocol (HTTP) server. It can be run from command line and it is very simple to use. A quick load testing output can be obtained in just one minute

### install apache benchmark tool

` apt-get install apache2-utils` 

#### Get the service IP address using 
 
`kubectl get svc` 

### send load on to the PODS

`    ab -n 500000 -c 1000 http://10.97.161.152/` 

`    -n requests     Number of requests to perform`

`    -c concurrency  Number of multiple requests to make at a time`
