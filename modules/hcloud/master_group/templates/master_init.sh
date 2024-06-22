#!/bin/bash

apt-get update -q -y
apt-get install -q -y \
    ca-certificates \
    curl \
    ntp

# k3s
curl -sfL https://get.k3s.io | INSTALL_K3S_CHANNEL=${k3s_channel} INSTALL_K3S_VERSION="${k3s_version}" K3S_TOKEN=${k3s_token} sh -s - ${k3s_ha_init}\
    --flannel-backend=host-gw \
    --disable local-storage \
    --disable-cloud-controller \
    --disable traefik \
    --disable servicelb \
    --node-taint node-role.kubernetes.io/master:NoSchedule \
    --kubelet-arg 'cloud-provider=external'

# manifestos addons
while ! test -d /var/lib/rancher/k3s/server/manifests; do
    echo "Waiting for '/var/lib/rancher/k3s/server/manifests'"
    sleep 1
done

# ccm
kubectl -n kube-system create secret generic hcloud --from-literal=token=${hcloud_token} --from-literal=network=${hcloud_network}
cat <<'EOF' | sudo tee /var/lib/rancher/k3s/server/manifests/hcloud-ccm.yaml
${ccm_manifest}
EOF

# csi
kubectl -n kube-system create secret generic hcloud-csi --from-literal=token=${hcloud_token}
cat <<'EOF' | sudo tee /var/lib/rancher/k3s/server/manifests/hcloud-csi.yaml
${csi_manifest}
EOF


# extra scripts
${extra_scripts}