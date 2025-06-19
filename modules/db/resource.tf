resource "aws_db_subnet_group" "db-subnet-grp" {
  name        = "${var.project_name}-${var.environment}-db-subnet-grp"
  description = "Database subnet group for ${var.project_name} in ${var.environment} environment"
  subnet_ids  = var.private_subnet_ids
  tags = {
    Name        = "${var.project_name}-${var.environment}-db-subnet-grp"
    Environment = var.environment
    Project     = var.project_name
  }

}

resource "random_password" "db_password" {
  length  = 16
  special = true
}

resource "aws_ssm_parameter" "db_password" {
  name  = "/${var.project_name}/${var.environment}/database/password"
  type  = "SecureString"
  value = random_password.db_password.result

}