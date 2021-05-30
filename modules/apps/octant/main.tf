
resource "helm_release" "octant-dashboard" {
  name             = "octant-dashboard"
  repository       = "https://deyaeddin.github.io/octant-dashboard-turnkey/repo"
  chart            = "octant"
  namespace        = var.default_namespace
  version          = "0.18.0"
  create_namespace = true
  values = [
    templatefile("${path.module}/values.yaml", {

      hostname       = "dash.${var.default_domain}"
      issuer_name = "${var.cluster_issuer_name}-${var.letsencrypt_is_prod ? "prod":"stage"}"

    })
  ]
}