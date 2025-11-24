locals {
  providers = read_terragrunt_config(find_in_parent_folders("providers.hcl"))
  application_tags = {
    environment = "hom"
    module      = "v2.4.2"
    bu          = "bu-techcore"
    squad       = "squad-command-center"
    system      = "ms-cc-admin"
  }
}

inputs = merge(local.application_tags, {
  name = "teste"
  versioning = {
    status = false
  }
  policy = [
    {
      "sid": "grant-basic-access-teste",
      "effect": "Allow",
      "principals": {
        "AWS": [
          "arn:aws:iam::111111111111:role/eks-techcore-hom-cc-admin-s3"
        ]
      },
      "actions": [
        "s3:GetObject",
        "s3:ListBucket",
        "s3:ListBucketVersions",
        "s3:GetBucketLocation",
        "s3:GetObjectAcl",
        "s3:GetBucketVersioning",
        "s3:PutObject",
        "s3:DeleteObject",
        "s3:PutObjectTagging",
        "s3:PutObjectVersionTagging"
      ]
    }
  ]
})

terraform {
  source = "git@github.com:PicPay/aws-s3-tf-module-alfred.git//module?ref=v2.4.2"
}

include "root" {
  path = find_in_parent_folders("root.hcl")
}

generate = local.providers.generate
