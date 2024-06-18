terraform {
  backend "s3" {
    bucket         = "generalpurpose-statefile-robotdreams"
    key            = "path/to/terraform.tfstate"
    region         = "eu-central-1"
  }
}

provider "aws" {
  region = "eu-central-1"
}

# Private S3 Bucket
resource "aws_s3_bucket" "private_bucket" {
  bucket = "generalpurpose-private-robotdreams"
  acl    = "private"
}

# Public S3 Bucket
resource "aws_s3_bucket" "public_bucket" {
  bucket = "generalpurpose-public-robotdreams"
  acl    = "public-read"
}

output "private_bucket_name" {
  value = aws_s3_bucket.private_bucket.bucket
}

output "public_bucket_name" {
  value = aws_s3_bucket.public_bucket.bucket
}
