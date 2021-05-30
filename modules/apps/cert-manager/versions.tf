terraform {
  required_providers {
    helm = {
      source = "hashicorp/helm"
      version = ">= 2.1.1"
    }
    template = {
      source = "hashicorp/template"
      version = ">= 2.2.0"
    }
    null = {
      source = "hashicorp/null"
      version = ">= 3.1.0"
    }
    kubernetes = {
      source = "hashicorp/kubernetes"
      version = ">= 2.2.0"
    }
  }
  required_version = ">= 0.14"
}
