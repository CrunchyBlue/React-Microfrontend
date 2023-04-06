terraform {
  required_providers {
    aws = {
      source = "hashicorp/aws"
      version = "4.61.0"
    }
  }
  backend "s3" {
    bucket = "s3-crunchyblue-tf"
    key    = "terraform/react-microfrontend"
    region = "us-east-1"
  }
}

provider "aws" {
  profile = "david"
  region = "us-east-1"
}