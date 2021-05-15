
variable "hcloud_token" {
  description = "Hetzner cloud auth token"
}

variable "k3s_config_file" {
  description = "String path to config file"
}

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
  description = "webroot namespace"
}

variable "dns_provider" {
  description = "DNS provider to use"
}

variable "cloud_flare_api_token" {
  description = "Cloudflare api token. Ref: https://dash.cloudflare.com/profile/api-tokens"
}

variable "cloud_flare_api_key" {
  description = "Cloudflare api key.  Ref: https://dash.cloudflare.com/profile/api-tokens"
}

variable "cloud_flare_api_email" {
  description = "Cloudflare primary email (login email)"
}

variable "cloud_flare_api_proxied" {
  description = "wither the zone will be proxied on cloudflare "
}

variable "cert_manager_solver_type" {
  description = "which solver cert-manger will use, values : HTTP01, DNS01_CLOUDFLARE, DNS01_HETZNER"
}

variable "hcloud_dns_api_token" {
  description = "hashed Hetzner DNS access token"
}