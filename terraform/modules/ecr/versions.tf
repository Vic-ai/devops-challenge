terraform {
  required_version = ">= 1.3.0"
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 4.2"
    }
  }
}

provider "aws" {
  region = var.aws_region
}

# For ECR Public
provider "aws" {
  alias  = "ecr-public"
  region = "us-east-1"
}
