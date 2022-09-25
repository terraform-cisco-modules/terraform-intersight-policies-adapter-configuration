<!-- BEGIN_TF_DOCS -->
[![Tests](https://github.com/terraform-cisco-modules/terraform-intersight-policies-adapter-configuration/actions/workflows/test.yml/badge.svg)](https://github.com/terraform-cisco-modules/terraform-intersight-policies-adapter-configuration/actions/workflows/test.yml)
# Terraform Intersight Policies - Adapter Configuration
Manages Intersight Adapter Configuration Policies

Location in GUI:
`Policies` » `Create Policy` » `Adapter Configuration`

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
  description = "Intersight Secret Key."
  sensitive   = true
  type        = string
}
```

## Environment Variables

### Terraform Cloud/Enterprise - Workspace Variables
- Add variable apikey with value of [your-api-key]
- Add variable secretkey with value of [your-secret-file-content]

### Linux
```bash
export TF_VAR_apikey="<your-api-key>"
export TF_VAR_secretkey=`cat <secret-key-file-location>`
```

### Windows
```bash
$env:TF_VAR_apikey="<your-api-key>"
$env:TF_VAR_secretkey="<secret-key-file-location>""
```
<!-- END_TF_DOCS -->