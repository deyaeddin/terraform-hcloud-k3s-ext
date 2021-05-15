output "master_ipv4" {
  value = hcloud_server.master.ipv4_address
}

output "master_internal_ipv4" {
  value = hcloud_server_network.master.ip
}

output "masters_node_ipv4" {
  value = hcloud_server.master_node.*.ipv4_address
}

output "master_node_internal_ipv4" {
  value = hcloud_server_network.master_node.*.ip
}