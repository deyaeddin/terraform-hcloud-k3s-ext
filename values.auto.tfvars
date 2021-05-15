
hcloud_token      = "xyz"

k3s_config_file   = "~/.kubeconfig/hetzner.config"
public_key_path   = "~/.ssh/id_rsa.pub"
private_key_path  = "~/.ssh/id_rsa"

hcloud_network_ip_range        = "10.0.0.0/8"
hcloud_network_subnet_type     = "cloud"
hcloud_network_subnet_zone     = "eu-central"
hcloud_network_subnet_ip_range = "10.0.0.0/16"
cluster_name                   = "my-cluster"
hcloud_datacenter              = "hel1-dc2"
image                          = "ubuntu-20.04"
k3s_channel                    = "latest"
k3s_version                    = "v1.21.0+k3s1"
master_groups_type  = "cx21" # 2 vCPU, 4 GB RAM, 40 GB Disk space
master_groups_count = 3
// NOTE: pass emtpy array to use a single master
node_groups = {
  "cx21"  = 4
  //"cpx11" = 2
}

## Apps
enable_apps         = true
default_domain      = "example.me"
cluster_issuer_name = "letsencrypt"
letsencrypt_is_prod = false
issuer_email        = "admin@example.com"
cert_manager_solver_type = "DNS01_HETZNER" // HTTP01, DNS01_CLOUDFLARE, DNS01_HETZNER

lb_hcloud_name        = "my_cluster_lb"
lb_hcloud_location    = "hel1"
lb_hcloud_protocol    = "tcp"
nginx_default_backend = "nginx-webroot-backend"
default_namespace     = "my-apps"

dns_provider            = "hetzner" // "hetzner or cloudflare"

// 'echo -n xxxxx | base64'  => yyyyyyy
cloud_flare_api_token   = "yyyyyyy"
// 'echo -n xxxxx | base64' => yyyyyyy
cloud_flare_api_key     = "yyyyyyy"
cloud_flare_api_email   = "me@example.com"
cloud_flare_api_proxied = false

/// 'echo -n xxxxx | base64'  => yyyyyyy
hcloud_dns_api_token = "yyyyyyy"
