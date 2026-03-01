terraform {
  backend "s3" {
    bucket = "federated-engineers-terraform-state"
    key    = "production/data-platform-team/terraform.tfstate"
    region = "eu-central-1"
  }
}
