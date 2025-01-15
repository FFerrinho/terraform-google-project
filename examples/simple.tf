module "gcp_project" {
  source = "../"

  projects = {
    "my-project" = {
      org_id             = "1234567890"
      billing_account    = "ABCD-EFGH-IJKL-MNOP"
      apis              = ["compute.googleapis.com", "containerregistry.googleapis.com"]
      labels            = {}
      folder_id         = null
      skip_delete       = false
      auto_create_network = true
    }
  }
}
