terraform {
  required_providers {
    kubernetes = {
      source  = "hashicorp/kubernetes"
      version = "2.21.1"
    }
  }
}

provider "kubernetes" {
  config_path = "~/.kube/config" 
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
