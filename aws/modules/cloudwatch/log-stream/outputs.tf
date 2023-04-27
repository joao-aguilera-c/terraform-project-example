output "cloudwatch_log_stream_arn" {
  description = "The ARN of the CloudWatch Log Stream."
  value       = module.cloudwatch_log-stream.cloudwatch_log_stream_arn
}

output "cloudwatch_log_stream_name" {
  description = "The name of the CloudWatch Log Stream."
  value       = module.cloudwatch_log-stream.cloudwatch_log_stream_name
}
