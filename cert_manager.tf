resource "kubernetes_namespace" "ibm_cert_manager_namespace" {
  count = var.enable_ibm_cert_manager ? 1 : 0
  metadata {
    name = var.cert_manager_namespace
  }
}

resource "kubernetes_manifest" "ibm_cert_manager_operator_group" {
  count = var.enable_ibm_cert_manager ? 1 : 0
  manifest = {
    "apiVersion" = "operators.coreos.com/v1alpha2"
    "kind"       = "OperatorGroup"
    "metadata" = {
      "name"      = "cert-manager-operatorgroup"
      "namespace" = var.cert_manager_namespace
    }
  }
}

resource "kubernetes_manifest" "ibm_cert_manager_subscription" {
  count = var.enable_ibm_cert_manager ? 1 : 0
  manifest = {
    "apiVersion" = "operators.coreos.com/v1alpha1"
    "kind"       = "Subscription"
    "metadata" = {
      "name"      = "ibm-cert-manager-operator"
      "namespace" = var.cert_manager_namespace
    }
    "spec" = {
      "channel"             = var.cert_manager_subscription_channel
      "installPlanApproval" = "Automatic"
      "name"                = "ibm-cert-manager-operator"
      "source"              = "ibm-cert-manager-catalog"
      "sourceNamespace"     = "openshift-marketplace"
    }
  }
  wait {
    fields = {
      "status.catalogHealth[0].healthy" = "true"
    }
  }
}

resource "kubernetes_manifest" "ibm_cert_manager_catalog_source" {
  count = var.enable_ibm_cert_manager ? 1 : 0
  manifest = {
    "apiVersion" = "operators.coreos.com/v1alpha1"
    "kind"       = "CatalogSource"
    "metadata" = {
      "name"      = "ibm-cert-manager-catalog"
      "namespace" = "openshift-marketplace"
    }
    "spec" = {
      "displayName" = "ibm-cert-manager-4.2.3"
      "publisher"   = "IBM"
      "sourceType"  = "grpc"
      "image"       = var.cert_manager_catalog_source_image
      "updateStrategy" = {
        "registryPoll" = {
          "interval" = "45m"
        }
      }
    }
  }
  wait {
    fields = {
      "status.connectionState.lastObservedState" = "READY"
    }
  }
}
