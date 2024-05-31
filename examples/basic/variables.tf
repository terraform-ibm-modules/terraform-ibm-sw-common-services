####################
# Cluster variables
####################
variable "cluster_name" {
  type        = string
  description = "The name or ID of the cluster to be used"
  default     = "my-cluster-name"
}

variable "ibmcloud_api_key" {
  type        = string
  description = "IBM Cloud API key"
}

variable "ibmcloud_region" {
  type        = string
  description = "IBM Cloud region where all resources will be deployed"
  default     = "us-south"
}

####################
# Optional variables
####################
variable "enable_ibm_cert_manager" {
  type        = bool
  default     = true
  description = "Option to deploy cert-manager when running terraform"
}

variable "enable_ibm_licensing" {
  type        = bool
  default     = true
  description = "Option to deploy licensing when running terraform"
}
