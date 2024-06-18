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

resource "aws_s3_bucket" "private_bucket" {
  bucket = "generalpurpose-private-robotdreams"
  acl    = "private"
}

resource "aws_s3_bucket" "public_bucket" {
  bucket = "generalpurpose-public-robotdreams"
  acl    = "public-read"
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
