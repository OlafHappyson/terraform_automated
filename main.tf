terraform {
  backend "s3" {
    bucket         = "generalpurpose-statefile-robotdreams"
    key            = "path/to/terraform.tfstate"
    region         = "eu-central-1"
  }
}
