variable "cidr_block" {
  description = "The VPC CIDR  range to use for the virtual network."
    type = string
    
  
}

variable "name_prefix" {
  description = "The prefix to use for the VPC name."
    type = string
  
  
}

variable "vpc_id" {
  description = "The ID of the VPC to associate the security group with"
    type = string
  
}


