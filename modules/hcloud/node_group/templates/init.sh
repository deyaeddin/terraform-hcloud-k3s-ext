#!/bin/bash

apt-get update -q -y
apt-get install -q -y \
    ca-certificates \
    curl \
    ntp

# k3s
curl -sfL https://get.k3s.io | INSTALL_K3S_CHANNEL=${k3s_channel} INSTALL_K3S_VERSION="${k3s_version}" K3S_URL=https://${master_internal_ipv4}:6443 K3S_TOKEN=${k3s_token} sh -s - \
    --tls-san ${node_internal_ipv4} \
    --kubelet-arg 'cloud-provider=external'

# extra scripts
${extra_scripts}
