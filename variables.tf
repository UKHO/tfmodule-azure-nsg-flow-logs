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