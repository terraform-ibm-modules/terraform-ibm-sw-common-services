/********************************************************************
This file is used to implement the ROOT module.
*********************************************************************/

data "ibm_container_vpc_cluster" "cluster" {
  count             = var.is_vpc_cluster ? 1 : 0
  name              = var.cluster_id
  resource_group_id = var.cluster_resource_group_id
}

data "ibm_container_cluster" "cluster" {
  count             = var.is_vpc_cluster ? 0 : 1
  name              = var.cluster_id
  resource_group_id = var.cluster_resource_group_id
}

locals {
  cluster_name = var.is_vpc_cluster ? data.ibm_container_vpc_cluster.cluster[0].resource_name : data.ibm_container_cluster.cluster[0].resource_name
}

resource "helm_release" "ibm_cert_manager" {
  name          = "ibm-cert-manager"
  chart         = "${path.module}/chart/deploy-cert-manager"
  wait          = true
  wait_for_jobs = true

  set {
    name  = "config.clustername"
    type  = "string"
    value = local.cluster_name
  }
}

resource "helm_release" "ibm_licensing" {
  name          = "ibm-licensing"
  chart         = "${path.module}/chart/deploy-licensing"
  wait          = true
  wait_for_jobs = true

  set {
    name  = "config.clustername"
    type  = "string"
    value = local.cluster_name
  }
}
