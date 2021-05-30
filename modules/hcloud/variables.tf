
variable "hcloud_token" {
  description = "Hetzner cloud auth token"
  sensitive = true
}

variable "k3s_config_file" {
  description = "String path to config file"
}

variable "hcloud_network_ip_range" {
  description = "ip_range of the main network "
}

variable "hcloud_network_subnet_type" {
  description = "subnet type"
}

variable "hcloud_network_subnet_zone" {
  description = "Subnet Zon"
}

variable "hcloud_network_subnet_ip_range" {
  description = "ip_range of the subnetwork "
}

variable "cluster_name" {
  description = "Cluster name (prefix for all resource names)"
}

variable "hcloud_datacenter" {
  description = "Hetzner datacenter where resources resides, hel1-dc2 (Helsinki 1 DC 2) or fsn1-dc14 (Falkenstein 1 DC14)"
}

variable "image" {
  description = "Node boot image"
}

variable "ssh_keys" {
  type        = list(string)
  description = "List of public ssh_key ids"
}

variable "k3s_channel" {
  description = "k3s channel (stable, latest, v1.19 and so on)"
}

variable "k3s_version" {
  description = "k3s version (v1.21.0+k3s1, v1.19.10+k3s1 and so on)"
}

variable "private_key_path" {
  description = "string path to private key which will be used to access all the servers including the nodes"
}

# "cx21" # 2 vCPU, 4 GB RAM, 40 GB Disk space
variable "node_groups" {
  description = "Map of worker node groups, key is server_type, value is count of nodes in group"
  type        = map(string)
}

variable "master_groups_type" {
  description = "Node type (size)"
}

variable "master_groups_count" {
    description = "Number of control plane nodes."
}

variable "hcloud_masters_extra_scripts" {
  description = "Additional list of commands to be added to initial master server creation"
  type = list(string)
}

variable "hcloud_node_extra_scripts" {
  description = "Additional list of commands to be added to initial node server creation"
  type = list(string)
}