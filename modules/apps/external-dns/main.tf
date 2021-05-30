
locals {
  dns_secret_name = "dns-secret"
  hcloud_data = {
    "hetzner-api-key": var.hcloud_dns_api_token
  }
  cloudflare_data = {
    "cloudflare_api_token": var.cloud_flare_api_token
    "cloudflare_api_key": var.cloud_flare_api_key
  }
}


resource "helm_release" "external_dns" {
  name       = "external-dns"
  repository = "https://charts.bitnami.com/bitnami"
  chart      = "external-dns"
  version    = "5.0.0"

  values = [
    templatefile("${path.module}/values.yaml", {

      ed_owner_id       = var.cluster_name // must be a unique value that doesn't change for the lifetime of your cluster.
      provider          = var.dns_provider
      secret_name       = local.dns_secret_name

      cloud_flare_api_token   = var.cloud_flare_api_token
      cloud_flare_api_key     = var.cloud_flare_api_key
      cloud_flare_api_email   = var.cloud_flare_api_email
      cloud_flare_api_proxied = var.cloud_flare_api_proxied
    })
  ]

  // Error: Post "http://localhost/api/v1/namespaces/default/secrets": dial tcp 127.0.0.1:80: connect: connection refused
  // doesn't make sense but ..?!!
  depends_on = [kubernetes_secret.dns_secrets]
}


resource "kubernetes_secret" "dns_secrets" {
  metadata {
    name = local.dns_secret_name
    namespace = "default"
  }
  data = var.dns_provider == "hetzner" ? local.hcloud_data : local.cloudflare_data
  type = "kubernetes.io/Opaque"

}

