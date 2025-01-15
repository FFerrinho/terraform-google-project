variable "projects" {
  description = "A map of projects to create."
  type = map(object({
    project_id          = optional(string)
    org_id              = optional(string)
    folder_id           = optional(string)
    billing_account     = optional(string)
    deletion_policy     = optional(string)
    labels              = optional(map(string))
    auto_create_network = optional(bool)
    apis                = optional(list(string))
  }))

  validation {
    condition = alltrue([
    for project in var.projects :
    project.deletion_policy == null || contains(["PREVENT", "ABANDON", "DELETE"], project.deletion_policy)
    ])
    error_message = "deletion_policy must be one of: PREVENT, ABANDON, DELETE"
  }

  validation {
    condition = alltrue([
      for project in var.projects :
      project.auto_create_network == null || can(tobool(project.auto_create_network))
    ])
    error_message = "auto_create_network must be a boolean value (true/false)"
  }
  
}
