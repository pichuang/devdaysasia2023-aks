# https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/log_analytics_workspace
resource "azurerm_log_analytics_workspace" "law-traces" {
  location            = var.lab-location
  resource_group_name = var.lab-rg
  # The WorkSpace name has to be unique across the whole of azure;
  # not just the current subscription/tenant.
  name              = "law-traces"
  sku               = "PerGB2018"
  retention_in_days = 30 # 30 ~ 730
  daily_quota_gb    = 1  # -1 (unlimited)
}

# https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/application_insights
resource "azurerm_application_insights" "ai-aks" {
  name                                = "ai-aks"
  location                            = var.lab-location
  resource_group_name                 = var.lab-rg
  application_type                    = "other"
  daily_data_cap_in_gb                = 1
  retention_in_days                   = 30
  sampling_percentage                 = 100
  disable_ip_masking                  = false
  workspace_id                        = azurerm_log_analytics_workspace.law-traces.id
  local_authentication_disabled       = false
  internet_ingestion_enabled          = true
  internet_query_enabled              = true
  force_customer_storage_for_profiler = false

  depends_on = [azurerm_log_analytics_workspace.law-traces]
}

output "instrumentation_key" {
  value = azurerm_application_insights.ai-aks.instrumentation_key
}

output "app_id" {
  value = azurerm_application_insights.ai-aks.app_id
}