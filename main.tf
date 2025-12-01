resource "kubernetes_namespace" "tenant" {
  metadata {
    name = var.tenant_name
  }
}

resource "kubernetes_manifest" "deployment" {
  manifest = yamldecode(
    templatefile("${path.module}/templates/k8s-deployment.yaml", {
      tenant = var.tenant_name
    })
  )
}

resource "kubernetes_manifest" "service" {
  manifest = yamldecode(
    templatefile("${path.module}/templates/k8s-service.yaml", {
      tenant = var.tenant_name
    })
  )
}

resource "kubernetes_manifest" "ingress" {
  manifest = yamldecode(
    templatefile("${path.module}/templates/k8s-ingress.yaml", {
      tenant = var.tenant_name
    })
  )
}
