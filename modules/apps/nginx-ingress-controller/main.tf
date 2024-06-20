
resource "helm_release" "nginx_ingress" {
  provider = helm.configured
  name             = "nginx-ingress-controller"
  repository       = "https://charts.bitnami.com/bitnami"
  chart            = "nginx-ingress-controller"
  namespace        = var.default_namespace
  version          = "11.3.8"
  create_namespace = true

  values = [
    templatefile("${path.module}/values.yaml", {
      hostname          = var.default_domain
      default_backend   = var.nginx_default_backend
      default_namespace = var.default_namespace
      lb_name        = var.lb_hcloud_name
      lb_location    = var.lb_hcloud_location
      lb_protocol    = var.lb_hcloud_protocol
    })
  ]

}
