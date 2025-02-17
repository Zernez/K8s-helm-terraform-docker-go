# Copyright (c) HashiCorp, Inc.
# SPDX-License-Identifier: MPL-2.0

provider "helm" {
  kubernetes {
    host                   = data.aws_eks_cluster.cluster.endpoint
    cluster_ca_certificate = base64decode(data.aws_eks_cluster.cluster.certificate_authority.0.data)
    exec {
      api_version = "client.authentication.k8s.io/v1beta1"
      args        = ["eks", "get-token", "--cluster-name", data.aws_eks_cluster.cluster.name]
      command     = "aws"
    }
  }
}

resource "helm_release" "goapphelm" {
  name         = "helmapp"
  repository   = "https://zernez.github.io/K8s-helm-terraform-docker-go"
  chart        = "helm"

  values = [
    file("../helm/values.yaml"),
    file("../helm/values-prod.yaml")
  ]
}
