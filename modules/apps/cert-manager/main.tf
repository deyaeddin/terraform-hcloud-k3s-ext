
locals {
  dns_secret_name = "dns-secret"
  webhook_group_name = "acme.farhand.me"
  hetzner_api_url = "https://dns.hetzner.com/api/v1"
  cert_manager_namespace = "cert-manager"

}

data "template_file" "cluster_issuer" {
  template = file("${path.module}/manifests/clusterIssuer.yaml")
  vars = {
    acme_email       = var.issuer_email
    issuer_name = var.cluster_issuer_name
    server      = var.letsencrypt_is_prod ? "https://acme-v02.api.letsencrypt.org/directory" : "https://acme-staging-v02.api.letsencrypt.org/directory"
    solver_type = var.cert_manager_solver_type

    zoneName    = "${var.default_domain}." //adding the trailing .
    groupName   = local.webhook_group_name
    hetzner_api_url = local.hetzner_api_url
    dns_secret_name = local.dns_secret_name

    cloudflare_email = var.cloud_flare_api_email

  }
}


resource "helm_release" "cert_manager_webhook" {
  count = var.cert_manager_solver_type == "DNS01_HETZNER" ? 1 : 0
  repository = "https://raw.githubusercontent.com/deyaeddin/cert-manager-webhook-hetzner/helmrepo/"
  chart = "cert-manager-webhook-hetzner"
  name = "cert-manager-webhook-hetzner"
  namespace        = local.cert_manager_namespace
  version          = "0.1.2"

  set {
    name =  "groupName"
    value = local.webhook_group_name
  }

  depends_on = [helm_release.cert_manager]
}


resource "helm_release" "cert_manager" {
  name = "cert-manager"
  //  repository        = "https://charts.jetstack.io"
  chart            = "jetstack/cert-manager"
  namespace        =  local.cert_manager_namespace
  version          = "v1.3.1"
  create_namespace = true

  set {
    name  = "installCRDs"
    value = "true"
  }

}

resource "null_resource" "cert_manager_chart" {

  depends_on = [helm_release.cert_manager]

  provisioner "local-exec" {
    command = " kubectl --kubeconfig ${var.k3s_config_file} apply -f -<<EOF\n${data.template_file.cluster_issuer.rendered}\nEOF"
  }
}

data "template_file" "cert_manager_secrets"{
  count = var.cert_manager_solver_type == "HTTP01" ? 0 : 1

  template = file("${path.module}/manifests/dnsSecret.yaml")
  vars = {
    secret_name = local.dns_secret_name
    namespace = var.cert_manager_solver_type == "DNS01_CLOUDFLARE" ? "kube-system" : local.cert_manager_namespace
    api_key_token = var.cert_manager_solver_type == "DNS01_CLOUDFLARE" ? var.cloud_flare_api_key: var.hcloud_dns_api_token
  }

}



resource "null_resource" "hetzner_cet_manager_webhook_secret" {
  count = var.cert_manager_solver_type == "HTTP01" ? 0 : 1
  depends_on = [helm_release.cert_manager]
  provisioner "local-exec" {
    command = " kubectl --kubeconfig ${var.k3s_config_file} apply -f -<<EOF\n${data.template_file.cert_manager_secrets[count.index].rendered}\nEOF"
  }
}
