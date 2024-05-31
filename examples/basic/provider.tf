########################################################################################################################
# Provider config
########################################################################################################################

provider "kubernetes" {
  host               = data.ibm_container_cluster_config.cluster_config.host
  client_certificate = data.ibm_container_cluster_config.cluster_config.admin_certificate
  client_key         = data.ibm_container_cluster_config.cluster_config.admin_key
}

provider "ibm" {
  ibmcloud_api_key = var.ibmcloud_api_key
  region           = var.ibmcloud_region
}
