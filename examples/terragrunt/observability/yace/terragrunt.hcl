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
    assume_role_enabled = true
    exporter_assumable_roles = [
      "arn:aws:iam::${local.account_vars.locals.X.dev-0001.aws_account_id}:role/Y-${local.account_vars.locals.X.dev-0001.env_name}-yace-assumable-role",
      "arn:aws:iam::${local.account_vars.locals.X.qa-0001.aws_account_id}:role/Y-${local.account_vars.locals.X.qa-0001.env_name}-yace-assumable-role",
      "arn:aws:iam::${local.account_vars.locals.X.stage-0001.aws_account_id}:role/Y-${local.account_vars.locals.X.stage-0001.env_name}-yace-assumable-role"
    ]
    tags = local.common_tags.locals.common_tags
  }
  exporter_assume_role = {
    role_name                     = "${local.account_vars.locals.business_unit}-${local.account_vars.locals.env_name}-svc-k8s-${local.parent}-${local.name}"
    role_permissions_boundary_arn = local.account_vars.locals.permissions_boundary
    oidc_providers = {
      eks = {
        provider_arn               = dependency.eks.outputs.oidc_provider_arn
        namespace_service_accounts = ["observability:${local.name}"]
      }
    }
  }
}
