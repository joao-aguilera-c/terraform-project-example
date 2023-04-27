# Copyright (c) HashiCorp, Inc.
# SPDX-License-Identifier: MPL-2.0

provider "aws" {
  region = var.region
}

module "general_log-group" {
  source  = "../../modules/cloudwatch/log-group"

  name = "${var.project_name}-general"
  retention_in_days = 30
  tags = {
    Project = var.project_name
  }
}

module "general_log-stream" {
  source  = "../../modules/cloudwatch/log-stream"

  name = "${var.project_name}-general"
  log_group_name = module.general_log-group.cloudwatch_log_group_name
}





# module "lambdaJs" {
#   source = "../modules/lambda"
#     function_name = "lambda1"
#     description = "lambda1"
#     handler = "index.lambda_handler"
#     runtime = "nodejs14.x"
#     lambda_path = "nodejs-lambda"
# }

# module "lambdaPy" {
#   source = "../modules/lambda"
#     function_name = "lambda2"
#     description = "lambda2"
#     handler = "index.lambda_handler"
#     runtime = "python3.8"
#     lambda_path = "python-lambda"
# }