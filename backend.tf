terraform {
  backend "azurerm" {
    resource_group_name  = "Lab1-tf-storage-rg"
    storage_account_name = "backendstorage101"
    container_name       = "backendstorage"
    key                  = "terraform.tfstate"
  }
}