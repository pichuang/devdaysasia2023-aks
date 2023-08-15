variable "lab-rg" {
  type        = string
  description = "value of the resource group name"
  default     = "rg-terraform"
}
variable "location" {
  type        = string
  description = "value of the location"
  default     = "westus2"
}

variable "environment" {
  type        = string
  description = "value of the environment"
  default     = "demo"
}