

variable "k3s_config_file" {
  description = "String path to config file"
}

variable "default_domain" {
  description = "root domain for ingress default service"
}

variable "default_namespace" {
  description = "default applications namespace"
}

variable "storage_class" {
  description = "storage class to use with minio drivers"
}