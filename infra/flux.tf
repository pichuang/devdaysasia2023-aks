# https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/kubernetes_cluster_extension

# GitOps Flux
resource "azurerm_kubernetes_cluster_extension" "extension-flux" {
  name           = "aks-ext-flux"
  cluster_id     = azurerm_kubernetes_cluster.aks.id
  extension_type = "microsoft.flux"
  depends_on = [
    azurerm_kubernetes_cluster.aks
  ]
}

# https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/kubernetes_flux_configuration#git_repository
resource "azurerm_kubernetes_flux_configuration" "flux-config" {
  name       = "flux-config"
  cluster_id = azurerm_kubernetes_cluster.aks.id
  namespace  = "flux"
  scope      = "cluster"

  git_repository {
    url                      = "https://github.com/pichuang/devdaysasia2023-aks"
    reference_type           = "branch"
    reference_value          = "main"
    sync_interval_in_seconds = "60"
    timeout_in_seconds       = 600
  }

  kustomizations {
    name                       = "podinfo"
    path                       = "./app/podinfo"
    garbage_collection_enabled = true
    recreating_enabled         = true
    sync_interval_in_seconds   = 60
    retry_interval_in_seconds  = 60
    timeout_in_seconds         = 600
  }

  kustomizations {
    name                       = "asm-demo"
    path                       = "./app/asm-demo"
    garbage_collection_enabled = true
    recreating_enabled         = true
    sync_interval_in_seconds   = 60
    retry_interval_in_seconds  = 60
    timeout_in_seconds         = 600
  }

  kustomizations {
    name                       = "chatgpt-lite"
    path                       = "./app/chatgpt-lite"
    garbage_collection_enabled = true
    recreating_enabled         = true
    sync_interval_in_seconds   = 60
    retry_interval_in_seconds  = 60
    timeout_in_seconds         = 600
  }

  depends_on = [
    azurerm_kubernetes_cluster_extension.extension-flux
  ]
}