terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 3.0"
    }
  }
  backend "s3" {
    bucket = "jmresume.com"
    key    = "global/s3/terraform.tfstate"
    region = "us-east-2"
    profile = "Jaz.Admin"
  }
}

 provider "aws" {
  region = "us-east-2"
  profile = "Jaz.Admin"
}
