
provider "hcloud" {
  token = var.hcloud_token
}

provider "helm" {
  debug   = true
  kubernetes {
    config_path = var.k3s_config_file
    ## On destroy, it's trying to connect to 127.0.0.1
    //    host                   = module.hcloud.config_k3s_host
    //    client_certificate     = base64decode(module.hcloud.k3s_client_certificate)
    //    client_key             = base64decode(module.hcloud.k3s_client_key)
    //    cluster_ca_certificate = base64decode(module.hcloud.k3s_cluster_ca_certificate)
  }
}

provider "kubernetes" {
  config_path    = var.k3s_config_file
  ## On destroy, it trying's to connect to 127.0.0.1
  //  host                   = module.hcloud.config_k3s_host
  //  client_certificate     = base64decode(module.hcloud.k3s_client_certificate)
  //  client_key             = base64decode(module.hcloud.k3s_client_key)
  //  cluster_ca_certificate = base64decode(module.hcloud.k3s_cluster_ca_certificate)
}

provider "minio" {
  minio_server = "minio.apps.svc.cluster.local:9000"
  //  minio_region = "us-east-1"
  minio_access_key = "abcd123456"
  minio_secret_key = "123456abcd"
  minio_ssl = false // default false
}