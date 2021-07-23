/* vcn.tf 
Author: DALQUINT - denny.alquinta@oracle.com
Purpose: The following script defines the VCN Artifact used in this project
Registry: https://registry.terraform.io/providers/hashicorp/oci/latest/docs/resources/core_vcn 
Copyright (c) 2021, Oracle and/or its affiliates. All rights reserved. 
*/


resource "oci_core_vcn" "VCN" {

  compartment_id = local.nw_compartment_ocid
  cidr_blocks    = var.vcn_cidr_blocks
  display_name   = var.vcn_display_name
  dns_label      = substr(replace(tostring(var.vcn_display_name), "_", ""), 0, 15)

  lifecycle {
    ignore_changes = [defined_tags["Oracle-Tags.CreatedBy"], defined_tags["Oracle-Tags.CreatedOn"]]
  }
  defined_tags = {
    "${oci_identity_tag_namespace.devrel.name}.${oci_identity_tag.release.name}" = local.release
  }
}