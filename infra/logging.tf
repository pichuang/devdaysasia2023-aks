# https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/log_analytics_workspace
resource "azurerm_log_analytics_workspace" "law-logging" {
  location            = var.lab-location
  resource_group_name = var.lab-rg
  # The WorkSpace name has to be unique across the whole of azure;
  # not just the current subscription/tenant.
  name              = "law-logging"
  sku               = "PerGB2018"
  retention_in_days = 30 # 30 ~ 730
  daily_quota_gb    = 1  # -1 (unlimited)

  depends_on = [azurerm_resource_group.resource-group]
}

# https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/log_analytics_solution
resource "azurerm_log_analytics_solution" "las-aks" {
  location              = var.lab-location
  resource_group_name   = var.lab-rg
  solution_name         = "ContainerInsights"
  workspace_name        = azurerm_log_analytics_workspace.law-logging.name
  workspace_resource_id = azurerm_log_analytics_workspace.law-logging.id

  plan {
    product   = "OMSGallery/ContainerInsights"
    publisher = "Microsoft"
  }

  depends_on = [azurerm_log_analytics_workspace.law-logging]
}