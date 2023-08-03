# Terraform Module: NSG-Flow_logs

## Required Resources

- `Resource Group` exists or is created external to the module.
- `Provider` must be created external to the module.

## Usage

```terraform
# NSG Flow Logs with Traffic Analytics

## Creating nsg flow logs

## Usage Vars

variable "rg" {
    description = "rg where the flowslogs will be stored"
    default = ""
}
variable "watcherrg" {
    description = "rg for NetworkWatcher"
    default = ""
}

variable "spokensgrg" {
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

variable "intervalminutes" {
    description = "interval minutes - this is static value. Please choose 10 or 60 mins interval" 
    default = 60
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
  source                        = "github.com/UKHO/tfmodule-nsg-flow-logs?ref=0.2.0"
  providers = {
    azurerm.nsgflow = azurerm.alias
    azurerm.hub = azurerm.alias
  }
   
   rg                       = "${var.rg}"
   watcherrg                = "${var.watcherrg}"
   spokerg                  = "${var.spokensgrg}"
   spokensg                 = "${var.spokensg}"
   watcher                  = "${var.watcher}"
   storage                  = "${var.storage}"
   workspace                = "${var.workspace}"
   intervalminutes          = "${var.intervalminutes}"
 }

