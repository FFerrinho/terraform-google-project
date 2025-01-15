output "project_info" {
  value = {
    for project_name, project in google_project.main : project_name => {
      id         = project.project_id
      project_id = project.project_id
      name       = project.name
      number     = project.number
    }
  }
}
