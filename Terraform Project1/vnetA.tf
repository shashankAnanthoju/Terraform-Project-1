##Virtual network - VnetA
resource "azurerm_virtual_network" "tf-vnet01" {
  name                = var.vnetAname
  location            = azurerm_resource_group.tf-vnetrg01.location
  resource_group_name = azurerm_resource_group.tf-vnetrg01.name
  address_space       = var.vnetAcidr
  tags = local.commontags
  depends_on     = [ azurerm_resource_group.tf-vnetrg01 ]
}

##Public Subnet for vm01
resource "azurerm_subnet" "tf-sbt01" {
  name                 = var.sbt01name
  resource_group_name  = azurerm_resource_group.tf-vnetrg01.name
  virtual_network_name = azurerm_virtual_network.tf-vnet01.name
  address_prefixes     = var.sbt01cidr
  depends_on           = [ azurerm_resource_group.tf-vnetrg01, azurerm_virtual_network.tf-vnet01]
}

## NSG creation and association to public subnet of VM01
resource "azurerm_network_security_group" "tf-nsg01" {
  name                = var.nsg1name
  location            = azurerm_resource_group.tf-vnetrg01.location
  resource_group_name = azurerm_resource_group.tf-vnetrg01.name

  security_rule {
    name                       = "myiptovm01custom3389"
    priority                   = 300
    direction                  = "Inbound"
    access                     = "Allow"
    protocol                   = "Tcp"
    source_port_range          = "*"
    destination_port_range     = "3389"
    source_address_prefix      = "99.248.178.39"
    destination_address_prefix = "*"
  }
}

  resource "azurerm_subnet_network_security_group_association" "tf-nsg_associate01" {
  subnet_id                 = azurerm_subnet.tf-sbt01.id
  network_security_group_id = azurerm_network_security_group.tf-nsg01.id
}


##Private Subnet for vm02
resource "azurerm_subnet" "tf-sbt02" {
  name                 = var.sbt02name
  resource_group_name  = azurerm_resource_group.tf-vnetrg01.name
  virtual_network_name = azurerm_virtual_network.tf-vnet01.name
  address_prefixes     = var.sbt02cidr
  depends_on           = [ azurerm_resource_group.tf-vnetrg01, azurerm_virtual_network.tf-vnet01 ]
}

## NSG creation and association to private subnet of VM02
resource "azurerm_network_security_group" "tf-nsg02" {
  name                = var.nsg2name
  location            = azurerm_resource_group.tf-vnetrg01.location
  resource_group_name = azurerm_resource_group.tf-vnetrg01.name

  security_rule {
    name                       = "vm01tovm02custom3389"
    priority                   = 301
    direction                  = "Inbound"
    access                     = "Allow"
    protocol                   = "Tcp"
    source_port_range          = "*"
    destination_port_range     = "3389"
    source_address_prefix      = "10.1.0.0"
    destination_address_prefix = "10.1.0.16"
  }
}

  resource "azurerm_subnet_network_security_group_association" "tf-nsg_associate02" {
  subnet_id                 = azurerm_subnet.tf-sbt02.id
  network_security_group_id = azurerm_network_security_group.tf-nsg02.id
}


## Virtual network peering for Vnet-A
resource "azurerm_virtual_network_peering" "tf-vnetAtoVnetB" {
  name                      = var.peervnetAtoVnetB
  resource_group_name       = azurerm_resource_group.tf-vnetrg01.name
  virtual_network_name      = azurerm_virtual_network.tf-vnet01.name
  remote_virtual_network_id = azurerm_virtual_network.tf-vnet02.id

}

## Virtual network peering for Vnet-B
resource "azurerm_virtual_network_peering" "tf-vnetBtoVnetA" {
  name                      = var.peervnetBtoVnetA
  resource_group_name       = azurerm_resource_group.tf-vnetrg01.name
  virtual_network_name      = azurerm_virtual_network.tf-vnet02.name
  remote_virtual_network_id = azurerm_virtual_network.tf-vnet01.id
  
}
