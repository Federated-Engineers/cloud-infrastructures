data "aws_vpc" "test-vpc-before-AK-vpc" {
  id = var.vpc_id
}

data "aws_subnet" "test-vpc-before-AK-subnet-public1-eu-central-1a" {
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