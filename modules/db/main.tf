resource "aws_db_instance" "db-instance" {
  identifier             = "${var.project_name}-${var.environment}-db"
  engine                 = var.db_engine
  engine_version         = var.db_engine_version
  instance_class         = var.db_instance_class
  db_subnet_group_name   = aws_db_subnet_group.db-subnet-grp.name
  vpc_security_group_ids = var.db_security_group_id



  #db storage configuration 
  allocated_storage     = var.db_allocated_storage
  max_allocated_storage = var.db_max_allocated_storage
  storage_type          = var.db_storage_type
  storage_encrypted     = var.db_storage_encrypted

  #db credentials
  db_name  = var.db_name
  username = var.db_username
  password = random_password.db_password.result


  #db maintenance and backup
  multi_az                   = true
  backup_retention_period    = 1
  backup_window              = "03:00-04:00"
  skip_final_snapshot        = true
  auto_minor_version_upgrade = true

    depends_on = [
    aws_db_subnet_group.db-subnet-grp,
    aws_ssm_parameter.db_password
  ]

  tags = {
    Name        = "${var.project_name}-${var.environment}-db"
    Environment = var.environment
    Project     = var.project_name
    Engine      = var.db_engine
  }

}
