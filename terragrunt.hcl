remote_state {
  backend = "s3"

  config = {
    bucket = "tf-state-aws-acc-001"
    key    = "s3/${path_relative_to_include()}/terraform.tfstate"
    region = "sa-east-1"
  }
}

generate "provider" {
  path      = "provider.tf"
  if_exists = "overwrite"

  contents = <<EOF
  terraform {
    required_version = ">= 1.5.0"

    required_providers {
      aws = {
        source  = "hashicorp/aws"
        version = "~> 5.0"
      }
    }
  }

  provider "aws" {
    region = "sa-east-1"
  }
  EOF
}
