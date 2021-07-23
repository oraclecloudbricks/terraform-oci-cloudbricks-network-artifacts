# Copyright (c) 2021 Oracle and/or its affiliates.
# All rights reserved. The Universal Permissive License (UPL), Version 1.0 as shown at http://oss.oracle.com/licenses/upl
# dhcpopt.tf
#
# Purpose: The following script defines the DHCP Options
# Registry: https://registry.terraform.io/providers/hashicorp/oci/latest/docs/resources/core_dhcp_options




resource "oci_core_dhcp_options" "DHCPOptions" {
  compartment_id = local.nw_compartment_ocid
  options {
    type        = "DomainNameServer"
    server_type = "VcnLocalPlusInternet"
  }
  options {
    type                = "SearchDomain"
    search_domain_names = [var.custom_search_domain]
  }
  vcn_id       = oci_core_vcn.VCN.id
  display_name = var.dhcp_options_display_name

  lifecycle {
    ignore_changes = [defined_tags["Oracle-Tags.CreatedBy"], defined_tags["Oracle-Tags.CreatedOn"]]
  }
  defined_tags = {
    "${oci_identity_tag_namespace.devrel.name}.${oci_identity_tag.release.name}" = local.release
  }
}