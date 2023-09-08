

##Creating a virtual machine vm01
resource "azurerm_windows_virtual_machine" "tf-vm01" {
  name                = "${var.vm01name}"
  location            = azurerm_resource_group.tf-vmrg01.location
  resource_group_name = azurerm_resource_group.tf-vmrg01.name
  size                = var.vmsize["small28"]
  admin_username      = "adminuser"
  admin_password      = "P@$$w0rd1234!"
  network_interface_ids = [ azurerm_network_interface.tf-vm01nic.id ]

  os_disk {
    name                 = "${var.vm01name}-OsDisk"
    caching              = "ReadWrite"
    storage_account_type = "Standard_LRS"
  }

  source_image_reference {
    publisher = "MicrosoftWindowsServer"
    offer     = "WindowsServer"
    sku       = "2016-Datacenter"
    version   = "latest"
  }
}


##Creating a public IP for vm01
resource "azurerm_public_ip" "tf-vm01pubip" {
  name                = "${var.vm01name}-pubip"
  resource_group_name = azurerm_resource_group.tf-vmrg01.name
  location            = azurerm_resource_group.tf-vmrg01.location
  allocation_method   = "Static"
}

##creating a NIC for vm01
resource "azurerm_network_interface" "tf-vm01nic" {
  name                = "${var.vm01name}-nic"
  location            = azurerm_resource_group.tf-vmrg01.location
  resource_group_name = azurerm_resource_group.tf-vmrg01.name

  ip_configuration {
    name                          = "internal"
    subnet_id                     = azurerm_subnet.tf-sbt01.id
    private_ip_address_allocation = "Dynamic"
    public_ip_address_id          = azurerm_public_ip.tf-vm01pubip.id 
  }
}


##VM01 Data Disk creation
resource "azurerm_managed_disk" "tf-vm01dd01" {
  name                 = "${var.vm01name}-dd01"
  location             = azurerm_resource_group.tf-vmrg01.location
  resource_group_name  = azurerm_resource_group.tf-vmrg01.name
  storage_account_type = "Standard_LRS"
  create_option        = "Empty"
  disk_size_gb         = 4
}

##VM01 Datadisk01 attachment
resource "azurerm_virtual_machine_data_disk_attachment" "tf-vm01dd01attach" {
  managed_disk_id    = azurerm_managed_disk.tf-vm01dd01.id
  virtual_machine_id = azurerm_windows_virtual_machine.tf-vm01.id
  lun                = "0"
  caching            = "ReadWrite"
}

###########################################################


##Creating a virtual machine vm02
resource "azurerm_windows_virtual_machine" "tf-vm02" {
  name                = "${var.vm02name}"
  location            = azurerm_resource_group.tf-vmrg01.location
  resource_group_name = azurerm_resource_group.tf-vmrg01.name
  size                = var.vmsize["small28"]
  admin_username      = "adminuser"
  admin_password      = "P@$$w0rd1234!"
  network_interface_ids = [ azurerm_network_interface.tf-vm02nic.id ]

  os_disk {
    name                 = "${var.vm02name}-OsDisk"
    caching              = "ReadWrite"
    storage_account_type = "Standard_LRS"
  }

  source_image_reference {
    publisher = "MicrosoftWindowsServer"
    offer     = "WindowsServer"
    sku       = "2016-Datacenter"
    version   = "latest"
  }
}


##creating a NIC for vm02
resource "azurerm_network_interface" "tf-vm02nic" {
  name                = "${var.vm02name}-nic"
  location            = azurerm_resource_group.tf-vmrg01.location
  resource_group_name = azurerm_resource_group.tf-vmrg01.name

  ip_configuration {
    name                          = "internal"
    subnet_id                     = azurerm_subnet.tf-sbt02.id
    private_ip_address_allocation = "Dynamic"
  }
}


