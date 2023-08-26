# https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/container_registry

resource "azurerm_container_registry" "acrdevdaysasia2023" {
  name                          = "acrdevdaysasia2023"
  resource_group_name           = var.lab-rg
  location                      = var.lab-location
  sku                           = "Premium"
  admin_enabled                 = false
  public_network_access_enabled = true
  anonymous_pull_enabled        = false
  network_rule_bypass_option    = "AzureServices"
  data_endpoint_enabled         = false
  export_policy_enabled         = true
  zone_redundancy_enabled       = false

  retention_policy {
    enabled = true
    days    = 7
  }
  georeplications {
    location                  = "East US"
    regional_endpoint_enabled = true
    zone_redundancy_enabled   = false
  }

  depends_on = [
    azurerm_resource_group.resource-group
  ]
}

# resource "azurerm_role_assignment" "role-assignment-acr" {
#   principal_id                     = azurerm_kubernetes_cluster.aks.kubelet_identity[0].principal_id
#   role_definition_name             = "AcrPull"
#   scope                            = azurerm_container_registry.acrdevdaysasia2023.id
#   skip_service_principal_aad_check = true

#   depends_on = [azurerm_kubernetes_cluster.aks, azurerm_container_registry.acrdevdaysasia2023]
# }