module "iam_policy" {
  source        = "terraform-aws-modules/iam/aws//modules/iam-policy"
  version       = "5.17.0"
  create_policy = true

  name   = var.policy_name
  path   = var.policy_path
  policy = var.policy
  tags   = var.tags
}