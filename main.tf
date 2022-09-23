#____________________________________________________________
#
# Intersight Organization Data Source
# GUI Location: Settings > Settings > Organizations > {Name}
#____________________________________________________________

data "intersight_organization_organization" "org_moid" {
  name = var.organization
}

#____________________________________________________________
#
# Intersight UCS Server Profile(s) Data Source
# GUI Location: Profiles > UCS Server Profiles > {Name}
#____________________________________________________________

data "intersight_server_profile" "profiles" {
  for_each = { for v in local.profiles : v.name => v if v.object_type == "server.Profile" }
  name     = each.value.name
}

#__________________________________________________________________
#
# Intersight UCS Server Profile Template(s) Data Source
# GUI Location: Templates > UCS Server Profile Templates > {Name}
#__________________________________________________________________

data "intersight_server_profile_template" "templates" {
  for_each = { for v in local.profiles : v.name => v if v.object_type == "server.ProfileTemplate" }
  name     = each.value.name
}

#_________________________________________________________________
#
# Intersight Adapter Configuration Policy
# GUI Location: Policies > Create Policy > Adapter Configuration
#_________________________________________________________________

locals {
  dce_interface_settings = [for i in range(var.adapter_ports) :
    {
      additional_properties = ""
      class_id              = "adapter.DceInterfaceSettings"
      fec_mode = length(
        var.fec_modes) == 1 ? element(var.fec_modes, 0) : element(var.fec_modes, i
      )
      interface_id = i
      object_type  = "adapter.DceInterfaceSettings"
    }
  ]
  profiles = {
    for v in var.profiles : v.name => {
      name        = v.name
      object_type = v.object_type != null ? v.object_type : "server.Profile"
    }
  }
}

resource "intersight_adapter_config_policy" "adapter_configuration" {
  depends_on = [
    data.intersight_server_profile.profiles,
    data.intersight_server_profile_template.templates,
    data.intersight_organization_organization.org_moid
  ]
  description = var.description != "" ? var.description : "${var.name} Adapter Configuration Policy."
  name        = var.name
  organization {
    moid        = data.intersight_organization_organization.org_moid.results[0].moid
    object_type = "organization.Organization"
  }
  settings {
    object_type            = "adapter.AdapterConfig"
    slot_id                = var.pci_slot
    dce_interface_settings = local.dce_interface_settings
    eth_settings {
      lldp_enabled = var.enable_lldp
    }
    fc_settings {
      fip_enabled = var.enable_fip
    }
    port_channel_settings {
      enabled = var.enable_port_channel
    }
  }
  dynamic "profiles" {
    for_each = local.profiles
    content {
      moid = length(regexall("server.ProfileTemplate", profiles.value.object_type)
        ) > 0 ? data.intersight_server_profile_template.templates[profiles.value.name].results[0
      ].moid : data.intersight_server_profile.profiles[profiles.value.name].results[0].moid
      object_type = profiles.value.object_type
    }
  }
  dynamic "tags" {
    for_each = var.tags
    content {
      key   = tags.value.key
      value = tags.value.value
    }
  }
}
