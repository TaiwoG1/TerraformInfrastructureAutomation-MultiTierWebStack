resource "azurerm_mssql_server" "tf-server" {
  name                         = var.sql_server_name
  resource_group_name          = var.resource_group_name
  location                     = var.location
  version                      = "12.0"
  administrator_login          = var.admin_username
  administrator_login_password = var.admin_password
}

resource "azurerm_mssql_database" "tf-database" {
  name         = var.db_name
  server_id    = azurerm_mssql_server.tf-server.id
  collation    = "SQL_Latin1_General_CP1_CI_AS"
  license_type = "LicenseIncluded"
  max_size_gb  = 2
  sku_name     = "S0"
  enclave_type = "VBS"
}

resource "azurerm_mssql_virtual_network_rule" "tf-vnet-rule" {
  name = "Lab1-sql-vnet-rule"
  server_id = azurerm_mssql_server.tf-server.id
  subnet_id = var.vmss_subnet_id
}