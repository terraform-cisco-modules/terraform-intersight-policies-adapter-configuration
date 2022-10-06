terraform {
  required_providers {
    intersight = {
      source  = "CiscoDevNet/intersight"
      version = ">=1.0.32"
    }
  }
}

# Setup provider, variables and outputs
provider "intersight" {
  apikey    = var.intersight_keyid
  secretkey = file(var.intersight_secretkeyfile)
  endpoint  = var.intersight_endpoint
}

variable "intersight_keyid" {}
variable "intersight_secretkeyfile" {}
variable "intersight_endpoint" {
  default = "intersight.com"
}
variable "name" {}

output "moid" {
  value = module.main.moid
}

# This is the module under test
module "main" {
  source              = "../.."
  adapter_ports       = 4
  description         = "VIC 1467 Adapter Configuration Policy."
  enable_fip          = true
  enable_lldp         = true
  enable_port_channel = true
  fec_modes           = ["cl91"]
  name                = var.name
  organization        = "terratest"
  pci_slot            = "MLOM"
}
