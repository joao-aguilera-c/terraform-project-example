module "cloudwatch_log-stream" {
  source  = "terraform-aws-modules/cloudwatch/aws//modules/log-stream"
  version = "4.2.1"

  create = true
  log_group_name = var.log_group_name
  name = var.name
}
