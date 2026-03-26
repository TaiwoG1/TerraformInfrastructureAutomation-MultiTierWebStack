variable "resource_group_name" {
    type = string
    description = "The name of the resource group created in the root directory"
}

variable "location" {
    type = string
}

variable "vnet_name" {
    type = string
    default = "Lab1-vnet"
}

variable "subnet_name" {
    type = string
    default = "Lab1-subnet"
}

variable "test" {
    type = string
    description = "This is the value for the resource tag "
}

variable "nsg_name" {
    type = string
    description = "This is the name of the network security group resource"
    default = "Lab1-nsg"
}

variable "nsg_name_r" {
    type = string
    description = "This is the name of the network security group rule "
    default = "Lab1-nsg-r"
}