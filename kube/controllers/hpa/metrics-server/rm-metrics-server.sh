#!/bin/bash 

kubectl -n kube-system delete service/metrics-server
kubectl -n kube-system delete deployment.apps/metrics-server
kubectl -n kube-system delete serviceaccount/metrics-server
kubectl -n kube-system delete rolebinding.rbac.authorization.k8s.io/metrics-server-auth-reader
kubectl delete apiservice.apiregistration.k8s.io/v1beta1.metrics.k8s.io
kubectl delete clusterrole.rbac.authorization.k8s.io/system:aggregated-metrics-reader
kubectl delete clusterrolebinding.rbac.authorization.k8s.io/metrics-server:system:auth-delegator
kubectl delete clusterrole.rbac.authorization.k8s.io/system:metrics-server
kubectl delete clusterrolebinding.rbac.authorization.k8s.io/system:metrics-server
