output "all_subnet_ids" {
  description = "List of all subnet IDs"
  value       = [for subnet in aws_subnet.subnets : subnet.id]
}

output "public_subnet_ids" {
  description = "List of public subnet IDs"
  value = [
    for subnet in aws_subnet.subnets :
    subnet.id if subnet.tags["Type"] == "public"
  ]
}

output "private_subnet_ids" {
  description = "List of private subnet IDs"
  value = [
    for subnet in aws_subnet.subnets :
    subnet.id if subnet.tags["Type"] == "private"
  ]
}
