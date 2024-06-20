
// ----------------------------------------------------------------------------
// Hetzner Cloud Variables
// ----------------------------------------------------------------------------

# hcloud_token                   = <hcloud token>" "set TF_VAR_hcloud_token value in your Environment Variables"
k3s_config_file                = "~/.kube/hcloud_config"
public_key_path                = "~/.ssh/id_rsa_hcloud.pub" // Generate SSH key pair separately
private_key_path               = "~/.ssh/id_rsa_hcloud"    // Generate SSH key pair separately
hcloud_network_ip_range        = "10.0.0.0/8"
hcloud_network_subnet_type     = "cloud"
hcloud_network_subnet_zone     = "eu-central"
hcloud_network_subnet_ip_range = "10.0.0.0/16"
cluster_name                   = "my-cluster"
hcloud_datacenter              = "hel1-dc2" // "nbg1-dc3"
image                          = "ubuntu-24.04"
k3s_channel                    = "latest"//"stable"
k3s_version                    = "v1.30.1+k3s1" //"v1.19.11+k3s1" "v1.20.7+k3s1" "v1.21.1+k3s1"
master_groups_type             = "cx32" # 2 vCPU, 4 GB RAM, 40 GB Disk space
master_groups_count            = 1      // Odd number for HA enabled
node_groups                    = {      // NOTE: pass empty map to use a single master
  "cx22" = 2
  //"cpx11" = 2
}
hcloud_masters_extra_scripts  = [
  "echo \"----starting additional script----\"",
#   "echo \"----installing additional packages----\"",
#     "apt-get update",
#     "apt-get install -y curl",
#     "apt-get install -y vim",
#     "apt-get install -y git",
#     "apt-get install -y jq",
#     "apt-get install -y tree",
#     "apt-get install -y htop",
#     "apt-get install -y net-tools",
#     "apt-get install -y dnsutils",
#     "apt-get install -y bash-completion",
#     "apt-get install -y apt-transport-https",
#     "apt-get install -y ca-certificates",
#     "apt-get install -y software-properties-common",
#     "apt-get install -y gnupg",
  "echo \"----finished additional script----\"",
]

hcloud_node_extra_scripts = [
  "echo \"----starting additional script----\"",
#     "echo \"----installing additional packages----\"",
#         "apt-get update",
#         "apt-get install -y curl",
#         "apt-get install -y vim",
#         "apt-get install -y git",
#         "apt-get install -y jq",
#         "apt-get install -y tree",
#         "apt-get install -y htop",
#         "apt-get install -y net-tools",
#         "apt-get install -y dnsutils",
#         "apt-get install -y bash-completion",
#         "apt-get install -y apt-transport-https",
#         "apt-get install -y ca-certificates",
#         "apt-get install -y software-properties-common",
#         "apt-get install -y gnupg",
    "echo \"----finished additional script----\"",
]


// ----------------------------------------------------------------------------
// Core Apps Variables
// ----------------------------------------------------------------------------
enable_apps              = true
# default_domain           = "<example.com>" // set TF_VAR_default_domain value in your Environment Variables
cluster_issuer_name      = "letsencrypt"
letsencrypt_is_prod      = false
# issuer_email             = "admin@example.com" // set TF_VAR_issuer_email value in your Environment Variables
cert_manager_solver_type = "DNS01_CLOUDFLARE" // HTTP01, DNS01_CLOUDFLARE, DNS01_HETZNER
lb_hcloud_name           = "my-cluster_lb"
lb_hcloud_location       = "hel1" // "nbg1"
lb_hcloud_protocol       = "tcp"
nginx_default_backend    = "default-backend"
default_namespace        = "apps"
dns_provider             = "cloudflare" // "hetzner or cloudflare"
# hcloud_dns_api_token     = "<hcloud DNS key>" // set TF_VAR_hcloud_dns_api_token value in your Environment Variables
# cloud_flare_api_token    = "<cloudflare api toke>" // set TF_VAR_cloud_flare_api_token value in your Environment Variables
# cloud_flare_api_key      = "<cloudflare api key>" // set TF_VAR_cloud_flare_api_key value in your Environment Variables
# cloud_flare_api_email    = "<cloudflare email>" // set TF_VAR_cloud_flare_api_email value in your Environment Variables
cloud_flare_api_proxied  = false
storage_class            = "hcloud-volumes"




