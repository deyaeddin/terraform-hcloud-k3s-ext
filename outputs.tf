
output "master_ipv4" {
  depends_on  = [module.hcloud]
  description = "Public IP Address of the master node"
  value = module.hcloud.master_ipv4
}

output "master_internal_ipv4" {
  depends_on  = [module.hcloud]
  description = "Private IP Address of the master node"
  value = module.hcloud.master_internal_ipv4
}

output "master_nodes_ipv4" {
  depends_on  = [module.hcloud]
  description = "Public IP Address of the master nodes in groups"
  value = module.hcloud.*.master_nodes_ipv4
}

output "master_nodes_internal_ipv4" {
  depends_on  = [module.hcloud]
  description = "Public IP Address of the master nodes in groups"
  value = module.hcloud.*.master_nodes_internal_ipv4
}

output "nodes_ipv4" {
  depends_on  = [module.hcloud]
  description = "Public IP Address of the worker nodes in groups"
  value = module.hcloud.nodes_ipv4
}
