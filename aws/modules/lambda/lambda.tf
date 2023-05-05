module "lambda_function" {
  source  = "terraform-aws-modules/lambda/aws"
  version = "4.16.0"

  function_name = var.function_name
  description   = var.description
  handler       = var.handler
  runtime       = var.runtime
  timeout       = var.timeout

  source_path = {
    path             = var.lambda_path
    pip_requirements = var.pip_requirements
    npm_requirements = var.npm_requirements
    npm_package_json = true
  }

  environment_variables = var.environment_variables

  attach_policy_statements = var.attach_policy_statements
  policy_statements        = var.policy_statements

  attach_policy_json = var.attach_policy_json
  policy_json        = var.policy_json

  event_source_mapping = var.event_source_mapping

  allowed_triggers = var.allowed_triggers
  publish          = true
  tags             = var.tags
}
