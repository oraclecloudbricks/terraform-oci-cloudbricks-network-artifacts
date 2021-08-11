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
    values = [var.peered_vcn_network_compartment_name]
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

data "oci_core_local_peering_gateways" "PEERLPG" {

  compartment_id = var.is_spoke == true ? local.peered_nw_compartment_ocid : local.nw_compartment_ocid
  vcn_id         = local.peered_vcn_ocid
  filter {
    name   = "display_name"
    values = [var.peered_lpg_display_name]
  }
}

data "oci_core_vcns" "PEEREDVCN" {
  compartment_id = var.is_spoke == true ? local.peered_nw_compartment_ocid : local.nw_compartment_ocid
  filter {
    name   = "display_name"
    values = [var.peered_vcn_display_name]
  }
}

locals {
  # Compartment OCID Local Accessor
  nw_compartment_ocid        = lookup(data.oci_identity_compartments.NWCOMPARTMENTS.compartments[0], "id")
  peered_nw_compartment_ocid = length(data.oci_identity_compartments.PEEREDNWCOMPARTMENTS.compartments) > 0 ? lookup(data.oci_identity_compartments.PEEREDNWCOMPARTMENTS.compartments[0], "id") : null
  nw_compartment_object      = data.oci_identity_compartments.NWCOMPARTMENTS.compartments[0]

  # Service Gateway OCID Local Accessor 
  all_service_list_ocid               = data.oci_core_services.ALLSERVICES.services.0.id
  storage_service_list_ocid           = data.oci_core_services.STORAGESERVICES.services.0.id
  all_service_gateway_destination     = data.oci_core_services.ALLSERVICES.services[0]["cidr_block"]
  storage_service_gateway_destination = data.oci_core_services.STORAGESERVICES.services[0]["cidr_block"]

  # Peered LPG Local Accessor
  peered_lpg_ocid = length(data.oci_core_local_peering_gateways.PEERLPG.local_peering_gateways) > 0 ? lookup(data.oci_core_local_peering_gateways.PEERLPG.local_peering_gateways[0], "id") : null
  peered_vcn_ocid = length(data.oci_core_vcns.PEEREDVCN.virtual_networks) > 0 ? lookup(data.oci_core_vcns.PEEREDVCN.virtual_networks[0], "id") : null
}