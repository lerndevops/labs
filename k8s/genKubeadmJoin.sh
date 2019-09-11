#!/bin/bash


#kubeadm token create

token=`kubeadm token generate`
kubeadm token create "$token" --print-join-command --ttl=0

# kubeadm token list
# kubeadm token delete
