/*
 * Copyright (c) 2021 Teradici Corporation
 *
 * This source code is licensed under the MIT license found in the
 * LICENSE file in the root directory of this source tree.
 */

output "network-security-group-ids" {
  description = "The domain controller network security group id"
  value       = [for item in azurerm_network_security_group.nsg : item.id]
}

output "subnet-workstation-ids" {
  description = "The workstation network subnet id"
  value       = [for item in azurerm_subnet.workstation : item.id]
}

output "subnet-workstation-names" {
  description = "The workstation network subnet name"
  value       = [for item in azurerm_subnet.workstation : item.name]
}

output "subnet-workstation-locations" {
 description = "The workstation network subnet locations" 
  # workstation location subnet is created one per virtual network so the subnet locations match
  value = var.locations
}

output "nat-gateway-ids" {
  value = [for item in azurerm_nat_gateway.nat : item.id]
}

output "all-output" {
  description = "An output value following modules can use as a dependency and be sure all resouces are created beforehand"
  value       = {}

  # Anything that refers to this output must wait until the actions for this module have completed first
  depends_on = [
    azurerm_network_security_group.nsg,
    azurerm_subnet.workstation,
    azurerm_subnet_network_security_group_association.workstation,
    azurerm_virtual_network.main_vnet,
    azurerm_virtual_network_peering.aadds_peering,
    azurerm_virtual_network_peering.aadds_peering_2
  ]
}

output "resource-group-name" {
  description = "Name of the resource group"
  value       = var.resource_group_name
}

output "vnet_name" {
  description = "Name of the VNET"
  value = azurerm_virtual_network.main_vnet.name
}