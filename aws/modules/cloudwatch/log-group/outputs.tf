output "cloudwatch_log_group_arn" {
  description = "The ARN of the CloudWatch Log Group."
  value       = module.cloudwatch_log-group.cloudwatch_log_group_arn
}

output "cloudwatch_log_group_name" {
  description = "The name of the CloudWatch Log Group."
  value       = module.cloudwatch_log-group.cloudwatch_log_group_name
}
