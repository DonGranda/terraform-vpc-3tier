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