#!/bin/bash

MASTER_NODE_HOST=${master_ipv4}
MASTER_NODE_USER=root

K8S_API=https://${master_ipv4}:6443
CLUSTER=${cluster_name}
K3S_CONFIG_FILE=${config_file}
PRIVATE_KEY=${private_key}
###################

sshcheck() {
  ssh -q -i $PRIVATE_KEY -o "StrictHostKeyChecking=no" -o "BatchMode=yes" -o "ConnectTimeout=5" $MASTER_NODE_USER@$MASTER_NODE_HOST 'exit 0'
}

while ! sshcheck ; do
    echo "Can't connect to $MASTER_NODE_HOST ... will try again"
    sleep 2
done

echo "Connection established to $MASTER_NODE_HOST"

sshrun() {
    ssh -q -i $PRIVATE_KEY -o "StrictHostKeyChecking=no" $MASTER_NODE_USER@$MASTER_NODE_HOST -- $@
}

while ! sshrun 'kubectl cluster-info'; do
    echo "Waiting cluster"
    sleep 2
done


rawconfig="$(sshrun kubectl config view -ojson --raw)"

cacert_file=$(mktemp)
cert_file=$(mktemp)
key_file=$(mktemp)

echo "$rawconfig" | jq -r '.clusters[0].cluster["certificate-authority-data"]' | base64 -d >$cacert_file
echo "$rawconfig" | jq -r '.users[0].user["client-certificate-data"]' | base64 -d >$cert_file
echo "$rawconfig" | jq -r '.users[0].user["client-key-data"]' | base64 -d >$key_file



# create cluster entry in local kubectl config
kubectl config --kubeconfig $K3S_CONFIG_FILE  set-cluster $CLUSTER \
    --server=$K8S_API \
    --certificate-authority=$cacert_file \
    --embed-certs=true

kubectl config --kubeconfig $K3S_CONFIG_FILE set-credentials $CLUSTER \
    --client-certificate=$cert_file \
    --client-key=$key_file \
    --embed-certs=true

rm -f $cacert_file $cert_file $key_file

kubectl config --kubeconfig $K3S_CONFIG_FILE set-context $CLUSTER \
    --cluster=$CLUSTER \
    --user=$CLUSTER

kubectl config --kubeconfig $K3S_CONFIG_FILE use-context $CLUSTER
