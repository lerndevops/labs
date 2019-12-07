#!/bin/bash

kubectl delete service/dashboard-metrics-scraper -n kubernetes-dashboard
kubectl delete service/kubernetes-dashboard -n kubernetes-dashboard
kubectl delete deployment.apps/kubernetes-dashboard -n kubernetes-dashboard
kubectl delete deployment.apps/kubernetes-metrics-scraper -n kubernetes-dashboard
kubectl delete serviceaccount/kubernetes-dashboard -n kubernetes-dashboard
kubectl delete secret/kubernetes-dashboard-certs -n kubernetes-dashboard
kubectl delete secret/kubernetes-dashboard-csrf -n kubernetes-dashboard
kubectl delete secret/kubernetes-dashboard-key-holder -n kubernetes-dashboard
kubectl delete configmap/kubernetes-dashboard-settings -n kubernetes-dashboard
kubectl delete role.rbac.authorization.k8s.io/kubernetes-dashboard -n kubernetes-dashboard
kubectl delete clusterrole.rbac.authorization.k8s.io/kubernetes-dashboard -n kubernetes-dashboard
kubectl delete rolebinding.rbac.authorization.k8s.io/kubernetes-dashboard -n kubernetes-dashboard
kubectl delete clusterrolebinding.rbac.authorization.k8s.io/kubernetes-dashboard -n kubernetes-dashboard
kubectl delete namespace/kubernetes-dashboard -n kubernetes-dashboard
