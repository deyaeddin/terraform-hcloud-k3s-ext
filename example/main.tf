
module "k3s-ext" {
  source                       = "deyaeddin/k3s-ext/hcloud"
  version                      = "0.0.1"
  cloud_flare_api_email        = ""
  cloud_flare_api_key          = ""
  cloud_flare_api_token        = ""
  default_domain               = "deyaeddin.com"
  hcloud_dns_api_token         = ""
  hcloud_masters_extra_scripts = []
  hcloud_node_extra_scripts    = []
  hcloud_token                 = ""
  issuer_email                 = "info@deyaeddin.com"
  enable_apps                  = false
}