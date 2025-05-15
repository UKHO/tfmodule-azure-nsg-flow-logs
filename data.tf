data "azurerm_resource_group" "main" {
  provider = azurerm.hub
  name     = var.rg
}

<<<<<<< HEAD
data "azurerm_resource_group" "spokensgrg" {
  provider = azurerm.nsgflow
  name = var.spokensgrg
}

data "azurerm_resource_group" "watcherrg" {
  provider = azurerm.nsgflow
  name = var.watcherrg
}

data "azurerm_network_security_group" "main" {
  provider            = azurerm.nsgflow
  name                = var.spokensg
  resource_group_name = data.azurerm_resource_group.spokensgrg.name
}

data "azurerm_network_watcher" "main" {
  provider            = azurerm.nsgflow
=======
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
>>>>>>> 2320405a0cabeaf54b9275671ef312b5f2845380
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
<<<<<<< HEAD
  provider            = azurerm.nsgflow
  name                = var.vnet_name
  resource_group_name = data.azurerm_resource_group.spokensgrg.name  
=======
  provider            = azurerm.vnetflow
  name                = var.vnet_name
  resource_group_name = data.azurerm_resource_group.spokevnetrg.name  
>>>>>>> 2320405a0cabeaf54b9275671ef312b5f2845380
}