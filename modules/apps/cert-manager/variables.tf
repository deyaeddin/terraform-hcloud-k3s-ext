
variable "k3s_config_file" {
  description = "String path to config file"
}

variable "cluster_issuer_name" {
  description = "name for cert-manager cluster issuer"
}

variable "letsencrypt_is_prod" {
  type        = bool
  description = "wither to utilize the staging or production for Letsencrypt certificates issuing"
}

variable "issuer_email" {
  description = "email for issuing certificates with LetsEncrypt"
}

variable "cloud_flare_api_key" {
  description = "Cloudflare api key.  Ref: https://dash.cloudflare.com/profile/api-tokens"
  sensitive = true
}

variable "cloud_flare_api_email" {
  description = "Cloudflare primary email (login email)"
}

variable "cert_manager_solver_type" {
  description = "which solver cert-manger will use, values : HTTP01, DNS01_CLOUDFLARE, DNS01_HETZNER"
}

variable "default_domain" {
  description = "root domain for ingress default service"
}

variable "hcloud_dns_api_token" {
  description = "hashed Hetzner DNS access token"
  sensitive = true
}