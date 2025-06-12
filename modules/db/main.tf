resource "aws_db_instance" "db-instance" {
    identifier = "${var.project_name}-${var.environment}-db"
    engine         = var.db_engine
    engine_version = var.db_engine_version
    instance_class = var.db_instance_class
    db_subnet_group_name = aws_db_subnet_group.db-subnet-grp.name
   
   #db storage configuration
    allocated_storage     = var.db_allocated_storage
    max_allocated_storage = var.db_max_allocated_storage
    storage_type         = var.db_storage_type
    storage_encrypted    = var.db_storage_encrypted

    #db credentials
    db_name = var.db_name
    username = var.db_username
    manage_master_user_password = var.manage_master_user_password
  

    tags = {
    Name        = "${var.project_name}-${var.environment}-db"
    Environment = var.environment
    Project     = var.project_name
    Engine      = var.db_engine
    }

}
