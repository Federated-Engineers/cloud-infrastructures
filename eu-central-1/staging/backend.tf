terraform {
  backend "s3" {
    bucket = "federated-engineers-terraform-state"
    key    = "staging/data-platform-team/terraform.tfstate"
    region = "eu-central-1"
  }
}
