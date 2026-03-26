variable "vmss" {
    type = string
    default = "Lab1-vvmss"
}

variable "resource_group_name" {
    type = string
    description = "The name of the resource group created in the root directory"
}

variable "location" {
    type = string
}

variable "subnet_name" {
    type = string
}

variable "subnet_id" {
    type = string
}

variable "instance_count" {
    type = number
}

variable "backend_pool_id" {
    type = string
}

variable "nat_pool_id" {
    type = string
}

variable "health_probe_id" {
    type = string
}

variable "test" {
    type = string
}

variable "admin_username" {
    type = string
    description = "This is the admin's username for the sql server"
}

variable "admin_password" {
    type = string
    description = "This is the admin's password for the sql server"
}