module "dynamodb" {
  source = "terraform-aws-modules/dynamodb-table/aws"
  version = "3.2.0"

  name                        = var.table_name
  hash_key                    = var.hash_key
  range_key                   = var.range_key
  table_class                 = var.table_class
  deletion_protection_enabled = var.deletion_protection_enabled

  attributes = var.attributes

  global_secondary_indexes = var.global_secondary_indexes

  billing_mode   = var.billing_mode
  read_capacity  = var.read_capacity
  write_capacity = var.write_capacity

  stream_enabled = var.stream_enabled
  stream_view_type = var.stream_view_type

  tags = var.tags
}