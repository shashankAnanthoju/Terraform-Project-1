## This file is for assigning variables

## Tags values assigning
createdby = "Terraform"
Owner     = "Shashank"
Env       = "Testing"

##Resource Group values
vmrgname   = "tstvmrg"
cusregion  = "centralus"
vnetrgname = "vnetrg01"

##VNetA values
vnetAname  = "VNetA"
vnetAcidr  = ["10.1.0.0/16"]
sbt01name = "Public_Subnet"
sbt01cidr = ["10.1.0.0/28"]
sbt02name = "Private_Subnet"
sbt02cidr = ["10.1.0.16/28"]
nsg1name  = "tstwvm01_pub_nsg"
nsg2name  = "tstwvm02_pri_nsg" 

##VNetB values
vnetBname  = "VNetB"
vnetBcidr  = ["10.2.0.0/16"]

## Virtual network peering values from Vnet-A to Vnet-B
peervnetAtoVnetB = "peervnetAtovnetB"

## Virtual network peering values from Vnet-B to Vnet-A
peervnetBtoVnetA = "peervnetBtovnetA"


##VM01 values
vm01name  = "tstwvm01"

##VM02 values
vm02name  = "tstwvm02"