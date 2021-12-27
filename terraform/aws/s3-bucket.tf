resource "aws_s3_bucket" "testbucketforharshita" {
  bucket = "backends3dec27"
  acl    = "private"

  tags = {
    Name        = "backends3dec27"
    Environment = "Dev"
  }
}
