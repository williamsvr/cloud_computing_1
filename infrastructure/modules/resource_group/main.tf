## Resource Group
# Creation du resource group dans Azure
resource "azurerm_resource_group" "resource_group" {
  name     = var.rg_name
  location = var.physical_loc
}