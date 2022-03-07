# terraform-lacework-policies

Terraform module to allow `policy-as-code` style management of Lacework policies.
Requires a folder layout similar to the `lacework-content` repository.

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| lacework_content_path | Path fo the Lacework content directory. | `string` | - | yes |
| format | File format used for the queries and policies, either YAML or JSON. (Default: YAML) | `string`| `yaml` | no |
