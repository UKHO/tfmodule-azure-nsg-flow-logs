data "azurerm_resource_group" "main" {
  provider = azurerm.hub
  name     = var.rg
}

data "azurerm_resource_group" "spokensgrg" {
  provider = azurerm.nsgflow
  name = var.spokensgrg
}

data "azurerm_resource_group" "watcherrg" {
  provider = azurerm.nsgflow
  name = var.watcherrg
}

# spoke
data "azurerm_network_security_group" "main" {
  provider            = azurerm.nsgflow
  name                = var.spokensg
  resource_group_name = data.azurerm_resource_group.spokensgrg.name
}

# spoke network watcher
data "azurerm_network_watcher" "main" {
  provider            = azurerm.nsgflow
  name                = var.watcher
  resource_group_name = data.azurerm_resource_group.watcherrg.name
}

# core services storage accounts
data "azurerm_storage_account" "main" {
  provider            = azurerm.hub
  name                = var.storage
  resource_group_name = data.azurerm_resource_group.main.name
}

# core services log analytics workspace
data "azurerm_log_analytics_workspace" "main" {
  provider            = azurerm.hub
  name                = var.workspace
  resource_group_name = data.azurerm_resource_group.main.name
}

# spoke vnet
data "azurerm_virtual_network" "vnet" {
  provider            = azurerm.nsgflow
  name                = var.vnet_name
  resource_group_name = data.azurerm_resource_group.spokensgrg.name  
}