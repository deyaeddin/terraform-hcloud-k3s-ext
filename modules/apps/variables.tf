
variable "cluster_name" {
  description = "Cluster name (prefix for all resource names)"
}

variable "k3s_config_file" {
  description = "String path to config file"
}

variable "default_domain" {
  description = "root domain for ingress default service"
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

variable "default_backend_image_registry" {
    description = "default backend image registry"

}

variable "default_backend_image_repository" {
    description = "default backend image repository e.g. bitnami/nginx"

}

variable "default_backend_image_tag" {
    description = "default backend image tag e.g. 1.27.0-debian-12-r1"

}

variable "default_backend_image_digest" {
    description = "default backend image digest"

}
variable "default_namespace" {
  description = "default applications namespace"
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

variable "cert_manager_solver_type" {
  description = "which solver cert-manger will use, values : HTTP01, DNS01_CLOUDFLARE, DNS01_HETZNER"
}

variable "hcloud_dns_api_token" {
  description = "hashed Hetzner DNS access token"
  sensitive = true
}