terraform {
  required_providers {
    helm = {
      source = "hashicorp/helm"
      version = ">= 2.1.1"
    }
  }
  required_version = ">= 0.14"
}
