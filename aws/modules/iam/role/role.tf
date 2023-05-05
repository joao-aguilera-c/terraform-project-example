module "iam_role" {
  source      = "terraform-aws-modules/iam/aws//modules/iam-assumable-role"
  version     = "5.17.0"
  create_role = true

  role_name = var.role_name
  role_path = var.role_path

  custom_role_policy_arns = var.policy_arns

  role_requires_mfa = false

  tags = var.tags
}