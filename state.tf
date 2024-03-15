terraform {
  required_version = ">=1.2.0"

  backend "s3" {
    bucket         = "terraform-backend-infra360io"
    key            = "ap-south-1/prod/elk/terraform.tfstate"
    region         = "ap-south-1"
    dynamodb_table = "terraform-lock-infra360io"
    profile        = "infra360io"
  }

  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 4.31.0"
    }
    cloudinit = {
      source  = "hashicorp/cloudinit"
      version = "2.2.0"
    }
  }
}

provider "aws" {
  region  = var.region
  profile = var.aws_profile
  default_tags {
    tags = var.common_tags
  }
}
