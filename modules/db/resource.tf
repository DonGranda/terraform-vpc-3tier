resource "aws_db_subnet_group" "db-subnet-grp" {
  name        = "${var.project_name}-${var.environment}-db-subnet-grp"
  description = "Database subnet group for ${var.project_name} in ${var.environment} environment"
  subnet_ids  = var.db_private_subnets
  tags = {
    Name        = "${var.project_name}-${var.environment}-db-subnet-grp"
    Environment = var.environment
    Project     = var.project_name
  }

}