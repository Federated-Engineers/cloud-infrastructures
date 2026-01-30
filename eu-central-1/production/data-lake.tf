resource "aws_s3_bucket" "example" {
  bucket = "my-tf-test-bucketwhatever12"

  tags = {
    Name        = "My bucket"
    Environment = "Dev"
  }
}