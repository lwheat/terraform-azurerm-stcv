# Azure RM Spirent TestCenter Virtual Terraform

## Description
Run [STCv](https://www.spirent.com/products/testcenter-virtual-ethernet-ip-testing) traffic generator instances with public and test networks.

Instances can be controlled by the [Spirent TestCenter application](https://github.com/Spirent-terraform-Modules/terraform-azurerm-stc-gui).

<!-- BEGINNING OF PRE-COMMIT-TERRAFORM DOCS HOOK -->
## Requirements

| Name | Version |
|------|---------|
| terraform | >= 0.13.0 |
| azurerm | >=2.37.0 |

## Providers

| Name | Version |
|------|---------|
| azurerm | >=2.37.0 |

## Modules

No Modules.

## Resources

| Name |
|------|
| [azurerm_image](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/data-sources/image) |
| [azurerm_linux_virtual_machine](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/linux_virtual_machine) |
| [azurerm_network_interface](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/network_interface) |
| [azurerm_network_interface_security_group_association](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/network_interface_security_group_association) |
| [azurerm_network_security_group](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/network_security_group) |
| [azurerm_public_ip](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/public_ip) |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| admin\_username | Administrator user name. | `string` | `"azureuser"` | no |
| enable\_accelerated\_networking | Enable or disable accelerated networking on the network interface. | `bool` | `"true"` | no |
| ingress\_cidr\_blocks | List of management interface ingress IPv4/IPv6 CIDR ranges. | `list(string)` | n/a | yes |
| instance\_count | Number of STCv instances to create. | `number` | `2` | no |
| instance\_name | Name assigned to the instance.  An instance number will be appended to the name. | `string` | `"stcv"` | no |
| instance\_size | Specifies the size of the STCv VM instance. | `string` | `"Standard_DS3_v2"` | no |
| marketplace\_version | The Spirent TestCenter Virtual image version (e.g. 5.15.0106). When not specified, the latest marketplace image will be used. | `string` | `"latest"` | no |
| mgmt\_plane\_subnet\_id | Management public Azure subnet ID. | `string` | `""` | no |
| public\_key | File path to public key. | `string` | n/a | yes |
| resource\_group\_location | Resource group location in Azure. | `string` | `"West US"` | no |
| resource\_group\_name | Resource group name in Azure. | `string` | `"default"` | no |
| stcv\_image\_name | The Spirent TestCenter Virtual image created from private vhd file.  This variable overrides the marketplace image. | `string` | `""` | no |
| test\_plane\_subnet\_id | Test or data plane Azure subnet ID. | `string` | `""` | no |
| user\_data\_file | Path to the file containing user data for the instance. See README for Spirent TestCenter Virtual cloud-init configuration parameters that are supported. | `string` | n/a | yes |

## Outputs

| Name | Description |
|------|-------------|
| instance\_ids | List of instance IDs |
| instance\_private\_ips | List of private IP addresses assigned to the instances, if applicable |
| instance\_public\_ips | List of public IP addresses assigned to the instances, if applicable |
| test\_plane\_private\_ips | List of private IP addresses assigned to the test interface eth1 of instances, if applicable |
<!-- END OF PRE-COMMIT-TERRAFORM DOCS HOOK -->

## User Data (cloud-init)

### Example
```
#cloud-config
spirent:
  driver: dpdk
  speed: 10G
```
### Parameters

| Name | Description |  Type | Default
|------|-------------|-------------|-------------
| speed | Maximum network interface speed | 1G, 5G, 10G, 25G, 50G, 100G | 1G
| driver | Network driver interface | sockets, dpdk | dpdk (for supported cloud provider instances)
| rxq | RX queue size for dpdk driver | 1-N | 1
| benchmark | Turn benchmark rate mode on or off for dpdk driver| off, on | off
| ntp | NTP server | IP address | x.x.x.x (cloud provider recommended)
| ipv4mode | IPv4 address mode | none, static, dhcp | dhcp
| ipaddress | IPv4 address (static mode) | IPv4 address | -
| netmask | IPv4 netmask (static mode) | IPv4 netmask | -
| gwaddress | IPv4 gateway address (static mode) | IPv4 gateway address | -
| ipv6mode | IPv6 address mode | none, static, dhcp | none
| ipv6address | IPv6 address (static mode) | IPv6 address | -
| ipv6prefixlen | IPv6 prefix length (static mode) | IPv6 prefix length | -
| ipv6gwaddress | IPv6 gateway address (static mode) | IPv6 gateway address | -
| gvtap | Turn Gigamon gvtap agent on or off| off, on | off
