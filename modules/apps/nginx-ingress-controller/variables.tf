
variable "default_domain" {
  description = "root domain for ingress default service"
}

variable "cluster_issuer_name" {
  description = "name fro cert-manager cluster issuer"
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
