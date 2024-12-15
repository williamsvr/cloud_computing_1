# Génère une chaîne aléatoire utilisée pour le nommage et pour permettre à plusieurs utilisateurs d'exécuter le code sans conflits de noms
resource "random_string" "random_name" {
  length  = 8
  special = false
  upper   = false
}

# Crée une zone DNS privée pour lier le serveur PostgreSQL à un FQDN
resource "azurerm_private_dns_zone" "cpi_dns" {
  name                = "cloud-cpi-domain.postgres.database.azure.com"
  resource_group_name = var.rg_name
}

# Crée un lien entre la zone DNS privée et le réseau virtuel
resource "azurerm_private_dns_zone_virtual_network_link" "dns_private_link" {
  name                  = "cpi_dns_link"
  resource_group_name   = var.rg_name
  private_dns_zone_name = azurerm_private_dns_zone.cpi_dns.name
  virtual_network_id    = var.vnet_id

  depends_on = [azurerm_private_dns_zone.cpi_dns]
}

# Définit des variables locales pour le module
locals {
  flex_server_name = "${var.postgresql_server_name}-${random_string.random_name.result}"
}

# Ressource principale pour la création du serveur PostgreSQL
resource "azurerm_postgresql_flexible_server" "postgresql" {
  name                          = local.flex_server_name
  location                      = var.physical_loc
  resource_group_name           = var.rg_name
  sku_name                      = var.sku_name
  storage_mb                    = var.storage_mb
  version                       = var.db_version
  administrator_login           = var.admin_username
  administrator_password        = var.admin_password
  delegated_subnet_id           = var.subnet_id
  private_dns_zone_id           = azurerm_private_dns_zone.cpi_dns.id
  public_network_access_enabled = false
  zone                          = "1"

  depends_on = [azurerm_private_dns_zone.cpi_dns]
}

# Crée une base de données au sein du serveur PostgreSQL
resource "azurerm_postgresql_flexible_server_database" "database" {
  name      = var.db_name
  server_id = azurerm_postgresql_flexible_server.postgresql.id

  depends_on = [azurerm_postgresql_flexible_server.postgresql]
}

# Crée une règle de pare-feu pour le serveur flexible, permettant l'accès au sous-réseau de l'application web
resource "azurerm_postgresql_flexible_server_firewall_rule" "allow_webapp" {
  name             = "Allowwebapp"
  server_id        = azurerm_postgresql_flexible_server.postgresql.id
  start_ip_address = "10.0.2.0"
  end_ip_address   = "10.0.2.255"
}
