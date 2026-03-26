resource "azurerm_virtual_network" "tf-vnet" {
  name                = var.vnet_name
  resource_group_name = var.resource_group_name
  location            = var.location
  address_space       = ["10.0.0.0/16"]

  tags = {
    type = var.test
  }

}

resource "azurerm_subnet" "tf-subnet" {
  name                 = var.subnet_name
  resource_group_name  = var.resource_group_name
  virtual_network_name = azurerm_virtual_network.tf-vnet.name
  service_endpoints = ["Microsoft.Sql"]
  address_prefixes     = ["10.0.1.0/24"]
}

resource "azurerm_network_security_group" "tf-nsg" {
  name                = var.nsg_name
  resource_group_name = var.resource_group_name
  location            = var.location

  tags = {
    type = var.test
  }
}

resource "azurerm_network_security_rule" "tf-nsg-r" {
  name                        = var.nsg_name_r
  priority                    = 1000
  direction                   = "Inbound"
  access                      = "Allow"
  protocol                    = "*"
  source_port_range           = "*"
  destination_port_range      = "*"
  source_address_prefix       = "*"
  destination_address_prefix  = "*"
  resource_group_name = var.resource_group_name
  network_security_group_name = azurerm_network_security_group.tf-nsg.name
}

resource "azurerm_subnet_network_security_group_association" "tf-nsg-a" {
  subnet_id                 = azurerm_subnet.tf-subnet.id
  network_security_group_id = azurerm_network_security_group.tf-nsg.id
}

