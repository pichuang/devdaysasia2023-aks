# https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/monitor_workspace

resource "azurerm_monitor_workspace" "amw-aks" {
  name                          = "amw-aks"
  resource_group_name           = var.lab-rg
  location                      = var.lab-location
  public_network_access_enabled = false

  depends_on = [azurerm_resource_group.resource-group]
}

# https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/dashboard_grafana
resource "azurerm_dashboard_grafana" "grafana-aks" {
  name                              = "grafana-aks"
  resource_group_name               = var.lab-rg
  location                          = var.lab-location
  api_key_enabled                   = true
  deterministic_outbound_ip_enabled = false
  public_network_access_enabled     = true
  sku                               = "Standard"
  zone_redundancy_enabled           = false

  azure_monitor_workspace_integrations {
    resource_id = azurerm_monitor_workspace.amw-aks.id
  }
  identity {
    type = "SystemAssigned"
  }

  depends_on = [azurerm_monitor_workspace.amw-aks]
}
