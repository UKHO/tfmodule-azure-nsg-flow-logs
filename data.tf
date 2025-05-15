data "azurerm_resource_group" "main" {
  provider = azurerm.hub
  name     = var.rg
}

data "azurerm_resource_group" "spokevnetrg" {
  provider = azurerm.vnetflow
  name = var.spokevnetrg
}

data "azurerm_resource_group" "watcherrg" {
  provider = azurerm.vnetflow
  name = var.watcherrg
}

data "azurerm_network_watcher" "main" {
  provider            = azurerm.vnetflow
  name                = var.watcher
  resource_group_name = data.azurerm_resource_group.watcherrg.name
}

data "azurerm_storage_account" "main" {
  provider            = azurerm.hub
  name                = var.storage
  resource_group_name = data.azurerm_resource_group.main.name
}

data "azurerm_log_analytics_workspace" "main" {
  provider            = azurerm.hub
  name                = var.workspace
  resource_group_name = data.azurerm_resource_group.main.name
}

data "azurerm_virtual_network" "vnet" {
  provider            = azurerm.vnetflow
  name                = var.vnet_name
  resource_group_name = data.azurerm_resource_group.spokevnetrg.name  
}