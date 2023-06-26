variable "cluster_name" {}
variable "create" {}

resource "helm_release" "fluentd" {
  count            = var.create ? 1 : 0
  create_namespace = true
  namespace        = "fluentd"
  name             = "fluentd"

  repository = "https://fluent.github.io/helm-charts"
  chart      = "fluentd"

  # 0.3.9: unexpected error error_class=Elasticsearch::UnsupportedProductError error="The client noticed that the server is not a supported distribution of Elasticsearch."
  version = "0.3.7"

  values = [
    templatefile("${path.module}/values.yaml", {
      CLUSTER_NAME = var.cluster_name
    })
  ]
}