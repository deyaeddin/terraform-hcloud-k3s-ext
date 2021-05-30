
resource "helm_release" "nginx" {
  name             = "webroot"
  repository       = "https://charts.bitnami.com/bitnami"
  chart            = "nginx"
  namespace        = var.default_namespace
  version          = "8.9.0"
  create_namespace = true
  values = [
    templatefile("${path.module}/values.yaml", {
      hostname       = var.default_domain
      default_backend= var.nginx_default_backend
      issuer_name = "${var.cluster_issuer_name}-${var.letsencrypt_is_prod ? "prod":"stage"}"
    })
  ]
}