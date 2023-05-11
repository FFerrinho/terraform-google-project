variable "projects" {
  description = "A map of projects to create."
  type = map(object({
    project_id          = optional(string)
    org_id              = optional(string)
    folder_id           = optional(string)
    billing_account     = optional(string)
    skip_delete         = optional(bool)
    labels              = optional(map(string))
    auto_create_network = optional(bool)
    apis                = optional(list(string))
  }))
}
