resource "aws_s3_bucket" "s3b" {
  bucket = "bucket1"
  acl    = "private"

  tags = {
    Name        = "bucket1"
    Environment = "Dev"
  }
}
