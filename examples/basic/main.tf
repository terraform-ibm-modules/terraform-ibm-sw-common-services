########################################################################################################################
# Resource group
########################################################################################################################

module "resource_group" {
  source  = "terraform-ibm-modules/resource-group/ibm"
  version = "1.1.5"
  # if an existing resource group is not set (null) create a new one using prefix
  resource_group_name          = var.resource_group == null ? "${var.prefix}-resource-group" : null
  existing_resource_group_name = var.resource_group
}

########################################################################################################################
# Cert-Manager deployment
########################################################################################################################
/*data "ibm_container_cluster_config" "cluster_config" {
  cluster_name_id = var.cluster_id
  admin           = false
}*/

module "ibm_common_services_prereq" {
  source = "../.."

  enable_ibm_cert_manager = true
  enable_ibm_licensing    = true
  ##cluster_id              = var.cluster_id
  ##ibmcloud_api_key        = var.ibmcloud_api_key
  ##ibmcloud_region         = var.ibmcloud_region
}

##############################################################################
# Create VPC and Cluster
##############################################################################

resource "ibm_is_vpc" "example_vpc" {
  name           = "${var.prefix}-vpc"
  resource_group = module.resource_group.resource_group_id
  tags           = var.resource_tags
}

resource "ibm_is_public_gateway" "public_gateway" {
  name           = "${var.prefix}-gateway-1"
  vpc            = ibm_is_vpc.example_vpc.id
  resource_group = module.resource_group.resource_group_id
  zone           = "${var.region}-1"
}

resource "ibm_is_subnet" "testacc_subnet" {
  name                     = "${var.prefix}-subnet"
  vpc                      = ibm_is_vpc.example_vpc.id
  zone                     = "${var.region}-1"
  total_ipv4_address_count = 256
  resource_group           = module.resource_group.resource_group_id
  public_gateway           = ibm_is_public_gateway.public_gateway.id
}

resource "ibm_resource_instance" "cos_instance" {
  count             = var.is_openshift ? 1 : 0
  name              = "${var.prefix}-cos"
  service           = "cloud-object-storage"
  plan              = "standard"
  location          = "global"
  resource_group_id = module.resource_group.resource_group_id
  tags              = var.resource_tags
}

# Lookup the current default kube version
data "ibm_container_cluster_versions" "cluster_versions" {}
locals {
  default_version = var.is_openshift ? "${data.ibm_container_cluster_versions.cluster_versions.default_openshift_version}_openshift" : data.ibm_container_cluster_versions.cluster_versions.default_kube_version
}

resource "ibm_container_vpc_cluster" "cluster" {
  name                 = var.prefix
  vpc_id               = ibm_is_vpc.example_vpc.id
  kube_version         = local.default_version
  flavor               = "bx2.4x16"
  worker_count         = "2"
  entitlement          = var.is_openshift ? "cloud_pak" : null
  cos_instance_crn     = var.is_openshift ? ibm_resource_instance.cos_instance[0].id : null
  force_delete_storage = true
  wait_till            = "Normal"
  zones {
    subnet_id = ibm_is_subnet.testacc_subnet.id
    name      = "${var.region}-1"
  }
  resource_group_id = module.resource_group.resource_group_id
  tags              = var.resource_tags

  timeouts {
    delete = "2h"
    create = "3h"
  }
}

data "ibm_container_cluster_config" "cluster_config" {
  cluster_name_id   = ibm_container_vpc_cluster.cluster.id
  resource_group_id = module.resource_group.resource_group_id
}

# Sleep to allow RBAC sync on cluster
resource "time_sleep" "wait_operators" {
  depends_on      = [data.ibm_container_cluster_config.cluster_config]
  create_duration = "5s"
}

