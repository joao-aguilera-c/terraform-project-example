variable "role_name" {
  type = string
}

variable "role_path" {
  type = string
}

variable "policy_arns" {
  type = list(string)
}

variable "tags" {
  type = map(string)
  default = {
    Environment = ""
    Project     = ""
  }
}