
// ----------------------------------------------------------------------------
// Hetzner Cloud Variables
// ----------------------------------------------------------------------------

hcloud_token                   = "<hetzner cloud key>"
k3s_config_file                = "~/.kubeconfig/hetzner.config"
public_key_path                = "~/.ssh/id_rsa.pub"
private_key_path               = "~/.ssh/id_rsa"
hcloud_network_ip_range        = "10.0.0.0/8"
hcloud_network_subnet_type     = "cloud"
hcloud_network_subnet_zone     = "eu-central"
hcloud_network_subnet_ip_range = "10.0.0.0/16"
cluster_name                   = "my-cluster"
hcloud_datacenter              = "hel1-dc2" // "nbg1-dc3"
image                          = "ubuntu-20.04"
k3s_channel                    = "latest"//"stable"
k3s_version                    = "v1.21.1+k3s1" //"v1.19.11+k3s1" "v1.20.7+k3s1" "v1.21.1+k3s1"
master_groups_type             = "cx21" # 2 vCPU, 4 GB RAM, 40 GB Disk space
master_groups_count            = 1      // Odd number for HA enabled
node_groups                    = {      // NOTE: pass emtpy map to use a single master
  "cx21" = 4
  //"cpx11" = 2
}
hcloud_masters_extra_scripts  = [
  "echo \"----starting additional script----\"",
]

hcloud_node_extra_scripts = [
  "echo \"----starting additional script----\"",
]


// ----------------------------------------------------------------------------
// Core Apps Variables
// ----------------------------------------------------------------------------
enable_apps              = true
default_domain           = "example.com"
cluster_issuer_name      = "letsencrypt"
letsencrypt_is_prod      = false
issuer_email             = "admin@example.com"
cert_manager_solver_type = "DNS01_HETZNER" // HTTP01, DNS01_CLOUDFLARE, DNS01_HETZNER
lb_hcloud_name           = "name_cluster_lb"
lb_hcloud_location       = "hel1" // "nbg1"
lb_hcloud_protocol       = "tcp"
nginx_default_backend    = "default-backend"
default_namespace        = "apps"
dns_provider             = "hetzner" // "hetzner or cloudflare"
hcloud_dns_api_token     = "<hcloud DNS key>"
cloud_flare_api_token    = "<cloudflare api toke>"
cloud_flare_api_key      = "<cloudflare api key>"
cloud_flare_api_email    = "<cloudflare email>"
cloud_flare_api_proxied  = false
storage_class            = "hcloud-volumes"




