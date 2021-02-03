#VARIABLES

variable "instance_name" {
  description = "Name assigned to the instance.  An instance number will be appended to the name."
  type        = string
  default     = "stcv"
}

variable "instance_size" {
  description = "Specifies the size of the STCv VM instance."
  type        = string
  default     = "Standard_DS3_v2"
}

variable "instance_count" {
  description = "Number of STCv instances to create."
  type        = number
  default     = 2
}

variable "resource_group_name" {
  description = "Resource group name in Azure."
  type        = string
  default     = "default"
}

variable "resource_group_location" {
  description = "Resource group location in Azure."
  type        = string
  default     = "West US"
}

variable "enable_accelerated_networking" {
  description = "Enable or disable accelerated networking on the network interface."
  type        = bool
  default     = "true"
}

variable "admin_username" {
  description = "Administrator user name."
  type        = string
  default     = "azureuser"
}

variable "mgmt_plane_subnet_id" {
  description = "Management public Azure subnet ID."
  type        = string
  default     = ""
}

variable "test_plane_subnet_id" {
  description = "Test or data plane Azure subnet ID."
  type        = string
  default     = ""
}

variable "ingress_cidr_blocks" {
  description = "List of management interface ingress IPv4/IPv6 CIDR ranges."
  type        = list(string)
}

variable "public_key" {
  description = "File path to public key."
  type        = string
}

variable "marketplace_version" {
  description = "The Spirent TestCenter Virtual image version (e.g. 5.15.0106). When not specified, the latest marketplace image will be used."
  type        = string
}

variable "user_data_file" {
  description = "Path to the file containing user data for the instance. See README for Spirent TestCenter Virtual cloud-init configuration parameters that are supported."
  type        = string
}
