terraform {
  required_providers {
    random = {
      source  = "hashicorp/random"
      version = "3.7.1"
    }
    aws = {
      source  = "hashicorp/aws"
      version = "5.88.0"
    }
  }
}

provider "aws" {
  region = "eu-north-1"
}