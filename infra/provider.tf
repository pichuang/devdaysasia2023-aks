terraform {

  required_version = ">= 1.2.0"

  required_providers {
    azurerm = {
      source = "hashicorp/azurerm"
      # https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs
      version = ">= 3.69.0"
    }

    time = {
      source = "hashicorp/time"
      # https://registry.terraform.io/providers/hashicorp/time/latest/docs
      version = ">= 0.9.1"
    }

    null = {
      source = "hashicorp/null"
      # https://registry.terraform.io/providers/hashicorp/null/latest/docs
      version = ">=3.2.1"
    }

  }

  # When authenticating using OpenID Connect (OIDC)
  # https://developer.hashicorp.com/terraform/language/settings/backends/azurerm#example-configuration
  backend "azurerm" {
    resource_group_name  = "rg-terraform"
    storage_account_name = "saprodevdays2023asiaaks"
    container_name       = "tfstatfile"
    key                  = "production.terraform.tfstate"
    use_oidc             = true
  }
}

provider "azurerm" {
  features {
    resource_group {
      prevent_deletion_if_contains_resources = false
    }
  }
  use_oidc = true
}

# Define any Azure resources to be created here. A simple resource group is shown here as a minimal example.
resource "azurerm_resource_group" "resource-group" {
  name     = var.lab-rg
  location = var.lab-location
  tags     = merge(local.common_tags)
  lifecycle {
    ignore_changes = [
      tags,
    ]
  }
}