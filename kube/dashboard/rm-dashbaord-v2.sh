#!/bin/bash

kubectl -n default delete service/kubernetes-dashboard
kubectl -n default delete deployment.apps/kubernetes-dashboard
kubectl -n default delete service/dashboard-metrics-scraper
kubectl -n default delete deployment.apps/kubernetes-metrics-scraper
kubectl -n default delete deployment.apps/dashboard-metrics-scraper
kubectl -n default delete configmap/kubernetes-dashboard-settings
kubectl -n default delete secret/kubernetes-dashboard-csrf
kubectl -n default delete secret/kubernetes-dashboard-key-holder
kubectl -n default delete role.rbac.authorization.k8s.io/kubernetes-dashboard
kubectl -n default delete rolebinding.rbac.authorization.k8s.io/kubernetes-dashboard
kubectl -n default delete serviceaccount/kubernetes-dashboard
kubectl delete clusterrolebinding.rbac.authorization.k8s.io/kubernetes-dashboard
kubectl delete clusterrole.rbac.authorization.k8s.io/kubernetes-dashboard
kubectl delete namespace/kubernetes-dashboard
