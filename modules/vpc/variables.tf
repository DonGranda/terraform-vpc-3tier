variable "vpc_cidr" {
  description = "CIDR block for the VPC"
  type        = string
}

# Project name for resource naming
variable "project_name" {
  description = "Name of the project"
  type        = string
}

# Environment name for tagging
variable "environment" {
  description = "Environment name"
  type        = string
}

# List of availability zones to use
variable "availability_zones" {
  description = "List of availability zones"
  type        = list(string)
}

# Enable DNS hostnames flag
variable "enable_dns_hostnames" {
  description = "Enable DNS hostnames in VPC"
  type        = bool
  default     = true
}

# Enable DNS support flag
variable "enable_dns_support" {
  description = "Enable DNS support in VPC"
  type        = bool
  default     = true
}
