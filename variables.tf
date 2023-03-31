variable "name" {
  description = "Name of Azure Service."
  type        = string
}

variable "create_resource_group" {
  description = "Whether to create resource group and use it for all networking resources"
  default     = true
  type        = bool
}

variable "resource_group_name" {
  description = "A container that holds related resources for an Azure solution"
  default     = "rg-demo-westeurope-01"
  type        = string
}

variable "location" {
  description = "The location/region to keep all your network resources. To get the list of all locations with table format from azure cli, run 'az account list-locations -o table'"
  default     = "westeurope"
  type        = string
}

variable "tags" {
  description = "Tags to apply to all resources created."
  type        = map(string)
  default     = {}
}

variable "subnet_id" {
  description = "The ID of the Subnet which the App should be connected to."
  type        = string
  default     = null
}

variable "private_dns_zone_id" {
  description = "(Optional) The ID of the private DNS zone to create the MySQL Flexible Server. Changing this forces a new MySQL Flexible Server to be created."
  type        = string
  default     = null
}

variable "sku_name" {
  description = "(Optional) The SKU Name for the MySQL Flexible Server."
  type        = string
  default     = "B_Standard_B2s"
}

variable "mysql_version" {
  description = " (Optional) The version of the MySQL Flexible Server to use. Possible values are 5.7, and 8.0.21. Changing this forces a new MySQL Flexible Server to be created."
  type        = string
  default     = "5.7"
}

variable "zone" {
  description = "(Optional) Specifies the Availability Zone in which this MySQL Flexible Server should be located. Possible values are 1, 2 and 3."
  type        = string
  default     = "1"
}

variable "storage_iops" {
  description = "(Optional) The storage IOPS for the MySQL Flexible Server. Possible values are between 360 and 20000."
  type        = number
  default     = 750
}

variable "storage_size" {
  description = "(Optional) The max storage allowed for the MySQL Flexible Server. Possible values are between 20 and 16384."
  type        = number
  default     = 20
}
