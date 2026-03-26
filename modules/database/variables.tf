variable "resource_group_name" {
    type = string
    description = "The name of the resource group created in the root directory"
}

variable "location" {
    type = string
}

variable "test" {
    type = string
    description = "This is the value for the resource tag "
}

variable "sql_server_name" {
    type = string
    description = "This is the sql server's name"
}

variable "db_name" {
    type = string
    description = "This is the database name"
}

variable "admin_username" {
    type = string
    description = "This is the admin's username for the sql server"
}

variable "admin_password" {
    type = string
    description = "This is the admin's password for the sql server"
}

variable "vmss_subnet_id" {
    type = string
}