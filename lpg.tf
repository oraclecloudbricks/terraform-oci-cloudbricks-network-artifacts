# Copyright (c) 2021 Oracle and/or its affiliates.
# All rights reserved. The Universal Permissive License (UPL), Version 1.0 as shown at http://oss.oracle.com/licenses/upl
# lpg.tf
#
# Purpose: The following script defines the Local Peering Gateways used in this project
# Registry: https://registry.terraform.io/providers/hashicorp/oci/latest/docs/resources/core_local_peering_gateway


resource "oci_core_local_peering_gateway" "LocalPeeringGateway" {
  count          = var.lpg_count
  compartment_id = local.nw_compartment_ocid
  vcn_id         = oci_core_vcn.VCN.id
  display_name   = count.index < "10" ? "${var.lpg_display_name_base}${var.label_zs[0]}${count.index + 1}" : "${var.lpg_display_name_base}${var.label_zs[1]}${count.index + 1}"
  peer_id        = local.peered_lpg_ocid

  lifecycle {
    ignore_changes = [defined_tags["Oracle-Tags.CreatedBy"], defined_tags["Oracle-Tags.CreatedOn"]]
  }
  defined_tags = {
    "${oci_identity_tag_namespace.devrel.name}.${oci_identity_tag.release.name}" = local.release
  }
}