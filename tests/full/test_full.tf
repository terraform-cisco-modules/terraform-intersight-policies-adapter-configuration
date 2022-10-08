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
