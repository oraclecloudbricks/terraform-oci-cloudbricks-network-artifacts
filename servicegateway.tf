# Copyright (c) 2021 Oracle and/or its affiliates.
# All rights reserved. The Universal Permissive License (UPL), Version 1.0 as shown at http://oss.oracle.com/licenses/upl
# servicegateway.tf
#
# Purpose: The following script defines the Service Gateway used in this project
# Registry: https://registry.terraform.io/providers/hashicorp/oci/latest/docs/resources/core_service_gateway


resource "oci_core_service_gateway" "PrivateServiceGateway" {
  compartment_id = local.nw_compartment_ocid
  services {
    service_id = local.all_service_list_ocid
  }
  vcn_id       = oci_core_vcn.VCN.id
  display_name = var.service_gateway_display_name
}
