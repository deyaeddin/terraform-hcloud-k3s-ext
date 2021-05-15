
resource "null_resource" "helm_updater" {

  provisioner "local-exec" {
    command = "helm repo update"
  }
}


module "nginx_ingress_controller" {
  source                = "./nginx-ingress-controller"
  cluster_issuer_name   = var.cluster_issuer_name
  default_domain        = var.default_domain
  lb_hcloud_location    = var.lb_hcloud_location
  lb_hcloud_protocol    = var.lb_hcloud_protocol
  nginx_default_backend = var.nginx_default_backend
  default_namespace = var.default_namespace
  lb_hcloud_name        = var.lb_hcloud_name

  depends_on = [null_resource.helm_updater]
}

module "external_dns_hcloud" {
  source                  = "./external-dns"
  dns_provider            = var.dns_provider
  lb_hcloud_name          = var.lb_hcloud_name
  hcloud_dns_api_token    =  var.hcloud_dns_api_token
  k3s_config_file         = var.k3s_config_file

  cloud_flare_api_email   = var.cloud_flare_api_email
  cloud_flare_api_key     = var.cloud_flare_api_key
  cloud_flare_api_proxied = var.cloud_flare_api_proxied
  cloud_flare_api_token   = var.cloud_flare_api_token

  # we need the loadbalancer name / IP
  depends_on = [module.nginx_ingress_controller]
}



module "cert_manager" {
  source = "./cert-manager"

  k3s_config_file     = var.k3s_config_file
  cluster_issuer_name = var.cluster_issuer_name
  letsencrypt_is_prod = var.letsencrypt_is_prod
  issuer_email        = var.issuer_email
  cert_manager_solver_type = var.cert_manager_solver_type

  default_domain      = var.default_domain

  cloud_flare_api_key = var.cloud_flare_api_key
  cloud_flare_api_email = var.cloud_flare_api_email

  hcloud_dns_api_token = var.hcloud_dns_api_token

  # we need dns to be populated for DNS01 challenge
  depends_on = [module.external_dns_hcloud]

}


module "default_website" {
  source = "./default-website"
  cluster_issuer_name = var.cluster_issuer_name
  default_domain = var.default_domain
  nginx_default_backend = var.nginx_default_backend
  default_namespace = var.default_namespace

}

module "minio" {
  source = "./minio"
  default_domain = var.default_domain
  cluster_issuer_name = var.cluster_issuer_name
  default_namespace = var.default_namespace

}