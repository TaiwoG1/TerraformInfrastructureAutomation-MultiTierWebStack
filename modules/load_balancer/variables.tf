variable "public_ip_name" {
    type = string
    default = "Lab1-pub-ip"
}

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

variable "load_bal" {
    type = string
    default = "Lab1-LB"
}

variable "domain_name_label" {
    type = string
    description = "This is the domain name for the public ip resource"
}