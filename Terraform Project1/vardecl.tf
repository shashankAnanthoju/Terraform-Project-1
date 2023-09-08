## This file is for declaring variables

## tags variables declaration
variable "createdby" { type = string }
variable "Owner"     { type = string }
variable "Env"       { type = string }

## VM Resource group variables declaration
variable "vmrgname"  { type = string }
variable "cusregion" { type = string }


## VNET-A variables declaration
variable "vnetrgname"     { type = string }
variable "vnetAname"      { type = string }
variable "vnetAcidr"      { type = list   }
variable "sbt01name"      { type = string }
variable "sbt01cidr"      { type = list   }
variable "sbt02name"      { type = string }
variable "sbt02cidr"      { type = list   }
variable "nsg1name"       { type = string }
variable "nsg2name"       { type = string }

## VNET-B variables declaration
variable "vnetBname"     { type = string }
variable "vnetBcidr"     { type = list   }

## Virtual network peering from Vnet-A to Vnet-B
variable "peervnetAtoVnetB" { type = string }

## Virtual network peering from Vnet-B to Vnet-A
variable "peervnetBtoVnetA" { type = string }


##VM01 Variables
variable "vm01name"  { type = string }

##VM02 Variables
variable "vm02name"  { type = string }

##VM Size variables
variable "vmsize"  {
    type = map
    default = {
        "xsmall24"   = "Standard_B2s"
        "small28"    = "Standard_B2ms"
        "medium416"  = "Standard_B4ms"
        "large832"   = "Standard_B8ms"
        "xlarge1664" = "Standard_B16ms"
    }
}