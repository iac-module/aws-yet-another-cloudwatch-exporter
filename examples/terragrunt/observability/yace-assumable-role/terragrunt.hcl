include {
  path = find_in_parent_folders()
}
iam_role = local.account_vars.iam_role

terraform {
  source = "git::https://github.com/iac-module/aws-yet-another-cloudwatch-exporter.git//?ref=v1.0.0"
}

locals {
  common_tags  = read_terragrunt_config(find_in_parent_folders("tags.hcl"))
  account_vars = read_terragrunt_config(find_in_parent_folders("account.hcl"))
  region_vars  = read_terragrunt_config(find_in_parent_folders("region.hcl"))
  region       = local.region_vars.locals.aws_region
  name         = basename(get_terragrunt_dir())
  parent       = basename(dirname(get_terragrunt_dir()))
}
dependency "eks" {
  config_path = find_in_parent_folders("eks/cluster-0001")
}

inputs = {
  common = {
    exporter_role_enabled = true
    tags                  = local.common_tags.locals.common_tags
  }
  exporter_role = {
    role_requires_mfa       = false
    role_name               = "${local.account_vars.locals.business_unit}-${local.account_vars.locals.env_name}-${local.name}"
    trusted_role_arns       = ["arn:aws:iam::${local.account_vars.locals.X.infra-0001.aws_account_id}:role/${local.account_vars.locals.business_unit}-${local.account_vars.locals.X.infra-0001.env_name}-svc-k8s-${local.parent}-yace"]
    create_instance_profile = false
    trusted_role_services   = []
  }
}
