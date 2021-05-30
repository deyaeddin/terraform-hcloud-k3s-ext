


output "node_ipv4" {
  value = hcloud_server.node.*.ipv4_address
}
