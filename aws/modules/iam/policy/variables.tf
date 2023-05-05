variable "policy_name" {
  type = string
}

variable "policy" {
  description = "The policy as a JSON string"
  type        = string
}

variable "policy_path" {
  type        = string
  description = "The path of the policy in IAM"
  default     = "/"
}

variable "tags" {
  description = "AWS tags"
  type        = map(string)
  default = {
    Environment = ""
    Project     = ""
  }
}