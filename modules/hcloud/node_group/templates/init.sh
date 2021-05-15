#!/bin/bash

apt-get -yq update
apt-get install -yq \
    ca-certificates \
    curl \
    ntp

# k3s
curl -sfL https://get.k3s.io | INSTALL_K3S_CHANNEL=${k3s_channel} INSTALL_K3S_VERSION="${k3s_version}" K3S_URL=https://${master_internal_ipv4}:6443 K3S_TOKEN=${k3s_token} sh -s - \
    --kubelet-arg 'cloud-provider=external'