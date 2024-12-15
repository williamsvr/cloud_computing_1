## Réseau virtuel
# Cette ressource crée un réseau virtuel (VNet) dans Azure.
# Le VNet définit un espace réseau privé permettant à vos ressources Azure de communiquer.
resource "azurerm_virtual_network" "vnet" {
  name                = var.vnet_name
  location            = var.physical_loc
  resource_group_name = var.rg_name
  address_space       = var.vnet_address_space
}

## Sous-réseaux
# Cette ressource configure des sous-réseaux au sein du VNet.
# Chaque sous-réseau peut avoir des plages d'adresses spécifiques et des services associés (par exemple, Azure Storage).
resource "azurerm_subnet" "subnets" {
  for_each             = { for subnet in var.subnets : subnet.name => subnet }
  name                 = each.value.name
  resource_group_name  = var.rg_name
  virtual_network_name = azurerm_virtual_network.vnet.name
  address_prefixes     = each.value.address_prefixes
  service_endpoints    = each.value.name == "blob_subnet" ? ["Microsoft.Storage"] : []

  depends_on = [azurerm_virtual_network.vnet]

  dynamic "delegation" {
    for_each = each.value.service_delegation == true ? [1] : []

    content {
      name = each.value.delegation.delegation_name

      service_delegation {
        name    = each.value.delegation.name
        actions = each.value.delegation.actions
      }
    }
  }
}

## Groupes de sécurité réseau

# Groupe de sécurité réseau pour l'application web
# Autorise le trafic entrant depuis le sous-réseau de la base de données
resource "azurerm_network_security_group" "webapp_nsg" {
  name                = "webapp-nsg"
  resource_group_name = var.rg_name
  location            = var.physical_loc

  security_rule {
    name                       = "AllowDbSubnetTraffic"
    priority                   = 100
    direction                  = "Inbound"
    access                     = "Allow"
    protocol                   = "*"
    source_port_range          = "*"
    destination_port_range     = "*"
    source_address_prefix      = "10.0.1.0/24" # Sous-réseau de la base de données
    destination_address_prefix = "10.0.2.0/24" # Sous-réseau de l'application
  }
}

# Groupe de sécurité réseau pour la base de données
# Autorise le trafic entrant depuis le sous-réseau de l'application web
resource "azurerm_network_security_group" "db_nsg" {
  name                = "db-nsg"
  resource_group_name = var.rg_name
  location            = var.physical_loc

  security_rule {
    name                       = "AllowAppSubnetTraffic"
    priority                   = 100
    direction                  = "Inbound"
    access                     = "Allow"
    protocol                   = "*"
    source_port_range          = "*"
    destination_port_range     = "*"
    source_address_prefix      = "10.0.2.0/24" # Sous-réseau de l'application
    destination_address_prefix = "10.0.1.0/24" # Sous-réseau de la base de données
  }
}
