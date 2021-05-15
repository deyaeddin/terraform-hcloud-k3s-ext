
resource "helm_release" "minio_bucket" {
  name             = "minio-bucket"
  repository       = "https://charts.bitnami.com/bitnami"
  chart            = "minio"
  namespace        = var.default_namespace
  version          = "6.7.7"
  create_namespace = true

  values = [
    templatefile("${path.module}/values.yaml", {
      hostname               = "bucket.${var.default_domain}"
      cluster_issuer         = var.cluster_issuer_name
      minio_access_key_pass  = "abcd123456"
      minio_secret_key_pass  = "123456abcd"
    })
  ]

}
