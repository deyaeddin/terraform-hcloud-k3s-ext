
variable "hcloud_token" {
  description = "Hetzner cloud auth token"
  sensitive = true
}

variable "cluster_name" {
  description = "Cluster name (prefix for all resource names)"
}

variable "hcloud_datacenter" {
  description = "Hetzner datacenter where resources resides, hel1-dc2 (Helsinki 1 DC 2) or fsn1-dc14 (Falkenstein 1 DC14)"

}

variable "masters_node_type" {
  description = "Node type (size)"
}

variable "masters_node_count" {
  description = "Number of control plane nodes."
}

variable "k3s_ha" {
  description = "is High availability presented"
  type        = bool
}


variable "image" {
  description = "Node boot image"
}

variable "k3s_token" {
  description = "k3s initialization token"
}

variable "k3s_channel" {
  description = "k3s channel (stable, latest, v1.19 and so on)"
}
variable "k3s_version" {
  description = "k3s version (v1.21.0+k3s1, v1.19.10+k3s1 and so on)"
}

variable "ssh_keys" {
  description = "Public SSH keys ids (list) used to login"
}

variable "hcloud_subnet_id" {
  description = "IP Subnet id used to assign internal IP addresses to nodes"
}

variable "hcloud_network_id" {
  description = "Hetzner cloud private network Id"
}
variable "hcloud_firewall_base_id" {
  description = "Hetzner firewall ID for masters and nodes"
}

variable "hcloud_firewall_k3s_master_id" {
  description = "Hetzner firewall ID for masters"
}

variable "hcloud_masters_extra_scripts" {
  description = "Additional list of commands to be added to initial master server creation"
  type = list(string)
}
