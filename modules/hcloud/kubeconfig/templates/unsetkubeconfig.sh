#!/bin/bash

CLUSTER=${cluster_name}
K3S_CONFIG_FILE=${config_file}
###################

kubectl config --kubeconfig $K3S_CONFIG_FILE unset current-context
kubectl config --kubeconfig $K3S_CONFIG_FILE unset clusters.$CLUSTER
kubectl config --kubeconfig $K3S_CONFIG_FILE unset users.$CLUSTER
kubectl config --kubeconfig $K3S_CONFIG_FILE unset contexts.$CLUSTER
