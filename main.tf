/********************************************************************
This file is used to implement the ROOT module.
*********************************************************************/
data "ibm_container_cluster_config" "cluster_config" {
  cluster_name_id = var.cluster_name
  admin           = true
}
