

// Setting KubeConfig
data "template_file" "set_kube_config" {
  template = file("${path.module}/templates/setkubeconfig.sh")
  vars = {
    cluster_name  = var.cluster_name
    master_ipv4   = var.master_ipv4
    private_key   = var.private_key_path
    config_file   = var.k3s_config_file
  }
}

resource "local_file" "set_kube_config" {
  content         = data.template_file.set_kube_config.rendered
  filename        = "${path.module}/exec/setkubeconfig.sh"
  file_permission = "0755"
  provisioner "local-exec" {
    command = "${path.module}/exec/setkubeconfig.sh"
  }
}




// Clearing KubeConfig
data "template_file" "unset_kube_config" {
  template = file("${path.module}/templates/unsetkubeconfig.sh")
  vars = {
    cluster_name = var.cluster_name
  }
}

resource "local_file" "unset_kube_config" {
  content         = data.template_file.unset_kube_config.rendered
  filename        = "${path.module}/exec/unsetkubeconfig.sh"
  file_permission = "0755"

  provisioner "local-exec" {
    when    = destroy
    command = "${path.module}/exec/unsetkubeconfig.sh"
  }
}

