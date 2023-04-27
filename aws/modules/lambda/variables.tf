variable "function_name" {
  description = "The name of the lambda function"
  type        = string
  default     = "my-lambda1"
}

variable "description" {
  description = "The description of the lambda function"
  type        = string
  default     = "lambda function"
}

variable "handler" {
  description = "The handler of the lambda function"
  type        = string
  default     = "index.lambda_handler"
}

variable "runtime" {
  description = "The runtime of the lambda function"
  type        = string
  default     = "python3.9"
}

variable "timeout" {
  description = "The timeout of the lambda function"
  type        = number
  default     = 3
}

variable "lambda_path" {
  description = "The path of the lambda function"
  type        = string
  default     = "index.py"
}

variable "pip_requirements" {
  description = "The pip requirements file path of the lambda function, if true, it tries to install the requirements.txt file if it in on lambda_path"
  default     = true
}

variable "npm_requirements" {
  description = "The npm requirements file path of the lambda function, if true, it tries to install the package.json file if it in on lambda_path"
  default     = true
}

variable "environment_variables" {
  description = "A map that defines environment variables for the Lambda Function."
  type        = map(string)
  default     = {}
}

variable "attach_policy_statements" {
  description = "Whether to attach a custom policy statements to the lambda role"
  type        = bool
  default     = false
}

variable "policy_statements" {
  description = "A list of custom policy statements to attach to the lambda role"
  type        = any
  default     = {}
}

variable "tags" {
  description = "The tags of the lambda function"
  type        = map(string)
  default = {
    Name = "my-lambda1"
  }
}
