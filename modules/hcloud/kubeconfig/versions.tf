terraform {
  required_providers {
    local = {
      source  = "hashicorp/local"
      version = ">= 2.5.1"
    }

  }
  required_version = ">= 1.8.0"
}
