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
        "sns:Publish"
      ]
      resources = [module.sns.topic_arn]
    }
  }
}


module "sns" {
  source = "../../modules/sns"

  name                       = "sns"
  tags                       = local.tags
}

module "lambda" {
  source        = "../../modules/lambda"
  function_name = "snsLambda"
  description   = "snsLambda"
  handler       = "index.lambda_handler"
  runtime       = "python3.8"
  lambda_path   = "python-lambda"
  timeout       = 60
  tags          = local.tags

  pip_requirements = false

  environment_variables = {
    SNS_TOPIC_ARN = module.sns.topic_arn
  }

  attach_policy_statements = true
  policy_statements        = local.policy_statement
}
