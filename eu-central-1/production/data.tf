data "aws_vpc" "federated-engineers-vpc" {
  id = var.vpc_id
}

data "aws_subnet" "private-subnet" {
  id = var.subnet_id
}

data "aws_subnet" "public-subnet" {
  id = var.subnet_id
}

data "aws_iam_policy" "sftp-policy" {
  arn = "arn:aws:iam::049417293525:policy/sftp-policy"
}

data "aws_iam_role" "sftp-role" {
  name = "sftp-role"
}

data "aws_s3_bucket" "sftp-bucket" {
  bucket = "sftp-bucket-demo-rofiat"
}