


locals {
  set_kube_config = templatefile("${path.module}/templates/setkubeconfig.sh", {
    cluster_name  = var.cluster_name
    master_ipv4   = var.master_ipv4
    private_key   = var.private_key_path
    config_file   = var.k3s_config_file
  })

  unset_kube_config = templatefile("${path.module}/templates/unsetkubeconfig.sh", {
    cluster_name = var.cluster_name
    config_file   = var.k3s_config_file
  })

  raw_settings = fileexists(var.k3s_config_file) ? yamldecode(file(var.k3s_config_file)) : null

#   cluster_server = fileexists(var.k3s_config_file) && (local.raw_settings!=null)  && (local.raw_settings.clusters!=null) ? local.raw_settings.clusters[0].cluster.server : null
#   cluster_ca_certificate = fileexists(var.k3s_config_file) && (local.raw_settings!=null) && (local.raw_settings.clusters!=null) ? local.raw_settings.clusters[0].cluster.certificate-authority-data : null
#   client_certificate = fileexists(var.k3s_config_file) && (local.raw_settings!=null) && (local.raw_settings.users!=null)? local.raw_settings.users[0].user.client-certificate-data : null
#   client_key = fileexists(var.k3s_config_file) && (local.raw_settings!=null)&& (local.raw_settings.users!=null)? local.raw_settings.users[0].user.client-key-data : null
}


// Setting KubeConfig
resource "local_file" "set_kube_config" {
  content         = local.set_kube_config
  filename        = "${path.module}/exec/setkubeconfig.sh"
  file_permission = "0755"
  provisioner "local-exec" {
    command = "${path.module}/exec/setkubeconfig.sh"
  }
}




// Clearing KubeConfig

resource "local_file" "unset_kube_config" {
  content         = local.unset_kube_config
  filename        = "${path.module}/exec/unsetkubeconfig.sh"
  file_permission = "0755"

  provisioner "local-exec" {
    when    = destroy
    command = "${path.module}/exec/unsetkubeconfig.sh"
  }
}

