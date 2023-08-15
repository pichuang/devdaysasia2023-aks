# https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/kubernetes_cluster
resource "azurerm_kubernetes_cluster" "aks" {
  location                  = var.lab-location
  name                      = var.aks-name
  resource_group_name       = var.lab-rg
  dns_prefix                = var.dns-prefix
  sku_tier                  = "Standard"
  automatic_channel_upgrade = "stable"
  kubernetes_version        = "1.27.1"

  image_cleaner_enabled        = false
  image_cleaner_interval_hours = 48

  # node_resource_group

  api_server_access_profile {
    authorized_ip_ranges = ["0.0.0.0/0"]
    # subnet_id
    # vnet_integration_enabled
  }

  auto_scaler_profile {
    balance_similar_node_groups      = false
    expander                         = "least-waste"
    max_graceful_termination_sec     = 600
    max_node_provisioning_time       = "15m"
    max_unready_nodes                = 3
    max_unready_percentage           = 45
    new_pod_scale_up_delay           = "10s"
    scale_down_delay_after_add       = "10m"
    scale_down_delay_after_delete    = "10s"
    scale_down_delay_after_failure   = "3m"
    scan_interval                    = "10s"
    scale_down_unneeded              = "10m"
    scale_down_unready               = "20m"
    scale_down_utilization_threshold = 0.5
    empty_bulk_delete_max            = 10
    skip_nodes_with_local_storage    = true
    skip_nodes_with_system_pods      = true
  }

  default_node_pool {
    name = "agentpool"
    # https://learn.microsoft.com/en-us/azure/virtual-machines/dv3-dsv3-series#dv3-series
    # 4c / 16G
    vm_size                      = "Standard_D4_v3"
    node_count                   = 1
    enable_auto_scaling          = true
    max_count                    = 3
    min_count                    = 1
    max_pods                     = 250
    node_labels                  = { "level" : "core" }
    os_disk_type                 = "Managed"
    os_sku                       = "Mariner"
    os_disk_size_gb              = 128
    scale_down_mode              = "Delete"
    type                         = "VirtualMachineScaleSets"
    ultra_ssd_enabled            = false
    workload_runtime             = "OCIContainer"
    enable_node_public_ip        = false
    fips_enabled                 = false
    kubelet_disk_type            = "OS"
    only_critical_addons_enabled = false
    vnet_subnet_id               = azurerm_subnet.subnet-aks-default.id
  }

  identity {
    # principal_id = (known after apply)
    # tenant_id    = (known after apply)
    type = "SystemAssigned"
  }

  # linux_profile {
  #   admin_username = var.admin_username

  #   ssh_key {
  #     key_data = file(var.ssh_public_key)
  #   }
  # }

  network_profile {
    network_plugin    = "azure"
    network_policy    = "azure"
    load_balancer_sku = "standard"
    outbound_type     = "loadBalancer"
    # docker_bridge_cidr = "172.17.0.1/16"
    ip_versions = ["IPv4"]
    # network_mode       = (known after apply)
    # network_policy     = (known after apply)
    # pod_cidr           = (known after apply)
    # pod_cidrs          = []
    dns_service_ip = "10.0.196.10"
    # 10.0.196.4 - 10.0.199.254
    service_cidr  = "10.0.196.0/22"
    service_cidrs = ["10.0.196.0/22"]
  }

  ingress_application_gateway {
    # gateway_id =
    gateway_name = "apic-aks"
    # subnet_cidr =
    subnet_id = azurerm_subnet.subnet-apic.id
  }
}

# resource "azurerm_kubernetes_cluster_node_pool" "nodepool-app1" {
#   name                  = "generic-gw"
#   kubernetes_cluster_id = azurerm_kubernetes_cluster.aks.id
#   vm_size               = "Standard_D4_v3"
#   enable_auto_scaling   = true
#   node_count            = 0
#   min_count = 1
#   max_count = 3
#   max_pods = 3
#   os_disk_type = "Managed"
#   os_sku = "Mariner"
#   os_disk_size_gb = 128
#   os_type = "Linux"
#   priority = "Regular"
#   scale_down_mode = "Delete"

#   vnet_subnet_id = azurerm_subnet.subnet-aks-nodepool-app1.id

#   node_labels = { "name": "generic-gw" }

# }