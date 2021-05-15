
data "template_file" "node_init" {
  template = file("${path.module}/templates/init.sh")
  vars = {
    k3s_token   = var.k3s_token
    k3s_channel = var.k3s_channel
    k3s_version = var.k3s_version

    master_internal_ipv4 = var.master_internal_ipv4
  }
}

resource "hcloud_server" "node" {
  count       = var.node_count
  name        = "${var.cluster_name}-${var.node_type}-${count.index}"
  server_type = var.node_type
  datacenter  = var.hcloud_datacenter
  image       = var.image
  ssh_keys    = var.ssh_keys
  user_data   = data.template_file.node_init.rendered

  labels = {
    provisioner = "terraform",
    engine      = "k3s",
    node_type   = "worker"
  }

  firewall_ids = [var.hcloud_firewall_base_id]
}

resource "hcloud_server_network" "node" {
  count     = var.node_count
  server_id = hcloud_server.node[count.index].id
  subnet_id = var.hcloud_subnet_id
}

output "node_ipv4" {
  value = hcloud_server.node.*.ipv4_address
}
