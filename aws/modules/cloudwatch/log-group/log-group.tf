module "cloudwatch_log-group" {
  source  = "terraform-aws-modules/cloudwatch/aws//modules/log-group"
  version = "4.2.1"

  create            = true
  kms_key_id        = var.kms_key_id
  name              = var.name
  name_prefix       = var.name_prefix
  retention_in_days = var.retention_in_days
  tags              = var.tags
}
