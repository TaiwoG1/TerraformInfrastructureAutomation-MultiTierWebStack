output "backend_pool_id" {
    value = azurerm_lb_backend_address_pool.tf-lb-backend-address-pool.id
}

output "nat_pool_id" {
    value = azurerm_lb_nat_pool.tf-lb-nat-pool.id
}

output "health_probe_id" {
    value = azurerm_lb_probe.tf-lb-probe.id
}