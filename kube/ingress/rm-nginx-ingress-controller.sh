#!/bin/bash 

kubectl -n ingress-nginx delete deployment.apps/nginx-ingress-controller
kubectl -n ingress-nginx delete serviceaccount/nginx-ingress-serviceaccount
kubectl -n ingress-nginx delete configmap/nginx-configuration
kubectl -n ingress-nginx delete configmap/tcp-services
kubectl -n ingress-nginx delete configmap/udp-services
kubectl -n ingress-nginx delete rolebinding.rbac.authorization.k8s.io/nginx-ingress-role-nisa-binding
kubectl -n ingress-nginx delete role.rbac.authorization.k8s.io/nginx-ingress-role
kubectl -n ingress-nginx delete limitrange/ingress-nginx
kubectl delete clusterrolebinding.rbac.authorization.k8s.io/nginx-ingress-clusterrole-nisa-binding
kubectl delete clusterrole.rbac.authorization.k8s.io/nginx-ingress-clusterrole
kubectl delete namespace/ingress-nginx
