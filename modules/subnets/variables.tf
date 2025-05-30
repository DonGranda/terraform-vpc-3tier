# VPC ID where subnets will be created
variable "vpc_id" {
  description = "ID of the VPC where subnets will be created"
  type        = string
}

# Internet Gateway ID for routing
variable "internet_gateway_id" {
  description = "ID of the Internet Gateway"
  type        = string
}

# List of public subnet CIDR blocks
variable "public_subnet_cidrs" {
  description = "List of CIDR blocks for public subnets"
  type        = list(string)
}

# List of private subnet CIDR blocks
variable "private_subnet_cidrs" {
  description = "List of CIDR blocks for private subnets"
  type        = list(string)
}

# List of availability zones to use
variable "availability_zones" {
  description = "List of availability zones"
  type        = list(string)
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

# Elastic IP IDs for NAT Gateways (from VPC module) - now expects a map
variable "nat_eip_ids" {
  description = "Map of Elastic IP IDs for NAT Gateways"
  type        = map(string)
  default     = {}
}