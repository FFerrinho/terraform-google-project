output "project_info" {
  value = [
    for project_name in keys(var.projects) : {
      project_id = google_project.main[project_name].project_id,
      number     = index(keys(var.projects), project_name) + 1
    }
  ]
}
