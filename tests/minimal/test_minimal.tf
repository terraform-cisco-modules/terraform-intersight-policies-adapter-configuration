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
  source   = "../.."
  org_moid = data.intersight_organization_organization.org_moid.moid
  name     = "test"
}
