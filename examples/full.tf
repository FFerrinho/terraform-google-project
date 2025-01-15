module "gcp_project" {
  source = "../"

  projects = {
    "prod-application" = {
      org_id             = "1234567890"
      billing_account    = "ABCD-EFGH-IJKL-MNOP"
      folder_id         = "9876543210"
      skip_delete       = true
      auto_create_network = false
      apis = [
        "compute.googleapis.com",
        "containerregistry.googleapis.com",
        "container.googleapis.com",
        "cloudbuild.googleapis.com",
        "cloudkms.googleapis.com",
        "monitoring.googleapis.com",
        "logging.googleapis.com"
      ]
      labels = {
        environment = "production"
        team        = "platform"
        cost-center = "123456"
      }
    },
    "staging-application" = {
      org_id             = "1234567890"
      billing_account    = "ABCD-EFGH-IJKL-MNOP"
      folder_id         = "9876543210"
      skip_delete       = false
      auto_create_network = true
      apis = [
        "compute.googleapis.com",
        "containerregistry.googleapis.com",
        "container.googleapis.com"
      ]
      labels = {
        environment = "staging"
        team        = "platform"
        cost-center = "123456"
      }
    }
  }
}
