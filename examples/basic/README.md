# Basic example of using cert-manager and licensing

<!-- BEGIN SCHEMATICS DEPLOY HOOK -->
<a href="https://cloud.ibm.com/schematics/workspaces/create?workspace_name=sw-common-services-basic-example&repository=https://github.com/terraform-ibm-modules/terraform-ibm-sw-common-services/tree/main/examples/basic"><img src="https://img.shields.io/badge/Deploy%20with IBM%20Cloud%20Schematics-0f62fe?logo=ibm&logoColor=white&labelColor=0f62fe" alt="Deploy with IBM Cloud Schematics" style="height: 16px; vertical-align: text-bottom;"></a>
<!-- END SCHEMATICS DEPLOY HOOK -->


When applying, all cluster variables must be set either in the `variables.tf` file or in the command line so that the cluster can be properly accessed

Command line example:
`TF_VAR_ibmcloud_api_key=$ibmcloud_api_key terraform apply`

<!-- BEGIN SCHEMATICS DEPLOY TIP HOOK -->
:information_source: Ctrl/Cmd+Click or right-click on the Schematics deploy button to open in a new tab
<!-- END SCHEMATICS DEPLOY TIP HOOK -->
