variable "table_name" {
  description = "Name of the DynamoDB table"
  type        = string
}

variable "hash_key" {
  description = "The attribute to use as the hash (partition) key. Must also be defined as an attribute"
  type        = string
}

variable "attributes" {
  description = "The table attributes and their types, including keys"
  type        = list(map(string))
}

variable "billing_mode" {
  description = "The valid values are PROVISIONED or PAY_PER_REQUEST"
  type        = string
  default     = "PROVISIONED"
}

variable "read_capacity" {
  description = "The number of read units for this table. If the billing_mode is PROVISIONED, this field should be greater than 0"
  type        = number
  default     = 1
}

variable "write_capacity" {
  description = "The number of write units for this table. If the billing_mode is PROVISIONED, this field should be greater than 0"
  type        = number
  default     = 1
}

variable "range_key" {
  description = "The attribute to use as the range (sort) key. Must also be defined as an attribute"
  type        = string
  default     = null
}

variable "table_class" {
  description = "Valid values are STANDARD and STANDARD_INFREQUENT_ACCESS"
  type        = string
  default     = "STANDARD"
}

variable "deletion_protection_enabled" {
  description = "Enables deletion protection"
  type        = bool
  default     = false
}

variable "global_secondary_indexes" {
  description = "Describe a GSI for the table; subject to the normal limits on the number of GSIs, projected attributes, etc."
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

variable "stream_enabled" {
  description = "Enable DynamoDB Streams"
  type = bool
  default = false
}

variable "stream_view_type" {
  description = "When an item in the table is modified, StreamViewType determines what information is written to the table's stream. Valid values are KEYS_ONLY, NEW_IMAGE, OLD_IMAGE, NEW_AND_OLD_IMAGES."
  type = string
  default = null
}