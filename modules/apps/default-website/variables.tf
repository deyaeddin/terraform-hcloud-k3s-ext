
variable "default_domain" {
  description = "root domain for ingress default service"
}

variable "cluster_issuer_name" {
  description = "name fro cert-manager cluster issuer"
}

variable "nginx_default_backend" {
  description = "nginx ingress controller default backend service name"
}
variable "default_namespace" {
  description = "webroot namespace"
}
