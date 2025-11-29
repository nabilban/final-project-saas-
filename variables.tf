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


