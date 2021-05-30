terraform {
  required_providers {
    helm = {
      source = "hashicorp/helm"
      version = ">= 2.1.1"
    }
    kubernetes = {
      source = "hashicorp/kubernetes"
      version = ">= 2.2.0"
    }
  }
  required_version = ">= 0.14"
}
