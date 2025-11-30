terraform {
  required_providers {
    kubernetes = {
      source  = "hashicorp/kubernetes"
      version = "2.21.1"
    }
  }
}

provider "kubernetes" {
#   config_path = "~/.kube/config"
  host                   = var.k8s_host
  client_certificate     = base64decode(var.client_certificate)
  client_key             = base64decode(var.client_key)
  cluster_ca_certificate = base64decode(var.cluster_ca_certificate)
}

resource "kubernetes_namespace" "tenant" {
  metadata {
    name = var.tenant_name
  }
}

resource "kubernetes_manifest" "app" {
  manifest = yamldecode(
    templatefile("${path.module}/k8s-deployment.yaml", {
      tenant = var.tenant_name
    })
  )
}
