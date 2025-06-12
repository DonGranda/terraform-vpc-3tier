# Output the VPC ID for use in other modules
output "vpc_id" {
  description = "ID of the VPC"
  value       = aws_vpc.main.id
}

# Output the VPC CIDR block
output "vpc_cidr_block" {
  description = "CIDR block of the VPC"
  value       = aws_vpc.main.cidr_block
}

# Output the Internet Gateway ID
output "internet_gateway_id" {
  description = "ID of the Internet Gateway"
  value       = aws_internet_gateway.main.id
}

# Output the Elastic IP IDs for NAT Gateways
output "nat_eip_ids" {
  description = "Map of Elastic IP IDs for NAT Gateways"
  value = {
    for id, nat-gw in aws_eip.nat :
  id => nat-gw.id }
}

# Output the Elastic IP addresses
output "nat_eip_addresses" {
  description = "Map of Elastic IP addresses for NAT Gateways"
  value = {
    for name, nat_eip-ip in aws_eip.nat :
    name => nat_eip-ip.public_ip
  }
}