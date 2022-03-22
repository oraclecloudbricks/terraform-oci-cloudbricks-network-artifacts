# Copyright (c) 2021 Oracle and/or its affiliates.
# All rights reserved. The Universal Permissive License (UPL), Version 1.0 as shown at http://oss.oracle.com/licenses/upl
# routetables.tf
#
# Purpose: The following script defines the route tables used in this project
# Registry: https://registry.terraform.io/providers/hashicorp/oci/latest/docs/resources/core_route_table


resource "oci_core_route_table" "PrivateRouteTable" {
  compartment_id = local.nw_compartment_ocid
  vcn_id         = oci_core_vcn.VCN.id
  display_name   = var.private_route_table_display_name
  route_rules {
    network_entity_id = oci_core_nat_gateway.NATGateway.id
    description       = var.private_route_table_nat_route_rules_description
    destination       = var.private_route_table_nat_route_rules_destination
    destination_type  = var.private_route_table_nat_route_rules_destination_type
  }

  route_rules {
    network_entity_id = oci_core_service_gateway.PrivateServiceGateway.id
    description       = var.private_route_table_svc_route_rules_description
    destination       = local.all_service_gateway_destination
    destination_type  = var.private_route_table_svc_route_rules_destination_type
  }

  dynamic "route_rules" {
    for_each = local.hub_vcn_cidr_blocks
    content {
      network_entity_id = local.hub_drg[0].id
      destination       = route_rules.value
    }
  }

  dynamic "route_rules" {
    for_each = var.is_spoke ? [] : (var.is_orm ? split(",", replace(var.peered_vcn_cidr_blocks, "/\\s+/", "")) : tolist(var.peered_vcn_cidr_blocks))
    content {
      network_entity_id = oci_core_drg.DynamicRoutingGateway[0].id
      destination       = route_rules.value
    }
  }
}

resource "oci_core_route_table" "PublicRouteTable" {
  compartment_id = local.nw_compartment_ocid
  vcn_id         = oci_core_vcn.VCN.id
  display_name   = var.public_route_table_display_name

  route_rules {
    network_entity_id = oci_core_internet_gateway.INETGateway.id
    description       = var.public_route_table_inet_route_rules_description
    destination       = var.public_route_table_inet_route_rules_destination
    destination_type  = var.public_route_table_inet_route_rules_destination_type
  }

  route_rules {
    network_entity_id = oci_core_service_gateway.PrivateServiceGateway.id
    description       = var.public_route_table_svc_route_rules_description
    destination       = local.storage_service_gateway_destination
    destination_type  = var.public_route_table_svc_route_rules_destination_type
  }

  dynamic "route_rules" {
    for_each = local.hub_vcn_cidr_blocks
    content {
      network_entity_id = local.hub_drg[0].id
      destination       = route_rules.value
    }
  }

  dynamic "route_rules" {
    for_each = var.is_spoke ? [] : (var.is_orm ? split(",", replace(var.peered_vcn_cidr_blocks, "/\\s+/", "")) : tolist(var.peered_vcn_cidr_blocks))
    content {
      network_entity_id = oci_core_drg.DynamicRoutingGateway[0].id
      destination       = route_rules.value
    }
  }
}
