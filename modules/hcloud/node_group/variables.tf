
variable "cluster_name" {
  description = "Cluster name (prefix for all resource names)"
}

variable "hcloud_datacenter" {
  description = "Hetzner datacenter where resources resides, hel1-dc2 (Helsinki 1 DC 2) or fsn1-dc14 (Falkenstein 1 DC14)"
}

variable "node_count" {
  description = "Count on nodes in group"
}

variable "node_type" {
  description = "Node type (size)"
  validation {
    condition     = can(regex("^cx11$|^cpx11$|^cx21$|^cpx21$|^cx31$|^cpx31$|^cx41$|^cpx41$|^cx51$|^cpx51$|^ccx11$|^ccx21$|^ccx31$|^ccx41$|^ccx51$", var.node_type))
    error_message = "Node type is not valid."
  }
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

variable "master_ipv4" {
  description = "IP address (v4) of master node"
}

variable "master_internal_ipv4" {
  description = "Private IP address (v4) of master node"
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

variable "hcloud_node_extra_scripts" {
  description = "Additional list of commands to be added to initial node server creation"
  type = list(string)
}