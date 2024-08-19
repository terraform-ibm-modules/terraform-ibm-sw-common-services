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
/*
variable "cluster_config_endpoint_type" {
  description = "Specify which type of endpoint to use for for cluster config access: 'default', 'private', 'vpe', 'link'. 'default' value will use the default endpoint of the cluster."
  type        = string
  default     = "default"
  nullable    = false # use default if null is passed in
  validation {
    error_message = "Invalid Endpoint Type! Valid values are 'default', 'private', 'vpe', or 'link'"
    condition     = contains(["default", "private", "vpe", "link"], var.cluster_config_endpoint_type)
  }
}*/

variable "is_vpc_cluster" {
  description = "Specify true if the target cluster for the observability agents is a VPC cluster, false if it is a classic cluster."
  type        = bool
  default     = true
}
/*
variable "cert_manager_name" {
  description = "cert-manager name. Used for naming all kubernetes and helm resources on the cluster."
  type        = string
  default     = "ibm-cert-manager"
  nullable    = false
}

variable "cert_manager_namespace" {
  type        = string
  description = "Namespace where to deploy cert-manager. Default value is 'ibm-cert-manager'"
  default     = "ibm-cert-manager"
  nullable    = false
}

variable "licensing_name" {
  description = "licensing name. Used for naming all kubernetes and helm resources on the cluster."
  type        = string
  default     = "ibm-licensing"
  nullable    = false
}

variable "licensing_namespace" {
  type        = string
  description = "Namespace where to deploy licensing. Default value is 'ibm-licensing'"
  default     = "ibm-licensing"
  nullable    = false
}*/
