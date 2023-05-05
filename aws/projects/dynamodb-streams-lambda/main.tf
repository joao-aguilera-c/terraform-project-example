locals {
  tags = {
    Environment = "dev"
    Project     = "dynamodb-streams-and-lambda"
  }
  region     = var.region
  account-id = var.account_id
}

provider "aws" {
  region = local.region
}

module "bark_table" {
  source = "../../modules/dynamodb"

  table_name = "BarkTable"
  hash_key   = "Username"
  range_key  = "Timestamp"
  attributes = [
    {
      name = "Username"
      type = "S"
    },
    {
      name = "Timestamp"
      type = "S"
    }
  ]
  read_capacity    = 1
  write_capacity   = 1
  stream_enabled   = true
  stream_view_type = "NEW_AND_OLD_IMAGES"
  tags             = local.tags
}

module "bark_lambda" {
  source = "../../modules/lambda"

  function_name      = "publishNewBark"
  handler            = "publishNewBark.handler"
  runtime            = "nodejs14.x"
  timeout            = 5
  lambda_path        = "publishNewBark"
  attach_policy_json = true
  policy_json        = <<EOT
{
    "Version": "2012-10-17",
    "Statement": [
        {
            "Effect": "Allow",
            "Action": [
                "dynamodb:DescribeStream",
                "dynamodb:GetRecords",
                "dynamodb:GetShardIterator",
                "dynamodb:ListStreams"
            ],
            "Resource": "arn:aws:dynamodb:${local.region}:${local.account-id}:table/BarkTable/stream/*"
        }
    ]
}
  EOT
  event_source_mapping = {
    dynamodb = {
      event_source_arn  = module.bark_table.dynamodb_table_stream_arn
      starting_position = "TRIM_HORIZON"
      batch_size        = 1
    }
  }
  allowed_triggers = {
    dynamodb = {
      principal  = "dynamodb.amazonaws.com"
      source_arn = module.bark_table.dynamodb_table_stream_arn
    }
  }
  tags = local.tags
}