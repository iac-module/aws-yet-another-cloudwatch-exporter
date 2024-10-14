module "exporter_policy" {
  source      = "git::https://github.com/terraform-aws-modules/terraform-aws-iam.git//modules/iam-policy?ref=02a5b7f35ecdd60498d978166ab2033bbdae5013" #v5.44.0"
  count       = var.common.exporter_role_enabled ? 1 : 0
  name_prefix = var.exporter_policy.policy_name_prefix
  path        = var.exporter_policy.policy_path
  description = var.exporter_policy.policy_description
  policy      = data.aws_iam_policy_document.exporter_role[0].json
  tags        = merge(var.common.tags, var.exporter_policy.tags)
}

module "exporter_role" {
  count                         = var.common.exporter_role_enabled ? 1 : 0
  source                        = "git::https://github.com/terraform-aws-modules/terraform-aws-iam.git//modules/iam-assumable-role?ref=02a5b7f35ecdd60498d978166ab2033bbdae5013" #v5.44.0"
  trusted_role_actions          = var.exporter_role.trusted_role_actions
  trusted_role_arns             = var.exporter_role.trusted_role_arns
  trusted_role_services         = var.exporter_role.trusted_role_services
  mfa_age                       = var.exporter_role.mfa_age
  max_session_duration          = var.exporter_role.max_session_duration
  create_role                   = var.exporter_role.create_role
  create_instance_profile       = var.exporter_role.create_instance_profile
  role_name                     = var.exporter_role.role_name
  role_name_prefix              = var.exporter_role.role_name_prefix
  role_path                     = var.exporter_role.role_path
  role_requires_mfa             = var.exporter_role.role_requires_mfa
  role_permissions_boundary_arn = var.exporter_role.role_permissions_boundary_arn
  tags                          = merge(var.common.tags, var.exporter_role.tags)

  custom_role_policy_arns = [module.exporter_policy[0].arn]

  custom_role_trust_policy          = var.exporter_role.custom_role_trust_policy
  create_custom_role_trust_policy   = var.exporter_role.create_custom_role_trust_policy
  number_of_custom_role_policy_arns = var.exporter_role.number_of_custom_role_policy_arns
  inline_policy_statements          = var.exporter_role.inline_policy_statements
  admin_role_policy_arn             = var.exporter_role.admin_role_policy_arn
  poweruser_role_policy_arn         = var.exporter_role.poweruser_role_policy_arn
  readonly_role_policy_arn          = var.exporter_role.readonly_role_policy_arn
  attach_admin_policy               = var.exporter_role.attach_admin_policy
  attach_poweruser_policy           = var.exporter_role.attach_poweruser_policy
  attach_readonly_policy            = var.exporter_role.attach_readonly_policy
  force_detach_policies             = var.exporter_role.force_detach_policies
  role_description                  = var.exporter_role.role_description
  role_sts_externalid               = var.exporter_role.role_sts_externalid
  allow_self_assume_role            = var.exporter_role.allow_self_assume_role
  role_requires_session_name        = var.exporter_role.role_requires_session_name
  role_session_name                 = var.exporter_role.role_session_name
}
