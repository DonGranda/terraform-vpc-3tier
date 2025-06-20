variable "app_private_subnets_ids_map" {
    description = "Map of App private subnet IDs with keys"
    type        = map(string)
}

variable "instance_type" {
    description = "Instance type for the web server"
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

variable "app_security_group_id" {
    description = "Security group ID for the web server"
    type        = string
}