locals {
  commontags = {
    "Created by" = var.createdby
    "Owner"      = var.Owner
    "Env"        = var.Env 
  }
}


resource "azurerm_resource_group" "tf-vmrg" {
  name = var.rgname
  location = var.cusregion
  tags = local.commontags
}