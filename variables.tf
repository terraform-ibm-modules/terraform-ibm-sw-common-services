##############################################################################
# Cluster variables
##############################################################################

variable "cluster_id" {
  type        = string
  description = "The ID of the cluster you wish to deploy the agents in"
}

variable "cluster_resource_group_id" {
  type        = string
  description = "The Resource Group ID of the cluster"
}

variable "is_vpc_cluster" {
  description = "Specify true if the target cluster for the observability agents is a VPC cluster, false if it is a classic cluster."
  type        = bool
  default     = true
}

variable "cert_manager_namespace" {
  type        = string
  description = "The namespace for cert manager"
  default     = "ibm-cert-manager"
}

variable "cert_manager_catalog" {
  type        = string
  description = "The catalog name for cert manager"
  default     = "ibm-cert-manager-catalog"
}

variable "cert_manager_operator" {
  type        = string
  description = "The operator name for cert manager"
  default     = "ibm-cert-manager-operator"
}

variable "cert_manager_operator_group" {
  type        = string
  description = "The operator group for cert manager"
  default     = "cert-manager-operatorgroup"
}

variable "cert_manager_catalog_source_image" {
  type        = string
  description = "The catalog source image for cert manager"
  default     = "icr.io/cpopen/ibm-cert-manager-operator-catalog"
}

variable "cert_manager_subscription_channel" {
  type        = string
  description = "The subscription channel for cert manager"
  default     = "v4.2"
}

variable "licensing_namespace" {
  type        = string
  description = "The namespace for licensing"
  default     = "ibm-licensing"
}

variable "licensing_catalog" {
  type        = string
  description = "The catalog name for licensing"
  default     = "ibm-licensing-catalog"
}

variable "licensing_operator" {
  type        = string
  description = "The operator name for licensing"
  default     = "ibm-licensing-operator-app"
}

variable "licensing_operator_group" {
  type        = string
  description = "The operator group for licensing"
  default     = "licensing-operatorgroup"
}

variable "licensing_catalog_source_image" {
  type        = string
  description = "The catalog source image for licensing"
  default     = "icr.io/cpopen/ibm-licensing-catalog"
}

variable "licensing_subscription_channel" {
  type        = string
  description = "The subscription channel for licensing"
  default     = "v4.2"
}

variable "openshift_source" {
  type        = string
  description = "The openshift source for the subscriptions"
  default     = "openshift-marketplace"
}
