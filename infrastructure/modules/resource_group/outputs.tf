output "rg_id" {
  description = "ID du groupe de ressources"
  value       = azurerm_resource_group.resource_group.id
}

output "rg_name" {
  description = "Nom du groupe de ressources"
  value       = azurerm_resource_group.resource_group.name
}

output "physical_loc" {
  description = "Emplacement physique du groupe de ressources et des modules"
  value       = azurerm_resource_group.resource_group.location
}
