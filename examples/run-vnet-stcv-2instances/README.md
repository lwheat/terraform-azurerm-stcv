## Description
This Terraform module creates a new virtual network in the same location as the Resource group provided by user, with the user specified vnet address space and subnet CIDRs.
The example uses this virtual network and subnets to deploy Spirent TestCenter Virtual Machines from an Azure Marketplace image.
It deploys Spirent TestCenter Virtual traffic generator instances with public and test networks.

Instances can be controlled by the [Spirent TestCenter application](https://github.com/Spirent-terraform-Modules/terraform-azurerm-stc-gui).

## Usage

To run this example you need to execute:

    $ terraform init
    $ terraform plan
    $ terraform apply

This example will create resources that will incur a cost. Run `terraform destroy` when you don't need these resources.

Usage of Spirent TestCenter Virtual instances follows a Bring-Your-Own-License (BYOL) approach and is available for customers with current licenses purchased via [Spirent support](https://support.spirent.com/SpirentCSC).

<!-- BEGINNING OF PRE-COMMIT-TERRAFORM DOCS HOOK -->
## Requirements

| Name | Version |
|------|---------|
| azurerm | >=2.37.0 |

## Providers

| Name | Version |
|------|---------|
| azurerm | >=2.37.0 |

## Modules

| Name | Source | Version |
|------|--------|---------|
| stcv | ../.. |  |
| vnet | Azure/vnet/azurerm |  |

## Resources

| Name |
|------|
| [azurerm_resource_group](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/data-sources/resource_group) |

## Inputs

No input.

## Outputs

| Name | Description |
|------|-------------|
| instance\_public\_ips | List of public IP addresses assigned to the instances, if applicable |
<!-- END OF PRE-COMMIT-TERRAFORM DOCS HOOK -->
