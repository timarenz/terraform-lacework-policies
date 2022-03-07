# terraform-lacework-policies

Terraform module to allow `policy-as-code` style management of Lacework policies.
Requires a folder layout similar to the `lacework-content` repository. and `json`-based policies and queries.

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| lacework_content_path | Path fo the Lacework content directory. | `string` | - | yes |
