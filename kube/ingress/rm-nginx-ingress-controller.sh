#!/bin/bash 

kubectl -n default delete deployment.apps/nginx-ingress-controller
kubectl -n default delete serviceaccount/nginx-ingress-serviceaccount
kubectl -n default delete configmap/nginx-configuration
kubectl -n default delete configmap/tcp-services
kubectl -n default delete configmap/udp-services
kubectl -n default delete rolebinding.rbac.authorization.k8s.io/nginx-ingress-role-nisa-binding
kubectl -n default delete role.rbac.authorization.k8s.io/nginx-ingress-role
kubectl -n default delete limitrange/ingress-nginx
kubectl -n default delete service/ingress-nginx
kubectl delete clusterrolebinding.rbac.authorization.k8s.io/nginx-ingress-clusterrole-nisa-binding
kubectl delete clusterrole.rbac.authorization.k8s.io/nginx-ingress-clusterrole
#kubectl delete namespace/ingress-nginx
