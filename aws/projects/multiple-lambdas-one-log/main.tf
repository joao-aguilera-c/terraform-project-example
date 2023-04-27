provider "aws" {
  region = var.region
}

module "general_log-group" {
  source = "../../modules/cloudwatch/log-group"

  name              = "${var.project_name}-general"
  retention_in_days = 30
  tags = {
    Project = var.project_name
  }
}

module "general_log-stream" {
  source = "../../modules/cloudwatch/log-stream"

  name           = "${var.project_name}-general"
  log_group_name = module.general_log-group.cloudwatch_log_group_name
}

locals {
  policy_statement = {
    general-log = {
      effect    = "Allow"
      actions   = ["logs:PutLogEvents"]
      resources = [module.general_log-stream.cloudwatch_log_stream_arn]
    }
  }
}



module "lambdaJs" {
  source        = "../../modules/lambda"
  function_name = "lambda1"
  description   = "lambda1"
  handler       = "index.lambda_handler"
  runtime       = "nodejs14.x"
  lambda_path   = "nodejs-lambda"
  timeout       = 60

  environment_variables = {
    LOG_GROUP_NAME  = module.general_log-group.cloudwatch_log_group_name
    LOG_STREAM_NAME = module.general_log-stream.cloudwatch_log_stream_name
  }

  attach_policy_statements = true
  policy_statements = local.policy_statement
}

module "lambdaPy" {
  source        = "../../modules/lambda"
  function_name = "lambda2"
  description   = "lambda2"
  handler       = "index.lambda_handler"
  runtime       = "python3.8"
  lambda_path   = "python-lambda"
  timeout       = 60

  environment_variables = {
    LOG_GROUP_NAME  = module.general_log-group.cloudwatch_log_group_name
    LOG_STREAM_NAME = module.general_log-stream.cloudwatch_log_stream_name
  }

  attach_policy_statements = true
  policy_statements = local.policy_statement
}
