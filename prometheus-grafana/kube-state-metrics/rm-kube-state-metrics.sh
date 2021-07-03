#!/bin/bash

kubectl -n kube-system delete service/kube-state-metrics
kubectl -n kube-system delete deployment.apps/kube-state-metrics
kubectl -n kube-system delete serviceaccount/kube-state-metrics
kubectl delete clusterrolebinding.rbac.authorization.k8s.io/kube-state-metrics
kubectl delete clusterrole.rbac.authorization.k8s.io/kube-state-metrics
