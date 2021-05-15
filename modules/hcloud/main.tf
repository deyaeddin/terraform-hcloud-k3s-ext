

resource "hcloud_network" "private" {
  name     = "${var.cluster_name}-network"
  ip_range = var.hcloud_network_ip_range
}

resource "hcloud_network_subnet" "subnet" {
  network_id   = hcloud_network.private.id
  type         = var.hcloud_network_subnet_type
  network_zone = var.hcloud_network_subnet_zone
  ip_range     = var.hcloud_network_subnet_ip_range
}

resource "hcloud_firewall" "base" {
  name = "base"
  rule {
    direction  = "in"
    protocol   = "icmp"
    source_ips = ["0.0.0.0/0", "::/0"]
  }

  rule {
    direction  = "in"
    protocol   = "tcp"
    port       = "22"
    source_ips = ["0.0.0.0/0", "::/0"]
  }

  // Kubelet metrics
  rule {
    direction  = "in"
    protocol   = "tcp"
    port       = "10250"
    source_ips = ["0.0.0.0/0", "::/0"]
  }
}

resource "hcloud_firewall" "k3s_master" {
  name = "k3s-server"
  rule {
    direction  = "in"
    protocol   = "tcp"
    port       = "6443"
    source_ips = ["0.0.0.0/0", "::/0"]
  }
  // Required only for HA with embedded etcd
  rule {
    direction  = "in"
    protocol   = "tcp"
    port       = "2379-2380"
    source_ips = ["0.0.0.0/0", "::/0"]
  }
}

resource "random_string" "k3s_token" {
  length  = 48
  upper   = false
  special = false
}

module "master_group" {
  source = "./master_group"

  cluster_name      = var.cluster_name
  hcloud_datacenter = var.hcloud_datacenter
  image             = var.image
  ssh_keys          = var.ssh_keys

  hcloud_network_id = hcloud_network.private.id
  hcloud_subnet_id  = hcloud_network_subnet.subnet.id
  hcloud_firewall_base_id = hcloud_firewall.base.id
  hcloud_firewall_k3s_master_id = hcloud_firewall.k3s_master.id

  k3s_token   = random_string.k3s_token.result
  k3s_channel = var.k3s_channel
  k3s_version = var.k3s_version

  hcloud_token = var.hcloud_token

  masters_node_type  = var.master_groups_type
  masters_node_count = var.master_groups_count
  k3s_ha             = var.master_groups_count > 1
}

module "node_group" {
  source            = "./node_group"
  cluster_name      = var.cluster_name
  hcloud_datacenter = var.hcloud_datacenter
  image             = var.image
  ssh_keys          = var.ssh_keys

  master_ipv4          = module.master_group.master_ipv4
  master_internal_ipv4 = module.master_group.master_internal_ipv4

  hcloud_network_id = hcloud_network.private.id
  hcloud_subnet_id = hcloud_network_subnet.subnet.id
  hcloud_firewall_base_id = hcloud_firewall.base.id

  k3s_token   = random_string.k3s_token.result
  k3s_channel = var.k3s_channel
  k3s_version = var.k3s_version

  for_each   = var.node_groups
  node_type  = each.key
  node_count = each.value

  depends_on = [module.master_group]
}

module "kubeconfig" {
  source            = "./kubeconfig"
  cluster_name      = var.cluster_name
  master_ipv4       = module.master_group.master_ipv4
  k3s_config_file   = var.k3s_config_file
  private_key_path  = var.private_key_path

  depends_on        = [module.node_group, module.master_group]
}

