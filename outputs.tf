# # Add your code here
# output "validate_private_dns_zone_id" {
#   value = null

#   precondition {
#     condition     = (var.subnet_id != null && var.private_dns_zone_id == null)
#     error_message = "Please pass in private_dns_zone_id or change subnet_id to null."
#   }
# }
output "id" {
  description = "The ID of the MySQL Server."
  value       = azurerm_mysql_flexible_server.main.id
}

output "fqdn" {
  description = "The FQDN of the MySQL Server."
  value       = azurerm_mysql_flexible_server.main.fqdn
}

output "identity" {
  description = "An identity block as documented below."
  value       = azurerm_mysql_flexible_server.main.identity
}

output "password" {
  description = "The password of the secret for MySQL server"
  value       = random_password.password.result
  sensitive   = true
}

output "name" {
  description = "The name of the MySQL Flexible Server."
  value       = azurerm_mysql_flexible_server.main.name
}
