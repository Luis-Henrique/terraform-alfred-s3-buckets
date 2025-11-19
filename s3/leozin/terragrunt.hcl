include {
  path = find_in_parent_folders()
}

terraform {
  source = "git::https://github.com/Luis-Henrique/aws-s3-tf-module-alfred.git//module?ref=main"
}

inputs = {
  bucket_name    = "leozin"
  aws_account_id = "aws-acc-001"

  env     = "hom"
  bu      = "bu-techcore"
  squad   = "squad-command-center"
  product = "ms-cc-monitoring"

  shared              = false
  tribe               = "alfred"
  criticality         = "medium"
  data_classification = "internal"

  enable_principal_access = "Sim;true" == "Sim;true"
  resource_type = "EKS"
  resource_name = ""

  cluster_eks   = "eks-techcore-hom"
  namespace_eks = "observability"
}

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
