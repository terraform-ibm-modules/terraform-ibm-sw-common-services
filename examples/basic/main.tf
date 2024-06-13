########################################################################################################################
# Cert-Manager deployment
########################################################################################################################
data "ibm_container_cluster_config" "cluster_config" {
  cluster_name_id = var.cluster_id
  admin           = false
}

module "ibm_common_services_prereq" {
  source = "../.."

  enable_ibm_cert_manager = var.enable_ibm_cert_manager
  enable_ibm_licensing    = var.enable_ibm_licensing
  cluster_id              = var.cluster_id
  ibmcloud_api_key        = var.ibmcloud_api_key
  ibmcloud_region         = var.ibmcloud_region
}
