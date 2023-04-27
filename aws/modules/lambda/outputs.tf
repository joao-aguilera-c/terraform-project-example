output "name" {
  value = module.lambda_function.lambda_function_name
}

output "arn" {
  value = module.lambda_function.lambda_function_arn
}