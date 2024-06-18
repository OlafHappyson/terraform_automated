variable "aws_access_key" {}
variable "aws_secret_key" {}
variable "s3_bucket" {}
variable "s3_key" {}
variable "s3_region" {}

provider "aws" {
  access_key = var.aws_access_key
  secret_key = var.aws_secret_key
  region     = var.s3_region
}

terraform {
  backend "s3" {
    bucket         = var.s3_bucket
    key            = var.s3_key
    region         = eu-central-1
  }
}
