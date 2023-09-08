locals {
  commontags = {
    "Created by" = var.createdby
    "Owner"      = var.Owner
    "Env"        = var.Env 
  }
}

 resource "azurerm_resource_group" "tf-vmrg01" {
    name     = var.vmrgname
    location = var.cusregion
    tags     = local.commontags
    }
 

 resource "azurerm_resource_group" "tf-vnetrg01" {
   name = var.vnetrgname
   location = var.cusregion
   tags     = local.commontags
 }


