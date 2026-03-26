variable "my_subscription_id" {
  type        = string
  description = "Azure subscription id"
}

variable "test" {
  type        = string
  description = "Tag value for test environment"
}

variable "rg1" {
  type        = string
  description = "Resource group 1"
}

variable "rg2" {
  type        = string
  description = "Resource group 2"
}

variable "location1" {
  type        = string
  description = "Location 1"
}

variable "location2" {
  type        = string
  description = "Location 2"
}

variable "vmss_instance_count" {
  type        = number
  default     = 2
  description = "Number of VM instances in the scale set"
}

variable "sql_server_name" {
  type = string
}

variable "db_name" {
  type = string
}

variable "admin_username" {
  type        = string
  description = "This is the admin's username for the sql server"
}

variable "admin_password" {
  type        = string
  description = "This is the admin's password for the sql server"
}

variable "domain_name_label" {
  type        = string
  description = "This is the domain name for the public ip resource"
}