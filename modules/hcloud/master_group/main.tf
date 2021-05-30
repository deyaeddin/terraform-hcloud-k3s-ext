
data "template_file" "ccm_manifest" {
  template = file("${path.module}/manifestos/hcloud-ccm-net.yaml")
}

data "template_file" "csi_manifest" {
  template = file("${path.module}/manifestos/hcloud-csi.yaml")
}


data "template_file" "master_init" {
  template = file("${path.module}/templates/master_init.sh")
  vars = {
    hcloud_token   = var.hcloud_token
    hcloud_network = var.hcloud_network_id

    k3s_token   = var.k3s_token
    k3s_channel = var.k3s_channel
    k3s_version = var.k3s_version
    k3s_ha_init = var.k3s_ha ? "server --cluster-init" : ""

    ccm_manifest = data.template_file.ccm_manifest.rendered
    csi_manifest = data.template_file.csi_manifest.rendered

    extra_scripts = join("\n", var.hcloud_masters_extra_scripts)
  }
}

resource "hcloud_server" "master" {
  name        = "${var.cluster_name}-master"
  datacenter  = var.hcloud_datacenter
  image       = var.image
  server_type = var.masters_node_type
  ssh_keys    = var.ssh_keys
  user_data   = data.template_file.master_init.rendered
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


data "template_file" "master_node_init" {
  template = file("${path.module}/templates/node_init.sh")
  vars = {
    hcloud_token   = var.hcloud_token
    hcloud_network = var.hcloud_network_id

    k3s_token          = var.k3s_token
    k3s_channel        = var.k3s_channel
    k3s_version        = var.k3s_version
    master_internal_ip = hcloud_server_network.master.ip

    ccm_manifest = data.template_file.ccm_manifest.rendered
    csi_manifest = data.template_file.csi_manifest.rendered

    extra_scripts = join("\n", var.hcloud_masters_extra_scripts)
  }
  depends_on = [hcloud_server_network.master]
}

resource "hcloud_server" "master_node" {
  count       = var.masters_node_count - 1
  name        = "${var.cluster_name}-master-${count.index}"
  datacenter  = var.hcloud_datacenter
  image       = var.image
  server_type = var.masters_node_type
  ssh_keys    = var.ssh_keys
  user_data   = data.template_file.master_node_init.rendered
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