

data "template_file" "get_connected" {
  template = file(var.k3s_config_file)
  depends_on = [local_file.set_kube_config]
}

output "k3s_host" {
  value = yamldecode(data.template_file.get_connected.rendered).clusters[0].cluster.server
}

output "k3s_cluster_ca_certificate" {
  value = yamldecode(data.template_file.get_connected.rendered).clusters[0].cluster.certificate-authority-data
  sensitive = true
}

output "k3s_client_certificate" {
  value = yamldecode(data.template_file.get_connected.rendered).users[0].user.client-certificate-data
  sensitive = true
}

output "k3s_client_key" {
  value = yamldecode(data.template_file.get_connected.rendered).users[0].user.client-key-data
  sensitive = true
}
