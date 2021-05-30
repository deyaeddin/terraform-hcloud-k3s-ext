
locals {
  minio_version = "RELEASE.2021-05-27T22-06-31Z"
  tenant_name               ="minio123"
  minio-tls-cert-name       = "minio-tls-cert"
}


resource "helm_release" "minio_operator" {
  name             = "minio-operator"
  repository       = "https://operator.min.io"
  chart            = "minio-operator"
  namespace        = "minio-operator"
  version          = "4.1.0"
  create_namespace = true

  values = [
    templatefile("${path.module}/values.yaml", {
      cluster_domain            = "cluster.local"
      ns_to_watch               = var.default_namespace
      tag                       = "v4.1.0"
      tenants_image_tag         = local.minio_version
      storage_class             = var.storage_class
      tenant_name               = local.tenant_name
      minio-tls-cert-name       = local.minio-tls-cert-name

    })
  ]

}


// Issuer Certificate
//
//resource "null_resource" "cert_manager_issuer" {
//  provisioner "local-exec" {
//    command = " kubectl --kubeconfig ${var.k3s_config_file} apply -f -<<EOF\n${data.template_file.issuer_certificate.rendered}\nEOF"
//  }
//}
//
//data "template_file" "issuer_certificate" {
//  template = file("${path.module}/manifests/issuer-certificate.yaml")
//  vars = {
//    minio-tls-cert-name = local.minio-tls-cert-name
//    ns_to_watch         = var.default_namespace
//    tenant_name         = local.tenant_name
//  }
//}