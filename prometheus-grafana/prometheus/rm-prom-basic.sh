#!/bin/bash

kubectl -n monitoring delete deployment.apps/prom-deployment
kubectl -n monitoring delete service/prom-svc
kubectl -n monitoring delete configmap/prom-server-conf
kubectl delete namespace/monitoring
