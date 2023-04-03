terraform {
  required_providers {
    aws = {
      source = "hashicorp/aws"
      version = "4.61.0"
    }
  }
  backend "s3" {
    bucket = "tf-crunchyblue-s3"
    key    = "terraform/react-microfrontend"
    region = "us-east-2"
  }
}

provider "aws" {
  profile = "david"
  region = "us-east-2"
}