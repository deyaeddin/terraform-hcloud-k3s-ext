
variable "cluster_name" {
  description = "Cluster name (prefix for all resource names)"
}

variable "master_ipv4" {
  description = "IP address (v4) of master node"
}

variable "k3s_config_file" {
  description = "String path to config file"
}

variable "private_key_path" {
  description = "string path to private key which will be used to access all the servers including the nodes"
}