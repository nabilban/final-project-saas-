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

# Build an ordered list of tenants. If `tenant_names` is provided use that;
# otherwise fall back to the original `tenant_name` for compatibility.
locals {
  tenant_list = length(var.tenant_names) > 0 ? var.tenant_names : [var.tenant_name]
}

# Create one namespace per tenant in tenant_list. Use for_each keyed by name
# so resources are stable and adding a new tenant will add a new resource
# instead of replacing the previous one.
resource "kubernetes_namespace" "tenant" {
  for_each = { for name in local.tenant_list : name => name }

  metadata {
    name = each.value
  }
}

# Render the manifest per tenant. We use each.key to template the file so each
# manifest contains the tenant-specific name. The manifest resource depends on
# the namespace so it is created after the namespace exists.
resource "kubernetes_manifest" "app" {
  for_each = kubernetes_namespace.tenant

  depends_on = [kubernetes_namespace.tenant]

  manifest = yamldecode(
    templatefile("${path.module}/k8s-deployment.yaml", {
      tenant = each.key
    })
  )
}


