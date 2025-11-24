generate "providers" {
  path      = "providers.tf"
  if_exists = "overwrite_terragrunt" 
  contents  = <<-EOF
  provider "aws" {
    region = "sa-east-1"
    assume_role {
      role_arn = "arn:aws:iam::aws-acc-001:role/alfred-workflow-role-hom"
    }
  }

  provider "aws" {
    region = "us-east-1"
    alias  = "master"
    assume_role {
      role_arn = "arn:aws:iam::210778840360:role/alfred-workflow-role-hom"
    }
  }

  provider "aws" {
    alias = "org_main_account_provider"
    region = "us-east-1"
    assume_role {
      role_arn     = "arn:aws:iam::aws-acc-001:role/alfred-workflow-role"
    }
  }

  provider "vault" {
    address = "https://vbr.limbo.work"
    auth_login {
      path = "auth/approle/login"

      parameters = {
        role_id   = "${get_env("VAULT_ROLE_ID_BR")}"
        secret_id = "${get_env("VAULT_SECRET_ID_BR")}"
      }
    }
  }
  EOF
}
