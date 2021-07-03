#!/bin/bash

kubectl -n monitoring delete service/prometheus-service
kubectl -n monitoring delete deployment.apps/prometheus-deployment
kubectl -n monitoring delete configmap/prom-server-conf
kubectl delete clusterrole.rbac.authorization.k8s.io/prometheus
kubectl delete clusterrolebinding.rbac.authorization.k8s.io/prometheus
kubectl delete namespace/monitoring
