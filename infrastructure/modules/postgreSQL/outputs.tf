output "dns_private_zone_id" {
  description = "ID de la zone DNS privée"
  value       = azurerm_private_dns_zone.cpi_dns.id
}

output "postgresql_server_fqdn" {
  description = "Nom de domaine complet (FQDN) du serveur PostgreSQL"
  value       = azurerm_postgresql_flexible_server.postgresql.fqdn
}

output "postgresql_server_id" {
  description = "ID unique du serveur PostgreSQL flexible"
  value       = azurerm_postgresql_flexible_server.postgresql.id
}

output "database_id" {
  description = "ID de la base de données créée dans le serveur PostgreSQL"
  value       = azurerm_postgresql_flexible_server_database.database.id
}

output "database_port" {
  description = "Port de la base de données créée dans le serveur PostgreSQL"
  value       = 5432
}

output "database_name" {
  description = "Nom de la base de données créée dans le serveur PostgreSQL"
  value       = azurerm_postgresql_flexible_server_database.database.name
}
