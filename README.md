# Terraform Module: NSG-Flow_logs

## Required Resources

- `Resource Group` exists or is created external to the module.
- `Provider` must be created external to the module.

## Usage

```terraform
# NSG Flow Logs with Traffic Analytics

## Creating nsg flow logs

## Usage Vars

variable "subscription_id" {
    default = ""
}

variable "hub_subscription_id" {
    description = "core services subscription"
    default = ""  
}

variable "rg" {
    description = "rg where the flowslogs will be stored"
    default = ""
}
variable "watcherrg" {
    description = "rg for NetworkWatcher"
    default = ""
}

variable "spokerg" {
    description = "rg where the nsg lives"
    default = ""
}

variable "spokensg" {
   description = "NSG where we want to enable flowlogs"
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

#provider "azurerm" {
#  features {}
#  alias = "nsgflow"
#  subscription_id = var.subscription_id  
#}


module "nsgflowlogs" {
  source                        = "./tfmodule-NSGflowlogs"
  providers = {
    azurerm.src = azurerm.logs
  }
   
   subscription_id          = "${var.subscription_id}"
   hub_subscription_id      = "${var.hub_subscription_id}"
   rg                       = "${var.rg}"
   watcherrg                = "${var.watcherrg}"
   spokerg                  = "${var.spokerg}"
   spokensg                 = "${var.spokensg}"
   watcher                  = "${var.watcher}"
   storage                  = "${var.storage}"
   workspace                = "${var.workspace}"
 }

