output "vpc_id" {
  description = "ID of the created VPC"
  value       = module.vpc.vpc_id
}

output "internet_gateway_id" {
  description = "ID of the Internet Gateway"
  value       = module.vpc.internet_gateway_id
}

output "nat_gateway_ids" {
  description = "Map of NAT Gateway IDs"
  value       = module.subnets.nat_gateway_ids
}

output "public_subnet_ids" {
  description = "Map of public subnet IDs"
  value       = module.subnets.public_subnet_ids
}

output "private_subnet_ids" {
  description = "Map of private subnet IDs"
  value       = module.subnets.private_subnet_ids
}

output "web_security_group_id" {
  description = "ID of the web security group"
  value       = module.security_groups.web_security_group_id
}

output "app_security_group_id" {
  description = "ID of the app security group"
  value       = module.security_groups.app_security_group_id
}

output "db_security_group_id" {
  description = "ID of the database security group"
  value       = module.security_groups.db_security_group_id
}

output "db_instance_endpoint" {
  description = "Endpoint of the RDS instance"
  value       = module.rds_db.db_instance_endpoint
}

output "db_instance_port" {
  description = "Port of the RDS instance"
  value       = module.rds_db.db_instance_port
}

output "db_username" {
  description = "Username for the database"
  value       = var.db_username
}

output "db_name" {
  description = "Database name"
  value       = var.db_name
}

output "web_server_instance_ids" {
  description = "Map of EC2 instance IDs for the web server"
  value       = module.web_server.instance_ids
}

output "alb_dns_name" {
  description = "DNS name of the Application Load Balancer"
  value       = module.application_load_balancer.alb_dns_name
}

output "alb_arn" {
  description = "ARN of the Application Load Balancer"
  value       = module.application_load_balancer.alb_arn
}

output "alb_url" {
  description = "Complete URL of the Application Load Balancer"
  value       = module.application_load_balancer.alb_url
}