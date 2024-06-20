terraform {
  required_providers {
    hcloud = {
      source = "hetznercloud/hcloud"
      version = ">= 1.47.0"
    }

  }
  required_version = ">= 1.8.0"
}