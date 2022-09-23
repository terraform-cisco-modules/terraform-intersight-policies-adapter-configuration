module "adapter_configuration" {
  source  = "terraform-cisco-modules/policies-adapter_configuration/intersight"
  version = ">= 1.0.1"

  adapter_ports = 2
  description   = "VIC 1497 Adapter Configuration Policy."
  fec_modes     = ["cl91"]
  name          = "default"
  organization  = "default"
}
