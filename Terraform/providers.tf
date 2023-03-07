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
    shared_credentials_file = "~/.aws/credentials"
    
  }
}

 provider "aws" {
  region = "us-east-2"
  
}
