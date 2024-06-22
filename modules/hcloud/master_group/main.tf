
locals {
  ccm_manifest = file("${path.module}/manifestos/hcloud-ccm-net.yaml")
  csi_manifest = file("${path.module}/manifestos/hcloud-csi.yaml")
  master_init = templatefile("${path.module}/templates/master_init.sh",{
    hcloud_token   = var.hcloud_token
    hcloud_network = var.hcloud_network_id

    k3s_token   = var.k3s_token
    k3s_channel = var.k3s_channel
    k3s_version = var.k3s_version
    k3s_ha_init = var.k3s_ha ? "server --cluster-init" : ""
    master_internal_ipv4 = hcloud_server_network.master.ip

    ccm_manifest = local.ccm_manifest
    csi_manifest = local.csi_manifest

    extra_scripts = join("\n", var.hcloud_masters_extra_scripts)
  })

  master_node_init = templatefile("${path.module}/templates/node_init.sh", {
    hcloud_token   = var.hcloud_token
    hcloud_network = var.hcloud_network_id

    k3s_token          = var.k3s_token
    k3s_channel        = var.k3s_channel
    k3s_version        = var.k3s_version
    master_internal_ipv4 = hcloud_server_network.master.ip
    node_internal_ipv4   = hcloud_server_network.master_node[count.index].ip

    ccm_manifest = local.ccm_manifest
    csi_manifest = local.csi_manifest

    extra_scripts = join("\n", var.hcloud_masters_extra_scripts)
  })

  depends_on = [hcloud_server_network.master]
}

resource "hcloud_server" "master" {
  name        = "${var.cluster_name}-master"
  datacenter  = var.hcloud_datacenter
  image       = var.image
  server_type = var.masters_node_type
  ssh_keys    = var.ssh_keys
  user_data   = local.master_init
  keep_disk   = true

  labels = {
    provisioner = "terraform",
    engine      = "k3s",
    node_type   = "control-plane-master"
  }

  firewall_ids = [var.hcloud_firewall_base_id, var.hcloud_firewall_k3s_master_id]
}

resource "hcloud_server_network" "master" {
  server_id = hcloud_server.master.id
  subnet_id = var.hcloud_subnet_id
}


resource "hcloud_server" "master_node" {
  count       = var.masters_node_count - 1
  name        = "${var.cluster_name}-master-${count.index}"
  datacenter  = var.hcloud_datacenter
  image       = var.image
  server_type = var.masters_node_type
  ssh_keys    = var.ssh_keys
  user_data   = local.master_node_init
  keep_disk   = true

  labels = {
    provisioner = "terraform",
    engine      = "k3s",
    node_type   = "control-plane-${count.index}"
  }

  firewall_ids = [var.hcloud_firewall_base_id, var.hcloud_firewall_k3s_master_id]
}

resource "hcloud_server_network" "master_node" {
  count     = var.masters_node_count - 1
  server_id = hcloud_server.master_node[count.index].id
  subnet_id = var.hcloud_subnet_id
}