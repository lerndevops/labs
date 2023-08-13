## ELK Stack

### Elastic Search 
> is a no sql db that stores the data from various sources

### Logstash 
> is a service that can collect the data from various sources & pushes to Elastic Search DB

### beats 
> beats are small agents, that can collet the data from various sources & push data to either Logstash or directly to Elastic Search DB

### Kibana
> Kibana is a data visualization and exploration tool used for log and time-series analytics, application monitoring, and operational intelligence use cases. It offers powerful and easy-to-use features such as histograms, line graphs, pie charts, heat maps, and built-in geospatial support.


## Deploy Elatic Search, Kibana & Filebeat on kubernetes Cluster 

>> **Note: the stack requries minimum of 2cpu/4gb ram in each worker node where they will run**

```sh
kubectl apply -f https://github.com/lerndevops/labs/raw/master/elk/elastic-search.yaml
```

```sh
kubectl apply -f https://github.com/lerndevops/labs/raw/master/elk/kibana.yaml
```

```sh
kubectl apply -f https://github.com/lerndevops/labs/raw/master/elk/filebeat.yaml
```

## get kibana login credentials 
> **username**
```sh
kubectl get secrets --namespace=default elasticsearch-master-credentials -ojsonpath='{.data.username}' | base64 -d ; echo
```

> **password**
```sh
kubectl get secrets --namespace=default elasticsearch-master-credentials -ojsonpath='{.data.password}' | base64 -d ; echo
```
