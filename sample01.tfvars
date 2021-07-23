######################################## COMMON VARIABLES ######################################
region           = "sa-santiago-1"
tenancy_ocid     = "ocid1.tenancy.oc1..aaaaaaaaoqdygmiidrabhv3y4hkr3rb3z6dpmgotvq2scffra6jt7rubresa"
user_ocid        = "ocid1.user.oc1..aaaaaaaafl42rhkw624h4os6n2ulcfxjjn2ylqsanhgtcph7j7owirzj6gya"
fingerprint      = "9a:9e:13:cf:94:6e:2c:b9:54:d2:60:0d:e4:14:8b:5e"
private_key_path = "/Users/dralquinta/OneDrive/DevOps/My_Keys/oci_api_key.pem"
######################################## COMMON VARIABLES ######################################

######################################## ARTIFACT VARIABLES ######################################
vcn_cidr_blocks                     = ["10.0.0.0/16"]
private_subnet_cidr_block_map       = { "HUB01_pvtsn01" : "10.0.0.0/23", "HUB01_pvtsn02" : "10.0.2.0/23", "HUB01_pvtsn03" : "10.0.4.0/23" }
public_subnet_cidr_block_map        = { "HUB01_pubsn01" : "10.0.6.0/23", "HUB01_pubsn02" : "10.0.8.0/23", "HUB01_pubsn03" : "10.0.10.0/23" }
vcn_display_name                    = "HUB01_VCN_Terraform"
vcn_network_compartment_name        = "DALQUINT_HUB_Network"
dhcp_options_display_name           = "HUB01_DHCP_Options"
custom_search_domain                = "test.com"
private_route_table_display_name    = "HUB01_pvt_hub_rt"
public_route_table_display_name     = "HUB01_pub_hub_rt"
private_security_list_display_name  = "HUB01_pvt_hub_sl"
public_security_list_display_name   = "HUB01_pub_hub_sl"
service_gateway_display_name        = "HUB01_SVC_GW"
nat_gateway_display_name            = "HUB01_NAT_GW"
internet_gateway_display_name       = "HUB01_INET_GW"
lpg_count                           = 1
lpg_display_name_base               = "HUB01_LPG"
peered_vcn_network_compartment_name = ""
peered_lpg_display_name             = ""
is_spoke                            = false
