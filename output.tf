# Copyright (c) 2021 Oracle and/or its affiliates.
# All rights reserved. The Universal Permissive License (UPL), Version 1.0 as shown at http://oss.oracle.com/licenses/upl
# output.tf
#
# Purpose: The following script defines the output for newtwork artifacts built on this backend module


output "vcn" {
  description = "VCN Object"
  value       = oci_core_vcn.VCN
}

output "private_subnets" {
  description = "Private subnets created"
  value       = oci_core_subnet.PrivateSubnet
}

output "public_subnets" {
  description = "Public subnets created"
  value       = oci_core_subnet.PublicSubnet
}

output "service_gateway" {
  description = "Service Gateway component"
  value       = oci_core_service_gateway.PrivateServiceGateway
}

output "nat_gateway" {
  description = "NAT Gateway component"
  value       = oci_core_nat_gateway.NATGateway

}

output "internet_gateway" {
  description = "Internet Gateway component"
  value       = oci_core_internet_gateway.INETGateway
}

output "private_security_list" {
  description = "Private Security List associated to subnets"
  value       = oci_core_security_list.PrivateSecurityList
}

output "public_security_list" {
  description = "Public Security List associated to subnets"
  value       = oci_core_security_list.PublicSecurityList
}

output "private_route_table" {
  description = "Private Route Table associated to subnets"
  value       = oci_core_route_table.PrivateRouteTable
}

output "public_route_table" {
  description = "Public Route Table assocaited to subnets"
  value       = oci_core_route_table.PublicRouteTable
}

output "dhcp_options" {
  description = "DHCP Options associated to VCN"
  value       = oci_core_dhcp_options.DHCPOptions
}

output "dynamic_routing_gateway" {
  description = "Dynamic Routing Gateway Associated to VCNs"
  value       = oci_core_drg.DynamicRoutingGateway
}
