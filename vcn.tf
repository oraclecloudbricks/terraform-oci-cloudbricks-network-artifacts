# Copyright (c) 2021 Oracle and/or its affiliates.
# All rights reserved. The Universal Permissive License (UPL), Version 1.0 as shown at http://oss.oracle.com/licenses/upl
# vcn.tf
#
# Purpose: The following script defines the VCN Artifact used in this project
# Registry: https://registry.terraform.io/providers/hashicorp/oci/latest/docs/resources/core_vcn 

resource "oci_core_vcn" "VCN" {
  compartment_id = local.nw_compartment_ocid
  # Remove spacing and split into a list when passed by ORM
  cidr_blocks    = var.is_orm ? split(",", replace(var.vcn_cidr_blocks, "/\\s+/", "")) : tolist(var.vcn_cidr_blocks)
  display_name   = var.vcn_display_name
  dns_label      = substr(replace(tostring(var.vcn_display_name), "_", ""), 0, 15)
}
