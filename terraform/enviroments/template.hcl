locals {
  service     = basename(path_relative_to_include())
  region      = basename(dirname(path_relative_to_include()))
  environment = basename(dirname(dirname(path_relative_to_include())))
  inputs      = try(yamldecode(file(find_in_parent_folders("inputs.yaml"))), {})
  tags = {
    "Project"     = "Vic.ai"
    "ManagedBy"   = "Terraform"
    "Environment" = local.environment
  }
}

remote_state {
  backend = "s3"
  config = {
    bucket                = "vic.ai-${local.environment}-${local.region}-tf-states"
    key                   = "platform/${local.region}/${local.environment}/${local.service}.tfstate"
    region                = local.region
    encrypt               = true
    dynamodb_table        = "terraform-lock"
    s3_bucket_tags        = local.tags
    disable_bucket_update = true
  }
}

generate "provider" {
  path      = "versions_override.tf"
  if_exists = "overwrite_terragrunt"
  contents  = <<EOF
    terraform {
      backend "s3" {}
    }
    provider "aws" {
      region = "${local.region}"
    }
  EOF
}

inputs = merge(
  local.inputs,
  {
    environment = local.environment
    tags        = local.tags
    aws_region  = local.region
  }
)

terraform_version_constraint = format("= 1.3.1")
