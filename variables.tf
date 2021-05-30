
## Common
variable "hcloud_token" {
  description = "Hetzner cloud auth token"
  sensitive = true
}

variable "k3s_config_file" {
  description = "String path to config file"
}

variable "public_key_path" {
  description = "string path to public key which will be used to access all the servers including the nodes"
}

variable "private_key_path" {
  description = "string path to private key which will be used to access all the servers including the nodes"
}

variable "enable_apps" {
  type = bool
  description = "wither to enable deploying cert-manager, nginx-ingress-controller ...etc"
}

## Hetzner Cloud
variable "hcloud_network_ip_range" {
  description = "ip_range of the main network "
}

variable "hcloud_network_subnet_type" {
  description = "subnet type"
}

variable "hcloud_network_subnet_zone" {
  description = "Subnet Zon"
}

variable "hcloud_network_subnet_ip_range" {
  description = "ip_range of the subnetwork "
}

variable "cluster_name" {
  description = "Cluster name (prefix for all resource names)"
}

variable "hcloud_datacenter" {
  description = "Hetzner datacenter where resources resides, hel1-dc2 (Helsinki 1 DC 2) or fsn1-dc14 (Falkenstein 1 DC14)"
}

variable "image" {
  description = "Node boot image"
}

variable "k3s_channel" {
  description = "k3s channel (stable, latest, v1.19 and so on)"
}

variable "k3s_version" {
  description = "k3s version (v1.21.0+k3s1, v1.19.10+k3s1 and so on)"
}

# "cx21" # 2 vCPU, 4 GB RAM, 40 GB Disk space
variable "node_groups" {
  description = "Map of worker node groups, key is server_type, value is count of nodes in group"
  type        = map(string)
}

variable "master_groups_type" {
  description = "Node type (size)"
  validation {
    condition     = can(regex("^cx11$|^cpx11$|^cx21$|^cpx21$|^cx31$|^cpx31$|^cx41$|^cpx41$|^cx51$|^cpx51$|^ccx11$|^ccx21$|^ccx31$|^ccx41$|^ccx51$", var.master_groups_type))
    error_message = "Node type is not valid."
  }
}

variable "master_groups_count" {
  description = "Number of control plane nodes."
}

variable "hcloud_masters_extra_scripts" {
  description = "Additional list of commands to be added to initial master server creation"
  type = list(string)
}

variable "hcloud_node_extra_scripts" {
  description = "Additional list of commands to be added to initial node server creation"
  type = list(string)
}


# Apps
variable "default_domain" {
  description = "root domain for ingress default service"
}

variable "cluster_issuer_name" {
  description = "name fro cert-manager cluster issuer"
}

variable "letsencrypt_is_prod" {
  type        = bool
  description = "wither to utilize the staging or production for Letsencrypt certificates issuing"
}

variable "issuer_email" {
  description = "email for issuing certificates with LetsEncrypt"
}

variable "cert_manager_solver_type" {
  description = "which solver cert-manger will use, values : HTTP01, DNS01_CLOUDFLARE, DNS01_HETZNER"
}

variable "lb_hcloud_name" {
  description = "name of the loadbalancer"
}

variable "lb_hcloud_location" {
  description = "location of the loadbalancer"
}

variable "lb_hcloud_protocol" {
  description = "protocol for the loadbalancer"
}

variable "nginx_default_backend" {
  description = "nginx ingress controller default backend service name"
}

variable "default_namespace" {
  description = "default applications namespace"
}

variable "hcloud_dns_api_token" {
  description = "hashed Hetzner DNS access token"
  sensitive = true
}

variable "dns_provider" {
  description = "DNS provider to use"
}

variable "cloud_flare_api_token" {
  description = "Cloudflare api token. Ref: https://dash.cloudflare.com/profile/api-tokens"
  sensitive = true
}

variable "cloud_flare_api_key" {
  description = "Cloudflare api key.  Ref: https://dash.cloudflare.com/profile/api-tokens"
  sensitive = true
}

variable "cloud_flare_api_email" {
  description = "Cloudflare primary email (login email)"
}

variable "cloud_flare_api_proxied" {
  description = "wither the zone will be proxied on cloudflare "
}

variable "storage_class" {
  description = "storage class to use with minio drivers"
}
