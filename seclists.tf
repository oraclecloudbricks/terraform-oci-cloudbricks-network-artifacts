# Copyright (c) 2021 Oracle and/or its affiliates.
# All rights reserved. The Universal Permissive License (UPL), Version 1.0 as shown at http://oss.oracle.com/licenses/upl
# seclist.tf
#
# Purpose: The following script defines the Security Lists artifacts used in this project
# Registry: https://registry.terraform.io/providers/hashicorp/oci/latest/docs/resources/core_security_list


resource "oci_core_security_list" "PrivateSecurityList" {
  compartment_id = local.nw_compartment_ocid
  vcn_id         = oci_core_vcn.VCN.id
  display_name   = var.private_security_list_display_name
  egress_security_rules {
    destination      = var.private_security_list_egress_security_rules_destination
    protocol         = var.private_security_list_egress_security_rules_protocol
    description      = var.private_security_list_egress_security_rules_description
    destination_type = var.private_security_list_egress_security_rules_destination_type
    stateless        = var.private_security_list_egress_security_rules_stateless
  }
  ingress_security_rules {
    protocol    = var.private_security_list_ingress_security_rules_protocol
    source      = var.private_security_list_ingress_security_rules_source
    description = var.private_security_list_ingress_security_rules_description
    source_type = var.private_security_list_ingress_security_rules_source_type
    stateless   = var.private_security_list_ingress_security_rules_stateless
  }

}

resource "oci_core_security_list" "PublicSecurityList" {
  compartment_id = local.nw_compartment_ocid
  vcn_id         = oci_core_vcn.VCN.id
  display_name   = var.public_security_list_display_name
  egress_security_rules {
    destination      = var.public_security_list_egress_security_rules_destination
    protocol         = var.public_security_list_egress_security_rules_protocol
    description      = var.public_security_list_egress_security_rules_description
    destination_type = var.public_security_list_egress_security_rules_destination_type
    stateless        = var.public_security_list_egress_security_rules_stateless
  }
  ingress_security_rules {
    protocol    = var.public_security_list_ingress_security_rules_protocol
    source      = var.public_security_list_ingress_security_rules_source
    description = var.public_security_list_ingress_security_rules_description
    source_type = var.public_security_list_ingress_security_rules_source_type
    stateless   = var.public_security_list_ingress_security_rules_stateless
  }

}
