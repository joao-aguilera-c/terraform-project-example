variable "name" {
  description = "The name of the SNS queue"
  type        = string
}


variable "tags" {
  description = "A map of tags to add to all resources"
  type        = map(string)
  default     = {}
}
