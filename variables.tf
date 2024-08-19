##############################################################################
# Cluster variables
##############################################################################

variable "cluster_id" {
  type        = string
  description = "The ID of the cluster you wish to deploy the agents in"
}

variable "cluster_resource_group_id" {
  type        = string
  description = "The Resource Group ID of the cluster"
}

variable "is_vpc_cluster" {
  description = "Specify true if the target cluster for the observability agents is a VPC cluster, false if it is a classic cluster."
  type        = bool
  default     = true
}
