variable "cluster_name" {
  description = "Cluster name"
  type        = string
  default     = ""
}

variable "cluster_version" {
  description = "Project name"
  type        = string
  default     = "1.26"
}

variable "vpc_id" {
  description = "VPC ID"
  type        = string
  default     = ""
}

variable "public_subnets" {
  description = "Public subnets"
  type        = list(string)
  default     = []
}

variable "private_subnets" {
  description = "Private subnets"
  type        = list(string)
  default     = []
}

variable "tags" {
  description = "A map of tags to apply to all resources created by the module."
  default = {
    Environment = ""
    Project     = ""
  }
}

variable "eks_managed_node_groups" {
  description = "A map of maps, each containing a configuration for a nodegroup. Refer to the docs for the available fields"
  default = {
    one = {
      name           = "nodegroup-01"
      instance_types = ["t3.small"]
      min_size       = 1
      max_size       = 3
      desired_size   = 1
    }
  }
}

variable "region" {
  description = "The AWS region"
  type        = string
}