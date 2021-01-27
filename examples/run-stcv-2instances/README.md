## Description
This Terraform module deploys Spirent TestCenter Virtual Machines from an Azure Marketplace image.
The example requires the user to provide an already existing virtual network , management subnet, test subnet names.
It deploys Spirent TestCenter Virtual traffic generator instances with public and test networks.
Instances can be controlled by the Spirent TestCenter application.

<!-- BEGINNING OF PRE-COMMIT-TERRAFORM DOCS HOOK -->
## Requirements

No requirements.

## Providers

No provider.

## Inputs

No input.

## Outputs

| Name | Description |
|------|-------------|
| instance\_public\_ips | List of public IP addresses assigned to the instances, if applicable |

<!-- END OF PRE-COMMIT-TERRAFORM DOCS HOOK -->