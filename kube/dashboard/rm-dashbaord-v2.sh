#!/bin/bash

kubectl -n kubernetes-dashboard delete service/kubernetes-dashboard
kubectl -n kubernetes-dashboard delete deployment.apps/kubernetes-dashboard
kubectl -n kubernetes-dashboard delete service/dashboard-metrics-scraper
kubectl -n kubernetes-dashboard delete deployment.apps/dashboard-metrics-scraper
kubectl -n kubernetes-dashboard delete configmap/kubernetes-dashboard-settings
kubectl -n kubernetes-dashboard delete secret/kubernetes-dashboard-csrf
kubectl -n kubernetes-dashboard delete secret/kubernetes-dashboard-key-holder
kubectl -n kubernetes-dashboard delete role.rbac.authorization.k8s.io/kubernetes-dashboard
kubectl -n kubernetes-dashboard delete rolebinding.rbac.authorization.k8s.io/kubernetes-dashboard
kubectl -n kubernetes-dashboard delete serviceaccount/kubernetes-dashboard
kubectl delete clusterrolebinding.rbac.authorization.k8s.io/kubernetes-dashboard
kubectl delete clusterrole.rbac.authorization.k8s.io/kubernetes-dashboard
kubectl delete namespace/kubernetes-dashboard
