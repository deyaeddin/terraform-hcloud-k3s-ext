terraform {
  required_providers {
    helm = {
      source = "hashicorp/helm"
    }
    template = {
      source = "hashicorp/template"
    }
    null = {
      source = "hashicorp/null"
    }
  }
  required_version = ">= 0.14"
}