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

# Download cluster config which is required to connect to cluster
/*
data "ibm_container_cluster_config" "cluster_config" {
  cluster_name_id   = var.cluster_id
  resource_group_id = var.cluster_resource_group_id
  config_dir        = "${path.module}/kubeconfig"
  endpoint_type     = var.cluster_config_endpoint_type != "default" ? var.cluster_config_endpoint_type : null # null value represents default
}*/

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
  /*
  provisioner "local-exec" {
    command     = "${path.module}/scripts/confirm-rollout-status.sh ${var.cert_manager_name} ${var.cert_manager_namespace}"
    interpreter = ["/bin/bash", "-c"]
    environment = {
      KUBECONFIG = data.ibm_container_cluster_config.cluster_config.config_file_path
    }
  }*/
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
  /*
  provisioner "local-exec" {
    command     = "${path.module}/scripts/confirm-rollout-status.sh ${var.licensing_name} ${var.licensing_namespace}"
    interpreter = ["/bin/bash", "-c"]
    environment = {
      KUBECONFIG = data.ibm_container_cluster_config.cluster_config.config_file_path
    }
  }*/
}
