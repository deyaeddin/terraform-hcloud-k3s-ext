
variable "cluster_name" {
  description = "Cluster name (prefix for all resource names)"
}

variable "k3s_config_file" {
  description = "String path to config file"
}

variable "dns_provider" {
  description = "DNS provider to use"
}

variable "hcloud_dns_api_token" {
  description = "hashed Hetzner DNS access token"
  sensitive = true
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

