# Copyright (c) 2021 Oracle and/or its affiliates.
# All rights reserved. The Universal Permissive License (UPL), Version 1.0 as shown at http://oss.oracle.com/licenses/upl
# datasource.tf
#
# Purpose: The following script defines the lookup logic used in code to obtain pre-created resources in tenancy.


/********** Compartment and CF Accessors **********/
data "oci_identity_compartments" "NWCOMPARTMENTS" {
  compartment_id            = var.tenancy_ocid
  compartment_id_in_subtree = true
  filter {
    name   = "name"
    values = [var.vcn_network_compartment_name]
  }
}

data "oci_identity_compartments" "PEEREDNWCOMPARTMENTS" {
  compartment_id            = var.tenancy_ocid
  compartment_id_in_subtree = true
  filter {
    name   = "name"
    values = [var.hub_vcn_compartment_name]
  }
}

data "oci_core_services" "ALLSERVICES" {
  filter {
    name   = "name"
    values = ["All .* Services In Oracle Services Network"]
    regex  = true
  }
}

data "oci_core_services" "STORAGESERVICES" {
  filter {
    name   = "name"
    values = ["OCI *"]
    regex  = true
  }
}

data "oci_core_vcns" "PEEREDVCN" {
  compartment_id = var.is_spoke == true ? local.peered_nw_compartment_ocid : local.nw_compartment_ocid
  filter {
    name   = "display_name"
    values = [var.hub_vcn_display_name]
  }
}

data "oci_core_drgs" "DRG" {
  count          = var.is_spoke == true ? 1 : 0
  compartment_id = local.peered_nw_compartment_ocid
  filter {
    name   = "display_name"
    values = [var.drg_display_name]
  }
}


locals {
  # Compartment OCID Local Accessor
  nw_compartment_ocid        = var.is_orm ? var.vcn_network_compartment_name : (length(data.oci_identity_compartments.NWCOMPARTMENTS.compartments) > 0 ? data.oci_identity_compartments.NWCOMPARTMENTS.compartments[0].id : "")
  peered_nw_compartment_ocid = var.is_orm ? var.hub_vcn_compartment_name : (length(data.oci_identity_compartments.PEEREDNWCOMPARTMENTS.compartments) > 0 ? data.oci_identity_compartments.PEEREDNWCOMPARTMENTS.compartments[0].id : "")

  # Service Gateway OCID Local Accessor
  all_service_list_ocid               = data.oci_core_services.ALLSERVICES.services.0.id
  storage_service_list_ocid           = data.oci_core_services.STORAGESERVICES.services.0.id
  all_service_gateway_destination     = data.oci_core_services.ALLSERVICES.services[0]["cidr_block"]
  storage_service_gateway_destination = data.oci_core_services.STORAGESERVICES.services[0]["cidr_block"]

  # DRG Accessors
  hub_drg             = length(data.oci_core_drgs.DRG) > 0 ? data.oci_core_drgs.DRG[0].drgs : []
  hub_vcn_cidr_blocks = length(data.oci_core_vcns.PEEREDVCN.virtual_networks) > 0 ? lookup(data.oci_core_vcns.PEEREDVCN.virtual_networks[0], "cidr_blocks") : []

  # Subnet Map Accessors
  # private_subnet_map = var.is_orm ? tomap("{${var.private_subnet_cidr_block_map}}") : var.private_subnet_cidr_block_map
  # public_subnet_map  = var.is_orm ? tomap("{${var.public_subnet_cidr_block_map}}") : var.public_subnet_cidr_block_map

  #hub01_pvtsn01 = 10.0.0.0/23, hub01_pvtsn02 = 10.0.2.0/23, hub01_pvtsn03 = 10.0.4.0/23

  private_subnet_map = var.is_orm ? ({for item in [for item in split(",", trimspace(var.private_subnet_cidr_block_map)) :{name = trimspace(split("=", item)[0]),cidr = trimspace(split("=", item)[1])}] : item.name => item.cidr}) : var.private_subnet_cidr_block_map
  public_subnet_map = var.is_orm ? ({for item in [for item in split(",", trimspace(var.public_subnet_cidr_block_map)) :{name = trimspace(split("=", item)[0]),cidr = trimspace(split("=", item)[1])}] : item.name => item.cidr}) : var.public_subnet_cidr_block_map

  # private_subnet_map = var.is_orm ? { for item in [for item in split(",", trimspace(var.private_subnet_cidr_block_map)) : { name = trimspace(split(":", item)[0]), cidr = trimspace(split(":", item)[1]) }] : item.name => item.cidr } : var.private_subnet_cidr_block_map

}
