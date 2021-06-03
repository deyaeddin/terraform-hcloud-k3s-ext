
module "k3s-ext" {
  source                       = "deyaeddin/k3s-ext/hcloud"
  version                      = "0.0.1"
  cloud_flare_api_email        = ""
  cloud_flare_api_key          = ""
  cloud_flare_api_token        = ""
  default_domain               = "example.me"
  hcloud_dns_api_token         = ""
  hcloud_masters_extra_scripts = []
  hcloud_node_extra_scripts    = []
  hcloud_token                 = ""
  issuer_email                 = "deya@yanax.com"

  //optional
  k3s_version                  = "v1.21.1+k3s1" //"v1.19.11+k3s1" "v1.20.7+k3s1" "v1.21.1+k3s1"
  master_groups_type           = "cx21"         # 2 vCPU, 4 GB RAM, 40 GB Disk space
  master_groups_count          = 3              // Odd number for HA enabled
  node_groups = {                               // NOTE: pass emtpy map to use a single master
    "cx21" = 4
    "cpx11" = 2
  }
}