data "aws_iam_policy_document" "exporter_role" {
  #checkov:skip=CKV_AWS_356: https://github.com/nerdswords/yet-another-cloudwatch-exporter?tab=readme-ov-file#authentication
  count = var.common.exporter_role_enabled ? 1 : 0
  statement {
    sid    = "1"
    effect = "Allow"
    actions = [
      "tag:GetResources",
      "cloudwatch:GetMetricData",
      "cloudwatch:GetMetricStatistics",
      "cloudwatch:ListMetrics",
      "apigateway:GET",
      "aps:ListWorkspaces",
      "autoscaling:DescribeAutoScalingGroups",
      "dms:DescribeReplicationInstances",
      "dms:DescribeReplicationTasks",
      "ec2:DescribeTransitGatewayAttachments",
      "ec2:DescribeSpotFleetRequests",
      "shield:ListProtections",
      "storagegateway:ListGateways",
      "storagegateway:ListTagsForResource",
      "iam:ListAccountAliases"
    ]
    resources = [
      "*"
    ]
  }
}

data "aws_iam_policy_document" "assume_role" {
  count = var.common.assume_role_enabled ? 1 : 0
  statement {
    sid    = "1"
    effect = "Allow"
    actions = [
      "sts:AssumeRole",
    ]
    resources = [
      for i in var.common.exporter_assumable_roles : i
    ]
  }
}
