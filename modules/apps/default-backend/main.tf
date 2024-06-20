
resource "helm_release" "nginx" {
  provider = helm.configured
  name             = "webroot"
  repository       = "https://charts.bitnami.com/bitnami"
  chart            = "nginx"
  namespace        = var.default_namespace
  version          = "18.1.2"
  create_namespace = true
  values = [
    templatefile("${path.module}/values.yaml", {
      default_domain       = var.default_domain
      default_backend= var.nginx_default_backend
      issuer_name = "${var.cluster_issuer_name}-${var.letsencrypt_is_prod ? "prod":"stage"}"
      image_registry = var.default_backend_image_registry
      image_repository = var.default_backend_image_repository
      image_tag = var.default_backend_image_tag
      image_digest = var.default_backend_image_digest
    })
  ]
}