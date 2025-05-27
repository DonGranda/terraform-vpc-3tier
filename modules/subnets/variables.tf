variable "private_subnet_name" {
    description = "private subnet name "
    type = string
  
}

variable "private_subnet_cidr" {
  description = "The CIDR range to  use for private subnet."
    type = string 
}

variable "public_subnet_name" {
    description = "Public subnet name "
    type = string
  
}

variable "public_subnet_cidr" {
      description = "The CIDR range to  use for public subnet."

    type = string 
}

variable "vpc_id" {
  type = string
}
variable "vpc_cidr_block_base" {
  description = "The CIDR range to use for the VPC."
  type        = string
  
}