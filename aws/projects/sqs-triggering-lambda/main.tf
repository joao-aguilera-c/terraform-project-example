provider "aws" {
  region = var.region
}

locals {
  tags = {
    Project = var.project_name
  }

  policy_statement = {
    general-log = {
      effect = "Allow"
      actions = [
        "sqs:ReceiveMessage",
        "sqs:DeleteMessage",
        "sqs:GetQueueAttributes"
      ]
      resources = [module.sqs.queue_arn]
    }
  }
}


module "sqs" {
  source = "../../modules/sqs"

  name                       = "sqs"
  visibility_timeout_seconds = 300
  tags                       = local.tags
}

module "lambda" {
  source        = "../../modules/lambda"
  function_name = "sqsLambda"
  description   = "sqsLambda"
  handler       = "index.lambda_handler"
  runtime       = "python3.8"
  lambda_path   = "python-lambda"
  timeout       = 60
  tags          = local.tags

  pip_requirements = false

  attach_policy_statements = true
  policy_statements        = local.policy_statement
}

resource "aws_lambda_event_source_mapping" "event_source_mapping" {
  batch_size       = 1
  event_source_arn = module.sqs.queue_arn
  enabled          = true
  function_name    = module.lambda.name
}
