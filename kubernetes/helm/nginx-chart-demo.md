## deploy Nginx Deployment & Server with nginxdemo helmchart

```
git clone https://github.com/lerndevops/educka
cd educka/helm/charts
```

### validate chart for any errors 

```
cd educka/helm/charts
root@kube-master:/helm/charts# helm lint nginxdemo/
==> Linting .
1 chart(s) linted, 0 chart(s) failed
```

### dry-run of a helm install and enable debug to inspect the generated definitions:

```
root@kube-master:/helm/charts# helm install nginxdemo --dry-run --debug nginxdemo
install.go:149: [debug] Original chart version: ""
install.go:166: [debug] CHART PATH: /home/educka/helm/charts/nginxdemo

MANIFEST:
---
# Source: nginxdemo/templates/service.yaml
apiVersion: v1
kind: Service
metadata:
  name: nginxdemo-svc
spec:
  type: NodePort
  selector:
     app: "frontend"
  ports:
   - protocol: TCP
     port: 80
---
# Source: nginxdemo/templates/deployment.yaml
apiVersion: apps/v1
kind: Deployment
metadata:
  name: nginxdemo
spec:
  replicas: 3
  selector:
     matchLabels:
        app: "frontend"
  template:
    metadata:
      name: nginxdemo
      labels:
        app: "frontend"
    spec:
      containers:
      - name: nginxdemo
        image: nginx
        ports:
        - containerPort: 80
```

## Install Chart & validate

```
root@kube-master:/helm/charts# helm install nginxdemo nginxdemo
NAME: nginxdemo
LAST DEPLOYED: Wed Jan  8 23:25:17 2020
NAMESPACE: default
STATUS: deployed
REVISION: 1
TEST SUITE: None


root@kube-master:/helm/charts# helm list
NAME            NAMESPACE       REVISION        UPDATED                                 STATUS          CHART           APP VERSION
nginxdemo       default         1               2020-01-08 23:25:17.950477298 -0800 PST deployed        nginxdemo-0.1.0 1.2.0


root@kube-master:/home/educka/helm/charts# kubectl get deploy
NAME        READY   UP-TO-DATE   AVAILABLE   AGE
nginxdemo   3/3     3            3           26s


root@kube-master:/helm/charts# kubectl get svc
NAME                   TYPE        CLUSTER-IP      EXTERNAL-IP   PORT(S)        AGE
kubernetes             ClusterIP   10.96.0.1       <none>        443/TCP        4d19h
nginxdemo-svc          NodePort    10.96.184.101   <none>        80:30330/TCP   32s
```