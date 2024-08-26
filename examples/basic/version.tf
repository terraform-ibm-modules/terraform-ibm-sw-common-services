terraform {
  required_version = ">= 1.3.0"
  required_providers {
    ibm = {
      source  = "IBM-Cloud/ibm"
      version = ">= 1.64.0"
    }
    helm = {
      source  = "hashicorp/helm"
      version = ">= 2.13.1"
    }
    kubernetes = {
      source  = "hashicorp/kubernetes"
      version = ">= 2.8.0"
    }
    time = {
      source  = "hashicorp/time"
      version = ">= 0.9.1"
    }
  }
}
