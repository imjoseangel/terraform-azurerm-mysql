#-------------------------------
# Local Declarations
#-------------------------------
locals {
  # tflint-ignore: terraform_unused_declarations
  resource_group_name          = element(coalescelist(data.azurerm_resource_group.rgrp[*].name, azurerm_resource_group.rg[*].name, [""]), 0)
  location                     = element(coalescelist(data.azurerm_resource_group.rgrp[*].location, azurerm_resource_group.rg[*].location, [""]), 0)
  validate_private_dns_zone_id = (var.subnet_id != null && var.private_dns_zone_id == null) ? tobool("Please pass in private_dns_zone_id or change subnet_id to null.") : true
}

data "azurerm_client_config" "current" {}

#---------------------------------------------------------
# Resource Group Creation or selection - Default is "true"
#---------------------------------------------------------
data "azurerm_resource_group" "rgrp" {
  count = var.create_resource_group ? 0 : 1
  name  = var.resource_group_name
}

resource "azurerm_resource_group" "rg" {
  #ts:skip=AC_AZURE_0389 RSG lock should be skipped for now.
  count    = var.create_resource_group ? 1 : 0
  name     = lower(var.resource_group_name)
  location = var.location
  tags     = merge({ "ResourceName" = format("%s", var.resource_group_name) }, var.tags, )
}

#---------------------------------------------------------
# Resource Creation
#---------------------------------------------------------

resource "random_password" "password" {
  length           = 17
  min_lower        = 1
  min_numeric      = 1
  min_special      = 1
  min_upper        = 1
  override_special = "_"
}

resource "azurerm_mysql_flexible_server" "main" {
  name                         = var.name
  resource_group_name          = local.resource_group_name
  location                     = local.location
  administrator_login          = "mysqladmin"
  administrator_password       = random_password.password.result
  backup_retention_days        = 7
  delegated_subnet_id          = var.subnet_id
  geo_redundant_backup_enabled = false
  private_dns_zone_id          = var.private_dns_zone_id
  sku_name                     = var.sku_name
  version                      = var.mysql_version
  zone                         = var.zone

  storage {
    iops    = var.storage_iops
    size_gb = var.storage_size
  }
}
