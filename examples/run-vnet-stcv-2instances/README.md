## Description
This Terraform module creates a new virtual network in the same location as the Resource group provided by user, with the user specified vnet address space and subnet CIDRs.
The example uses this virtual network and subnets to deploy Spirent TestCenter Virtual Machines from an Azure Marketplace image.
It deploys Spirent TestCenter Virtual traffic generator instances with public and test networks.
Instances can be controlled by the Spirent TestCenter application.

<!-- BEGINNING OF PRE-COMMIT-TERRAFORM DOCS HOOK -->
## Requirements

| Name | Version |
|------|---------|
| azurerm | >=2.37.0 |

## Providers

| Name | Version |
|------|---------|
| azurerm | >=2.37.0 |

## Inputs

No input.

## Outputs

| Name | Description |
|------|-------------|
| instance\_public\_ips | List of public IP addresses assigned to the instances, if applicable |

<!-- END OF PRE-COMMIT-TERRAFORM DOCS HOOK -->