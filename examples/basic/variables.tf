####################
# Cluster variables
####################

variable "ibmcloud_api_key" {
  type        = string
  description = "IBM Cloud API key"
  sensitive   = true
}

variable "region" {
  type        = string
  description = "IBM Cloud region where all resources will be deployed"
  default     = "us-south"
}

variable "prefix" {
  type        = string
  description = "Prefix to append to all resources created by this example"
  default     = "basic"
}

variable "resource_group" {
  type        = string
  description = "An existing resource group name to use for this example, if unset a new resource group will be created"
  default     = null
}

variable "is_openshift" {
  type        = bool
  description = "Defines whether this is an OpenShift or Kubernetes cluster"
  default     = true
}

variable "resource_tags" {
  type        = list(string)
  description = "Optional list of tags to be added to created resources"
  default     = []
}

####################
# Optional variables
####################
