variable "k8s_host" {
  type = string
  description = "The Kubernetes API server endpoint"
}

variable "client_certificate" {
  type = string
  description = "Base64 encoded client certificate"
}

variable "client_key" {
  type = string
  description = "Base64 encoded client key"
}

variable "cluster_ca_certificate" {
  type = string
  description = "Base64 encoded CA certificate"
}

variable "tenant_name" {
  type = string
  description = "Tenant namespace name"
}

# Optional list of tenant names. If this list is non-empty, Terraform will
# create namespaces/manifests for each name. If empty, we fall back to the
# single `tenant_name` for backward compatibility with existing runs.
variable "tenant_names" {
  type        = list(string)
  description = "Optional list of tenant namespace names to create"
  default     = []
}
