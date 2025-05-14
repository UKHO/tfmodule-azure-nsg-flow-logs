resource "azurerm_network_watcher_flow_log" "main" {
  count = var.ignore_changes
  network_watcher_name = data.azurerm_network_watcher.main.name
  resource_group_name  = data.azurerm_resource_group.watcherrg.name
  name                 = "${var.spokensg}-flowlogs"   
  provider             = azurerm.nsgflow
  version              = "2"

  target_resource_id        = data.azurerm_virtual_network.vnet.id
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
    interval_in_minutes   = var.intervalminutes 
  }
}

