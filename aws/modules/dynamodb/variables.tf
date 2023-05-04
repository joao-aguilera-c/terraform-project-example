variable "table_name" {
  description = "The DynamoDB table name"
  type        = string
}

variable "hash_key" {
  description = "The primary key hash"
  type        = string
}

variable "attributes" {
  description = "The table attributes and their types, including keys"
  type        = list(map(string))
}

variable "billing_mode" {
  description = "PROVISIONED or PAY_PER_REQUEST"
  type        = string
  default     = "PROVISIONED"
}

variable "read_capacity" {
  description = ""
  type        = number
  default     = 1
}

variable "write_capacity" {
  description = ""
  type        = number
  default     = 1
}

variable "range_key" {
  description = "The primary key range, when the primary key is a pair of values"
  type        = string
  default     = null
}

variable "table_class" {
  description = "The table class can be STANDARD or STANDARD_INFREQUENT_ACCESS"
  type        = string
  default     = "STANDARD"
}

variable "deletion_protection_enabled" {
  description = "Enables deletion protection"
  type        = bool
  default     = false
}

variable "global_secondary_indexes" {
  description = "Secondary indexes"
  type        = list(map(string))
  default     = []
}

variable "tags" {
  description = "AWS tags"
  type        = map(string)
  default = {
    Environment = ""
    Project     = ""
  }
}