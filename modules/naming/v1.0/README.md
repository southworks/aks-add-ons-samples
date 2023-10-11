## Requirements

| Name | Version |
|------|---------|
| <a name="requirement_terraform"></a> [terraform](#requirement\_terraform) | >=1.3.1 |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_environment"></a> [environment](#input\_environment) | Environment used to generate the names. | `string` | n/a | yes |
| <a name="input_generator"></a> [generator](#input\_generator) | Map of domains/resources/quantity to generate the names. | `map(map(number))` | <pre>{<br>  "domain": {<br>    "resource": 1<br>  }<br>}</pre> | no |
| <a name="input_location"></a> [location](#input\_location) | Location used to generate the names. | `string` | n/a | yes |
| <a name="input_product_area"></a> [product\_area](#input\_product\_area) | n/a | `string` | n/a | yes |

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_env_abbr"></a> [env\_abbr](#output\_env\_abbr) | The abbreviated environment name. |
| <a name="output_environment"></a> [environment](#output\_environment) | Environment value received as variable. |
| <a name="output_generated_names"></a> [generated\_names](#output\_generated\_names) | A map containing the generated names. |
| <a name="output_location"></a> [location](#output\_location) | Location value received as variable. |

## How to call this module
Below is a code sample of how to engage the naming module through a deployment file. Note that product_area, environment, location, and generator should all be specified and the accepted values are limited.

Under Generator, the domain name should be specified. Domain names should be unique within a subscription. Reusing a domain name when deploying to the same subscription in multiple deployment files may result in collisions, due to duplicate names.
The domain input field is currently freeform and will accept any alphanumeric value that complies with the naming restrictions of the resource type specified by Azure. Here is a [link](https://docs.microsoft.com/en-us/azure/azure-resource-manager/management/resource-name-rules) to Azure naming restrictions.

```
module "naming" {
  source       = "<..>/naming/"
  product_area = "ucb"
  environment  = "staging"
  location     = "westeurope"
  generator = {
    domain = {
      resource_group  = 1
      virtual_machine = 5
      virtual_network = 2
    }
  }
}

resource "azurerm_resource_group" "resourcegroup" {
  name     = module.naming.generated_names.domain.resource_group[0]
  location = module.naming.location
  tags     = {}
}

```
