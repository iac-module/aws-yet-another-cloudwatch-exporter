module "assume_policy" {
  source      = "git::https://github.com/terraform-aws-modules/terraform-aws-iam.git//modules/iam-policy?ref=02a5b7f35ecdd60498d978166ab2033bbdae5013" #v5.44.0"
  count       = var.common.assume_role_enabled ? 1 : 0
  name_prefix = var.assume_policy.policy_name_prefix
  path        = var.assume_policy.policy_path
  description = var.assume_policy.policy_description
  policy      = data.aws_iam_policy_document.assume_role[0].json
  tags        = merge(var.common.tags, var.assume_policy.tags)
}

module "assume_role" {
  count                                                           = var.common.assume_role_enabled ? 1 : 0
  source                                                          = "git::https://github.com/terraform-aws-modules/terraform-aws-iam.git//modules/iam-role-for-service-accounts-eks?ref=02a5b7f35ecdd60498d978166ab2033bbdae5013" #v5.44.0"
  create_role                                                     = var.assume_role.create_role
  role_name                                                       = var.assume_role.role_name
  role_path                                                       = var.assume_role.role_path
  role_permissions_boundary_arn                                   = var.assume_role.role_permissions_boundary_arn
  role_description                                                = var.assume_role.role_description
  role_name_prefix                                                = var.assume_role.role_name_prefix
  policy_name_prefix                                              = var.assume_role.policy_name_prefix
  role_policy_arns                                                = { policy = module.assume_policy[0].arn }
  oidc_providers                                                  = var.assume_role.oidc_providers
  tags                                                            = merge(var.common.tags, var.assume_role.tags)
  force_detach_policies                                           = var.assume_role.force_detach_policies
  max_session_duration                                            = var.assume_role.max_session_duration
  assume_role_condition_test                                      = var.assume_role.assume_role_condition_test
  allow_self_assume_role                                          = var.assume_role.allow_self_assume_role
  attach_aws_gateway_controller_policy                            = var.assume_role.attach_aws_gateway_controller_policy
  attach_cert_manager_policy                                      = var.assume_role.attach_cert_manager_policy
  cert_manager_hosted_zone_arns                                   = var.assume_role.cert_manager_hosted_zone_arns
  attach_cluster_autoscaler_policy                                = var.assume_role.attach_cluster_autoscaler_policy
  cluster_autoscaler_cluster_ids                                  = var.assume_role.cluster_autoscaler_cluster_ids
  cluster_autoscaler_cluster_names                                = var.assume_role.cluster_autoscaler_cluster_names
  attach_ebs_csi_policy                                           = var.assume_role.attach_ebs_csi_policy
  ebs_csi_kms_cmk_ids                                             = var.assume_role.ebs_csi_kms_cmk_ids
  attach_efs_csi_policy                                           = var.assume_role.attach_efs_csi_policy
  attach_mountpoint_s3_csi_policy                                 = var.assume_role.attach_mountpoint_s3_csi_policy
  mountpoint_s3_csi_bucket_arns                                   = var.assume_role.mountpoint_s3_csi_bucket_arns
  mountpoint_s3_csi_kms_arns                                      = var.assume_role.mountpoint_s3_csi_kms_arns
  mountpoint_s3_csi_path_arns                                     = var.assume_role.mountpoint_s3_csi_path_arns
  attach_external_dns_policy                                      = var.assume_role.attach_external_dns_policy
  external_dns_hosted_zone_arns                                   = var.assume_role.external_dns_hosted_zone_arns
  attach_external_secrets_policy                                  = var.assume_role.attach_external_secrets_policy
  external_secrets_ssm_parameter_arns                             = var.assume_role.external_secrets_ssm_parameter_arns
  external_secrets_secrets_manager_arns                           = var.assume_role.external_secrets_secrets_manager_arns
  external_secrets_kms_key_arns                                   = var.assume_role.external_secrets_kms_key_arns
  external_secrets_secrets_manager_create_permission              = var.assume_role.external_secrets_secrets_manager_create_permission
  attach_fsx_lustre_csi_policy                                    = var.assume_role.attach_fsx_lustre_csi_policy
  fsx_lustre_csi_service_role_arns                                = var.assume_role.fsx_lustre_csi_service_role_arns
  attach_karpenter_controller_policy                              = var.assume_role.attach_karpenter_controller_policy
  karpenter_controller_cluster_id                                 = var.assume_role.karpenter_controller_cluster_id
  karpenter_controller_cluster_name                               = var.assume_role.karpenter_controller_cluster_name
  karpenter_tag_key                                               = var.assume_role.karpenter_tag_key
  karpenter_controller_ssm_parameter_arns                         = var.assume_role.karpenter_controller_ssm_parameter_arns
  karpenter_controller_node_iam_role_arns                         = var.assume_role.karpenter_controller_node_iam_role_arns
  karpenter_subnet_account_id                                     = var.assume_role.karpenter_subnet_account_id
  karpenter_sqs_queue_arn                                         = var.assume_role.karpenter_sqs_queue_arn
  enable_karpenter_instance_profile_creation                      = var.assume_role.enable_karpenter_instance_profile_creation
  attach_load_balancer_controller_policy                          = var.assume_role.attach_load_balancer_controller_policy
  attach_load_balancer_controller_targetgroup_binding_only_policy = var.assume_role.attach_load_balancer_controller_targetgroup_binding_only_policy
  load_balancer_controller_targetgroup_arns                       = var.assume_role.load_balancer_controller_targetgroup_arns
  attach_appmesh_controller_policy                                = var.assume_role.attach_appmesh_controller_policy
  attach_appmesh_envoy_proxy_policy                               = var.assume_role.attach_appmesh_envoy_proxy_policy
  attach_amazon_managed_service_prometheus_policy                 = var.assume_role.attach_amazon_managed_service_prometheus_policy
  amazon_managed_service_prometheus_workspace_arns                = var.assume_role.amazon_managed_service_prometheus_workspace_arns
  attach_velero_policy                                            = var.assume_role.attach_velero_policy
  velero_s3_bucket_arns                                           = var.assume_role.velero_s3_bucket_arns
  attach_vpc_cni_policy                                           = var.assume_role.attach_vpc_cni_policy
  vpc_cni_enable_cloudwatch_logs                                  = var.assume_role.vpc_cni_enable_cloudwatch_logs
  vpc_cni_enable_ipv4                                             = var.assume_role.vpc_cni_enable_ipv4
  vpc_cni_enable_ipv6                                             = var.assume_role.vpc_cni_enable_ipv6
  attach_node_termination_handler_policy                          = var.assume_role.attach_node_termination_handler_policy
  node_termination_handler_sqs_queue_arns                         = var.assume_role.node_termination_handler_sqs_queue_arns
  attach_cloudwatch_observability_policy                          = var.assume_role.attach_cloudwatch_observability_policy
}
