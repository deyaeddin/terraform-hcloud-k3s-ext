
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

variable "nginx_default_backend" {
  description = "nginx ingress controller default backend service name"
}

variable "default_namespace" {
  description = "default applications namespace"
}
