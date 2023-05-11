## Requirements

| Name | Version |
|------|---------|
| <a name="requirement_google"></a> [google](#requirement\_google) | 4.61.0 |

## Providers

| Name | Version |
|------|---------|
| <a name="provider_google"></a> [google](#provider\_google) | 4.61.0 |
| <a name="provider_random"></a> [random](#provider\_random) | n/a |

## Modules

No modules.

## Resources

| Name | Type |
|------|------|
| [google_project.main](https://registry.terraform.io/providers/hashicorp/google/4.61.0/docs/resources/project) | resource |
| [google_project_service.main](https://registry.terraform.io/providers/hashicorp/google/4.61.0/docs/resources/project_service) | resource |
| [random_id.random](https://registry.terraform.io/providers/hashicorp/random/latest/docs/resources/id) | resource |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_projects"></a> [projects](#input\_projects) | A map of projects to create. | <pre>map(object({<br>    project_id          = optional(string)<br>    org_id              = optional(string)<br>    folder_id           = optional(string)<br>    billing_account     = optional(string)<br>    skip_delete         = optional(bool)<br>    labels              = optional(map(string))<br>    auto_create_network = optional(bool)<br>    apis                = optional(list(string))<br>  }))</pre> | n/a | yes |

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_project_info"></a> [project\_info](#output\_project\_info) | n/a |
