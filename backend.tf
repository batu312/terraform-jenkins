terraform {
  backend "s3" {
    bucket = "bucket56789234"
    key    = "state/terraform.tfstate"
    region = "us-east-2"
  }
}
