
## Common
variable "hcloud_token" {
  description = "Hetzner cloud auth token"
  sensitive = true
}

variable "k3s_config_file" {
  description = "String path to config file"
  default = "~/.kubeconfig/hetzner.config"
}

variable "public_key_path" {
  description = "string path to public key which will be used to access all the servers including the nodes"
  default = "~/.ssh/id_rsa.pub"
}

variable "private_key_path" {
  description = "string path to private key which will be used to access all the servers including the nodes"
  default = "~/.ssh/id_rsa"
}

variable "enable_apps" {
  type = bool
  description = "wither to enable deploying cert-manager, nginx-ingress-controller ...etc"
  default = false
}

## Hetzner Cloud
variable "hcloud_network_ip_range" {
  description = "ip_range of the main network "
  default = "10.0.0.0/8"
}

variable "hcloud_network_subnet_type" {
  description = "subnet type"
  default = "cloud"
}

variable "hcloud_network_subnet_zone" {
  description = "Subnet Zon"
  default = "eu-central"
}

variable "hcloud_network_subnet_ip_range" {
  description = "ip_range of the subnetwork "
  default = "10.0.0.0/16"
}

variable "cluster_name" {
  description = "Cluster name (prefix for all resource names)"
  default = "my-cluster"
}

variable "hcloud_datacenter" {
  description = "Hetzner datacenter where resources resides, hel1-dc2 (Helsinki 1 DC 2) or fsn1-dc14 (Falkenstein 1 DC14)"
  default = "hel1-dc2"
}

variable "image" {
  description = "Node boot image"
  default = "ubuntu-24.04"
}

variable "k3s_channel" {
  description = "k3s channel (stable, latest, v1.19 and so on)"
  default = "latest"
}

variable "k3s_version" {
  description = "k3s version (v1.21.0+k3s1, v1.19.10+k3s1 and so on)"
  default = "v1.30.1+k3s1"
}

# "cx21" # 2 vCPU, 4 GB RAM, 40 GB Disk space
variable "node_groups" {
  description = "Map of worker node groups, key is server_type, value is count of nodes in group. NOTE: pass emtpy map to use a single master"
  type        = map(string)
  default = {
    "cx22" = 2
    "cx32" = 1
  }
}

variable "master_groups_type" {
  description = "Node type (size)"
  default = "cx22"
  validation {
    condition     = can(regex("^cx22$|^cpx11$|^cx32$|^cpx21$|^cpx31$|^cx42$|^cpx41$|^cx52$|^cpx51$|^ccx11$|^ccx21$|^ccx31$|^ccx41$|^ccx51$", var.master_groups_type))
    error_message = "Node type is not valid."
  }
}

variable "master_groups_count" {
  description = "Number of control plane nodes."
  default = 1
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

variable "default_backend_image_registry" {
  description = "default backend image registry"
  default = "docker.io"
}

variable "default_backend_image_repository" {
  description = "default backend image repository e.g. bitnami/nginx"
  default = "bitnami/nginx"
}

variable "default_backend_image_tag" {
  description = "default backend image tag e.g. 1.27.0-debian-12-r1"
  default = "1.27.0-debian-12-r1"
}

variable "default_backend_image_digest" {
  description = "default backend image digest"
  default = ""
}

variable "cluster_issuer_name" {
  description = "name for cert-manager cluster issuer"
  default = "letsencrypt"
}

variable "letsencrypt_is_prod" {
  type        = bool
  description = "wither to utilize the staging or production for Letsencrypt certificates issuing"
  default = false
}

variable "issuer_email" {
  description = "email for issuing certificates with LetsEncrypt"
}

variable "cert_manager_solver_type" {
  description = "which solver cert-manger will use, values : HTTP01, DNS01_CLOUDFLARE, DNS01_HETZNER"
  default = "HTTP01"
}

variable "lb_hcloud_name" {
  description = "name of the loadbalancer"
  default = "name_cluster_lb"
}

variable "lb_hcloud_location" {
  description = "location of the loadbalancer"
  default = "hel1"
}

variable "lb_hcloud_protocol" {
  description = "protocol for the loadbalancer"
  default = "tcp"
}

variable "nginx_default_backend" {
  description = "nginx ingress controller default backend service name"
  default = "default-backend"
}

variable "default_namespace" {
  description = "default applications namespace"
  default = "apps"
}

variable "hcloud_dns_api_token" {
  description = "hashed Hetzner DNS access token"
  sensitive = true
}

variable "dns_provider" {
  description = "DNS provider to use. Values can be hetzner or cloudflare"
  default = "hetzner"
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
  default = false
}

variable "storage_class" {
  description = "storage class to use with minio drivers"
  default = "hcloud-volumes"
}
