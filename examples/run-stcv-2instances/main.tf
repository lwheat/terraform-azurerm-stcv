## Example : This Terraform module deploys Spirent TestCenter Virtual Machines from an Azure Marketplace image.
# The example requires the user to provide an already existing virtual network , management subnet, test subnet names.

provider "azurerm" {
  version                    = ">=2.37.0"
  skip_provider_registration = "true"
  features {}
}

data "azurerm_subnet" "mgmt_plane" {
  name                 = "stcv-mgmt"
  virtual_network_name = "STCv"
  resource_group_name  = "default"
}

data "azurerm_subnet" "test_plane" {
  name                 = "stcv-test"
  virtual_network_name = "STCv"
  resource_group_name  = "default"
}

module "stcv" {
  source                    = "../.."
  instance_count            = 2
  marketplace_version       = "5.15.0106"
  resource_group_location   = "West US 2"
  virtual_network           = "STCv"
  mgmt_plane_subnet_id      = data.azurerm_subnet.mgmt_plane.id
  test_plane_subnet_id      = data.azurerm_subnet.test_plane.id
  user_data_file            = "../../cloud-init.yaml"
  public_key                = "~/.ssh/id_rsa.pub"

  # Warning: Using all address cidr block to simplify the example. You should restrict addresses to your public network.
  ingress_cidr_blocks       = ["0.0.0.0/0"]
}

output "instance_public_ips" {
  value = module.stcv.*.instance_public_ips
}