# Terraform Module: NSG-Flow_logs

## Required Resources

- `Resource Group` exists or is created external to the module.
- `Provider` must be created external to the module.

## Usage

```terraform
# Private Endpoint

## Creating Private Enpoints

## Usage Vars

variable "subscription_id" {
    default = "0a275b4e-b4ed-4ac0-93b4-3899c98f56af"
}
variable "rg" {
    default = "shedtek-RG"
}
variable "spokerg" {
    default = "m-shedtek-appgateway-RG"
}

variable "spokensg" {
   default = "NSG-FlowLogs-VM-nsg"
}

variable "watcherrg" {
  default = "NetworkWatcherRG"
}

variable "watcher" {
    default = "NetworkWatcher_uksouth"    
}

variable "storage" {
  default = "shedtek"
}

variable "workspace" {
    default = "NSG-FlowLogs-Workspace"
}


#provider "azurerm" {
#  features {}
#  alias = "nsgflow"
#  subscription_id = var.subscription_id  
#}


module "nsgflowlogs" {
  source                        = "./tfmodule-nsg-flow-logs" 
    azurerm.src = azurerm.nsgflow
  }
   subscription_id          = "${var.subscription_id}"
   rg                       = "${var.rg}"
   watcherrg                = "${var.watcherrg}"
   spokerg                  = "${var.spokerg}"
   spokensg                 = "${var.spokensg}"
   watcher                  = "${var.watcher}"
   storage                  = "${var.storage}"
   workspace                = "${var.workspace}"
 }

