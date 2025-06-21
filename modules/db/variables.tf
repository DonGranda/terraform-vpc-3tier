variable "project_name" {
  type = string
}
variable "environment" {
  description = "The environment for the resources, e.g., dev, staging, prod"
  type        = string
}
variable "db_private_subnet_ids" {
  description = "List of private subnet IDs for the database"
  type        = list(string)

}

# variable "db_private_subnets" {
#   description = "Map of private subnets for the database"
#   type        = list(string)

# }

variable "db_engine" {
  description = "Database engine"
  type        = string

  validation {
    condition = contains([
      "mysql", "postgres", "mariadb", "oracle-ee", "oracle-se2",
      "oracle-se1", "oracle-se", "sqlserver-ee", "sqlserver-se",
      "sqlserver-ex", "sqlserver-web"
    ], var.db_engine)
    error_message = "Engine must be a valid RDS engine type."
  }
}

variable "db_engine_version" {
  description = "Database engine version"
  type        = string

}

variable "db_instance_class" {
  description = "Instance class for the database"
  type        = string
}

variable "db_allocated_storage" {
  description = "Allocated storage for the database in GB"
  type        = number

}

variable "db_max_allocated_storage" {
  description = "Maximum allocated storage for the database in GB"
  type        = number

}

variable "db_storage_type" {
  description = "Storage type for the database"
  type        = string
  #default     = "gp2"

}

variable "db_storage_encrypted" {
  description = "Whether the database storage is encrypted"
  type        = bool
  default     = true

}

variable "db_name" {
  description = "Name of the database"
  type        = string

}
variable "db_username" {
  description = "Username for the database"
  type        = string

}
variable "manage_master_user_password" {
  description = "Whether to manage the master user password"
  type        = bool
  default     = true
}
variable "db_security_group_id" {
  description = "List of security group IDs for the database tier"
  type        = list(string)

}