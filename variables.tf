# AWS Region where resources will be created
variable "aws_region" {
  description = "AWS region where resources will be created"
  type        = string
  default     = "us-west-2"
}

# Project name for resource naming and tagging
variable "project_name" {
  description = "Name of the project for resource naming"
  type        = string
  default     = "terraform-vpc"
}

# Environment name (dev, staging, prod, etc.)
variable "environment" {
  description = "Environment name for resource tagging"
  type        = string
  default     = "dev"
}

# VPC CIDR block
variable "vpc_cidr" {
  description = "CIDR block for the VPC"
  type        = string
  default     = "10.0.0.0/16"
}

# Public subnet CIDR blocks (2 subnets - one per AZ)
variable "public_subnet_cidrs" {
  description = "List of CIDR blocks for public subnets (2 subnets - one per AZ)"
  type        = list(string)
  default     = ["10.0.1.0/24", "10.0.2.0/24"]
}

# Private subnet CIDR blocks (4 subnets - two per AZ)
variable "private_subnet_cidrs" {
  description = "List of CIDR blocks for private subnets (4 subnets - two per AZ)"
  type        = list(string)
  default     = ["10.0.3.0/24", "10.0.4.0/24", "10.0.5.0/24", "10.0.6.0/24"]
}

# Enable DNS hostnames in VPC
variable "enable_dns_hostnames" {
  description = "Enable DNS hostnames in the VPC"
  type        = bool
  default     = true
}

# Enable DNS support in VPC
variable "enable_dns_support" {
  description = "Enable DNS support in the VPC"
  type        = bool
  default     = true
}