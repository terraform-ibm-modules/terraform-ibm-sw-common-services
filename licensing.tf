resource "kubernetes_namespace" "ibm_licensing_service_namespace" {
  metadata {
    name = var.licensing_namespace
  }
}

resource "kubernetes_manifest" "ibm_licensing_service_operator_group" {
  manifest = {
    "apiVersion" = "operators.coreos.com/v1"
    "kind"       = "OperatorGroup"
    "metadata" = {
      "name"      = "licensing-operatorgroup"
      "namespace" = var.licensing_namespace
    }
    "spec" = {
      "targetNamespaces" = [
        var.licensing_namespace,
      ]
    }
  }
}

resource "kubernetes_manifest" "ibm_licensing_service_subscription" {
  manifest = {
    "apiVersion" = "operators.coreos.com/v1alpha1"
    "kind"       = "Subscription"
    "metadata" = {
      "name"      = "ibm-licensing-operator-app"
      "namespace" = var.licensing_namespace
    }
    "spec" = {
      "channel"             = var.licensing_subscription_channel
      "installPlanApproval" = "Automatic"
      "name"                = "ibm-licensing-operator-app"
      "source"              = "ibm-licensing-catalog"
      "sourceNamespace"     = "openshift-marketplace"
    }
  }
  wait {
    fields = {
      "status.catalogHealth[0].healthy" = "true"
    }
  }
}

resource "kubernetes_manifest" "ibm_licensing_service_catalog_source" {
  manifest = {
    "apiVersion" = "operators.coreos.com/v1alpha1"
    "kind"       = "CatalogSource"
    "metadata" = {
      "name"      = "ibm-licensing-catalog"
      "namespace" = "openshift-marketplace"
    }
    "spec" = {
      "displayName" = "IBM License Service Catalog"
      "publisher"   = "IBM"
      "sourceType"  = "grpc"
      "image"       = var.licensing_catalog_source_image
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
