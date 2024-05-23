########################################################################################################################
# Provider config
########################################################################################################################

provider "kubernetes" {
  host               = var.host
  client_certificate = base64decode(var.client_certificate)
  client_key         = base64decode(var.client_key)
}

provider "ibm" {
  ibmcloud_api_key = var.ibmcloud_api_key
  region           = var.ibmcloud_region
}
