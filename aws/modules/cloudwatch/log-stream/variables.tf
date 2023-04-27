variable "log_group_name" {
  description = "The name of the log group to create."
  type        = string
  default     = null
}

variable "name" {
  description = "The name of the log stream to create."
  type        = string
  default     = null
}
