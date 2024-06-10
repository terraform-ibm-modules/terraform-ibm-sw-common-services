variable "licensing_subscription_channel" {
  type        = string
  default     = "v4.1"
  description = "Channel of the licensing service subscription"
}

variable "licensing_catalog_source_image" {
  type        = string
  default     = "icr.io/cpopen/ibm-licensing-catalog"
  description = "Source image for the catalog source"
}

variable "licensing_namespace" {
  type        = string
  default     = "ibm-licensing"
  description = "Name for the licensing namespace"
}

variable "cert_manager_subscription_channel" {
  type        = string
  default     = "v4.2"
  description = "Channel of the licensing service subscription"
}

variable "cert_manager_catalog_source_image" {
  type        = string
  default     = "icr.io/cpopen/ibm-cert-manager-operator-catalog"
  description = "Source image for the catalog source"
}

variable "cert_manager_namespace" {
  type        = string
  default     = "ibm-cert-manager"
  description = "Name for the cert manager namespace"
}

####################
# Optional variables
####################
variable "enable_ibm_cert_manager" {
  type        = bool
  default     = false
  description = "Option to deploy cert-manager when running terraform"
}

variable "enable_ibm_licensing" {
  type        = bool
  default     = false
  description = "Option to deploy licensing when running terraform"
}
