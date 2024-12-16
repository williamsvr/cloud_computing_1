variable "rg_name" {
  description = "Nom du ressource group dans Azure"
  type        = string
}

variable "physical_loc" {
  description = "Emplacement physique des ressources Azure"
  type        = string
}

variable "gateway_name" {
  description = "Nom du gateway"
  type        = string
}

variable "subnet_id" {
  description = "ID du subnet où le gateway est déployé"
  type        = string
}

variable "app_service_fqdn" {
  description = "App service Fully Qualified Domain Name"
  type        = string
}