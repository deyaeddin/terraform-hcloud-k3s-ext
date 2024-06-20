
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

variable "nginx_default_backend" {
  description = "nginx ingress controller default backend service name"
}

variable "default_namespace" {
  description = "default applications namespace"
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
