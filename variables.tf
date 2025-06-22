variable "aws_region" {
  description = "AWS region where resources will be created"
  type        = string
  default     = "eu-north-1"
}

variable "project_name" {
  description = "Name of the project for resource naming"
  type        = string
  default     = "terraform-vpc"
}

variable "environment" {
  description = "Environment name for resource tagging"
  type        = string
  default     = "dev"
}

variable "vpc_cidr" {
  description = "CIDR block for the VPC"
  type        = string
  default     = "10.0.0.0/16"
}

variable "public_subnet_cidrs" {
  description = "List of CIDR blocks for public subnets (2 subnets - one per AZ)"
  type        = list(string)
  default     = ["10.0.1.0/24", "10.0.2.0/24"]
}

variable "private_subnet_cidrs" {
  description = "List of CIDR blocks for private subnets (4 subnets - two per AZ)"
  type        = list(string)
  default     = ["10.0.3.0/24", "10.0.4.0/24", "10.0.5.0/24", "10.0.6.0/24"]
}

variable "enable_dns_hostnames" {
  description = "Enable DNS hostnames in the VPC"
  type        = bool
  default     = true
}

variable "enable_dns_support" {
  description = "Enable DNS support in the VPC"
  type        = bool
  default     = true
}

//DATABASE VARIABLES
variable "db_engine" {
  description = "Database engine"
  type        = string
  default     = "mysql"

  # validation {
  #   condition     = contains(["mysql", "postgres", "mariadb", "oracle-ee", "oracle-se2", "oracle-se1", "oracle-se", "sqlserver-ee", "sqlserver-se", "sqlserver-ex", "sqlserver-web"], var.db_engine)
  #   error_message = "Engine must be a valid RDS engine type."
  # }

}

variable "db_engine_version" {
  description = "Database engine version"
  type        = string
  default     = "8.0"
}
variable "db_instance_class" {
  description = "Instance class for the database"
  type        = string
  default     = "db.t3.micro"
}
variable "db_allocated_storage" {
  description = "Allocated storage for the database in GB"
  type        = number
  default     = 20
}
variable "db_max_allocated_storage" {
  description = "Maximum allocated storage for the database in GB"
  type        = number
  default     = 100
}
variable "db_storage_type" {
  description = "Storage type for the database"
  type        = string
  default     = "gp2"
}
variable "db_storage_encrypted" {
  description = "Whether the database storage is encrypted"
  type        = bool
  default     = true
}
variable "db_name" {
  description = "Name of the database"
  type        = string
  default     = "mydatabase"
}
variable "db_username" {
  description = "Username for the database"
  type        = string
  default     = "admin"
}


variable "instance_type" {
  description = "Instance type for the web server"
  type        = string
  default     = "t3.micro"

}