variable "common" {
  description = "The common variables"
  type = object({
    exporter_assumable_roles = optional(list(string))
    tags                     = optional(map(any), {})
    assume_role_enabled      = optional(bool, false)
    exporter_role_enabled    = optional(bool, false)
  })
  default = {}
}

variable "assume_policy" {
  description = "The role variables for exporter policy"
  type = object({
    create_policy      = optional(bool, true)
    policy_name_prefix = optional(string, "exporter")
    policy_path        = optional(string, "/")
    policy_description = optional(string, "The policy for exporter role")
    tags               = optional(map(any), {})
  })
  default = {}
}

variable "assume_role" {
  description = "Variables for assume role"
  type = object({
    create_role                   = optional(bool, true)
    role_name                     = optional(string, null)
    role_path                     = optional(string, "/")
    role_permissions_boundary_arn = optional(string, null)
    role_description              = optional(string, null)
    role_name_prefix              = optional(string, null)
    policy_name_prefix            = optional(string, "AmazonEKS_")
    role_policy_arns              = optional(map(string), {})
    oidc_providers                = optional(any, {})
    tags                          = optional(map(any), {})
    force_detach_policies         = optional(bool, true)
    max_session_duration          = optional(number, null)
    assume_role_condition_test    = optional(string, "StringEquals")
    allow_self_assume_role        = optional(bool, false)
    ################################################################################
    # Policies
    ################################################################################
    attach_aws_gateway_controller_policy = optional(bool, false)
    attach_cert_manager_policy           = optional(bool, false)
    cert_manager_hosted_zone_arns        = optional(list(string), ["arn:aws:route53:::hostedzone/*"])
    attach_cluster_autoscaler_policy     = optional(bool, false)
    cluster_autoscaler_cluster_ids       = optional(list(string), [])
    cluster_autoscaler_cluster_names     = optional(list(string), [])
    attach_ebs_csi_policy                = optional(bool, false)
    ebs_csi_kms_cmk_ids                  = optional(list(string), [])
    attach_efs_csi_policy                = optional(bool, false)
    attach_mountpoint_s3_csi_policy      = optional(bool, false)
    mountpoint_s3_csi_bucket_arns        = optional(list(string), [])
    mountpoint_s3_csi_kms_arns           = optional(list(string), [])
    mountpoint_s3_csi_path_arns          = optional(list(string), [])
    attach_external_dns_policy           = optional(bool, false)
    external_dns_hosted_zone_arns        = optional(list(string), ["arn:aws:route53:::hostedzone/*"])
    # External Secrets
    attach_external_secrets_policy                     = optional(bool, false)
    external_secrets_ssm_parameter_arns                = optional(list(string), ["arn:aws:ssm:*:*:parameter/*"])
    external_secrets_secrets_manager_arns              = optional(list(string), ["arn:aws:secretsmanager:*:*:secret:*"])
    external_secrets_kms_key_arns                      = optional(list(string), ["arn:aws:kms:*:*:key/*"])
    external_secrets_secrets_manager_create_permission = optional(bool, false)
    # FSx Lustre CSI
    attach_fsx_lustre_csi_policy     = optional(bool, false)
    fsx_lustre_csi_service_role_arns = optional(list(string), ["arn:aws:iam::*:role/aws-service-role/s3.data-source.lustre.fsx.amazonaws.com/*"])
    # Karpenter controller
    attach_karpenter_controller_policy                              = optional(bool, false)
    karpenter_controller_cluster_id                                 = optional(string, "*")
    karpenter_controller_cluster_name                               = optional(string, "*")
    karpenter_tag_key                                               = optional(string, "karpenter.sh/discovery")
    karpenter_controller_ssm_parameter_arns                         = optional(list(string), ["arn:aws:ssm:*:*:parameter/aws/service/*"])
    karpenter_controller_node_iam_role_arns                         = optional(list(string), ["*"])
    karpenter_subnet_account_id                                     = optional(string, "")
    karpenter_sqs_queue_arn                                         = optional(string, null)
    enable_karpenter_instance_profile_creation                      = optional(bool, false)
    attach_load_balancer_controller_policy                          = optional(bool, false)
    attach_load_balancer_controller_targetgroup_binding_only_policy = optional(bool, false)
    # AWS Load Balancer Controller
    load_balancer_controller_targetgroup_arns = optional(list(string), ["arn:aws:elasticloadbalancing:*:*:targetgroup/*/*"])
    attach_appmesh_controller_policy          = optional(bool, false)
    # AWS Appmesh envoy proxy
    attach_appmesh_envoy_proxy_policy                = optional(bool, false)
    attach_amazon_managed_service_prometheus_policy  = optional(bool, false)
    amazon_managed_service_prometheus_workspace_arns = optional(list(string), ["*"])
    # Velero
    attach_velero_policy  = optional(bool, false)
    velero_s3_bucket_arns = optional(list(string), ["*"])
    # VPC CNI
    attach_vpc_cni_policy                   = optional(bool, false)
    vpc_cni_enable_cloudwatch_logs          = optional(bool, false)
    vpc_cni_enable_ipv4                     = optional(bool, false)
    vpc_cni_enable_ipv6                     = optional(bool, false)
    attach_node_termination_handler_policy  = optional(bool, false)
    node_termination_handler_sqs_queue_arns = optional(list(string), ["*"])
    # Amazon CloudWatch Observability
    attach_cloudwatch_observability_policy = optional(bool, false)
  })
  default = {}
}

variable "exporter_policy" {
  description = "The role variables for exporter policy"
  type = object({
    create_policy      = optional(bool, true)
    policy_name_prefix = optional(string, "exporter")
    policy_path        = optional(string, "/")
    policy_description = optional(string, "The policy for exporter role")
    tags               = optional(map(any), {})
  })
  default = {}
}
variable "exporter_role" {
  description = "The role variables for exporter role"
  type = object({
    trusted_role_actions              = optional(list(string), ["sts:AssumeRole", "sts:TagSession"])
    trusted_role_arns                 = optional(list(string), [])
    trusted_role_services             = optional(list(string), [])
    mfa_age                           = optional(number, 86400)
    max_session_duration              = optional(number, 3600)
    create_role                       = optional(bool, true)
    create_instance_profile           = optional(bool, false)
    role_name                         = optional(string, null)
    role_name_prefix                  = optional(string, null)
    role_path                         = optional(string, "/")
    role_requires_mfa                 = optional(bool, false)
    role_permissions_boundary_arn     = optional(string, "")
    tags                              = optional(map(string), {})
    custom_role_policy_arns           = optional(list(string), [])
    custom_role_trust_policy          = optional(string, "")
    create_custom_role_trust_policy   = optional(bool, false)
    number_of_custom_role_policy_arns = optional(number, null)
    inline_policy_statements          = optional(any, [])
    admin_role_policy_arn             = optional(string, "arn:aws:iam::aws:policy/AdministratorAccess")
    poweruser_role_policy_arn         = optional(string, "arn:aws:iam::aws:policy/PowerUserAccess")
    readonly_role_policy_arn          = optional(string, "arn:aws:iam::aws:policy/ReadOnlyAccess")
    attach_admin_policy               = optional(bool, false)
    attach_poweruser_policy           = optional(bool, false)
    attach_readonly_policy            = optional(bool, false)
    force_detach_policies             = optional(bool, false)
    role_description                  = optional(string, "")
    role_sts_externalid               = optional(any, [])
    allow_self_assume_role            = optional(bool, false)
    role_requires_session_name        = optional(bool, false)
    role_session_name                 = optional(list(string), ["$${aws:username}"])
  })
  default = {}
}
