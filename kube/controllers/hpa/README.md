# Horizontal Pod autoscaler

##  Install Metrics server - 

> Clone this repository and install metrics server. Please do note that this setup is good for dev/qa environment. A lot of considerations must be put while installing metrics server in production environment. The official metrics-server repository is kept at https://github.com/kubernetes-incubator/metrics-server and we are using the same repo with few changes. 

> Install the metrics server 

` cd metrics-server` 

` kubectl create -f . ` 


##  Create nginx deployment, service & hpa 

> It is mandatory to set requests on  cpu utilization as HPA requires CPU metrics. 

` kubectl create -f hpa.yaml` 

~~~
kubectl get hpa 
NAME    REFERENCE          TARGETS   MINPODS   MAXPODS   REPLICAS   AGE
nginx   Deployment/nginx   0%/40%    3         5         3          55s
~~~

##  Test the HPA using apache bench 

> Apache Bench (ab) is a load testing and benchmarking tool for Hypertext Transfer Protocol (HTTP) server. It can be run from command line and it is very simple to use. A quick load testing output can be obtained in just one minute

### install apache benchmark tool

` apt-get install apache2-utils` 

#### Get the service IP address using 
 
`kubectl get svc` 

### send load on to the PODS

`    ab -n 500000 -c 1000 http://10.97.161.152/` 

`    -n requests     Number of requests to perform`

`    -c concurrency  Number of multiple requests to make at a time`
