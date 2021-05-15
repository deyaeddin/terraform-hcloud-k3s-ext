
locals {
  dns_secret_name = "dns-secret"
}


data "hcloud_load_balancer" "lb_hcloud" {
  name = var.lb_hcloud_name
}

resource "helm_release" "external_dns" {
  name       = "external-dns"
  repository = "https://charts.bitnami.com/bitnami"
  chart      = "external-dns"
  version    = "4.12.3"

  values = [
    templatefile("${path.module}/values.yaml", {

      hcloud_lb_ipv4 = data.hcloud_load_balancer.lb_hcloud.ipv4

      ed_owner_id = "${var.lb_hcloud_name}_id" // must be a unique value that doesn't change for the lifetime of your cluster.
      provider     = var.dns_provider
      secret_name = local.dns_secret_name

      cloud_flare_api_token   = var.cloud_flare_api_token
      cloud_flare_api_key     = var.cloud_flare_api_key
      cloud_flare_api_email   = var.cloud_flare_api_email
      cloud_flare_api_proxied = var.cloud_flare_api_proxied
    })
  ]
}


data "template_file" "dns_secrets"{

  template = file("${path.module}/manifests/dnsSecret.yaml")
  vars = {
    secret_name = local.dns_secret_name
    namespace = "default"
    dns_provider = var.dns_provider
    api_key_token = var.hcloud_dns_api_token
    cloudflare_api_token = var.cloud_flare_api_token
    cloudflare_api_key = var.cloud_flare_api_key
  }

}

resource "null_resource" "dns_secrets" {

  provisioner "local-exec" {
    command = " kubectl --kubeconfig ${var.k3s_config_file} apply -f -<<EOF\n${data.template_file.dns_secrets.rendered}\nEOF"
  }
}
