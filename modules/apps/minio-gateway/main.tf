
resource "helm_release" "minio_gateway" {
  name             = "minio-bucket"
  repository       = "https://charts.bitnami.com/bitnami"
  chart            = "minio"
  namespace        = "${var.default_namespace}-backup"
  version          = "6.7.14"
  create_namespace = true

  values = [
    templatefile("${path.module}/values.yaml", {
      hostname               = "bucket.${var.default_domain}"
      issuer_name            = "${var.cluster_issuer_name}-${var.letsencrypt_is_prod ? "prod":"stage"}"
      minio_access_key_pass  = "abcd123456"
      minio_secret_key_pass  = "123456abcd"
    })
  ]

}
