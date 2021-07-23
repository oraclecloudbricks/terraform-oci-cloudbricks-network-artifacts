# Copyright (c) 2021 Oracle and/or its affiliates.
# All rights reserved. The Universal Permissive License (UPL), Version 1.0 as shown at http://oss.oracle.com/licenses/upl
# variables.tf
#
# Purpose: The following script declares all variables used in this backend repository


/********** Provider Variables NOT OVERLOADABLE **********/
variable "region" {
  description = "Target region where artifacts are going to be created"
}

variable "tenancy_ocid" {
  description = "OCID of tenancy"
}

variable "user_ocid" {
  description = "User OCID in tenancy. Currently hardcoded to user denny.alquinta@oracle.com"
}

variable "fingerprint" {
  description = "API Key Fingerprint for user_ocid derived from public API Key imported in OCI User config"
}

variable "private_key_path" {
  description = "Private Key Absolute path location where terraform is executed"
}

/********** Provider Variables NOT OVERLOADABLE **********/

/********** Brick Variables **********/
/********** VCN Variables **********/
variable "vcn_cidr_blocks" {
  description = "The list of one or more IPv4 CIDR blocks for the VCN"
}

variable "vcn_display_name" {
  description = "(Optional) (Updatable) A user-friendly name. Does not have to be unique, and it's changeable. Avoid entering confidential information."
}

variable "vcn_network_compartment_name" {
  description = "Name of the compartment that contains all the networking artifacts. This compartment needs to be pre-created"
}
/********** VCN Variables **********/

/********** DHCP Options Variables **********/
variable "dhcp_options_display_name" {
  description = "(Optional) (Updatable) A user-friendly name. Does not have to be unique, and it's changeable. Avoid entering confidential information."
}

variable "custom_search_domain" {
  description = "A domain name where the custom option can be applied"

}
/********** DHCP Options Variables **********/

/********** Private Security List Variables **********/
variable "private_security_list_display_name" {
  description = "(Optional) (Updatable) A user-friendly name. Does not have to be unique, and it's changeable. Avoid entering confidential information."
}

variable "private_security_list_egress_security_rules_destination" {
  description = "(Required) (Updatable) Conceptually, this is the range of IP addresses that a packet originating from the instance can go to."
  default     = "0.0.0.0/0"
}

variable "private_security_list_egress_security_rules_protocol" {
  description = "(Required) (Updatable) The transport protocol. Specify either all or an IPv4 protocol number as defined in Protocol Numbers. Options are supported only for ICMP (1), TCP (6), UDP (17), and ICMPv6 (58)."
  default     = "all"
}

variable "private_security_list_egress_security_rules_description" {
  description = "(Optional) (Updatable) An optional description of your choice for the rule."
  default     = "All egress rule for all protocols and IP Addresses"
}

variable "private_security_list_egress_security_rules_destination_type" {
  description = "Optional) (Updatable) Type of destination for the rule. The default is CIDR_BLOCK"
  default     = "CIDR_BLOCK"
}

variable "private_security_list_egress_security_rules_stateless" {
  description = "(Optional) (Updatable) A stateless rule allows traffic in one direction. Remember to add a corresponding stateless rule in the other direction if you need to support bidirectional traffic. For example, if egress traffic allows TCP destination port 80, there should be an ingress rule to allow TCP source port 80. Defaults to false, which means the rule is stateful and a corresponding rule is not necessary for bidirectional traffic."
  default     = true
}

variable "private_security_list_ingress_security_rules_protocol" {
  description = "(Required) (Updatable) The transport protocol. Specify either all or an IPv4 protocol number as defined in Protocol Numbers. Options are supported only for ICMP (1), TCP (6), UDP (17), and ICMPv6 (58)."
  default     = "all"
}

variable "private_security_list_ingress_security_rules_source" {
  description = "(Required) (Updatable) Conceptually, this is the range of IP addresses that a packet coming into the instance can come from."
  default     = "0.0.0.0/0"
}

variable "private_security_list_ingress_security_rules_description" {
  description = "(Optional) (Updatable) An optional description of your choice for the rule."
  default     = "All traffic in for private security List"
}

variable "private_security_list_ingress_security_rules_source_type" {
  description = "Type of source for the rule."
  default     = "CIDR_BLOCK"
}

variable "private_security_list_ingress_security_rules_stateless" {
  description = " A stateless rule allows traffic in one direction. Remember to add a corresponding stateless rule in the other direction if you need to support bidirectional traffic. For example, if ingress traffic allows TCP destination port 80, there should be an egress rule to allow TCP source port 80. Defaults to false, which means the rule is stateful and a corresponding rule is not necessary for bidirectional traffic."
  default     = true
}

/********** Private Security List Variables **********/

/********** Public Security List Variables **********/
variable "public_security_list_display_name" {
  description = "(Optional) (Updatable) A user-friendly name. Does not have to be unique, and it's changeable. Avoid entering confidential information."
}

variable "public_security_list_egress_security_rules_destination" {
  description = "(Required) (Updatable) Conceptually, this is the range of IP addresses that a packet originating from the instance can go to."
  default     = "0.0.0.0/0"
}

variable "public_security_list_egress_security_rules_protocol" {
  description = "(Required) (Updatable) The transport protocol. Specify either all or an IPv4 protocol number as defined in Protocol Numbers. Options are supported only for ICMP (1), TCP (6), UDP (17), and ICMPv6 (58)."
  default     = "all"
}

variable "public_security_list_egress_security_rules_description" {
  description = "(Optional) (Updatable) An optional description of your choice for the rule."
  default     = "All egress rule for all protocols and IP Addresses"
}

variable "public_security_list_egress_security_rules_destination_type" {
  description = "Optional) (Updatable) Type of destination for the rule. The default is CIDR_BLOCK"
  default     = "CIDR_BLOCK"
}

variable "public_security_list_egress_security_rules_stateless" {
  description = "(Optional) (Updatable) A stateless rule allows traffic in one direction. Remember to add a corresponding stateless rule in the other direction if you need to support bidirectional traffic. For example, if egress traffic allows TCP destination port 80, there should be an ingress rule to allow TCP source port 80. Defaults to false, which means the rule is stateful and a corresponding rule is not necessary for bidirectional traffic."
  default     = true
}

variable "public_security_list_ingress_security_rules_protocol" {
  description = "(Required) (Updatable) The transport protocol. Specify either all or an IPv4 protocol number as defined in Protocol Numbers. Options are supported only for ICMP (1), TCP (6), UDP (17), and ICMPv6 (58)."
  default     = "all"
}

variable "public_security_list_ingress_security_rules_source" {
  description = "(Required) (Updatable) Conceptually, this is the range of IP addresses that a packet coming into the instance can come from."
  default     = "0.0.0.0/0"
}

variable "public_security_list_ingress_security_rules_description" {
  description = "(Optional) (Updatable) An optional description of your choice for the rule."
  default     = "All traffic in for Public Security List"
}

variable "public_security_list_ingress_security_rules_source_type" {
  description = "Type of source for the rule."
  default     = "CIDR_BLOCK"
}

variable "public_security_list_ingress_security_rules_stateless" {
  description = " A stateless rule allows traffic in one direction. Remember to add a corresponding stateless rule in the other direction if you need to support bidirectional traffic. For example, if ingress traffic allows TCP destination port 80, there should be an egress rule to allow TCP source port 80. Defaults to false, which means the rule is stateful and a corresponding rule is not necessary for bidirectional traffic."
  default     = true
}

/********** Public Security List Variables **********/


/********** Private Route Table Variables **********/
variable "private_route_table_display_name" {
  description = "Private Route Table Display Name."
}
/********** Private Route Table Variables **********/

/********** Public Route Table Variables **********/
variable "public_route_table_display_name" {
  description = "Public Route Table Display Name."
}
/********** Public Route Table Variables **********/



/********** Private Subnet Variables **********/
variable "private_subnet_cidr_block_map" {
  type        = map(any)
  description = "Map of CIDR Blocks associated to private subnets and it's corresponding names"
}

variable "is_private_subnet_private" {
  description = "Describes if the subnet is private or not"
  default     = true
}
/********** Private Subnet Variables **********/

/********** Public Subnet Variables **********/
variable "public_subnet_cidr_block_map" {
  type        = map(any)
  description = "Map of CIDR Blocks associated to private subnets and it's corresponding names"
}

variable "is_public_subnet_private" {
  description = "Describes if the subnet is private or not"
  default     = false
}
/********** Public Subnet Variables **********/

/********** NAT Gateway Variables **********/

variable "nat_gateway_display_name" {
  description = "NAT Gateway Display Name"
}
variable "private_route_table_nat_route_rules_description" {
  description = "(Optional) (Updatable) An optional description of your choice for the rule."
  default     = "NAT Gateway default route"
}

variable "private_route_table_nat_route_rules_destination" {
  description = "private_route_table_route_rules_destination"
  default     = "0.0.0.0/0"
}

variable "private_route_table_nat_route_rules_destination_type" {
  description = "(Optional) (Updatable) Type of destination for the rule. Required if you provide a destination."
  default     = "CIDR_BLOCK"
}

/********** NAT Gateway Variables **********/

/********** Private Service Gateway Variables **********/
variable "service_gateway_display_name" {
  description = "Service Gateway Display Name"
}


variable "private_route_table_svc_route_rules_description" {
  description = "(Optional) (Updatable) An optional description of your choice for the rule."
  default     = "Service Gateway default route"
}

variable "private_route_table_svc_route_rules_destination_type" {
  description = "(Optional) (Updatable) Type of destination for the rule. Required if you provide a destination."
  default     = "SERVICE_CIDR_BLOCK"
}
/********** Private Service Gateway Variables **********/

/********** Public Service Gateway Variables **********/

variable "public_route_table_svc_route_rules_description" {
  description = "(Optional) (Updatable) An optional description of your choice for the rule."
  default     = "Service Gateway default route"
}

variable "public_route_table_svc_route_rules_destination_type" {
  description = "(Optional) (Updatable) Type of destination for the rule. Required if you provide a destination."
  default     = "SERVICE_CIDR_BLOCK"
}
/********** Public Service Gateway Variables **********/




/********** Public Internet Gateway Variables **********/
variable "internet_gateway_enabled" {
  description = "Describes if the Internet Gateway is enabled upon creation or not"
  default     = true
}

variable "internet_gateway_display_name" {
  description = "(Optional) (Updatable) A user-friendly name. Does not have to be unique, and it's changeable. Avoid entering confidential information."
}

variable "public_route_table_inet_route_rules_description" {
  description = "Description of Route Table Entry for Internet Gateway"
  default     = "Route entry for Internet Gateway"
}

variable "public_route_table_inet_route_rules_destination" {
  description = "private_route_table_route_rules_destination"
  default     = "0.0.0.0/0"
}

variable "public_route_table_inet_route_rules_destination_type" {
  description = "(Optional) (Updatable) Type of destination for the rule. Required if you provide a destination."
  default     = "CIDR_BLOCK"
}

/********** Public Internet Gateway Variables **********/

/********** Local Peering Gateway Variables **********/
variable "lpg_display_name_base" {
  description = "Local Peering Gateway Display Name Base"
}

variable "peered_lpg_display_name" {
  description = "Display name of peered LPG"
  default     = ""
}

variable "peered_vcn_display_name" {
  description = "Name of the peered VCN where the peered LPG is created"
  default     = ""
}

variable "peered_vcn_network_compartment_name" {
  description = "Name of the compartment where the VCN that's going to be peered is"
  default     = ""
}

variable "label_zs" {
  type        = list(any)
  description = "Auxiliary variable to concatenate with lpg number"
  default     = ["0", ""]
}

variable "lpg_count" {
  description = "Number of LPG to create"
  default     = 1
}

variable "is_spoke" {
  description = "Boolean that describes if the compartment is a spoke or not"
  default     = true
}
/********** Local Peering Gateway Variables **********/

/********** Brick Variables **********/

