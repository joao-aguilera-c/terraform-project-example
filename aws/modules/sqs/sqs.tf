module "sqs" {
  source = "terraform-aws-modules/sqs/aws"

  name = var.name

  fifo_queue = var.fifo_queue
  visibility_timeout_seconds = var.visibility_timeout_seconds
  
  tags = var.tags
}
