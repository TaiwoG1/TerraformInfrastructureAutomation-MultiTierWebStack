resource "azurerm_windows_virtual_machine_scale_set" "tf-vmss" {
  name                 = var.vmss
  resource_group_name  = var.resource_group_name
  location             = var.location
  sku                  = "Standard_D2s_v3"
  instances            = var.instance_count

  #upgrade_policy_mode = "Rolling"
  health_probe_id = var.health_probe_id



  admin_password       = var.admin_password
  admin_username       = var.admin_username
  computer_name_prefix = "vmss-"

  #os_profile_windows_config {
  #  provision_vm_agent        = true
  #  enable_automatic_upgrades = true
  #}  

  source_image_reference {
    publisher = "MicrosoftWindowsServer"
    offer     = "WindowsServer"
    sku       = "2016-Datacenter-Server-Core"
    version   = "latest"
  }

  os_disk {
    #managed_disk_type    = "Standard_LRS"
    caching              = "ReadWrite"
    storage_account_type = "Standard_LRS"
  }

  network_interface {
    name    = "tf-network-profile"
    primary = true

    ip_configuration {
      name      = "internal-ipconfig"
      primary   = true
      subnet_id = var.subnet_id
      load_balancer_backend_address_pool_ids = [var.backend_pool_id]
      load_balancer_inbound_nat_rules_ids    = [var.nat_pool_id]

    }
  }

  tags = {
    type = var.test
  }
}