output "master_ipv4" {
  depends_on  = [module.master_group]
  description = "Public IP Address of the master node"
  value = module.master_group.master_ipv4
}

output "master_internal_ipv4" {
  depends_on  = [module.master_group]
  description = "Private IP Address of the master node"
  value = module.master_group.master_internal_ipv4
}

output "master_nodes_ipv4" {
  depends_on  = [module.master_group]
  description = "Public IP Address of the master nodes in groups"
  value = module.master_group.*.masters_node_ipv4
}

output "master_nodes_internal_ipv4" {
  depends_on  = [module.master_group]
  description = "Public IP Address of the master nodes in groups"
  value = module.master_group.*.master_node_internal_ipv4
}

output "nodes_ipv4" {
  depends_on  = [module.node_group]
  description = "Public IP Address of the worker nodes in groups"
  value = {
    for type, n in module.node_group :
    type => n.node_ipv4
  }
}
