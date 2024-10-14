output "iam_exporter_policy_id" {
  description = "The policy's ID"
  value       = try(module.exporter_policy[0].id, "")
}

output "iam_exporter_policy_arn" {
  description = "The ARN assigned by AWS to this policy"
  value       = try(module.exporter_policy[0].arn, "")
}

output "iam_exporter_policy_description" {
  description = "The description of the policy"
  value       = try(module.exporter_policy[0].description, "")
}

output "iam_exporter_policy_name" {
  description = "The name of the policy"
  value       = try(module.exporter_policy[0].name, "")
}

output "iam_exporter_policy_path" {
  description = "The path of the policy in IAM"
  value       = try(module.exporter_policy[0].path, "")
}

output "iam_exporter_policy_policy" {
  description = "The policy document"
  value       = try(module.exporter_policy[0].policy, "")
}

#role


output "iam_exporter_role_arn" {
  description = "ARN of IAM role"
  value       = try(module.exporter_role[0].iam_role_arn, "")
}

output "iam_exporter_role_name" {
  description = "Name of IAM role"
  value       = try(module.exporter_role[0].iam_role_name, "")
}

output "iam_exporter_role_path" {
  description = "Path of IAM role"
  value       = try(module.exporter_role[0].iam_role_path, "")
}

output "iam_exporter_role_unique_id" {
  description = "Unique ID of IAM role"
  value       = try(module.exporter_role[0].iam_role_unique_id, "")
}

output "iam_exporter_requires_mfa" {
  description = "Whether IAM role requires MFA"
  value       = try(module.exporter_role[0].role_requires_mfa, "")
}

output "iam_exporter_instance_profile_arn" {
  description = "ARN of IAM instance profile"
  value       = try(module.exporter_role[0].iam_instance_profile_arn, "")
}

output "iam_exporter_instance_profile_name" {
  description = "Name of IAM instance profile"
  value       = try(module.exporter_role[0].iam_instance_profile_name, "")
}

output "iam_exporter_instance_profile_id" {
  description = "IAM Instance profile's ID."
  value       = try(module.exporter_role[0].iam_instance_profile_id, "")
}

output "iam_exporter_instance_profile_path" {
  description = "Path of IAM instance profile"
  value       = try(module.exporter_role[0].iam_instance_profile_path, "")
}

output "iam_exporter_sts_externalid" {
  description = "STS ExternalId condition value to use with a role"
  value       = try(module.exporter_role[0].role_sts_externalid, "")
}
