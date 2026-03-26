resource "azurerm_resource_group" "tf-rg" {
  name     = var.rg1
  location = var.location1
  tags = {
    type = var.test
  }
}

module "networking" {
  source              = "./modules/networking"
  resource_group_name = azurerm_resource_group.tf-rg.name
  location            = azurerm_resource_group.tf-rg.location
  test                = var.test
}

module "load_balancer" {
  source              = "./modules/load_balancer"
  resource_group_name = azurerm_resource_group.tf-rg.name
  location            = azurerm_resource_group.tf-rg.location
  domain_name_label   = var.domain_name_label
  test                = var.test
}

module "compute" {
  source              = "./modules/compute"
  backend_pool_id     = module.load_balancer.backend_pool_id
  nat_pool_id         = module.load_balancer.nat_pool_id
  health_probe_id     = module.load_balancer.health_probe_id
  subnet_id           = module.networking.subnet_id
  subnet_name         = module.networking.subnet_name
  resource_group_name = azurerm_resource_group.tf-rg.name
  location            = azurerm_resource_group.tf-rg.location
  instance_count      = var.vmss_instance_count
  admin_username      = var.admin_username
  admin_password      = var.admin_password
  test                = var.test
}

module "database" {
  source              = "./modules/database"
  resource_group_name = azurerm_resource_group.tf-rg.name
  location            = azurerm_resource_group.tf-rg.location
  vmss_subnet_id      = module.networking.subnet_id
  sql_server_name     = var.sql_server_name
  db_name             = var.db_name
  admin_username      = var.admin_username
  admin_password      = var.admin_password
  test                = var.test

}