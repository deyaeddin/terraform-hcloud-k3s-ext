
provider "hcloud" {
  token = var.hcloud_token
}

provider "helm" {
  alias = "default"
  debug   = true
  kubernetes {
    config_path =  fileexists(var.k3s_config_file) ?  var.k3s_config_file: null
  }
}

provider "helm" {
  alias = "configured"
  debug = true
  kubernetes {
    config_path =  fileexists(var.k3s_config_file) ? var.k3s_config_file : null
    host                   = module.hcloud.config_k3s_host != null ? module.hcloud.config_k3s_host : null
    client_certificate     = module.hcloud.k3s_client_certificate!= null ? base64decode(module.hcloud.k3s_client_certificate):  null
    client_key             = module.hcloud.k3s_client_key!=null ? base64decode(module.hcloud.k3s_client_key) : null
    cluster_ca_certificate = module.hcloud.k3s_cluster_ca_certificate!=null? base64decode(module.hcloud.k3s_cluster_ca_certificate) : null
  }
}

provider "kubernetes" {
  config_path =  fileexists(var.k3s_config_file) ? var.k3s_config_file : null
  host                   = module.hcloud.config_k3s_host != null ? module.hcloud.config_k3s_host : null
  client_certificate     = module.hcloud.k3s_client_certificate!= null ? base64decode(module.hcloud.k3s_client_certificate):  null
  client_key             = module.hcloud.k3s_client_key!=null ? base64decode(module.hcloud.k3s_client_key) : null
  cluster_ca_certificate = module.hcloud.k3s_cluster_ca_certificate!=null? base64decode(module.hcloud.k3s_cluster_ca_certificate) : null
}