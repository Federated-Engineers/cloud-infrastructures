resource "aws_s3_bucket" "example" {
  bucket = "my-tf-test-bucketwhatever1"

  tags = {
    Name        = "My bucket"
    Environment = "Dev"
  }
}