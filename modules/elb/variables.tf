variable "environment" {
  description = "Environment name"
  type        = string
}

variable "project_name" {
  description = "Name of the project"
  type        = string
}

variable "web_security_group_id" {
  description = "Security group ID for the web server"
  type        = string
}

variable "availability_zones" {
  description = "List of availability zones for the ELB"
  type        = list(string)
}

variable "vpc_id" {
  description = "ID of the VPC where the ELB will be created"
  type        = string

}
variable "public_subnet_ids" {
  description = "List of public subnet IDs for the ELB"
  type        = map(string)

}