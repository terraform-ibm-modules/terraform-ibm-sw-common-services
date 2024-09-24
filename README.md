<!-- Update this title with a descriptive name. Use sentence case. -->
# Terraform cert-manager and licensing deployments

<!--
Update status and "latest release" badges:
  1. For the status options, see https://terraform-ibm-modules.github.io/documentation/#/badge-status
  2. Update the "latest release" badge to point to the correct module's repo. Replace "terraform-ibm-module-template" in two places.
-->
[![Incubating (Not yet consumable)](https://img.shields.io/badge/status-Incubating%20(Not%20yet%20consumable)-red)](https://terraform-ibm-modules.github.io/documentation/#/badge-status)
[![latest release](https://img.shields.io/github/v/release/terraform-ibm-modules/terraform-ibm-sw-common-services?logo=GitHub&sort=semver)](https://github.com/terraform-ibm-modules/terraform-ibm-sw-common-services/releases/latest)
[![pre-commit](https://img.shields.io/badge/pre--commit-enabled-brightgreen?logo=pre-commit&logoColor=white)](https://github.com/pre-commit/pre-commit)
[![Renovate enabled](https://img.shields.io/badge/renovate-enabled-brightgreen.svg)](https://renovatebot.com/)
[![semantic-release](https://img.shields.io/badge/%20%20%F0%9F%93%A6%F0%9F%9A%80-semantic--release-e10079.svg)](https://github.com/semantic-release/semantic-release)

<!--
Add a description of modules in this repo.
Expand on the repo short description in the .github/settings.yml file.

For information, see "Module names and descriptions" at
https://terraform-ibm-modules.github.io/documentation/#/implementation-guidelines?id=module-names-and-descriptions
-->

This module deploys the `cert-manager` and `licensing` operators to a Kubernetes cluster


<!-- The following content is automatically populated by the pre-commit hook -->
<!-- BEGIN OVERVIEW HOOK -->
## Overview
* [terraform-ibm-sw-common-services](#terraform-ibm-sw-common-services)
* [Examples](./examples)
    * [Basic example of using cert-manager and licensing](./examples/basic)
* [Contributing](#contributing)
<!-- END OVERVIEW HOOK -->


<!--
If this repo contains any reference architectures, uncomment the heading below and link to them.
(Usually in the `/reference-architectures` directory.)
See "Reference architecture" in the public documentation at
https://terraform-ibm-modules.github.io/documentation/#/implementation-guidelines?id=reference-architecture
-->
<!-- ## Reference architectures -->


<!-- Replace this heading with the name of the root level module (the repo name) -->
## terraform-ibm-sw-common-services

### Usage

<!--
Add an example of the use of the module in the following code block.

Use real values instead of "var.<var_name>" or other placeholder values
unless real values don't help users know what to change.
-->

```hcl
# ############################################################################
# Init cluster config for helm
# ############################################################################

data "ibm_container_cluster_config" "cluster_config" {
  # Update this value with the ID or name of the cluster where the operators will be deployed
  cluster_name_id = "cluster_id"
}

# ############################################################################
# Config providers
# ############################################################################

provider "ibm" {
  # Update this value with your IBM Cloud API key value
  ibmcloud_api_key = "api key value"  # pragma: allowlist secret
  # Update this value with the region that your cluster is deployed
  region           = "us-south"
}

provider "helm" {
  kubernetes {
    host  = data.ibm_container_cluster_config.cluster_config.host
    token = data.ibm_container_cluster_config.cluster_config.token
    cluster_ca_certificate = data.ibm_container_cluster_config.cluster_config.ca_certificate
  }
}

provider "kubernetes" {
  host  = data.ibm_container_cluster_config.cluster_config.host
  token = data.ibm_container_cluster_config.cluster_config.token
  cluster_ca_certificate = data.ibm_container_cluster_config.cluster_config.ca_certificate
}

# ############################################################################
# Install cert-manager and licensing operators
# ############################################################################

module "ibm_common_services_prereq" {
  source                           = "terraform-ibm-modules/sw-common-services/ibm"
  cluster_id                       = "cluster id" # Update this with the ID of the cluster where the operators will be deployed
  cluster_resource_group_id        = "resource group id" # Update this with the ID of your IBM Cloud resource group
}
```

### Required IAM access policies
You need the following permissions to run this module.

- IAM Services
  - **Kubernetes** service
      - `Viewer` platform access
      - `Manager` service access

<!-- PERMISSIONS REQUIRED TO RUN MODULE
If this module requires permissions, uncomment the following block and update
the sample permissions, following the format.
Replace the sample Account and IBM Cloud service names and roles with the
information in the console at
Manage > Access (IAM) > Access groups > Access policies.
-->

<!--
You need the following permissions to run this module:

- IAM services
    - **Sample IBM Cloud** service
        - `Editor` platform access
        - `Manager` platform access
- Account management services
    - **Sample account management** service
        - `Editor` platform access
-->

<!-- NO PERMISSIONS FOR MODULE
If no permissions are required for the module, uncomment the following
statement instead the previous block.
-->

<!-- No permissions are needed to run this module.-->


<!-- The following content is automatically populated by the pre-commit hook -->
<!-- BEGINNING OF PRE-COMMIT-TERRAFORM DOCS HOOK -->
### Requirements

| Name | Version |
|------|---------|
| <a name="requirement_terraform"></a> [terraform](#requirement\_terraform) | >= 1.3.0 |
| <a name="requirement_helm"></a> [helm](#requirement\_helm) | >= 2.13.1, < 3.0.0 |
| <a name="requirement_ibm"></a> [ibm](#requirement\_ibm) | >= 1.64.0, < 2.0.0 |

### Modules

No modules.

### Resources

| Name | Type |
|------|------|
| [helm_release.ibm_cert_manager](https://registry.terraform.io/providers/hashicorp/helm/latest/docs/resources/release) | resource |
| [helm_release.ibm_licensing](https://registry.terraform.io/providers/hashicorp/helm/latest/docs/resources/release) | resource |
| [ibm_container_cluster.cluster](https://registry.terraform.io/providers/IBM-Cloud/ibm/latest/docs/data-sources/container_cluster) | data source |
| [ibm_container_vpc_cluster.cluster](https://registry.terraform.io/providers/IBM-Cloud/ibm/latest/docs/data-sources/container_vpc_cluster) | data source |

### Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_cert_manager_catalog"></a> [cert\_manager\_catalog](#input\_cert\_manager\_catalog) | The catalog name for cert manager | `string` | `"ibm-cert-manager-catalog"` | no |
| <a name="input_cert_manager_catalog_source_image"></a> [cert\_manager\_catalog\_source\_image](#input\_cert\_manager\_catalog\_source\_image) | The catalog source image for cert manager | `string` | `"icr.io/cpopen/ibm-cert-manager-operator-catalog"` | no |
| <a name="input_cert_manager_namespace"></a> [cert\_manager\_namespace](#input\_cert\_manager\_namespace) | The namespace for cert manager | `string` | `"ibm-cert-manager"` | no |
| <a name="input_cert_manager_operator"></a> [cert\_manager\_operator](#input\_cert\_manager\_operator) | The operator name for cert manager | `string` | `"ibm-cert-manager-operator"` | no |
| <a name="input_cert_manager_operator_group"></a> [cert\_manager\_operator\_group](#input\_cert\_manager\_operator\_group) | The operator group for cert manager | `string` | `"cert-manager-operatorgroup"` | no |
| <a name="input_cert_manager_subscription_channel"></a> [cert\_manager\_subscription\_channel](#input\_cert\_manager\_subscription\_channel) | The subscription channel for cert manager | `string` | `"v4.2"` | no |
| <a name="input_cluster_id"></a> [cluster\_id](#input\_cluster\_id) | The ID of the cluster you wish to deploy the agents in | `string` | n/a | yes |
| <a name="input_cluster_resource_group_id"></a> [cluster\_resource\_group\_id](#input\_cluster\_resource\_group\_id) | The Resource Group ID of the cluster | `string` | n/a | yes |
| <a name="input_is_vpc_cluster"></a> [is\_vpc\_cluster](#input\_is\_vpc\_cluster) | Specify true if the target cluster for the observability agents is a VPC cluster, false if it is a classic cluster. | `bool` | `true` | no |
| <a name="input_licensing_catalog"></a> [licensing\_catalog](#input\_licensing\_catalog) | The catalog name for licensing | `string` | `"ibm-licensing-catalog"` | no |
| <a name="input_licensing_catalog_source_image"></a> [licensing\_catalog\_source\_image](#input\_licensing\_catalog\_source\_image) | The catalog source image for licensing | `string` | `"icr.io/cpopen/ibm-licensing-catalog"` | no |
| <a name="input_licensing_namespace"></a> [licensing\_namespace](#input\_licensing\_namespace) | The namespace for licensing | `string` | `"ibm-licensing"` | no |
| <a name="input_licensing_operator"></a> [licensing\_operator](#input\_licensing\_operator) | The operator name for licensing | `string` | `"ibm-licensing-operator-app"` | no |
| <a name="input_licensing_operator_group"></a> [licensing\_operator\_group](#input\_licensing\_operator\_group) | The operator group for licensing | `string` | `"licensing-operatorgroup"` | no |
| <a name="input_licensing_subscription_channel"></a> [licensing\_subscription\_channel](#input\_licensing\_subscription\_channel) | The subscription channel for licensing | `string` | `"v4.2"` | no |
| <a name="input_openshift_source"></a> [openshift\_source](#input\_openshift\_source) | The openshift source for the subscriptions | `string` | `"openshift-marketplace"` | no |

### Outputs

No outputs.
<!-- END OF PRE-COMMIT-TERRAFORM DOCS HOOK -->

<!-- Leave this section as is so that your module has a link to local development environment set-up steps for contributors to follow -->
## Contributing

You can report issues and request features for this module in GitHub issues in the module repo. See [Report an issue or request a feature](https://github.com/terraform-ibm-modules/.github/blob/main/.github/SUPPORT.md).

To set up your local development environment, see [Local development setup](https://terraform-ibm-modules.github.io/documentation/#/local-dev-setup) in the project documentation.
