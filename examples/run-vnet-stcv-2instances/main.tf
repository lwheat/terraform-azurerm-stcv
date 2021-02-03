## Example: This example creates a new virtual network in the same location as the Resource group , with the specified address space and subnet CIDRs.
# The example uses this virtual network and subnets to deploys a Spirent TestCenter Virtual Machine from an Azure Marketplace image.

provider "azurerm" {
  version                    = ">=2.37.0"
  skip_provider_registration = "true"
  features {}
}

data "azurerm_resource_group" "rg_stcv" {
  name = "default"
}

module "vnet" {
  source              = "Azure/vnet/azurerm"
  vnet_name           = "stcv-vnet"
  resource_group_name = "default"
  address_space       = ["10.0.0.0/16"]
  subnet_prefixes     = ["10.0.1.0/24", "10.0.2.0/24"]
  subnet_names        = ["stcv-mgmt", "stcv-test"]
}

module "stcv" {
  source                  = "../.."
  instance_count          = 2
  marketplace_version     = "5.15.0106"
  resource_group_location = data.azurerm_resource_group.rg_stcv.location
  mgmt_plane_subnet_id    = module.vnet.vnet_subnets[0]
  test_plane_subnet_id    = module.vnet.vnet_subnets[1]
  user_data_file          = "../../cloud-init.yaml"
  public_key              = "~/.ssh/id_rsa.pub"

  # Warning: Using all address cidr block to simplify the example. You should limit instance access.
  ingress_cidr_blocks = ["0.0.0.0/0"]
}

output "instance_public_ips" {
  description = "List of public IP addresses assigned to the instances, if applicable"
  value       = module.stcv.*.instance_public_ips
}
