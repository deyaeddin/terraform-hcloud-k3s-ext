terraform {
  required_providers {
    helm = {
      source = "hashicorp/helm"
      version = ">= 2.14.0"
      configuration_aliases = [ helm.default , helm.configured ]
    }

    null = {
      source = "hashicorp/null"
      version = ">= 3.2.2"
    }
    kubernetes = {
      source = "hashicorp/kubernetes"
      version = ">= 2.2.0"
    }
  }
  required_version = ">= 1.8.0"
}
