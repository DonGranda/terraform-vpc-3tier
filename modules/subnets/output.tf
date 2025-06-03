output "public_subnet_ids" {
  description = "Map of public subnet IDs"
  value       = { for k, v in aws_subnet.all_subnets : k => v.id if local.all_subnets[k].type == "Public" }
}

# Output private subnet IDs
output "private_subnet_ids" {
  description = "Map of private subnet IDs"
  value       = { for k, v in aws_subnet.all_subnets : k => v.id if local.all_subnets[k].type == "Private" }
}

# Output all subnet details
output "all_subnet_details" {
  description = "Map of all subnets with their details"
  value = {
    for k, v in aws_subnet.all_subnets : k => {
      id                = v.id
      cidr_block        = v.cidr_block
      availability_zone = v.availability_zone
      type              = v.tags.Type
      tier              = v.tags.Tier
    }
  }
}

# Output NAT Gateway IDs
output "nat_gateway_ids" {
  description = "Map of NAT Gateway IDs"
  value       = { for k, v in aws_nat_gateway.main : k => v.id }
}

# output "public_route_table_id" {
#   description = "ID of the public route table"
#   value       = aws_route_table.public.id
# }

# # Output private route table IDs
# output "private_route_table_ids" {
#   description = "Map of private route table IDs"
#   value       = { for k, v in aws_route_table.private : k => v.id }
# }