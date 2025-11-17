include {
  path = find_in_parent_folders()
}

terraform {
  source = "git::https://github.com/Luis-Henrique/aws-s3-tf-module-alfred.git//module?ref=main"
}

inputs = {
  bucket_name    = "teste"
  aws_account_id = "aws-acc-001"

  env   = "hom"
  bu    = "bu-techcore"
  squad = "squad-command-center"
  product = "ms-cc-admin"

  shared              = false
  tribe               = "alfred"
  criticality         = "medium"
  data_classification = "internal"
}
