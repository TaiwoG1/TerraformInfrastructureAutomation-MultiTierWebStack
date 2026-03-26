resource "azurerm_public_ip" "tf-pub-ip" {
  name                = var.public_ip_name
  resource_group_name = var.resource_group_name
  location            = var.location  
  allocation_method   = "Static"
  domain_name_label   = var.domain_name_label

  tags = {
    type = var.test
  }
}






resource "azurerm_lb" "tf-lb" {
  name                = var.load_bal
  resource_group_name = var.resource_group_name
  location            = var.location
  
  frontend_ip_configuration {
    name                 = "PublicIPAddress"
    public_ip_address_id = azurerm_public_ip.tf-pub-ip.id
  }
}

resource "azurerm_lb_backend_address_pool" "tf-lb-backend-address-pool" {
  loadbalancer_id = azurerm_lb.tf-lb.id
  name            = "BackEndAddressPool"
}

resource "azurerm_lb_nat_pool" "tf-lb-nat-pool" {
  resource_group_name            = var.resource_group_name
  name                           = "rdp"
  loadbalancer_id                = azurerm_lb.tf-lb.id
  protocol                       = "Tcp"
  frontend_port_start            = 50000
  frontend_port_end              = 50119
  backend_port                   = 3389
  frontend_ip_configuration_name = "PublicIPAddress"
}

resource "azurerm_lb_probe" "tf-lb-probe" {
  name            = "http-probe"
  loadbalancer_id = azurerm_lb.tf-lb.id  
  protocol        = "Tcp"
  port            = 3389
  interval_in_seconds = 15
  number_of_probes    = 2
}


resource "azurerm_lb_rule" "tf-lb-rule" {
  loadbalancer_id                = azurerm_lb.tf-lb.id
  name                           = "LBRule-HTTP-8080"
  protocol                       = "Tcp"
  frontend_port                  = 80          # Port users reach on the Public IP
  backend_port                   = 8080        # Port the application reach listens on in the VMSS
  frontend_ip_configuration_name = "PublicIPAddress"
  backend_address_pool_ids       = [azurerm_lb_backend_address_pool.tf-lb-backend-address-pool.id]
  probe_id                       = azurerm_lb_probe.tf-lb-probe.id
}