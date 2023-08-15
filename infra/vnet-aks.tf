# https://blog.pichuang.com.tw/azure-subnets.html

resource "azurerm_virtual_network" "vnet-aks" {
  # 10.0.128.4 - 10.0.255.254
  address_space       = ["10.0.128.0/17"]
  location            = var.location
  name                = "vnet-aks"
  resource_group_name = var.lab-rg

  depends_on = [
    azurerm_resource_group.resource-group
  ]
}

resource "azurerm_subnet" "subnet-aks-default" {
  name                 = "subnet-aks-default"
  resource_group_name  = var.lab-rg
  virtual_network_name = azurerm_virtual_network.vnet-aks.name
  # 10.0.128.4 - 10.0.191.254
  address_prefixes = ["10.0.128.0/18"]

  depends_on = [
    azurerm_virtual_network.vnet-aks
  ]
}

resource "azurerm_subnet" "subnet-apic" {
  name                 = "subnet-apic"
  resource_group_name  = var.lab-rg
  virtual_network_name = azurerm_virtual_network.vnet-aks.name
  address_prefixes     = ["10.0.192.0/24"]

  depends_on = [
    azurerm_virtual_network.vnet-aks
  ]
}

resource "azurerm_subnet" "aks-azurefirewallsubnet" {
  name                 = "AzureFirewallSubnet"
  resource_group_name  = var.lab-rg
  virtual_network_name = azurerm_virtual_network.vnet-aks.name
  # 10.0.193.4 - 10.0.193.62
  address_prefixes = ["10.0.193.0/26"]

  depends_on = [
    azurerm_virtual_network.vnet-aks
  ]
}

resource "azurerm_subnet" "aks-azurefirewallsubnetmanagement" {
  name                 = "AzureFirewallSubnetManagement"
  resource_group_name  = var.lab-rg
  virtual_network_name = azurerm_virtual_network.vnet-aks.name
  # 10.0.193.68 - 10.0.193.126
  address_prefixes = ["10.0.193.64/26"]

  depends_on = [
    azurerm_virtual_network.vnet-aks
  ]
}

resource "azurerm_subnet" "subnet-aks-nodepool-app1" {
  name                 = "subnet-aks-nodepool-app1"
  resource_group_name  = var.lab-rg
  virtual_network_name = azurerm_virtual_network.vnet-aks.name
  address_prefixes     = ["10.0.194.0/24"]

  depends_on = [
    azurerm_virtual_network.vnet-aks
  ]
}

