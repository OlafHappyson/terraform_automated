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
  bucket = "my-private-bucket-example"
}

resource "aws_s3_bucket_policy" "private_bucket_policy" {
  bucket = aws_s3_bucket.private_bucket.id

  policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Effect = "Deny"
        Principal = "*"
        Action = "s3:GetObject"
        Resource = "${aws_s3_bucket.private_bucket.arn}/*"
        Condition = {
          Bool = {
            "aws:SecureTransport" = "false"
          }
        }
      }
    ]
  })
}

# Public S3 Bucket
resource "aws_s3_bucket" "public_bucket" {
  bucket = "my-public-bucket-example"
}

resource "aws_s3_bucket_policy" "public_bucket_policy" {
  bucket = aws_s3_bucket.public_bucket.id

  policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Effect = "Allow"
        Principal = "*"
        Action = "s3:GetObject"
        Resource = "${aws_s3_bucket.public_bucket.arn}/*"
      }
    ]
  })
}

output "private_bucket_name" {
  value = aws_s3_bucket.private_bucket.bucket
}

output "public_bucket_name" {
  value = aws_s3_bucket.public_bucket.bucket
}
