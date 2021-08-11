# Copyright (c) 2021 Oracle and/or its affiliates.
# All rights reserved. The Universal Permissive License (UPL), Version 1.0 as shown at http://oss.oracle.com/licenses/upl
# subnets.tf
#
# Purpose:The following script defines the Subnets Artifact used in this project along with Route Table Attachments
# Registry: https://registry.terraform.io/providers/hashicorp/oci/latest/docs/resources/core_subnet


resource "oci_core_subnet" "PrivateSubnet" {
  for_each       = var.private_subnet_cidr_block_map
  cidr_block     = each.value
  compartment_id = local.nw_compartment_ocid
  vcn_id         = oci_core_vcn.VCN.id

  dhcp_options_id            = oci_core_dhcp_options.DHCPOptions.id
  display_name               = each.key
  route_table_id             = oci_core_route_table.PrivateRouteTable.id
  security_list_ids          = [oci_core_security_list.PrivateSecurityList.id]
  prohibit_public_ip_on_vnic = var.is_private_subnet_private
  dns_label                  = substr(replace(tostring(each.key), "_", ""), 0, 15)

}


resource "oci_core_subnet" "PublicSubnet" {
  for_each       = var.public_subnet_cidr_block_map
  cidr_block     = each.value
  compartment_id = local.nw_compartment_ocid
  vcn_id         = oci_core_vcn.VCN.id

  dhcp_options_id            = oci_core_dhcp_options.DHCPOptions.id
  display_name               = each.key
  route_table_id             = oci_core_route_table.PublicRouteTable.id
  security_list_ids          = [oci_core_security_list.PublicSecurityList.id]
  prohibit_public_ip_on_vnic = var.is_public_subnet_private
  dns_label                  = substr(replace(tostring(each.key), "_", ""), 0, 15)

  lifecycle {
    ignore_changes = [defined_tags["Oracle-Tags.CreatedBy"], defined_tags["Oracle-Tags.CreatedOn"]]
  }
  defined_tags = {
    "${oci_identity_tag_namespace.devrel.name}.${oci_identity_tag.release.name}" = local.release
  }
}