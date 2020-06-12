#!/bin/bash 

kubectl create serviceaccount cluster-admin-dashboard-sa > /dev/null 2>&1
kubectl create clusterrolebinding cluster-admin-dashboard --clusterrole=cluster-admin --serviceaccount=default:cluster-admin-dashboard-sa > /dev/null 2>&1

#TOKEN=$(kubectl describe secret $(kubectl -n default get secret | awk '/^cluster-admin-dashboard-sa-token-/{print $1}') | awk '$1=="token:"${print $2}")
#TOKEN=$(kubectl get secret $(kubectl -n default get secret | awk '/^cluster-admin-dashboard-sa-token-/{print $1}') -o jsonpath='{.data.token}')

TOKEN=$(kubectl describe secret $(kubectl -n default get secret | awk '/^cluster-admin-dashboard-sa-token-/{print $1}') | grep token: | awk '{print $2}')

echo $TOKEN
