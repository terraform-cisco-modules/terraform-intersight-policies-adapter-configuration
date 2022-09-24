#____________________________________________________________
#
# Adapter Configuration Policy Variables Section.
#____________________________________________________________


variable "adapter_ports" {
  default     = 4
  description = "The Number of Physical Ports of the Adapter."
  type        = number
}

variable "description" {
  default     = ""
  description = "Description of the Policy."
  type        = string
  # validation {
  #   condition = can(regex("^[[:ascii:]]{0,1024}$", var.description))
  #   error_message = "Allowed characters: Any ASCII Character. Maximum characters: 1024."
  # }
}

variable "enable_fip" {
  default     = true
  description = "Status of FIP protocol on the adapter interfaces."
  type        = bool
}

variable "enable_lldp" {
  default     = true
  description = "Status of LLDP protocol on the adapter interfaces."
  type        = bool
}

variable "enable_port_channel" {
  default     = true
  description = <<-EOT
    When Port Channel is enabled, two vNICs and two vHBAs are available for use on the adapter card.
    When disabled, four vNICs and four vHBAs are available for use on the adapter card. Disabling
    port channel reboots the server. Port Channel is supported only for Cisco VIC 1455/1457 adapters.
  EOT
  type        = bool
}

variable "fec_modes" {
  default     = ["cl91"]
  description = <<-EOT
    DCE Interface Forward Error Correction (FEC) mode setting for the DCE interfaces of the adapter. FEC mode setting is supported only for Cisco VIC 14xx adapters. FEC mode 'cl74' is unsupported for Cisco VIC 1495/1497. This setting will be ignored for unsupported adapters and for unavailable DCE interfaces.
    The List can be One value.  Assigned to All Interfaces. Or it must be a list of Four values for each Interface.
    * cl74 - Use cl74 standard as FEC mode setting. 'Clause 74' aka FC-FEC ('FireCode' FEC) offers simple, low-latency protection against 1 burst/sparse bit error, but it is not good for random errors.
    * cl91 - Use cl91 standard as FEC mode setting. 'Clause 91' aka RS-FEC ('ReedSolomon' FEC) offers better error protection against bursty and random errors but adds latency.
    * Off - Disable FEC mode on the DCE Interface.
  EOT
  type        = list(string)
  # validation {
  #   condition     = [for s in var.fec_modes : can(regex("^(cl74|cl91|Off)$", s))]
  #   error_message = "Allowed values are: `cl74`, `cl91`, `Off`."
  # }
}

variable "name" {
  default     = "default"
  description = "Name for the Policy."
  type        = string
  validation {
    condition     = can(regex("^[a-zA-Z0-9_.:-]{1,64}$", var.name))
    error_message = "Allowed characters: `a`-`z`, `A`-`Z`, `0`-`9`, `_`, `.`, `:`, `-`. Maximum characters: 64."
  }
}

variable "organization" {
  default     = "default"
  description = "Intersight Organization Name to Apply Policy to.  https://intersight.com/an/settings/organizations/."
  type        = string
}

variable "profiles" {
  default     = []
  description = <<-EOT
    List of Profiles to Assign to the Policy.
    * name - Name of the Profile to Assign.
    * object_type - Object Type to Assign in the Profile Configuration.
      - server.Profile - For UCS Server Profiles.
      - server.ProfileTemplate - For UCS Server Profile Templates.
  EOT
  type = list(object(
    {
      name        = string
      object_type = optional(string, "server.Profile")
    }
  ))
}

variable "pci_slot" {
  default     = "MLOM"
  description = "PCIe slot where the VIC adapter is installed. Supported values are (1-15) and MLOM."
  type        = string
  validation {
    condition     = can(regex("(MLOM|[0-9]|1[0-5])", var.pci_slot))
    error_message = "Allowed values are: `MLOM` or `1` thru `15`."
  }
}

variable "tags" {
  default     = []
  description = "List of Tag Attributes to Assign to the Policy."
  type        = list(map(string))
}
