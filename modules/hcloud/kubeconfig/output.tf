

output "k3s_host" {
  value = local.raw_settings!=null ? local.raw_settings.clusters[0].cluster.server : null
}

output "k3s_cluster_ca_certificate" {
  value = local.raw_settings!=null ? local.raw_settings.clusters[0].cluster.certificate-authority-data : null
  sensitive = true
}

output "k3s_client_certificate" {
  value = local.raw_settings!=null ? local.raw_settings.users[0].user.client-certificate-data : null
  sensitive = true
}

output "k3s_client_key" {
  value = local.raw_settings!=null ? local.raw_settings.users[0].user.client-key-data : null
  sensitive = true
}
