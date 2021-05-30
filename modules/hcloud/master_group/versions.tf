terraform {
  required_providers {
    hcloud = {
      source = "hetznercloud/hcloud"
      version = ">= 1.26.0"
    }
    template = {
      source = "hashicorp/template"
      version = ">= 2.2.0"
    }
  }
  required_version = ">= 0.14"
}