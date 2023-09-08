##Virtual network - VnetB
resource "azurerm_virtual_network" "tf-vnet02" {
  name                = var.vnetBname
  location            = azurerm_resource_group.tf-vnetrg01.location
  resource_group_name = azurerm_resource_group.tf-vnetrg01.name
  address_space       = var.vnetBcidr
  tags = local.commontags
  depends_on     = [ azurerm_resource_group.tf-vnetrg01 ]
}



