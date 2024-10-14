output "iam_assume_policy_id" {
  description = "The policy's ID"
  value       = try(module.assume_policy[0].id, "")
}

output "iam_assume_policy_arn" {
  description = "The ARN assigned by AWS to this policy"
  value       = try(module.assume_policy[0].arn, "")
}

output "iam_assume_policy_description" {
  description = "The description of the policy"
  value       = try(module.assume_policy[0].description, "")
}

output "iam_assume_policy_name" {
  description = "The name of the policy"
  value       = try(module.assume_policy[0].name, "")
}

output "iam_assume_policy_path" {
  description = "The path of the policy in IAM"
  value       = try(module.assume_policy[0].path, "")
}

output "iam_assume_policy_policy" {
  description = "The policy document"
  value       = try(module.assume_policy[0].policy, "")
}

#role
output "iam_assume_role_arn" {
  description = "ARN of IAM role"
  value       = try(module.assume_role[0].iam_role_arn, "")
}

output "iam_assume_role_name" {
  description = "Name of IAM role"
  value       = try(module.assume_role[0].iam_role_name, "")
}

output "iam_assume_role_path" {
  description = "Path of IAM role"
  value       = try(module.assume_role[0].iam_role_path, "")
}

output "iam_assume_role_unique_id" {
  description = "Unique ID of IAM role"
  value       = try(module.assume_role[0].iam_role_unique_id, "")
}
