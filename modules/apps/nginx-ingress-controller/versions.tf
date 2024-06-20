terraform {
  required_providers {
    helm = {
      source = "hashicorp/helm"
      version = ">= 2.14.0"
      configuration_aliases = [ helm.default, helm.configured ]
    }
  }
  required_version = ">= 1.8.0"
}
