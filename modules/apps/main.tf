
resource "null_resource" "helm_updater" {

  provisioner "local-exec" {
    command = <<EOT
        helm repo add stable https://charts.helm.sh/stable
        helm repo add bitnami https://charts.bitnami.com/bitnami
        helm repo add jetstack https://charts.jetstack.io
        helm repo add cert-manager-webhook-hetzner https://vadimkim.github.io/cert-manager-webhook-hetzner
        helm repo update
    EOT
  }
}


module "default_backend" {
  source = "./default-backend"
  cluster_issuer_name = var.cluster_issuer_name
  letsencrypt_is_prod = var.letsencrypt_is_prod
  default_domain = var.default_domain
  nginx_default_backend = var.nginx_default_backend
  default_namespace = var.default_namespace
  default_backend_image_registry = var.default_backend_image_registry
  default_backend_image_repository = var.default_backend_image_repository
  default_backend_image_tag = var.default_backend_image_tag
  default_backend_image_digest = var.default_backend_image_digest

  providers = {
    helm.default = helm.default
    helm.configured = helm.configured
  }

  depends_on = [null_resource.helm_updater]
}

module "nginx_ingress_controller" {
  source                = "./nginx-ingress-controller"
  default_domain        = var.default_domain
  lb_hcloud_location    = var.lb_hcloud_location
  lb_hcloud_protocol    = var.lb_hcloud_protocol
  nginx_default_backend = var.nginx_default_backend
  default_namespace = var.default_namespace
  lb_hcloud_name        = var.lb_hcloud_name
  providers = {
    helm.default = helm.default
    helm.configured = helm.configured
  }
  // we need the default backend service to be operated
  // so the loadbalancer become healthy
  depends_on = [module.default_backend]
}

module "external_dns" {
  source                  = "./external-dns"
  dns_provider            = var.dns_provider
  k3s_config_file         = var.k3s_config_file
  cluster_name            = var.cluster_name
  hcloud_dns_api_token    =  var.hcloud_dns_api_token

  cloud_flare_api_email   = var.cloud_flare_api_email
  cloud_flare_api_key     = var.cloud_flare_api_key
  cloud_flare_api_proxied = var.cloud_flare_api_proxied
  cloud_flare_api_token   = var.cloud_flare_api_token
  providers = {
    helm.default = helm.default
    helm.configured = helm.configured
  }
  depends_on              = [module.nginx_ingress_controller]
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
  providers = {
    helm.default = helm.default
    helm.configured = helm.configured
  }
  # we need dns to be populated for DNS01 challenge
  depends_on = [module.external_dns]

}
