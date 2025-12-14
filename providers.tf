provider "aws" {
  default_tags {
    tags = {
      Environment = "Production"
      Owner       = "DE-Team"
      Managed_by  = "Terraform"
      Deployed_by = "Atlantis"

    }
  }
  region = "eu-central-1"
}