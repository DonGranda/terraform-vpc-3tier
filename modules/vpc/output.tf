output "vpc_id" {
  description = "The ID of the VPC"
  value       = aws_vpc.main.id
  
}

output "vpc_cidr_block" {
  description = "The CIDR block of the VPC"
  value       = aws_vpc.main.cidr_block
  
}

output "internet_gateway_id" {
  description = "The ID of the Internet Gateway"
  value       = aws_internet_gateway.main.id
  
}

output "nat_gateway_ids" {
  description = "A map of NAT Gateway IDs by subnet"
  value       = [
    for nat-gw in aws_aws_nat_gateway.vpc_nat_gateway:
    nat-gw.id 
  ]  
}