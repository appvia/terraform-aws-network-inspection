variable "vpc_tags" {
  description = "Map of tags to filter VPCs by"
  type        = map(string)
  default     = {}
}

variable "subnet_tags" {
  description = "Map of tags to filter subnets by"
  type        = map(string)
  default     = {}
} 