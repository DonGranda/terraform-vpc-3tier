variable "name_prefix" {
  description = "Prefix for the security group name"
  type        = string
  
}

variable "vpc_id" {
  description = "The ID of the VPC to associate the security group with"
  type        = string
  
}