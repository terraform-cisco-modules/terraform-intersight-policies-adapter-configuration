terraform {
  required_providers {
    test = {
      source = "terraform.io/builtin/test"
    }

    intersight = {
      source  = "CiscoDevNet/intersight"
      version = ">=1.0.32"
    }
  }
}

data "intersight_organization_organization" "org_moid" {
  name = "default"
}

module "main" {
  source              = "../.."
  description         = "Adapter Configuration Example"
  enable_fip          = true
  enable_lldp         = true
  enable_port_channel = true
  fec_mode_1          = "cl91"
  fec_mode_2          = "cl91"
  fec_mode_3          = "cl91"
  fec_mode_4          = "cl91"
  name                = "test"
  org_moid            = data.intersight_organization_organization.org_moid.moid
  pci_slot            = "MLOM"
}

data "intersight_adapter_config_policy" "adapter_configuration" {
  depends_on = [
    module.main
  ]
  name         = "test"
}

resource "test_assertions" "adapter_configuration" {
  component = "adapter_configuration"

  # equal "description" {
  #   description = "description"
  #   got         = data.intersight_adapter_config_policy.adapter_configuration.description
  #   want        = "Adapter Configuration Example"
  # }
  # 
  # equal "name" {
  #   description = "name"
  #   got         = data.intersight_adapter_config_policy.adapter_configuration.name
  #   want        = "test"
  # }

  equal "settings" {
    description = "settings"
    got         = data.intersight_adapter_config_policy.adapter_configuration.results[0].settings
    want        = "tyson"
  }
}