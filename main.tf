resource "random_id" "random" {
  byte_length = 2
}

resource "google_project" "main" {
  for_each            = var.projects
  name                = each.key
  project_id          = join("-", [each.key, random_id.random.dec])
  org_id              = each.value.org_id
  folder_id           = each.value.folder_id
  billing_account     = each.value.billing_account
  deletion_policy     = each.value.deletion_policy
  auto_create_network = each.value.auto_create_network

  labels = merge(each.value.labels,
    {
      managed = "terraform"
  })
}

locals {
  project_api_combinations = [
    for project_name, project in var.projects : [
      for api in coalesce(project.apis, []) : { project_name = project_name, api = api }
    ]
  ]
  flattened_combinations = flatten(local.project_api_combinations)
}

resource "google_project_service" "main" {
  for_each = {
    for index, combination in local.flattened_combinations : "${combination.project_name}-${combination.api}-${index}" => {
      project_name = combination.project_name
      api          = combination.api
    }
  }

  service = each.value.api
  project = google_project.main[each.value.project_name].project_id

  disable_dependent_services = true
  disable_on_destroy         = true
}
