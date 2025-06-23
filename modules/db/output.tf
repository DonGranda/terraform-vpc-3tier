output "db_instance_id" {
  description = "RDS instance ID"
  value       = aws_db_instance.db-instance.id
}


output "db_instance_endpoint" {
  description = "RDS instance endpoint"
  value       = aws_db_instance.db-instance.endpoint
}

output "db_instance_port" {
  description = "RDS instance port"
  value       = aws_db_instance.db-instance.port
}

output "db_subnet_group_name" {
  description = "DB subnet group name"
  value       = aws_db_subnet_group.db-subnet-grp.name
}


