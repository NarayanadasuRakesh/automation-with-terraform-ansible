terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "5.32.1"
    }
  }
  backend "s3" {
    bucket         = "robotshop-vpc-dev"
    key            = "vpc"
    region         = "us-east-1"
    dynamodb_table = "robotshop-vpc-dev"
  }
}

provider "aws" {
  # Configuration options
}