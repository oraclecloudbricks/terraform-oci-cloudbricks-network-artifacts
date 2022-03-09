# Copyright (c) 2021 Oracle and/or its affiliates.
# All rights reserved. The Universal Permissive License (UPL), Version 1.0 as shown at http://oss.oracle.com/licenses/upl
# drg.tf
#
# Purpose: The following script defines the Dynamic Routing Gateway (DRG) Artifact used in this project 
# Registry: https://registry.terraform.io/providers/hashicorp/oci/latest/docs/resources/core_drg
#           https://registry.terraform.io/providers/hashicorp/oci/latest/docs/resources/core_drg_attachment


resource "oci_core_drg" "DynamicRoutingGateway" {
  count          = var.drg_display_name != "" && !var.is_spoke ? 1 : 0
  compartment_id = local.nw_compartment_ocid

  display_name = var.drg_display_name
}

resource "oci_core_drg_attachment" "DynamicRoutingGatewayAttachment" {
  count      = var.drg_display_name != "" ? 1 : 0
  depends_on = [oci_core_drg.DynamicRoutingGateway]
  drg_id     = length(local.hub_drg) > 0 ? local.hub_drg[0].id : oci_core_drg.DynamicRoutingGateway[0].id

  network_details {
    id   = oci_core_vcn.VCN.id
    type = "VCN"
  }
}
