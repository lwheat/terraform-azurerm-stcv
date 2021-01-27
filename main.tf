provider "azurerm" {
  version                    = ">=2.37.0"
  skip_provider_registration = "true"
  features {}
}

resource "azurerm_public_ip" "stcv" {
  count               = var.instance_count
  name                = "publicip-${var.instance_name}-${count.index}"
  location            = var.resource_group_location
  resource_group_name = var.resource_group_name
  allocation_method   = "Dynamic"
}

resource "azurerm_network_security_group" "mgmt_plane" {
  name                = "nsg-mgmt-${var.instance_name}"
  location            = var.resource_group_location
  resource_group_name = var.resource_group_name

  security_rule {
    name                       = "ssh"
    priority                   = 100
    direction                  = "Inbound"
    access                     = "Allow"
    protocol                   = "Tcp"
    source_port_range          = "*"
    destination_port_range     = "22"
    source_address_prefixes    = var.ingress_cidr_blocks
    destination_address_prefix = "*"
  }

  security_rule {
    name                       = "stc-chassis"
    priority                   = 110
    direction                  = "Inbound"
    access                     = "Allow"
    protocol                   = "Tcp"
    source_port_range          = "*"
    destination_port_range     = "40004"
    source_address_prefixes    = var.ingress_cidr_blocks
    destination_address_prefix = "*"
  }

  security_rule {
    name                       = "stc-portgroup"
    priority                   = 120
    direction                  = "Inbound"
    access                     = "Allow"
    protocol                   = "Tcp"
    source_port_range          = "*"
    destination_port_range     = "51204"
    source_address_prefixes    = var.ingress_cidr_blocks
    destination_address_prefix = "*"
  }

  security_rule {
    name                       = "bll-ephemeral"
    description                = "All outbound traffic back to BLL"
    priority                   = 101
    direction                  = "Outbound"
    access                     = "Allow"
    protocol                   = "Tcp"
    source_port_range          = "*"
    destination_port_range     = "49100-65535"
    source_address_prefix      = "*"
    destination_address_prefix = "*"
  }

  security_rule {
    name                       = "ntp"
    description                = "NTP server"
    priority                   = 110
    direction                  = "Outbound"
    access                     = "Allow"
    protocol                   = "Udp"
    source_port_range          = "*"
    destination_port_range     = "123"
    source_address_prefix      = "*"
    destination_address_prefix = "*"
  }
}

resource "azurerm_network_security_group" "test_plane" {
  name                = "nsg-test-${var.instance_name}"
  location            = var.resource_group_location
  resource_group_name = var.resource_group_name

  # all traffic
  security_rule {
    name                       = "all-traffic"
    priority                   = 100
    direction                  = "Outbound"
    access                     = "Allow"
    protocol                   = "*"
    source_port_range          = "*"
    destination_port_range     = "*"
    source_address_prefix      = "*"
    destination_address_prefix = "*"
  }
}

resource "azurerm_network_interface" "mgmt_plane" {
  count               = var.instance_count
  name                = "nic-mgmt-${var.instance_name}-${count.index}"
  location            = var.resource_group_location
  resource_group_name = var.resource_group_name

  ip_configuration {
    name                          = "ipc-mgmt-${var.instance_name}-${count.index}"
    subnet_id                     = var.mgmt_plane_subnet_id
    private_ip_address_allocation = "Dynamic"
    public_ip_address_id          = "${element(azurerm_public_ip.stcv.*.id, count.index)}"
  }
}

resource "azurerm_network_interface" "test_plane" {
  count                         = var.instance_count
  name                          = "nic-test-${var.instance_name}-${count.index}"
  location                      = var.resource_group_location
  resource_group_name           = var.resource_group_name
  enable_accelerated_networking = var.enable_accelerated_networking

  ip_configuration {
    name                          = "ipc-test-${var.instance_name}-${count.index}"
    subnet_id                     = var.test_plane_subnet_id
    private_ip_address_allocation = "Dynamic"
  }
}

resource "azurerm_network_interface_security_group_association" "mgmt_plane" {
  count                     = var.instance_count
  network_interface_id      = "${element(azurerm_network_interface.mgmt_plane.*.id, count.index)}"
  network_security_group_id = azurerm_network_security_group.mgmt_plane.id
}

resource "azurerm_network_interface_security_group_association" "test_plane" {
  count                     = var.instance_count
  network_interface_id      = "${element(azurerm_network_interface.test_plane.*.id, count.index)}"
  network_security_group_id = azurerm_network_security_group.test_plane.id
}

# Create STCv VMs
resource "azurerm_linux_virtual_machine" "stcv" {
  count                 = var.instance_count
  name                  = "${var.instance_name}${count.index}"
  location              = var.resource_group_location
  resource_group_name   = var.resource_group_name
  network_interface_ids = ["${element(azurerm_network_interface.mgmt_plane.*.id, count.index)}", "${element(azurerm_network_interface.test_plane.*.id, count.index)}"]
  size                  = var.instance_size
  admin_username        = var.admin_username

  admin_ssh_key {
    username   = var.admin_username
    public_key = file(var.public_key)
  }

  custom_data = base64encode(file(var.user_data_file))

  plan {
    name      = "testcentervirtual"
    publisher = "spirentcommunications1594084187199"
    product   = "testcenter_virtual"
  }

  os_disk {
    name                 = "osdisk-${var.instance_name}-${count.index}"
    caching              = "ReadWrite"
    storage_account_type = "Standard_LRS"
  }

  source_image_reference {
    publisher = "spirentcommunications1594084187199"
    offer     = "testcenter_virtual"
    sku       = "testcentervirtual"
    version   = var.marketplace_version != "" ? var.marketplace_version : "latest"
  }
}



