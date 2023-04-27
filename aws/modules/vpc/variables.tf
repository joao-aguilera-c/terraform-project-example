variable "project_name" {
  description = "Project name"
  type        = string
  default     = ""
}

variable "cidr" {
  description = "The CIDR block for the VPC."
  default     = "10.0.0.0/21"
}

variable "private_subnets" {
  description = "A list of CIDR blocks for the private subnets."
  default     = ["10.0.1.0/23", "10.0.2.0/23", "10.0.3.0/23"]
}

variable "public_subnets" {
  description = "A list of CIDR blocks for the public subnets."
  default     = ["10.0.4.0/26", "10.0.5.0/26", "10.0.6.0/26"]
}

variable "tags" {
  description = "A map of tags to apply to all resources created by the module."
  default = {
    Environment = ""
    Project     = ""
  }
}
