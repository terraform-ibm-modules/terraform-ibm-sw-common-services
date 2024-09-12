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
  set {
    name  = "cert_manager_namespace"
    type  = "string"
    value = var.cert_manager_namespace
  }
  set {
    name  = "cert_manager_catalog"
    type  = "string"
    value = var.cert_manager_catalog
  }
  set {
    name  = "cert_manager_operator"
    type  = "string"
    value = var.cert_manager_operator
  }
  set {
    name  = "cert_manager_operator_group"
    type  = "string"
    value = var.cert_manager_operator_group
  }
  set {
    name  = "cert_manager_catalog_source_image"
    type  = "string"
    value = var.cert_manager_catalog_source_image
  }
  set {
    name  = "cert_manager_subscription_channel"
    type  = "string"
    value = var.cert_manager_subscription_channel
  }
  set {
    name  = "openshift_source"
    type  = "string"
    value = var.openshift_source
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
  set {
    name  = "licensing_namespace"
    type  = "string"
    value = var.licensing_namespace
  }
  set {
    name  = "licensing_catalog"
    type  = "string"
    value = var.licensing_catalog
  }
  set {
    name  = "licensing_operator"
    type  = "string"
    value = var.licensing_operator
  }
  set {
    name  = "licensing_operator_group"
    type  = "string"
    value = var.licensing_operator_group
  }
  set {
    name  = "licensing_catalog_source_image"
    type  = "string"
    value = var.licensing_catalog_source_image
  }
  set {
    name  = "licensing_subscription_channel"
    type  = "string"
    value = var.licensing_subscription_channel
  }
  set {
    name  = "openshift_source"
    type  = "string"
    value = var.openshift_source
  }
}
