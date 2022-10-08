<!-- BEGIN_TF_DOCS -->
[![License: GPL v3](https://img.shields.io/badge/License-GPLv3-blue.svg)](https://www.gnu.org/licenses/gpl-3.0)
[![Developed by: Cisco](https://img.shields.io/badge/Developed%20by-Cisco-blue)](https://developer.cisco.com)
[![Tests](https://github.com/terraform-cisco-modules/terraform-intersight-policies-adapter-configuration/actions/workflows/terratest.yml/badge.svg)](https://github.com/terraform-cisco-modules/terraform-intersight-policies-adapter-configuration/actions/workflows/terratest.yml)

# Terraform Intersight Policies - Adapter Configuration
Manages Intersight Adapter Configuration Policies

Location in GUI:
`Policies` » `Create Policy` » `Adapter Configuration`

## Easy IMM

[*Easy IMM - Comprehensive Example*](https://github.com/terraform-cisco-modules/easy-imm-comprehensive-example) - A comprehensive example for policies, pools, and profiles.

## Example

### main.tf
```hcl
module "adapter_configuration" {
  source  = "terraform-cisco-modules/policies-adapter_configuration/intersight"
  version = ">= 1.0.1"

  adapter_ports = 2
  description   = "VIC 1497 Adapter Configuration Policy."
  fec_modes     = ["cl91"]
  name          = "default"
  organization  = "default"
}
```

### provider.tf
```hcl
terraform {
  required_providers {
    intersight = {
      source  = "CiscoDevNet/intersight"
      version = ">=1.0.32"
    }
  }
  required_version = ">=1.3.0"
}

provider "intersight" {
  apikey    = var.apikey
  endpoint  = var.endpoint
  secretkey = fileexists(var.secretkeyfile) ? file(var.secretkeyfile) : var.secretkey
}
```

### variables.tf
```hcl
variable "apikey" {
  description = "Intersight API Key."
  sensitive   = true
  type        = string
}

variable "endpoint" {
  default     = "https://intersight.com"
  description = "Intersight URL."
  type        = string
}

variable "secretkey" {
  default     = ""
  description = "Intersight Secret Key Content."
  sensitive   = true
  type        = string
}

variable "secretkeyfile" {
  default     = "blah.txt"
  description = "Intersight Secret Key File Location."
  sensitive   = true
  type        = string
}
```

## Environment Variables

### Terraform Cloud/Enterprise - Workspace Variables
- Add variable apikey with value of [your-api-key]
- Add variable secretkey with value of [your-secret-file-content]

### Linux and Windows
```bash
export TF_VAR_apikey="<your-api-key>"
export TF_VAR_secretkeyfile="<secret-key-file-location>"
```

## Requirements

| Name | Version |
|------|---------|
| <a name="requirement_terraform"></a> [terraform](#requirement\_terraform) | >=1.3.0 |
| <a name="requirement_intersight"></a> [intersight](#requirement\_intersight) | >=1.0.32 |
## Providers

| Name | Version |
|------|---------|
| <a name="provider_intersight"></a> [intersight](#provider\_intersight) | 1.0.32 |
## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_apikey"></a> [apikey](#input\_apikey) | Intersight API Key. | `string` | n/a | yes |
| <a name="input_endpoint"></a> [endpoint](#input\_endpoint) | Intersight URL. | `string` | `"https://intersight.com"` | no |
| <a name="input_secretkey"></a> [secretkey](#input\_secretkey) | Intersight Secret Key. | `string` | n/a | yes |
| <a name="input_adapter_ports"></a> [adapter\_ports](#input\_adapter\_ports) | The Number of Physical Ports of the Adapter. | `number` | `4` | no |
| <a name="input_description"></a> [description](#input\_description) | Description of the Policy. | `string` | `""` | no |
| <a name="input_enable_fip"></a> [enable\_fip](#input\_enable\_fip) | Status of FIP protocol on the adapter interfaces. | `bool` | `true` | no |
| <a name="input_enable_lldp"></a> [enable\_lldp](#input\_enable\_lldp) | Status of LLDP protocol on the adapter interfaces. | `bool` | `true` | no |
| <a name="input_enable_port_channel"></a> [enable\_port\_channel](#input\_enable\_port\_channel) | When Port Channel is enabled, two vNICs and two vHBAs are available for use on the adapter card.<br>When disabled, four vNICs and four vHBAs are available for use on the adapter card. Disabling<br>port channel reboots the server. Port Channel is supported only for Cisco VIC 1455/1457 adapters. | `bool` | `true` | no |
| <a name="input_fec_modes"></a> [fec\_modes](#input\_fec\_modes) | DCE Interface Forward Error Correction (FEC) mode setting for the DCE interfaces of the adapter. FEC mode setting is supported only for Cisco VIC 14xx adapters. FEC mode 'cl74' is unsupported for Cisco VIC 1495/1497. This setting will be ignored for unsupported adapters and for unavailable DCE interfaces.<br>The List can be One value.  Assigned to All Interfaces. Or it must be a list of Four values for each Interface.<br>* cl74 - Use cl74 standard as FEC mode setting. 'Clause 74' aka FC-FEC ('FireCode' FEC) offers simple, low-latency protection against 1 burst/sparse bit error, but it is not good for random errors.<br>* cl91 - Use cl91 standard as FEC mode setting. 'Clause 91' aka RS-FEC ('ReedSolomon' FEC) offers better error protection against bursty and random errors but adds latency.<br>* Off - Disable FEC mode on the DCE Interface. | `list(string)` | <pre>[<br>  "cl91"<br>]</pre> | no |
| <a name="input_name"></a> [name](#input\_name) | Name for the Policy. | `string` | `"default"` | no |
| <a name="input_organization"></a> [organization](#input\_organization) | Intersight Organization Name to Apply Policy to.  https://intersight.com/an/settings/organizations/. | `string` | `"default"` | no |
| <a name="input_profiles"></a> [profiles](#input\_profiles) | List of Profiles to Assign to the Policy.<br>* name - Name of the Profile to Assign.<br>* object\_type - Object Type to Assign in the Profile Configuration.<br>  - server.Profile - For UCS Server Profiles.<br>  - server.ProfileTemplate - For UCS Server Profile Templates. | <pre>list(object(<br>    {<br>      name        = string<br>      object_type = optional(string, "server.Profile")<br>    }<br>  ))</pre> | `[]` | no |
| <a name="input_pci_slot"></a> [pci\_slot](#input\_pci\_slot) | PCIe slot where the VIC adapter is installed. Supported values are (1-15) and MLOM. | `string` | `"MLOM"` | no |
| <a name="input_tags"></a> [tags](#input\_tags) | List of Tag Attributes to Assign to the Policy. | `list(map(string))` | `[]` | no |
## Outputs

| Name | Description |
|------|-------------|
| <a name="output_moid"></a> [moid](#output\_moid) | Adapter (VIC) Configuration Policy Managed Object ID (moid). |
## Resources

| Name | Type |
|------|------|
| [intersight_adapter_config_policy.adapter_configuration](https://registry.terraform.io/providers/CiscoDevNet/intersight/latest/docs/resources/adapter_config_policy) | resource |
| [intersight_organization_organization.org_moid](https://registry.terraform.io/providers/CiscoDevNet/intersight/latest/docs/data-sources/organization_organization) | data source |
| [intersight_server_profile.profiles](https://registry.terraform.io/providers/CiscoDevNet/intersight/latest/docs/data-sources/server_profile) | data source |
| [intersight_server_profile_template.templates](https://registry.terraform.io/providers/CiscoDevNet/intersight/latest/docs/data-sources/server_profile_template) | data source |
<!-- END_TF_DOCS -->