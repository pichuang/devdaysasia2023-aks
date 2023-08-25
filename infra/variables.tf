variable "lab-rg" {
  type        = string
  description = "value of the resource group name"
  default     = "rg-terraform"
}
variable "lab-location" {
  type        = string
  description = "value of the location"
  default     = "westus2"
}

variable "vnet-name" {
  type        = string
  description = "value of the vnet name"
  default     = "vnet-terraform"
}

variable "aks-name" {
  type        = string
  description = "value of the aks name"
  default     = "aks-terraform"
}

variable "dns-prefix" {
  type        = string
  description = "value of the dns prefix"
  default     = "dns-aks"
}

# variable "admin_username" {
#   type        = string
#   description = "value of the admin username"
#   default     = "azureuser"
#   sensitive   = true
# }


variable "environment" {
  type        = string
  description = "value of the environment"
  default     = "bootstrap"
}

