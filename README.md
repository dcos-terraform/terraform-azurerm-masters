![HashiCorp's Terraform](https://cultivatedops-static.s3.amazonaws.com/thirdparty/terraform/logo-50.png)

This repository is a [Terraform](https://terraform.io/) Module for azurerm virtual machine instances

The module creates AzureRM virtual machine instances

# Usage

Add the module to your Terraform resources like so:

```
module "terraform-azurerm-instance" {
  source = "./terraform-module-terraform-azurerm-instance"
  arg1 = "foo"
}
```

Then, load the module using `terraform get`.

# Options

This module supports a number of configuration options:

| option    | description |
|-----------|-|
| `arg1`    | argument #1 |

# Outputs

This module supports a number of outputs:

| output   | description |
|----------|-|
| `output` | value of the `resource.name.attr` resource  |
