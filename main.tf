
locals {
  current_date = formatdate("YYYY-MM-DD", timestamp())
  name_with_date = "Terraform key - ${local.current_date}"
}


resource "hcloud_ssh_key" "default" {
  name       = local.name_with_date
  public_key = file(var.public_key_path)
}

module "hcloud" {
  source                         = "./modules/hcloud"
  hcloud_token                   = var.hcloud_token
  ssh_keys                       = [hcloud_ssh_key.default.id]
  k3s_config_file                = var.k3s_config_file
  private_key_path               = var.private_key_path
  cluster_name                   = var.cluster_name
  master_groups_type             = var.master_groups_type
  master_groups_count            = var.master_groups_count
  node_groups                    = var.node_groups
  hcloud_datacenter              = var.hcloud_datacenter
  hcloud_network_ip_range        = var.hcloud_network_ip_range
  hcloud_network_subnet_ip_range = var.hcloud_network_subnet_ip_range
  hcloud_network_subnet_type     = var.hcloud_network_subnet_type
  hcloud_network_subnet_zone     = var.hcloud_network_subnet_zone
  image                          = var.image
  k3s_channel                    = var.k3s_channel
  k3s_version                    = var.k3s_version
  hcloud_masters_extra_scripts   = var.hcloud_masters_extra_scripts
  hcloud_node_extra_scripts      = var.hcloud_node_extra_scripts
}


module "apps" {
  count                    = var.enable_apps ? 1 : 0
  source                   = "./modules/apps"
  cluster_name             = var.cluster_name
  k3s_config_file          = var.k3s_config_file
  cluster_issuer_name      = var.cluster_issuer_name
  letsencrypt_is_prod      = var.letsencrypt_is_prod
  issuer_email             = var.issuer_email
  cert_manager_solver_type = var.cert_manager_solver_type
  hcloud_dns_api_token     = var.hcloud_dns_api_token
  default_domain           = var.default_domain
  default_backend_image_registry = var.default_backend_image_registry
  default_backend_image_repository = var.default_backend_image_repository
  default_backend_image_tag = var.default_backend_image_tag
  default_backend_image_digest = var.default_backend_image_digest
  lb_hcloud_location       = var.lb_hcloud_location
  lb_hcloud_name           = var.lb_hcloud_name
  lb_hcloud_protocol       = var.lb_hcloud_protocol
  nginx_default_backend    = var.nginx_default_backend
  default_namespace        = var.default_namespace
  dns_provider             = var.dns_provider
  cloud_flare_api_email    = var.cloud_flare_api_email
  cloud_flare_api_key      = var.cloud_flare_api_key
  cloud_flare_api_proxied  = var.cloud_flare_api_proxied
  cloud_flare_api_token    = var.cloud_flare_api_token
  storage_class            = var.storage_class
  providers = {
    helm.default = helm.default
    helm.configured = helm.configured
  }
  depends_on               = [module.hcloud]

}
