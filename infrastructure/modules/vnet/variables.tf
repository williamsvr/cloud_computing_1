variable "vnet_name" {
  description = "Nom du réseau virtuel"
  type        = string
}

variable "vnet_address_space" {
  description = "Espace d'adressage du réseau virtuel"
  type        = list(string)
}

variable "rg_name" {
  description = "Nom du groupe de ressources"
  type        = string
}

variable "physical_loc" {
  description = "Emplacement physique du groupe de ressources et des modules"
  type        = string
}

variable "subnets" {
  description = "Liste des sous-réseaux"
  type = list(object({
    name               = string
    address_prefixes   = list(string)
    service_delegation = bool

    delegation = object({
      delegation_name = string
      name            = string
      actions         = list(string)
    })
  }))
}
