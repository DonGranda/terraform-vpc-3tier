# modules/asg/variables.tf

variable "app_private_subnets_ids_map" {
  description = "Map of App private subnet IDs with keys"
  type        = map(string)
}

variable "instance_type" {
  description = "Instance type for the web server"
  type        = string
}

variable "project_name" {
  description = "Name of the project"
  type        = string
}

variable "environment" {
  description = "Environment name"
  type        = string
}

variable "app_security_group_id" {
  description = "Security group ID for the web server"
  type        = string
}

variable "target_group_arn" {
  description = "List of target group ARNs to attach to the Auto Scaling Group"
  type        = list(string)
#   default     = []
}

variable "min_size" {
  description = "Minimum number of instances in the Auto Scaling Group"
  type        = number
}

variable "max_size" {
  description = "Maximum number of instances in the Auto Scaling Group"
  type        = number
}

variable "desired_capacity" {
  description = "Desired number of instances in the Auto Scaling Group"
  type        = number
}

# Block Device Mapping Variables
variable "root_volume_size" {
  description = "Size of the root volume in GB"
  type        = number
}

variable "root_volume_type" {
  description = "Type of the root volume"
  type        = string
  default     = "gp3"
}

variable "ebs_encrypted" {
  description = "Whether to encrypt the EBS volume"
  type        = bool

}

# Network Interface Variables
variable "associate_public_ip_address" {
  description = "Whether to associate a public IP address with instances"
  type        = bool

}

variable "alb_arn_suffix" {
 description = "ALB ARN suffix for target tracking"
  type        = string
  default     = ""
}

variable "target_group_arn_suffix" {
  description = "Target Group ARN suffix for target tracking"
  type        = string
  default     = ""
}

variable "enable_alb_target_tracking" {
  description = "Enable ALB request count target tracking"
  type        = bool
  # Root moudle handle this variable
  # default     = false
}