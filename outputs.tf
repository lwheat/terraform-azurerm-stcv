# OUTPUTS
output "instance_public_ips" {
  description = "List of public IP addresses assigned to the instances, if applicable"
  value       = azurerm_linux_virtual_machine.stcv.*.public_ip_address
}

output "instance_private_ips" {
  description = "List of private IP addresses assigned to the instances, if applicable"
  value       = azurerm_linux_virtual_machine.stcv.*.private_ip_address
}

output "instance_ids" {
  description = "List of instance IDs"
  value       = azurerm_linux_virtual_machine.stcv.*.id
}

output "test_plane_private_ips" {
  description = "List of private IP addresses assigned to the test interface eth1 of instances, if applicable"
  value       = azurerm_network_interface.test_plane.*.private_ip_address
}
