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

# https://github.com/Azure/prometheus-collector/blob/main/AddonTerraformTemplate/main.tf
resource "azurerm_monitor_data_collection_endpoint" "dce" {
  name                = "dce-MSProm-aks"
  resource_group_name = var.lab-rg
  location            = var.lab-location
  kind                = "Linux"

  depends_on = [azurerm_resource_group.resource-group]
}

resource "azurerm_monitor_data_collection_rule" "dcr" {
  name                        = "dcr-MSProm-aks"
  resource_group_name         = var.lab-rg
  location                    = var.lab-location
  data_collection_endpoint_id = azurerm_monitor_data_collection_endpoint.dce.id
  kind                        = "Linux"

  destinations {
    monitor_account {
      monitor_account_id = azurerm_monitor_workspace.amw-aks.id
      name               = "MonitoringAccount-aks"
    }
  }

  data_flow {
    streams      = ["Microsoft-PrometheusMetrics"]
    destinations = ["MonitoringAccount-aks"]
  }


  data_sources {
    prometheus_forwarder {
      streams = ["Microsoft-PrometheusMetrics"]
      name    = "PrometheusDataSource"
    }
  }

  description = "DCR for Azure Monitor Metrics Profile (Managed Prometheus)"
  depends_on = [
    azurerm_monitor_data_collection_endpoint.dce
  ]
}

resource "azurerm_monitor_data_collection_rule_association" "dcra" {
  name                    = "dcra-MSProm-aks"
  target_resource_id      = azurerm_kubernetes_cluster.aks.id
  data_collection_rule_id = azurerm_monitor_data_collection_rule.dcr.id
  description             = "Association of data collection rule. Deleting this association will break the data collection for this AKS Cluster."
  depends_on = [
    azurerm_monitor_data_collection_rule.dcr
  ]
}

# resource "azurerm_role_assignment" "amw-datareaderrole" {
#   scope = azurerm_monitor_workspace.amw-aks.id

#   # https://www.azadvertizer.net/azrolesadvertizer/b0d8363b-8ddd-447d-831f-62ca05bff136.html
#   role_definition_id = "/subscriptions/${split("/", azurerm_monitor_workspace.amw-aks.id)[2]}/providers/Microsoft.Authorization/roleDefinitions/b0d8363b-8ddd-447d-831f-62ca05bff136"
#   principal_id       = azurerm_dashboard_grafana.grafana-aks.identity[0].principal_id
#   depends_on = [
#     azurerm_monitor_workspace.amw-aks,
#     azurerm_dashboard_grafana.grafana-aks
#   ]
# }
