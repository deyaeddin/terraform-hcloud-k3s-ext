terraform {
  required_providers {
    hcloud = {
      source = "hetznercloud/hcloud"
      version = ">= 1.47.0"
    }
    local = {
      source  = "hashicorp/local"
      version = ">= 2.5.1"
    }
    random = {
      source  = "hashicorp/random"
      version = ">= 3.6.2"
    }

    helm = {
      source  = "hashicorp/helm"
      version = ">= 2.14.0"
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
