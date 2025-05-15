# Terraform Module: Virtual-Network-Flow_logs

## Required Resources

- `Resource Group` exists or is created external to the module.
- `Provider` must be created external to the module.

## Usage

```terraform
# Virtual Network Flow Logs with Traffic Analytics

## Creating vnet flow logs

## Usage Vars

variable "rg" {
    description = "rg where the flowslogs will be stored"
    default = ""
}
variable "watcherrg" {
    description = "rg for NetworkWatcher"
    default = ""
}

variable "spokevnetrg" {
    description = "rg where the vnet lives"
    default = ""
}

variable "spokevnet" {
   description = "vnet where we want to enable flowlogs"
   default = ""
}

variable "watcher" {
    description = "The name of the NetworkWatcher - NetworkWatcher_uksouth - select region accordingly"
    default = ""
}

variable "storage" {
  description = "storage account name - Select correct storage account depending on region"
  default = ""
}

variable "workspace" {
    description = "log analytics workspace name -  this is static no matter which region the nsg's reside in" 
    default = ""
}

variable "intervalminutes" {
    description = "interval minutes - this is static value. Please choose 10 or 60 mins interval" 
    default = 60
}

variable "vnet_name" {
    description = "spoke vnet name"
    default = ""
}

#########RUN ROOT MODULE###############

locals {
  subscription_id     = "VALUE"
  hub_subscription_id = "VALUE" 
}

provider "azurerm" {
  features {}
  alias           = "alias" 
  subscription_id = local.subscription_id
}

provider "azurerm" {
  features {}
  alias           = "alias"
  subscription_id = local.hub_subscription_id
}

module "nsgflowlogs" {
  depends_on = [module.spokesetup]
  source     = "github.com/UKHO/tfmodule-nsg-flow-logs?ref=0.6.0"
  providers = {
    azurerm.vnetflow = azurerm.alias
    azurerm.hub     = azurerm.alias
  }
  rg          = local.rg
  watcherrg   = local.watcherrg
  spokevnetrg = local.spokevnetrg
  spokevnet   = local.spokevnet
  watcher     = local.watcher
  storage     = local.storage
  workspace   = local.workspace
  vnet_name   = module.spokesetup.virtual_network_name
} 

