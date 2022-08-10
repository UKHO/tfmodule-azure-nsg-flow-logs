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

data "azurerm_network_security_group" "main" {
  provider            = azurerm.nsgflow
  name                = var.spokensg
  resource_group_name = data.azurerm_resource_group.spokensgrg.name
}

data "azurerm_network_watcher" "main" {
  provider            = azurerm.nsgflow
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

resource "azurerm_network_watcher_flow_log" "main" {
  count = var.ignore_changes
  network_watcher_name = data.azurerm_network_watcher.main.name
  resource_group_name  = data.azurerm_resource_group.watcherrg.name
  name                 = "${var.spokensg}-flowlog"   
  provider             = azurerm.nsgflow
  version              = "2"

  network_security_group_id = data.azurerm_network_security_group.main.id
  storage_account_id        = data.azurerm_storage_account.main.id
  enabled                   = true
  lifecycle { 
    ignore_changes = [
      tags,
      location
   ] 
 }

  retention_policy {
    enabled = true
    days    = 90
  }

  traffic_analytics {
    enabled               = true
    workspace_id          = data.azurerm_log_analytics_workspace.main.workspace_id
    workspace_region      = data.azurerm_log_analytics_workspace.main.location
    workspace_resource_id = data.azurerm_log_analytics_workspace.main.id
    interval_in_minutes   = 60
  }
}
